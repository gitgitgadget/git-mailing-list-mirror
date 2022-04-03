Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82DDC433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 18:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359754AbiDCSY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 14:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359741AbiDCSYu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 14:24:50 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B750344D1
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 11:22:55 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B061F5A3EB;
        Sun,  3 Apr 2022 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649010174;
        bh=7iPBuR3wtPemFXqruLNpI0UpKKQtSK/F6Oia6R5EsGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=VtB9wciaxRd6LeWDnq9wOXjtt+zjBThdoQjU3BFWPuHXj4HIK+xpX1678fjK97MMu
         prwxBct7p3t+A1CFYk2rbJ0Vsf24Dk6oLWsLhzsAICOfw28BXfoTyMX2g+PY2djTw3
         rGZJIFi6XoyiguGGmc9BAcWoaZ1KiAKmLFp/J8ND73rvMoX3nzrxx8OOyImfNCsckM
         jvzEo8z0TzhS3UmHX+wvUnsm91weaO588Drg3D/ML2JtoeFZxu6edRS7J8DJqC/Jgf
         0BjsHeSyvxsEt7aNZDCec2heqiBT6ZZlarf2+O7UHOBNTzFeiYxUPUGWY+UGAPFgfx
         EFx2rZCLgG5PbnSCGf0aOYwX0+wzzbo+Ts9odwV/rvqP1OE7UtlfntUGn4MfpNsSwd
         +NTVm/44JpJ8rWwduSWnHU+MoJyMhd8vkg0khx7LXOZFDjki0WWIVDEX14rewh19ox
         Ocgm5TBOTOKSsswwvt4VS++Yj3BGrTfqL26Mc4oVWb3Gd6NLDtj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/4] builtin/stash: provide a way to import stashes from a ref
Date:   Sun,  3 Apr 2022 18:22:50 +0000
Message-Id: <20220403182250.904933-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220403182250.904933-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-1-sandals@crustytoothpaste.net>
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
see if they already have the same data in both repositories.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-stash.txt |   7 +++
 builtin/stash.c             | 108 ++++++++++++++++++++++++++++++++++++
 t/t3903-stash.sh            |  52 +++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 162110314e..28eb9cab0c 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -21,6 +21,7 @@ SYNOPSIS
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 'git stash' export ( --print | --to-ref <ref> ) [<stash>...]
+'git stash' import <commit>
 
 DESCRIPTION
 -----------
@@ -158,6 +159,12 @@ export ( --print | --to-ref <ref> ) [<stash>...]::
 	a chain of commits which can be transferred using the normal fetch and
 	push mechanisms, then imported using the `import` subcommand.
 
+import <commit>::
+
+	Import the specified stashes from the specified commit, which must have been
+	created by `export`, and add them to the list of stashes.  To replace the
+	existing stashes, use `clear` first.
+
 OPTIONS
 -------
 -a::
diff --git a/builtin/stash.c b/builtin/stash.c
index 89e22d0cdd..93b1a996c4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -34,6 +34,7 @@ static const char * const git_stash_usage[] = {
 	N_("git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
 	N_("git stash export (--print | --to-ref <ref>) [<stash>...]"),
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
@@ -1826,6 +1833,105 @@ static int write_commit_with_parents(struct object_id *out, const struct object_
 	return ret;
 }
 
+static int do_import_stash(const char *rev)
+{
+	struct object_id chain;
+	size_t nalloc = 0;
+	struct object_id *items = NULL;
+	int nitems = 0;
+	int res = 0;
+	int i;
+	const char *buffer = NULL;
+	struct commit *this = NULL;
+	char *msg = NULL;
+
+	if (get_oid(rev, &chain))
+		return error(_("not a valid revision: %s"), rev);
+
+	/*
+	 * Walk the commit history, finding each stash entry, and load data into
+	 * the array.
+	 */
+	for (i = 0;; i++) {
+		struct object_id tree, oid;
+		char revision[GIT_MAX_HEXSZ + 1];
+
+		oid_to_hex_r(revision, &chain);
+
+		if (get_oidf(&tree, "%s:", revision) ||
+		    !oideq(&tree, the_hash_algo->empty_tree)) {
+			return error(_("%s is not a valid exported stash commit"), revision);
+		}
+		if (get_oidf(&chain, "%s^1", revision) ||
+		    get_oidf(&oid, "%s^2", revision))
+			break;
+		ALLOC_GROW_BY(items, nitems, 1, nalloc);
+		oidcpy(&items[i], &oid);
+	}
+
+	/*
+	 * Now, walk each entry, adding it to the stash as a normal stash
+	 * commit.
+	 */
+	for (i = nitems - 1; i >= 0; i--) {
+		unsigned long bufsize;
+		const char *p;
+
+		this = lookup_commit_reference(the_repository, &items[i]);
+		buffer = get_commit_buffer(this, &bufsize);
+		if (!buffer) {
+			res = -1;
+			error(_("cannot read commit buffer for %s"), oid_to_hex(&items[i]));
+			goto out;
+		}
+
+		p = memmem(buffer, bufsize, "\n\n", 2);
+		if (!p) {
+			res = -1;
+			error(_("cannot parse commit %s"), oid_to_hex(&items[i]));
+			goto out;
+		}
+
+		p += 2;
+		msg = xmemdupz(p, bufsize - (p - buffer));
+		unuse_commit_buffer(this, buffer);
+		buffer = NULL;
+
+		if (do_store_stash(&items[i], msg, 1)) {
+			res = -1;
+			error(_("cannot save the stash for %s"), oid_to_hex(&items[i]));
+			goto out;
+		}
+		FREE_AND_NULL(msg);
+	}
+out:
+	if (this && buffer)
+		unuse_commit_buffer(this, buffer);
+	free(items);
+	free(msg);
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
@@ -2000,6 +2106,8 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
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
