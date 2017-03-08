Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A424F202F8
	for <e@80x24.org>; Wed,  8 Mar 2017 11:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbdCHLeM (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 06:34:12 -0500
Received: from crossperf.com ([5.39.84.17]:56382 "EHLO crossperf.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752062AbdCHLdo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 06:33:44 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Mar 2017 06:33:43 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crossperf.com; s=rsa2048; h=Message-ID:Sender:Content-Transfer-Encoding:
        Content-Type:Mime-Version:Subject:Cc:To:From:Date:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X/zNPooQqDxTYkY1DYe57enHm20MnIn1iXXR3bxJK+g=; b=g5qIUm1drq3hn1SvtV/i9+Dcu/
        6EQpHmUTzf1TsoLsIGTzbmDkgUFh4QvIFxLl6cW06/3pxCkv8lsclh31tE+pUr04fZk8tRoSQk1Iq
        MYgNcMOj429ubtlFl8aiPjYzPTr9Nsgi0mCZe110Qh/ASxTisW+LLq249JDupUEeKpHbyTIUe+OvY
        YQDfreef+LeYQ2NH1MuKxyjFKubRivbE5lnsEPv1Xs1im06B6NPd/EiPe0BJoKYrTlapsrQpvhATW
        u0Cba8ZpcoPCGhPaC+X612d8uM7IpWI//1BDAVhK6cQH43q2zCetrZiaVD6DoIGR4I5OKrIdlPf7X
        KuPehRvw==;
Date:   Wed, 08 Mar 2017 09:50:53 +0000
From:   mash <mash+git@crossperf.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        =?UTF-8?B?xaB0xJtww6Fu?= =?UTF-8?B?IE7Em21lYw==?= 
        <stepnem@gmail.com>
Subject: [PATCH] diff: allow "-" as a short-hand for "last branch"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Message-ID: <1clZj4-0006vN-9q@crossperf.com>
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
This is a GSoC microproject. I'm not sure how useful this change is.
Please review it and take it apart.

I'm not very happy with the change of handle_revision_arg.
Maybe I should teach sha1_name.c:get_sha1_basic how to handle a dash
instead.

Documentation was not updated. I could only think of updating revisions.txt but
that might be misleading since the use of dash does not work everywhere.

 revision.c           | 22 ++++++++++++++++++--
 t/t4063-diff-last.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 2 deletions(-)
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
index 0000000..1f635cb
--- /dev/null
+++ b/t/t4063-diff-last.sh
@@ -0,0 +1,58 @@
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
+test_expect_success '"diff -.." diffs against previous branch' '
+	git diff -.. >out &&
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
