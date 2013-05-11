From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Sat, 11 May 2013 20:54:19 +0100
Message-ID: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 21:54:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbFsb-0000Pu-1J
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 21:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943Ab3EKTyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 15:54:45 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:59740 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879Ab3EKTyi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 15:54:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E9643CDA57C;
	Sat, 11 May 2013 20:54:37 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UoEmvodF+cUZ; Sat, 11 May 2013 20:54:37 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id F2D99CDA5D2;
	Sat, 11 May 2013 20:54:36 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id D7A06161E418;
	Sat, 11 May 2013 20:54:36 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w2jDuAIRVDCM; Sat, 11 May 2013 20:54:36 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id DF0D5161E3CC;
	Sat, 11 May 2013 20:54:29 +0100 (BST)
X-Mailer: git-send-email 1.8.3.rc1.289.gcb3647f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224006>

This adds a new configuration variable "patchid.cacheRef" which controls
whether (and where) patch IDs will be cached in a notes tree.

Caching patch IDs in this way results in a performance improvement in
every case I have tried, for example when comparing the git-gui tree to
git.git (where git-gui has been merged into git.git but most git.git
commits do not appear in git-gui):

Without patch ID caching:
$ time git log --cherry master...git-gui/master >/dev/null
real    0m32.981s
user    0m32.364s
sys     0m0.621s

Prime the cache:
$ time git -c patchid.cacheref=patchids log --cherry \
	master...git-gui/master >/dev/null
real    0m33.860s
user    0m32.832s
sys     0m0.986s

With all patch IDs cached:
$ time git -c patchid.cacheref=patchids log --cherry \
	master...git-gui/master >/dev/null
real    0m1.041s
user    0m0.679s
sys     0m0.363s

Signed-off-by: John Keeping <john@keeping.me.uk>
---
This is another approach to fixing the "log --cherry" takes a long time
issue I encountered comparing commits built on git-gui to those in
git.git [1][2].

I think this is a useful feature even outside that use case.  I measured
a small improvement (when the cache is primed) even comparing two
branches with 1 and 2 different commits respectively.

[1] http://article.gmane.org/gmane.comp.version-control.git/223959
[2] http://article.gmane.org/gmane.comp.version-control.git/223956

 Documentation/config.txt             |  7 +++
 patch-ids.c                          | 91 +++++++++++++++++++++++++++++++++++-
 patch-ids.h                          |  1 +
 t/t6007-rev-list-cherry-pick-file.sh | 16 +++++++
 4 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..e36585c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1798,6 +1798,13 @@ pager.<cmd>::
 	precedence over this option.  To disable pagination for all
 	commands, set `core.pager` or `GIT_PAGER` to `cat`.
 
+patchid.cacheRef::
+	The name of a notes ref in which to store patch IDs for commits.
+	The ref is taken to be in `refs/notes/` if it is not qualified.
++
+Note that the patch ID notes are never pruned automatically, so you may
+wish to periodically run `git notes --ref <ref> prune` against this ref.
+
 pretty.<name>::
 	Alias for a --pretty= format string, as specified in
 	linkgit:git-log[1]. Any aliases defined here can be used just
diff --git a/patch-ids.c b/patch-ids.c
index bc8a28f..cb05eec 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -1,6 +1,9 @@
 #include "cache.h"
+#include "blob.h"
 #include "diff.h"
 #include "commit.h"
+#include "notes.h"
+#include "refs.h"
 #include "sha1-lookup.h"
 #include "patch-ids.h"
 
@@ -34,12 +37,38 @@ struct patch_id_bucket {
 	struct patch_id bucket[BUCKET_SIZE];
 };
 
+static int patch_id_config(const char *var, const char *value, void *cb)
+{
+	const char **cacheref = cb;
+
+	if (!strcmp(var, "patchid.cacheref"))
+		return git_config_string(cacheref, var, value);
+
+	return 0;
+}
+
 int init_patch_ids(struct patch_ids *ids)
 {
+	char *cacheref = NULL;
+
 	memset(ids, 0, sizeof(*ids));
 	diff_setup(&ids->diffopts);
 	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
 	diff_setup_done(&ids->diffopts);
+
+	git_config(patch_id_config, &cacheref);
+	if (cacheref) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, cacheref);
+		expand_notes_ref(&sb);
+
+		ids->cache = xcalloc(1, sizeof(*ids->cache));
+		init_notes(ids->cache, sb.buf, combine_notes_overwrite, 0);
+
+		strbuf_release(&sb);
+		free(cacheref);
+	}
+
 	return 0;
 }
 
@@ -52,9 +81,67 @@ int free_patch_ids(struct patch_ids *ids)
 		next = patches->next;
 		free(patches);
 	}
+
+	if (ids->cache) {
+		unsigned char notes_sha1[20];
+		if (write_notes_tree(ids->cache, notes_sha1) ||
+		    update_ref("patch-id: update cache", ids->cache->ref,
+				notes_sha1, NULL, 0, QUIET_ON_ERR))
+			error(_("failed to write patch ID cache"));
+
+		free_notes(ids->cache);
+		ids->cache = NULL;
+	}
+
 	return 0;
 }
 
+static int load_cached_patch_id(struct commit *commit,
+		struct notes_tree *cache, unsigned char *sha1)
+{
+	const unsigned char *note_sha1;
+	char *note;
+	enum object_type type;
+	unsigned long notelen;
+	int result = 1;
+
+	if (!cache)
+		return 1;
+
+	note_sha1 = get_note(cache, commit->object.sha1);
+	if (!note_sha1)
+		return 1;
+
+	if (!(note = read_sha1_file(note_sha1, &type, &notelen)) || !notelen ||
+			type != OBJ_BLOB)
+		goto out;
+
+	if (get_sha1_hex(note, sha1))
+		goto out;
+
+	result = 0;
+out:
+	free(note);
+	return result;
+}
+
+static void save_cached_patch_id(struct commit *commit,
+		struct notes_tree *cache, unsigned char *sha1)
+{
+	unsigned char note_sha1[20];
+	struct strbuf sb = STRBUF_INIT;
+	if (!cache)
+		return;
+
+	strbuf_addstr(&sb, sha1_to_hex(sha1));
+	strbuf_addch(&sb, '\n');
+	if (write_sha1_file(sb.buf, sb.len, blob_type, note_sha1) ||
+	    add_note(cache, commit->object.sha1, note_sha1, NULL))
+		error(_("unable to save patch ID in cache"));
+
+	strbuf_release(&sb);
+}
+
 static struct patch_id *add_commit(struct commit *commit,
 				   struct patch_ids *ids,
 				   int no_add)
@@ -64,11 +151,13 @@ static struct patch_id *add_commit(struct commit *commit,
 	unsigned char sha1[20];
 	int pos;
 
-	if (commit_patch_id(commit, &ids->diffopts, sha1))
+	if (load_cached_patch_id(commit, ids->cache, sha1) &&
+	    commit_patch_id(commit, &ids->diffopts, sha1))
 		return NULL;
 	pos = patch_pos(ids->table, ids->nr, sha1);
 	if (0 <= pos)
 		return ids->table[pos];
+	save_cached_patch_id(commit, ids->cache, sha1);
 	if (no_add)
 		return NULL;
 
diff --git a/patch-ids.h b/patch-ids.h
index c8c7ca1..cffb0eb 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -8,6 +8,7 @@ struct patch_id {
 
 struct patch_ids {
 	struct diff_options diffopts;
+	struct notes_tree *cache;
 	int nr, alloc;
 	struct patch_id **table;
 	struct patch_id_bucket *patches;
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 28d4f6b..1b112c3 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -207,4 +207,20 @@ test_expect_success '--count --left-right' '
 	test_cmp expect actual
 '
 
+cat >expect <<EOF
+1	1	2
+EOF
+
+test_expect_success 'rev-list --cherry-mark caches patch ids' '
+	test_config patchid.cacheref patchids &&
+	git rev-list --cherry-mark --left-right --count F...E -- bar >actual &&
+	test_cmp expect actual &&
+	git notes --ref patchids show master >cached_master &&
+	git log -p -1 master | git patch-id | sed -e "s/ .*//" >patch-id_master &&
+	test_cmp patch-id_master cached_master &&
+	# Get the patch IDs again, now they should be cached
+	git rev-list --cherry-mark --left-right --count F...E -- bar >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.3.rc1.289.gcb3647f
