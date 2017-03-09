Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4CC6202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 20:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750945AbdCIU0g (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 15:26:36 -0500
Received: from crossperf.com ([5.39.84.17]:33053 "EHLO crossperf.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbdCIU0f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 15:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crossperf.com; s=rsa2048; h=Message-ID:Sender:Content-Transfer-Encoding:
        Content-Type:Mime-Version:Subject:References:In-Reply-To:Cc:To:From:Date:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e3LEXYwlpSfMZoeGoaL2KLHwAC29V1oTfbdavqJ76f4=; b=PS9hy/mRjlZt9TSQ+oeyBIss3O
        I0h1BwH4dIhhcsvASrJ0LsMIzBmGlFFMVZh8wc48a09G9/4We4yTrb3sKzybqAgdm/VqiIJEBthln
        P22ezBcrXG+SE1RyiGfveQpRwFFGNCfQimbnT6ookSIgVV1vjhZJ35mCvBlD2H5gt92rmVQaSkerh
        fyyqxpA6BzZh/wfrw+FOglYeUgVWHdWF8SLPV8w5q9h7tuGwjMhEOUXG7cZgp3lTHUoMpFI2ggyGL
        mVAS0uP9msEiowxRku5y7xZ11XbjICV/2DMOIJ0Y2r04OZDr9WXOhPmOq5U4G04oM6ikAaTo+N0DV
        3d+ZJUeQ==;
Date:   Thu, 09 Mar 2017 20:26:24 +0000
From:   mash <mash+git@crossperf.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Vedant Bassi <sharababy.dev@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
In-Reply-To: <1clZj4-0006vN-9q@crossperf.com>
References: <1clZj4-0006vN-9q@crossperf.com>
Subject: [PATCH v2 GSoC RFC] diff: allow "-" as a short-hand for "last branch"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Message-ID: <1cm4dm-0007OE-MZ@crossperf.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like "git merge -" is a short-hand for "git merge @{-1}" to
conveniently merge the previous branch, "git diff -" is a short-hand for
"git diff @{-1}" to conveniently diff against the previous branch.

Allow the usage of "-" in the dot dot notation to allow the use of
"git diff -..HEAD^" as a short-hand for "git diff @{-1}..HEAD^".

Signed-off-by: mash <mash+git@crossperf.com>
---
Add tests to confirm that passing in this short-hand from stdin works.

Handling the dash in sha1_name:get_sha1_basic is not an issue but git was
designed with the dash in mind for options not for this weird short-hand so as
long as there's no decision made that git should actually have this short-hand
everywhere it does not seem like a good idea to change anything in there
because it would probably have unwanted side-effects.

For example for now just handle_revision_arg was modified which is mainly used
by git diff but also used in builtin/pack-objects.c:get_object_list#2785 which
is terrible since this may have already introduced an unwanted the side-effect.

Bypassing the whatever starts with a dash is always an option filters is not a
nice thing to do either.

Overall I see the benefit of the dash short-hand when doing checkouts since
it's very similar to "cd -" and switching between two branches is something one
would commonly do but for every git command where executing it twice results
into the same action achieving the same result twice it seems like a not that
useful short-hand.

Example:
master# g co maint
maint# g co -  # Switch to master
master# g co -  # Switch to maint (different result)
maint# g d -  # diff master..HEAD
maint# g d -  # diff master..HEAD (same result - less useful)

This is obviously only my own option.
Because of what was stated above I've now marked this as open for discussion
since I'm currently not convinced that applying the patch is a good idea.

 revision.c           | 22 +++++++++++++++--
 t/t4063-diff-last.sh | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 2 deletions(-)
 create mode 100755 t/t4063-diff-last.sh

diff --git a/revision.c b/revision.c
index b37dbec..c331bd5 100644
--- a/revision.c
+++ b/revision.c
@@ -1439,6 +1439,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	const char *arg = arg_;
 	int cant_be_filename = revarg_opt & REVARG_CANNOT_BE_FILENAME;
 	unsigned get_sha1_flags = 0;
+	static const char previous_branch[] = "@{-1}";
 
 	flags = flags & UNINTERESTING ? flags | BOTTOM : flags & ~BOTTOM;
 
@@ -1457,6 +1458,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 
 		if (!*next)
 			next = head_by_default;
+		else if (!strcmp(next, "-"))
+			next = previous_branch;
 		if (dotdot == arg)
 			this = head_by_default;
 		if (this == head_by_default && next == head_by_default &&
@@ -1469,6 +1472,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 				*dotdot = '.';
 				return -1;
 			}
+		} else if (!strcmp(this, "-")) {
+			this = previous_branch;
 		}
 		if (!get_sha1_committish(this, from_sha1) &&
 		    !get_sha1_committish(next, sha1)) {
@@ -1568,6 +1573,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	if (revarg_opt & REVARG_COMMITTISH)
 		get_sha1_flags = GET_SHA1_COMMITTISH;
 
+	if (!strcmp(arg, "-"))
+		arg = previous_branch;
 	if (get_sha1_with_context(arg, get_sha1_flags, sha1, &oc))
 		return revs->ignore_missing ? 0 : -1;
 	if (!cant_be_filename)
@@ -1578,6 +1585,15 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	return 0;
 }
 
+/*
+ * Check if the argument is supposed to be a revision argument instead of an
+ * option even though it starts with a dash.
+ */
+static int is_revision_arg(const char *arg)
+{
+	return *arg == '\0' || starts_with(arg, "..");
+}
+
 struct cmdline_pathspec {
 	int alloc;
 	int nr;
@@ -1621,7 +1637,9 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 				seen_dashdash = 1;
 				break;
 			}
-			die("options not supported in --stdin mode");
+			if (!is_revision_arg(sb.buf + 1)) {
+				die("options not supported in --stdin mode");
+			}
 		}
 		if (handle_revision_arg(sb.buf, revs, 0,
 					REVARG_CANNOT_BE_FILENAME))
@@ -2205,7 +2223,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (*arg == '-') {
+		if (*arg == '-' && !is_revision_arg(arg + 1)) {
 			int opts;
 
 			opts = handle_revision_pseudo_opt(submodule,
diff --git a/t/t4063-diff-last.sh b/t/t4063-diff-last.sh
new file mode 100755
index 0000000..dc28f9d
--- /dev/null
+++ b/t/t4063-diff-last.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description='diff against last branch'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello >world &&
+	git add world &&
+	git commit -m initial &&
+	git branch other &&
+	echo "hello again" >>world &&
+	git add world &&
+	git commit -m second
+'
+
+test_expect_success '"diff -" does not work initially' '
+	test_must_fail git diff -
+'
+
+test_expect_success '"diff -" diffs against previous branch' '
+	git checkout other &&
+
+	cat <<-\EOF >expect &&
+	diff --git a/world b/world
+	index c66f159..ce01362 100644
+	--- a/world
+	+++ b/world
+	@@ -1,2 +1 @@
+	 hello
+	-hello again
+	EOF
+
+	git diff - >out &&
+	test_cmp expect out
+'
+
+test_expect_success '"diff -" arguments from stdin' '
+	echo "-" | git diff --stdin >out &&
+	test_cmp expect out
+'
+
+test_expect_success '"diff -.." diffs against previous branch' '
+	git diff -.. >out &&
+	test_cmp expect out
+'
+
+test_expect_success '"diff -.." arguments from stdin' '
+	echo "-.." | git diff --stdin >out &&
+	test_cmp expect out
+'
+
+test_expect_success '"diff ..-" diffs inverted' '
+	cat <<-\EOF >expect &&
+	diff --git a/world b/world
+	index ce01362..c66f159 100644
+	--- a/world
+	+++ b/world
+	@@ -1 +1,2 @@
+	 hello
+	+hello again
+	EOF
+
+	git diff ..- >out &&
+	test_cmp expect out
+'
+
+test_done
-- 
2.9.3
