Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E37C64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 08:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBXIMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 03:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBXIM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 03:12:28 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB9C5C178
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 00:12:12 -0800 (PST)
Received: (qmail 4558 invoked by uid 109); 24 Feb 2023 08:12:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 08:12:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31767 invoked by uid 111); 24 Feb 2023 08:12:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 03:12:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 03:12:11 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] fsck: mention file path for index errors
Message-ID: <Y/hxW9i9GyKblNV4@coredump.intra.peff.net>
References: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we encounter an error in an index file, we may say something like:

  error: 1234abcd: invalid sha1 pointer in resolve-undo

But if you have multiple worktrees, each with its own index, it can be
very helpful to know which file had the problem. So let's pass that path
down through the various index-fsck functions and use it where
appropriate. After this patch you should get something like:

  error: 1234abcd: invalid sha1 pointer in resolve-undo of .git/worktrees/wt/index

That's a bit verbose, but since the point is that you shouldn't see this
normally, we're better to err on the side of more details.

I've also added the index filename to the name used by "fsck
--name-objects", which will show up if we find the object to be missing,
etc. This is bending the rules a little there, as the option claims to
write names that can be fed to rev-parse. But there is no revision
syntax to access the index of another worktree, so the best we can do is
make up something that a human will probably understand.

I did take care to retain the existing ":file" syntax for the current
worktree. So the uglier output should kick in only when it's actually
necessary. See the included tests for examples of both forms.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c  | 42 +++++++++++++++++++++++++++---------------
 t/t1450-fsck.sh | 20 +++++++++++++++++++-
 2 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index ddd13cb2b3..e0974644a1 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -731,19 +731,19 @@ static int fsck_head_link(const char *head_ref_name,
 	return 0;
 }
 
-static int fsck_cache_tree(struct cache_tree *it)
+static int fsck_cache_tree(struct cache_tree *it, const char *index_path)
 {
 	int i;
 	int err = 0;
 
 	if (verbose)
-		fprintf_ln(stderr, _("Checking cache tree"));
+		fprintf_ln(stderr, _("Checking cache tree of %s"), index_path);
 
 	if (0 <= it->entry_count) {
 		struct object *obj = parse_object(the_repository, &it->oid);
 		if (!obj) {
-			error(_("%s: invalid sha1 pointer in cache-tree"),
-			      oid_to_hex(&it->oid));
+			error(_("%s: invalid sha1 pointer in cache-tree of %s"),
+			      oid_to_hex(&it->oid), index_path);
 			errors_found |= ERROR_REFS;
 			return 1;
 		}
@@ -754,11 +754,12 @@ static int fsck_cache_tree(struct cache_tree *it)
 			err |= objerror(obj, _("non-tree in cache-tree"));
 	}
 	for (i = 0; i < it->subtree_nr; i++)
-		err |= fsck_cache_tree(it->down[i]->cache_tree);
+		err |= fsck_cache_tree(it->down[i]->cache_tree, index_path);
 	return err;
 }
 
-static int fsck_resolve_undo(struct index_state *istate)
+static int fsck_resolve_undo(struct index_state *istate,
+			     const char *index_path)
 {
 	struct string_list_item *item;
 	struct string_list *resolve_undo = istate->resolve_undo;
@@ -781,8 +782,9 @@ static int fsck_resolve_undo(struct index_state *istate)
 
 			obj = parse_object(the_repository, &ru->oid[i]);
 			if (!obj) {
-				error(_("%s: invalid sha1 pointer in resolve-undo"),
-				      oid_to_hex(&ru->oid[i]));
+				error(_("%s: invalid sha1 pointer in resolve-undo of %s"),
+				      oid_to_hex(&ru->oid[i]),
+				      index_path);
 				errors_found |= ERROR_REFS;
 				continue;
 			}
@@ -795,7 +797,8 @@ static int fsck_resolve_undo(struct index_state *istate)
 	return 0;
 }
 
-static void fsck_index(struct index_state *istate)
+static void fsck_index(struct index_state *istate, const char *index_path,
+		       int is_main_index)
 {
 	unsigned int i;
 
@@ -816,12 +819,14 @@ static void fsck_index(struct index_state *istate)
 		obj = &blob->object;
 		obj->flags |= USED;
 		fsck_put_object_name(&fsck_walk_options, &obj->oid,
-				     ":%s", istate->cache[i]->name);
+				     "%s:%s",
+				     is_main_index ? "" : index_path,
+				     istate->cache[i]->name);
 		mark_object_reachable(obj);
 	}
 	if (istate->cache_tree)
-		fsck_cache_tree(istate->cache_tree);
-	fsck_resolve_undo(istate);
+		fsck_cache_tree(istate->cache_tree, index_path);
+	fsck_resolve_undo(istate, index_path);
 }
 
 static void mark_object_for_connectivity(const struct object_id *oid)
@@ -993,12 +998,19 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			struct worktree *wt = *p;
 			struct index_state istate =
 				INDEX_STATE_INIT(the_repository);
+			char *path;
 
-			if (read_index_from(&istate,
-					    worktree_git_path(wt, "index"),
+			/*
+			 * Make a copy since the buffer is reusable
+			 * and may get overwritten by other calls
+			 * while we're examining the index.
+			 */
+			path = xstrdup(worktree_git_path(wt, "index"));
+			if (read_index_from(&istate, path,
 					    get_worktree_git_dir(wt)) > 0)
-				fsck_index(&istate);
+				fsck_index(&istate, path, wt->is_current);
 			discard_index(&istate);
+			free(path);
 		}
 
 	}
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 3b70ad9e22..bca46378b2 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -1032,7 +1032,25 @@ test_expect_success 'fsck detects problems in worktree index' '
 	blob=$(git -C wt rev-parse :file) &&
 	remove_object $blob &&
 
-	test_must_fail git fsck
+	test_must_fail git fsck --name-objects >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	missing blob $blob (.git/worktrees/wt/index:file)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'fsck reports problems in main index without filename' '
+	test_when_finished "rm -f .git/index && git read-tree HEAD" &&
+	echo "this object will be removed to break the main index" >file &&
+	git add file &&
+	blob=$(git rev-parse :file) &&
+	remove_object $blob &&
+
+	test_must_fail git fsck --name-objects >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	missing blob $blob (:file)
+	EOF
+	test_cmp expect actual
 '
 
 test_done
-- 
2.39.2.981.g6157336f25
