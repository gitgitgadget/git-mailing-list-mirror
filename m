Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1BCC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B62A611EE
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhECUoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 16:44:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:43532 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhECUoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 16:44:04 -0400
Received: (qmail 7558 invoked by uid 109); 3 May 2021 20:43:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 20:43:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7468 invoked by uid 111); 3 May 2021 20:43:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 16:43:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 16:43:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/9] fsck_tree(): fix shadowed variable
Message-ID: <YJBgXWb4Y2movw97@coredump.intra.peff.net>
References: <YJBgMP9eXq31INyN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJBgMP9eXq31INyN@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit b2f2039c2b (fsck: accept an oid instead of a "struct tree" for
fsck_tree(), 2019-10-18) introduced a new "oid" parameter to
fsck_tree(), and we pass it to the report() function when we find
problems. However, that is shadowed within the tree-walking loop by the
existing "oid" variable which we use to store the oid of each tree
entry. As a result, we may report the wrong oid for some problems we
detect within the loop (the entry oid, instead of the tree oid).

Our tests didn't catch this because they checked only that we found the
expected fsck problem, not that it was attached to the correct object.

Let's rename both variables in the function to avoid confusion. This
makes the diff a little noisy (e.g., all of the report() calls outside
the loop were already correct but need to be touched), but makes sure we
catch all cases and will avoid similar confusion in the future.

And we can update the test to be a bit more specific and catch this
problem.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c                     | 42 ++++++++++++++++++++------------------
 t/t7415-submodule-names.sh |  5 +++--
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/fsck.c b/fsck.c
index f5ed6a2635..dd31ed1413 100644
--- a/fsck.c
+++ b/fsck.c
@@ -558,7 +558,7 @@ static int verify_ordered(unsigned mode1, const char *name1,
 	return c1 < c2 ? 0 : TREE_UNORDERED;
 }
 
-static int fsck_tree(const struct object_id *oid,
+static int fsck_tree(const struct object_id *tree_oid,
 		     const char *buffer, unsigned long size,
 		     struct fsck_options *options)
 {
@@ -579,7 +579,7 @@ static int fsck_tree(const struct object_id *oid,
 	struct name_stack df_dup_candidates = { NULL };
 
 	if (init_tree_desc_gently(&desc, buffer, size)) {
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
 		return retval;
 	}
 
@@ -589,11 +589,11 @@ static int fsck_tree(const struct object_id *oid,
 	while (desc.size) {
 		unsigned short mode;
 		const char *name, *backslash;
-		const struct object_id *oid;
+		const struct object_id *entry_oid;
 
-		oid = tree_entry_extract(&desc, &name, &mode);
+		entry_oid = tree_entry_extract(&desc, &name, &mode);
 
-		has_null_sha1 |= is_null_oid(oid);
+		has_null_sha1 |= is_null_oid(entry_oid);
 		has_full_path |= !!strchr(name, '/');
 		has_empty_name |= !*name;
 		has_dot |= !strcmp(name, ".");
@@ -603,10 +603,11 @@ static int fsck_tree(const struct object_id *oid,
 
 		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
 			if (!S_ISLNK(mode))
-				oidset_insert(&options->gitmodules_found, oid);
+				oidset_insert(&options->gitmodules_found,
+					      entry_oid);
 			else
 				retval += report(options,
-						 oid, OBJ_TREE,
+						 tree_oid, OBJ_TREE,
 						 FSCK_MSG_GITMODULES_SYMLINK,
 						 ".gitmodules is a symbolic link");
 		}
@@ -617,9 +618,10 @@ static int fsck_tree(const struct object_id *oid,
 				has_dotgit |= is_ntfs_dotgit(backslash);
 				if (is_ntfs_dotgitmodules(backslash)) {
 					if (!S_ISLNK(mode))
-						oidset_insert(&options->gitmodules_found, oid);
+						oidset_insert(&options->gitmodules_found,
+							      entry_oid);
 					else
-						retval += report(options, oid, OBJ_TREE,
+						retval += report(options, tree_oid, OBJ_TREE,
 								 FSCK_MSG_GITMODULES_SYMLINK,
 								 ".gitmodules is a symbolic link");
 				}
@@ -628,7 +630,7 @@ static int fsck_tree(const struct object_id *oid,
 		}
 
 		if (update_tree_entry_gently(&desc)) {
-			retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+			retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
 			break;
 		}
 
@@ -676,25 +678,25 @@ static int fsck_tree(const struct object_id *oid,
 	name_stack_clear(&df_dup_candidates);
 
 	if (has_null_sha1)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_NULL_SHA1, "contains entries pointing to null sha1");
+		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_NULL_SHA1, "contains entries pointing to null sha1");
 	if (has_full_path)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
+		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
 	if (has_empty_name)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
+		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
 	if (has_dot)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_HAS_DOT, "contains '.'");
+		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_HAS_DOT, "contains '.'");
 	if (has_dotdot)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_HAS_DOTDOT, "contains '..'");
+		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_HAS_DOTDOT, "contains '..'");
 	if (has_dotgit)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_HAS_DOTGIT, "contains '.git'");
+		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_HAS_DOTGIT, "contains '.git'");
 	if (has_zero_pad)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
+		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
 	if (has_bad_modes)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
+		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
 	if (has_dup_entries)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_DUPLICATE_ENTRIES, "contains duplicate file entries");
+		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_DUPLICATE_ENTRIES, "contains duplicate file entries");
 	if (not_properly_sorted)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");
+		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");
 	return retval;
 }
 
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index fef6561d80..6a8cf3f47b 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -148,12 +148,13 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
 		{
 			printf "100644 blob $content\t$tricky\n" &&
 			printf "120000 blob $target\t.gitmodules\n"
-		} | git mktree &&
+		} >bad-tree &&
+		tree=$(git mktree <bad-tree) &&
 
 		# Check not only that we fail, but that it is due to the
 		# symlink detector
 		test_must_fail git fsck 2>output &&
-		grep gitmodulesSymlink output
+		grep "tree $tree: gitmodulesSymlink" output
 	)
 '
 
-- 
2.31.1.926.gd12152deb6

