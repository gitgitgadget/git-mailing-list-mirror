From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH] patch-ids: check modified paths before calculating diff
Date: Sun, 19 May 2013 14:17:35 +0100
Message-ID: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
Cc: Kevin Bracey <kevin@bracey.fi>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 19 15:18:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue3V5-00020Y-2o
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 15:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab3ESNRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 09:17:53 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:44165 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab3ESNRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 09:17:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 7C03A230D3;
	Sun, 19 May 2013 14:17:51 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kaEQPAW06C9Z; Sun, 19 May 2013 14:17:48 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 5AF12231F8;
	Sun, 19 May 2013 14:17:40 +0100 (BST)
X-Mailer: git-send-email 1.8.3.rc3.372.g721bad8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224886>

When using "git cherry" or "git log --cherry-pick" we often have a small
number of commits on one side and a large number on the other.  In
revision.c::cherry_pick_list we store the patch IDs for the small side
before comparing the large side to this.

In this case, it is likely that only a small number of paths are touched
by the commits on the smaller side of the range and by storing these we
can ignore many commits on the other side before unpacking blobs and
diffing them.

This improves performance in every example I have tried (times are best
of three, using git.git):

Before:
$ time git log --cherry master...jk/submodule-subdirectory-ok >/dev/null

real    0m0.373s
user    0m0.341s
sys     0m0.031s

After:
$ time git log --cherry master...jk/submodule-subdirectory-ok >/dev/null

real    0m0.060s
user    0m0.055s
sys     0m0.005s

Before:
$ time git log --cherry next...pu >/dev/null

real    0m0.661s
user    0m0.617s
sys     0m0.044s

After:
$ time git log --cherry next...pu >/dev/null

real    0m0.509s
user    0m0.478s
sys     0m0.030s

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 patch-ids.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 patch-ids.h |   3 ++
 2 files changed, 145 insertions(+)

diff --git a/patch-ids.c b/patch-ids.c
index bc8a28f..912f40c 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "diff.h"
+#include "diffcore.h"
 #include "commit.h"
 #include "sha1-lookup.h"
 #include "patch-ids.h"
@@ -16,6 +17,137 @@ static int commit_patch_id(struct commit *commit, struct diff_options *options,
 	return diff_flush_patch_id(options, sha1);
 }
 
+struct collect_paths_info {
+	struct string_list *paths;
+	int searching;
+};
+
+static int collect_paths_recursive(int n, struct tree_desc *t,
+	const char *base, struct pathspec *pathspec,
+	struct collect_paths_info *data);
+
+static int same_entry(struct name_entry *a, struct name_entry *b)
+{
+	if (!a->sha1 || !b->sha1)
+		return a->sha1 == b->sha1;
+	return	!hashcmp(a->sha1, b->sha1) &&
+		a->mode == b->mode;
+}
+
+static char *traverse_path(const struct traverse_info *info,
+		const struct name_entry *n)
+{
+	char *path = xmalloc(traverse_path_len(info, n) + 1);
+	return make_traverse_path(path, info, n);
+}
+
+static int add_touched_path(struct collect_paths_info *info, const char *path)
+{
+	if (info->searching) {
+		if (!string_list_has_string(info->paths, path))
+			return -1;
+	}
+	string_list_insert(info->paths, path);
+	return 0;
+}
+
+static inline const unsigned char *dir_sha1(struct name_entry *e)
+{
+	if (S_ISDIR(e->mode))
+		return e->sha1;
+	return NULL;
+}
+
+static int collect_touched_paths_cb(int n, unsigned long mask,
+		unsigned long dirmask, struct name_entry *entry,
+		struct traverse_info *info)
+{
+	struct collect_paths_info *collect_info = info->data;
+	if (n == 1) {
+		/* We're handling a root commit - add all the paths. */
+		if (entry[0].sha1 && !S_ISDIR(entry[0].mode)) {
+			if (add_touched_path(collect_info, entry[0].path))
+				return -1;
+		} else if (S_ISDIR(entry[0].mode)) {
+			char *newbase = traverse_path(info, entry);
+			struct tree_desc t[1];
+			void *buf0 = fill_tree_descriptor(t, entry[0].sha1);
+			int error = collect_paths_recursive(1, t, newbase,
+					info->pathspec, collect_info);
+			free(buf0);
+			free(newbase);
+			if (error < 0)
+				return error;
+		}
+		return mask;
+	}
+
+	if (same_entry(entry+0, entry+1))
+		return mask;
+
+	if (entry[0].mode && !S_ISDIR(entry[0].mode))
+		if (add_touched_path(collect_info, entry[0].path))
+			return -1;
+	if (entry[1].mode && !S_ISDIR(entry[1].mode))
+		if (add_touched_path(collect_info, entry[1].path))
+			return -1;
+
+	if ((entry[0].sha1 && S_ISDIR(entry[0].mode)) ||
+	    (entry[1].sha1 && S_ISDIR(entry[1].mode))) {
+		char *newbase = traverse_path(info,
+				S_ISDIR(entry[0].mode) ? entry+0 : entry+1);
+		struct tree_desc t[2];
+		void *buf0 = fill_tree_descriptor(t+0, dir_sha1(entry+0));
+		void *buf1 = fill_tree_descriptor(t+1, dir_sha1(entry+1));
+		int error = collect_paths_recursive(2, t, newbase,
+				info->pathspec, collect_info);
+		free(buf0);
+		free(buf1);
+		free(newbase);
+		if (error < 0)
+			return error;
+	}
+
+	return mask;
+}
+
+static int collect_paths_recursive(int n, struct tree_desc *t,
+		const char *base, struct pathspec *pathspec,
+		struct collect_paths_info *data)
+{
+	struct traverse_info info;
+
+	setup_traverse_info(&info, base);
+	info.data = data;
+	info.fn = collect_touched_paths_cb;
+	info.pathspec = pathspec;
+
+	return traverse_trees(n, t, &info);
+}
+
+static int collect_touched_paths(struct commit *commit, struct patch_ids *ids,
+		int searching)
+{
+	struct tree_desc trees[2];
+	struct collect_paths_info info = { &ids->touched_paths, searching };
+	void *commitbuf;
+	int result;
+
+	commitbuf = fill_tree_descriptor(trees + 1, commit->object.sha1);
+	if (commit->parents) {
+		void *parentbuf = fill_tree_descriptor(trees + 0,
+					commit->parents->item->object.sha1);
+		result = collect_paths_recursive(2, trees, "",
+				&ids->diffopts.pathspec, &info);
+		free(parentbuf);
+	} else {
+		result = collect_paths_recursive(1, trees + 1, "",
+				&ids->diffopts.pathspec, &info);
+	}
+	free(commitbuf);
+	return result;
+}
+
 static const unsigned char *patch_id_access(size_t index, void *table)
 {
 	struct patch_id **id_table = table;
@@ -40,6 +172,7 @@ int init_patch_ids(struct patch_ids *ids)
 	diff_setup(&ids->diffopts);
 	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
 	diff_setup_done(&ids->diffopts);
+	ids->touched_paths.strdup_strings = 1;
 	return 0;
 }
 
@@ -52,6 +185,8 @@ int free_patch_ids(struct patch_ids *ids)
 		next = patches->next;
 		free(patches);
 	}
+
+	string_list_clear(&ids->touched_paths, 0);
 	return 0;
 }
 
@@ -64,6 +199,13 @@ static struct patch_id *add_commit(struct commit *commit,
 	unsigned char sha1[20];
 	int pos;
 
+	if (no_add) {
+		if (collect_touched_paths(commit, ids, 1) < 0)
+			return NULL;
+	} else {
+		collect_touched_paths(commit, ids, 0);
+	}
+
 	if (commit_patch_id(commit, &ids->diffopts, sha1))
 		return NULL;
 	pos = patch_pos(ids->table, ids->nr, sha1);
diff --git a/patch-ids.h b/patch-ids.h
index c8c7ca1..c90bec5 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -1,6 +1,8 @@
 #ifndef PATCH_IDS_H
 #define PATCH_IDS_H
 
+#include "string-list.h"
+
 struct patch_id {
 	unsigned char patch_id[20];
 	char seen;
@@ -8,6 +10,7 @@ struct patch_id {
 
 struct patch_ids {
 	struct diff_options diffopts;
+	struct string_list touched_paths;
 	int nr, alloc;
 	struct patch_id **table;
 	struct patch_id_bucket *patches;
-- 
1.8.3.rc3.372.g721bad8
