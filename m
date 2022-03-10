Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987D4C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245158AbiCJRgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245109AbiCJRg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:36:26 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA55C18C795
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:35:24 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B6DBC5A12F;
        Thu, 10 Mar 2022 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646933721;
        bh=L1GXRSsBQxSXQ74Kxn+949Y15PrCBVGeG87V2LPxb8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=EQzDvkVv5j1Nmj0aQIjTytvtWJfFdzRJ3GWQvO0FCYj/g6Ws4umJGjywwXn0axNms
         B20L9mX5jDf1IsVPKK6jt39BxLbYl4q8sv3PFWyjH3P/mLarxo4pxk5ntK0+yWMB+G
         Qyd6/wOpJGvxbkSWSa/l4CmC+XWfQP7ldN/ePHGxW4hS9iIRlMRHR2xahLqX/RE6Mx
         1XS21TzaEeI8ZDDL8O85m+1caPJ1cSynueQ2FYiCmiUKQcenhk0xHqgfKTqRyISDTP
         qPx3a2G8j7MMoyWpfTjUct6tl59Bg4SnQVUlD6h/6OnUdB+3te92kJai12nIEPx2ue
         yQxaz9xSLu4aHP0hh3LYw9vPD+37tXwuHsH19gWHBcbm2ozBtSsytTUO7VfuIsY9Ti
         hzt+FAS3U2O2cp2cYm4TQTZG+3Xcz2l2l8RY4+nrFHkfiM683dclbY98eYmYrU0pdx
         ilWNNfEFZG8mmsCN5Y5HfAkbu3phXdHe75h2qc8FKZ4pr6GfTKh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 5/6] builtin/stash: provide a way to import stashes from a ref
Date:   Thu, 10 Mar 2022 17:32:35 +0000
Message-Id: <20220310173236.4165310-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have a way to export stashes to a ref, let's provide a way
to import them from such a ref back to the stash.  This works much the
way the export code does, except that we strip off the first parent
chain commit and then store each resulting commit back to the stash.

We don't clear the stash first and instead add the specified stashes to
the top of the stash.  This is because users may want to export just a
few stashes, such as to share a small amount of work in progress with a
colleague, and it would be undesirable for the receiving user to lose
all of their data.  For users who do want to replace the stash, it's
easy to do to: simply run "git stash clear" first.

We specifically rely on the fact that we'll produce identical stash
commits on both sides in our tests.  This provides a cheap,
straightforward check for our tests and also makes it easy for users to
see if they already have the same data in both repositories.  Note that
the exported commits don't because we don't write a predictable base
commit, however.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/stash.c  | 125 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t3903-stash.sh |  52 ++++++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index 582a04dbab..626e7b8531 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -34,6 +34,7 @@ static const char * const git_stash_usage[] = {
 	N_("git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
 	N_("git stash export (--print | --to-ref <ref>) [<stashes>]"),
+	N_("git stash import <commit>"),
 	NULL
 };
 
@@ -95,6 +96,10 @@ static const char * const git_stash_export_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_import_usage[] = {
+	N_("git stash import <commit>"),
+	NULL
+};
 
 static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
@@ -104,6 +109,7 @@ static struct strbuf stash_index_path = STRBUF_INIT;
  * b_commit is set to the base commit
  * i_commit is set to the commit containing the index tree
  * u_commit is set to the commit containing the untracked files tree
+ * c_commit is set to the first parent (chain commit) when importing and is otherwise unset
  * w_tree is set to the working tree
  * b_tree is set to the base tree
  * i_tree is set to the index tree
@@ -114,6 +120,7 @@ struct stash_info {
 	struct object_id b_commit;
 	struct object_id i_commit;
 	struct object_id u_commit;
+	struct object_id c_commit;
 	struct object_id w_tree;
 	struct object_id b_tree;
 	struct object_id i_tree;
@@ -138,6 +145,32 @@ static void assert_stash_like(struct stash_info *info, const char *revision)
 		die(_("'%s' is not a stash-like commit"), revision);
 }
 
+static int get_stash_info_for_import(struct stash_info *info, const struct object_id *oid)
+{
+	int has_parents;
+	char hexoid[GIT_MAX_HEXSZ + 1];
+	oid_to_hex_r(hexoid, oid);
+
+	oidcpy(&info->w_commit, oid);
+	if (get_oidf(&info->w_tree, "%s:", hexoid))
+		return -1;
+
+	has_parents = !get_oidf(&info->c_commit, "%s^1", hexoid);
+
+	/* If this tree is the empty one and we have no parents, we've reached the end. */
+	if (oideq(&info->w_tree, the_hash_algo->empty_tree) && !has_parents)
+		return 1;
+	if (get_oidf(&info->b_commit, "%s^2", hexoid) ||
+	    get_oidf(&info->i_commit, "%s^3", hexoid) ||
+	    get_oidf(&info->b_tree, "%s^2:", hexoid) ||
+	    get_oidf(&info->i_tree, "%s^3:", hexoid))
+		return -1;
+
+	info->has_u = !get_oidf(&info->u_commit, "%s^4", hexoid) &&
+		      !get_oidf(&info->u_tree, "%s^4:", hexoid);
+	return 0;
+}
+
 static int get_stash_info_1(struct stash_info *info, const char *commit, int quiet)
 {
 	int ret;
@@ -1827,6 +1860,96 @@ static char *write_commit_with_parents(struct object_id *out, const struct stash
 	return msg;
 }
 
+static int do_import_stash(const char *rev)
+{
+	struct object_id oid;
+	size_t nitems = 0, nalloc = 0;
+	struct stash_info *items = NULL;
+	int res = 0;
+
+	if (get_oid(rev, &oid))
+		return error(_("not a valid revision: %s"), rev);
+
+	/*
+	 * Walk the commit history, finding each stash entry, and load data into
+	 * the array.
+	 */
+	for (size_t i = 0;; i++, nitems++) {
+		int ret;
+
+		if (nalloc <= i) {
+			size_t new = nalloc * 3 / 2 + 5;
+			items = xrealloc(items, new * sizeof(*items));
+			nalloc = new;
+		}
+		memset(&items[i], 0, sizeof(*items));
+		/* We want this to be quiet because it might not exist. */
+		ret = get_stash_info_for_import(&items[i], &oid);
+		if (ret < 0)
+			return error(_("%s is not a valid exported stash commit"), oid_to_hex(&oid));
+		if (ret)
+			break;
+		oidcpy(&oid, &items[i].c_commit);
+	}
+
+	/*
+	 * Now, walk each entry, adding it to the stash as a normal stash
+	 * commit.
+	 */
+	for (ssize_t i = nitems - 1; i >= 0; i--) {
+		struct commit_list *parents = NULL;
+		struct commit_list **next = &parents;
+		struct object_id out;
+		char *msg;
+
+		next = commit_list_append(lookup_commit_reference(the_repository, &items[i].b_commit), next);
+		next = commit_list_append(lookup_commit_reference(the_repository, &items[i].i_commit), next);
+		if (items[i].has_u)
+			next = commit_list_append(lookup_commit_reference(the_repository,
+								   &items[i].u_commit),
+						  next);
+
+		msg = write_commit_with_parents(&out, &items[i], parents);
+		if (!msg) {
+			res = -1;
+			goto out;
+		}
+		if (do_store_stash(&out, msg, 1)) {
+			free(msg);
+			res = -1;
+			error(_("Cannot save the current status"));
+			goto out;
+		}
+		free(msg);
+	}
+out:
+	for (size_t i = 0; i < nitems; i++) {
+		free_stash_info(&items[i]);
+	}
+	free(items);
+
+	return res;
+}
+
+static int import_stash(int argc, const char **argv, const char *prefix)
+{
+	int ret = 0;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_import_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc != 1)
+		return error(_("a revision to import from is required"));
+
+
+	ret = do_import_stash(argv[0]);
+	return ret;
+}
+
 static int do_export_stash(const char *ref, size_t argc, const char **argv)
 {
 	struct object_id base;
@@ -1996,6 +2119,8 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 		return !!save_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "export"))
 		return !!export_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "import"))
+		return !!import_stash(argc, argv, prefix);
 	else if (*argv[0] != '-')
 		usage_msg_optf(_("unknown subcommand: %s"),
 			       git_stash_usage, options, argv[0]);
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b149e2af44..d2ddede9be 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1295,6 +1295,58 @@ test_expect_success 'stash --keep-index with file deleted in index does not resu
 	test_path_is_missing to-remove
 '
 
+test_expect_success 'stash export and import round-trip stashes' '
+	git reset &&
+	>untracked &&
+	>tracked1 &&
+	>tracked2 &&
+	git add tracked* &&
+	git stash -- &&
+	>subdir/untracked &&
+	>subdir/tracked1 &&
+	>subdir/tracked2 &&
+	git add subdir/tracked* &&
+	git stash -- subdir/ &&
+	stash0=$(git rev-parse --verify stash@{0}) &&
+	stash1=$(git rev-parse --verify stash@{1}) &&
+	simple=$(git stash export --print) &&
+	git stash clear &&
+	git stash import "$simple" &&
+	imported0=$(git rev-parse --verify stash@{0}) &&
+	imported1=$(git rev-parse --verify stash@{1}) &&
+	test "$imported0" = "$stash0" &&
+	test "$imported1" = "$stash1" &&
+	git stash export --to-ref refs/heads/foo &&
+	git stash clear &&
+	git stash import foo &&
+	imported0=$(git rev-parse --verify stash@{0}) &&
+	imported1=$(git rev-parse --verify stash@{1}) &&
+	test "$imported0" = "$stash0" &&
+	test "$imported1" = "$stash1"
+'
+
+test_expect_success 'stash import appends commits' '
+	git log --format=oneline -g refs/stash >actual &&
+	echo $(cat actual | wc -l) >count &&
+	git stash import refs/heads/foo &&
+	git log --format=oneline -g refs/stash >actual &&
+	test_line_count = $(($(cat count) * 2)) actual
+'
+
+test_expect_success 'stash export can accept specified stashes' '
+	git stash clear &&
+	git stash import foo &&
+	git stash export --to-ref bar stash@{1} stash@{0} &&
+	git stash clear &&
+	git stash import bar &&
+	imported0=$(git rev-parse --verify stash@{0}) &&
+	imported1=$(git rev-parse --verify stash@{1}) &&
+	test "$imported1" = "$stash0" &&
+	test "$imported0" = "$stash1" &&
+	git log --format=oneline -g refs/stash >actual &&
+	test_line_count = 2 actual
+'
+
 test_expect_success 'stash apply should succeed with unmodified file' '
 	echo base >file &&
 	git add file &&
