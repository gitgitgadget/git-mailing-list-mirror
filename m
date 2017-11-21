Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A30A2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdKUVHz (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:07:55 -0500
Received: from siwi.pair.com ([209.68.5.199]:44414 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbdKUVHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:07:31 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D6DCD8450B;
        Tue, 21 Nov 2017 16:07:30 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 675F5844F0;
        Tue, 21 Nov 2017 16:07:30 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com
Subject: [PATCH v5 02/10] fsck: introduce partialclone extension
Date:   Tue, 21 Nov 2017 21:07:12 +0000
Message-Id: <20171121210720.21376-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171121210720.21376-1-git@jeffhostetler.com>
References: <20171121210720.21376-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Currently, Git does not support repos with very large numbers of objects
or repos that wish to minimize manipulation of certain blobs (for
example, because they are very large) very well, even if the user
operates mostly on part of the repo, because Git is designed on the
assumption that every referenced object is available somewhere in the
repo storage. In such an arrangement, the full set of objects is usually
available in remote storage, ready to be lazily downloaded.

Teach fsck about the new state of affairs. In this commit, teach fsck
that missing promisor objects referenced from the reflog are not an
error case; in future commits, fsck will be taught about other cases.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fsck.c           |  2 +-
 cache.h                  |  3 +-
 packfile.c               | 77 +++++++++++++++++++++++++++++++++++++++++++--
 packfile.h               | 13 ++++++++
 t/t0410-partial-clone.sh | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 171 insertions(+), 5 deletions(-)
 create mode 100755 t/t0410-partial-clone.sh

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 56afe40..2934299 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -398,7 +398,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
 			obj->flags |= USED;
 			mark_object_reachable(obj);
-		} else {
+		} else if (!is_promisor_object(oid)) {
 			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
 			errors_found |= ERROR_REACHABLE;
 		}
diff --git a/cache.h b/cache.h
index 35e3f5e..c76f2e9 100644
--- a/cache.h
+++ b/cache.h
@@ -1587,7 +1587,8 @@ extern struct packed_git {
 	unsigned pack_local:1,
 		 pack_keep:1,
 		 freshened:1,
-		 do_not_close:1;
+		 do_not_close:1,
+		 pack_promisor:1;
 	unsigned char sha1[20];
 	struct revindex_entry *revindex;
 	/* something like ".git/objects/pack/xxxxx.pack" */
diff --git a/packfile.c b/packfile.c
index 4a5fe7a..234797c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -8,6 +8,11 @@
 #include "list.h"
 #include "streaming.h"
 #include "sha1-lookup.h"
+#include "commit.h"
+#include "object.h"
+#include "tag.h"
+#include "tree-walk.h"
+#include "tree.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -643,10 +648,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 		return NULL;
 
 	/*
-	 * ".pack" is long enough to hold any suffix we're adding (and
+	 * ".promisor" is long enough to hold any suffix we're adding (and
 	 * the use xsnprintf double-checks that)
 	 */
-	alloc = st_add3(path_len, strlen(".pack"), 1);
+	alloc = st_add3(path_len, strlen(".promisor"), 1);
 	p = alloc_packed_git(alloc);
 	memcpy(p->pack_name, path, path_len);
 
@@ -654,6 +659,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	if (!access(p->pack_name, F_OK))
 		p->pack_keep = 1;
 
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".promisor");
+	if (!access(p->pack_name, F_OK))
+		p->pack_promisor = 1;
+
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
 	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
 		free(p);
@@ -781,7 +790,8 @@ static void prepare_packed_git_one(char *objdir, int local)
 		if (ends_with(de->d_name, ".idx") ||
 		    ends_with(de->d_name, ".pack") ||
 		    ends_with(de->d_name, ".bitmap") ||
-		    ends_with(de->d_name, ".keep"))
+		    ends_with(de->d_name, ".keep") ||
+		    ends_with(de->d_name, ".promisor"))
 			string_list_append(&garbage, path.buf);
 		else
 			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
@@ -1889,6 +1899,9 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	for (p = packed_git; p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
+		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+		    !p->pack_promisor)
+			continue;
 		if (open_pack_index(p)) {
 			pack_errors = 1;
 			continue;
@@ -1899,3 +1912,61 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	}
 	return r ? r : pack_errors;
 }
+
+static int add_promisor_object(const struct object_id *oid,
+			       struct packed_git *pack,
+			       uint32_t pos,
+			       void *set_)
+{
+	struct oidset *set = set_;
+	struct object *obj = parse_object(oid);
+	if (!obj)
+		return 1;
+
+	oidset_insert(set, oid);
+
+	/*
+	 * If this is a tree, commit, or tag, the objects it refers
+	 * to are also promisor objects. (Blobs refer to no objects.)
+	 */
+	if (obj->type == OBJ_TREE) {
+		struct tree *tree = (struct tree *)obj;
+		struct tree_desc desc;
+		struct name_entry entry;
+		if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
+			/*
+			 * Error messages are given when packs are
+			 * verified, so do not print any here.
+			 */
+			return 0;
+		while (tree_entry_gently(&desc, &entry))
+			oidset_insert(set, entry.oid);
+	} else if (obj->type == OBJ_COMMIT) {
+		struct commit *commit = (struct commit *) obj;
+		struct commit_list *parents = commit->parents;
+
+		oidset_insert(set, &commit->tree->object.oid);
+		for (; parents; parents = parents->next)
+			oidset_insert(set, &parents->item->object.oid);
+	} else if (obj->type == OBJ_TAG) {
+		struct tag *tag = (struct tag *) obj;
+		oidset_insert(set, &tag->tagged->oid);
+	}
+	return 0;
+}
+
+int is_promisor_object(const struct object_id *oid)
+{
+	static struct oidset promisor_objects;
+	static int promisor_objects_prepared;
+
+	if (!promisor_objects_prepared) {
+		if (repository_format_partial_clone) {
+			for_each_packed_object(add_promisor_object,
+					       &promisor_objects,
+					       FOR_EACH_OBJECT_PROMISOR_ONLY);
+		}
+		promisor_objects_prepared = 1;
+	}
+	return oidset_contains(&promisor_objects, oid);
+}
diff --git a/packfile.h b/packfile.h
index 0cdeb54..a7fca59 100644
--- a/packfile.h
+++ b/packfile.h
@@ -1,6 +1,8 @@
 #ifndef PACKFILE_H
 #define PACKFILE_H
 
+#include "oidset.h"
+
 /*
  * Generate the filename to be used for a pack file with checksum "sha1" and
  * extension "ext". The result is written into the strbuf "buf", overwriting
@@ -125,6 +127,11 @@ extern int has_sha1_pack(const unsigned char *sha1);
 extern int has_pack_index(const unsigned char *sha1);
 
 /*
+ * Only iterate over packs obtained from the promisor remote.
+ */
+#define FOR_EACH_OBJECT_PROMISOR_ONLY 2
+
+/*
  * Iterate over packed objects in both the local
  * repository and any alternates repositories (unless the
  * FOR_EACH_OBJECT_LOCAL_ONLY flag, defined in cache.h, is set).
@@ -135,4 +142,10 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  void *data);
 extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
 
+/*
+ * Return 1 if an object in a promisor packfile is or refers to the given
+ * object, 0 otherwise.
+ */
+extern int is_promisor_object(const struct object_id *oid);
+
 #endif
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
new file mode 100755
index 0000000..3ddb3b9
--- /dev/null
+++ b/t/t0410-partial-clone.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description='partial clone'
+
+. ./test-lib.sh
+
+delete_object () {
+	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
+}
+
+pack_as_from_promisor () {
+	HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
+	>repo/.git/objects/pack/pack-$HASH.promisor
+}
+
+test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	C=$(git -C repo commit-tree -m c -p $A HEAD^{tree}) &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch my_branch "$A" &&
+	git -C repo branch -f my_branch my_commit &&
+	delete_object repo "$A" &&
+
+	# State that we got $C, which refers to $A, from promisor
+	printf "$C\n" | pack_as_from_promisor &&
+
+	# Normally, it fails
+	test_must_fail git -C repo fsck &&
+
+	# But with the extension, it succeeds
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo fsck
+'
+
+test_expect_success 'missing reflog object, but promised by a tag, passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	git -C repo tag -a -m d my_tag_name $A &&
+	T=$(git -C repo rev-parse my_tag_name) &&
+	git -C repo tag -d my_tag_name &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch my_branch "$A" &&
+	git -C repo branch -f my_branch my_commit &&
+	delete_object repo "$A" &&
+
+	# State that we got $T, which refers to $A, from promisor
+	printf "$T\n" | pack_as_from_promisor &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo fsck
+'
+
+test_expect_success 'missing reflog object alone fails fsck, even with extension set' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	B=$(git -C repo commit-tree -m b HEAD^{tree}) &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch my_branch "$A" &&
+	git -C repo branch -f my_branch my_commit &&
+	delete_object repo "$A" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	test_must_fail git -C repo fsck
+'
+
+test_done
-- 
2.9.3

