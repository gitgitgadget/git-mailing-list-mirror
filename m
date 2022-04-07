Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57363C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 22:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiDGWKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 18:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiDGWKY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 18:10:24 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA8017043
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 14:54:00 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 187D25A3F2;
        Thu,  7 Apr 2022 21:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649368440;
        bh=ZE5Ngr7WJKRyFSo4s8EJRh0mifCQiyL6mIKl/5//AZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gOni8ARMC6+vOpPrelDdioPZHTVFVYVrNzH+TABMfN2MEKIbCvWNTnjarr4ZwcH/C
         jDHUSBakw1gDURHG3b/13FqXjeGDB4I5tEt4Rc0znvoVg83EWDlWXRZe4xupnrwfRL
         9psDobEvMlXnbCy/kmVwmA4OmdTQoXX3gxlHOJ1V0TZ0yEs4+8E6BZ5vETyWhgKlsK
         cd5+1GWcG7p2ZW9ptmGLW/fGR4Sf4b1xcPecDEnPmtiALqh7h6qSeAAghTz4QdGsXj
         6K2KcCm0+bPAGQQmyQnqavETZMrLLPLLnjJ0GhgM3q027S9nsjDFWGAXcptMYZmPRG
         jBKFD83zJmaMjR20fDALCm8xZA6uTFbymFKJCYCGk15H0yVyaqsqOFxU+vbVFo/GVs
         71Q5QDfGcxdFYtPS9ZK2Q8Q+wGDNBGTD/he/h6FF2tXlsJd/CmSLIOj4rxDxwmVnk0
         vr0qTDrLRgfeUXOh5DYJ+Hd45ZvP+ClcYOc8fVhZQYi4u6GVSu7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/4] builtin/stash: provide a way to import stashes from a ref
Date:   Thu,  7 Apr 2022 21:53:52 +0000
Message-Id: <20220407215352.3491567-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220407215352.3491567-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220407215352.3491567-1-sandals@crustytoothpaste.net>
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
 builtin/stash.c             | 105 ++++++++++++++++++++++++++++++++++++
 t/t3903-stash.sh            |  63 ++++++++++++++++++++++
 3 files changed, 175 insertions(+)

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
index 07b0897eda..06fa74c0c2 100644
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
@@ -1827,6 +1834,102 @@ static int write_commit_with_parents(struct object_id *out, const struct object_
 	return ret;
 }
 
+static int do_import_stash(const char *rev)
+{
+	struct object_id chain;
+	struct oid_array items = OID_ARRAY_INIT;
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
+		oid_array_append(&items, &oid);
+	}
+
+	/*
+	 * Now, walk each entry, adding it to the stash as a normal stash
+	 * commit.
+	 */
+	for (i = items.nr - 1; i >= 0; i--) {
+		unsigned long bufsize;
+		const char *p;
+		const struct object_id *oid = items.oid + i;
+
+		this = lookup_commit_reference(the_repository, oid);
+		buffer = get_commit_buffer(this, &bufsize);
+		if (!buffer) {
+			res = -1;
+			error(_("cannot read commit buffer for %s"), oid_to_hex(oid));
+			goto out;
+		}
+
+		p = memmem(buffer, bufsize, "\n\n", 2);
+		if (!p) {
+			res = -1;
+			error(_("cannot parse commit %s"), oid_to_hex(oid));
+			goto out;
+		}
+
+		p += 2;
+		msg = xmemdupz(p, bufsize - (p - buffer));
+		unuse_commit_buffer(this, buffer);
+		buffer = NULL;
+
+		if (do_store_stash(oid, msg, 1)) {
+			res = -1;
+			error(_("cannot save the stash for %s"), oid_to_hex(oid));
+			goto out;
+		}
+		FREE_AND_NULL(msg);
+	}
+out:
+	if (this && buffer)
+		unuse_commit_buffer(this, buffer);
+	oid_array_clear(&items);
+	free(msg);
+
+	return res;
+}
+
+static int import_stash(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_import_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc != 1) {
+		usage_with_options(git_stash_import_usage, options);
+		return -1;
+	}
+
+	return do_import_stash(argv[0]);
+}
+
 static int do_export_stash(const char *ref, int argc, const char **argv)
 {
 	struct object_id base;
@@ -2000,6 +2103,8 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 		return !!save_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "export"))
 		return !!export_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "import"))
+		return !!import_stash(argc, argv, prefix);
 	else if (*argv[0] != '-')
 		usage_msg_optf(_("unknown subcommand: %s"),
 			       git_stash_usage, options, argv[0]);
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b149e2af44..03607a5a38 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -10,6 +10,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_expect_success 'setup' '
+	test_oid_cache <<-EOF
+	export_base sha1:73c9bab443d1f88ac61aa533d2eeaaa15451239c
+	export_base sha256:f210fa6346e3e2ce047bdb570426b17075980c1ac01fec8fc4b75bd3ab4bcfe4
+	EOF
+'
+
 test_expect_success 'usage on cmd and subcommand invalid option' '
 	test_expect_code 129 git stash --invalid-option 2>usage &&
 	grep "or: git stash" usage &&
@@ -1295,6 +1302,62 @@ test_expect_success 'stash --keep-index with file deleted in index does not resu
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
+	git stash --include-untracked -- subdir/ &&
+	git tag t-stash0 stash@{0} &&
+	git tag t-stash1 stash@{1} &&
+	simple=$(git stash export --print) &&
+	git stash clear &&
+	git stash import "$simple" &&
+	test_cmp_rev stash@{0} t-stash0 &&
+	test_cmp_rev stash@{1} t-stash1 &&
+	git stash export --to-ref refs/heads/foo &&
+	git stash clear &&
+	git stash import foo &&
+	test_cmp_rev stash@{0} t-stash0 &&
+	test_cmp_rev stash@{1} t-stash1
+'
+
+test_expect_success 'stash import appends commits' '
+	git log --format=oneline -g refs/stash >out &&
+	cat out out >out2 &&
+	git stash import refs/heads/foo &&
+	git log --format=oneline -g refs/stash >actual &&
+	test_line_count = $(wc -l <out2) actual
+'
+
+test_expect_success 'stash export can accept specified stashes' '
+	git stash clear &&
+	git stash import foo &&
+	git stash export --to-ref bar stash@{1} stash@{0} &&
+	git stash clear &&
+	git stash import bar &&
+	test_cmp_rev stash@{1} t-stash0 &&
+	test_cmp_rev stash@{0} t-stash1 &&
+	git log --format=oneline -g refs/stash >actual &&
+	test_line_count = 2 actual
+'
+
+test_expect_success 'stash can import and export zero stashes' '
+	git stash clear &&
+	git stash export --to-ref baz &&
+	test_cmp_rev "$(test_oid empty_tree)" baz: &&
+	test_cmp_rev "$(test_oid export_base)" baz &&
+	test_must_fail git rev-parse baz^1 &&
+	git stash import baz &&
+	test_must_fail git rev-parse refs/stash
+'
+
 test_expect_success 'stash apply should succeed with unmodified file' '
 	echo base >file &&
 	git add file &&
