Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3732013B
	for <e@80x24.org>; Tue, 14 Feb 2017 06:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdBNGF6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 01:05:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:54890 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751089AbdBNGF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 01:05:58 -0500
Received: (qmail 11846 invoked by uid 109); 14 Feb 2017 06:05:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 06:05:58 +0000
Received: (qmail 735 invoked by uid 111); 14 Feb 2017 06:05:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 01:05:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 01:05:55 -0500
Date:   Tue, 14 Feb 2017 01:05:55 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 5/7] grep: fix "--" rev/pathspec disambiguation
Message-ID: <20170214060555.yzh6hhi2t7pkeqvi@sigill.intra.peff.net>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we see "git grep pattern rev -- file" then we apply the
usual rev/pathspec disambiguation rules: any "rev" before
the "--" must be a revision, and we do not need to apply the
verify_non_filename() check.

But there are two bugs here:

  1. We keep a seen_dashdash flag to handle this case, but
     we set it in the same left-to-right pass over the
     arguments in which we parse "rev".

     So when we see "rev", we do not yet know that there is
     a "--", and we mistakenly complain if there is a
     matching file.

     We can fix this by making a preliminary pass over the
     arguments to find the "--", and only then checking the rev
     arguments.

  2. If we can't resolve "rev" but there isn't a dashdash,
     that's OK. We treat it like a path, and complain later
     if it doesn't exist.

     But if there _is_ a dashdash, then we know it must be a
     rev, and should treat it as such, complaining if it
     does not resolve. The current code instead ignores it
     and tries to treat it like a path.

This patch fixes both bugs, and tries to comment the parsing
flow a bit better.

It adds tests that cover the two bugs, but also some related
situations (which already worked, but this confirms that our
fixes did not break anything).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c  | 29 ++++++++++++++++++++++++-----
 t/t7810-grep.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 461347adb..e83b33bda 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1149,7 +1149,22 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	compile_grep_patterns(&opt);
 
-	/* Check revs and then paths */
+	/*
+	 * We have to find "--" in a separate pass, because its presence
+	 * influences how we will parse arguments that come before it.
+	 */
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--")) {
+			seen_dashdash = 1;
+			break;
+		}
+	}
+
+	/*
+	 * Resolve any rev arguments. If we have a dashdash, then everything up
+	 * to it must resolve as a rev. If not, then we stop at the first
+	 * non-rev and assume everything else is a path.
+	 */
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		unsigned char sha1[20];
@@ -1158,13 +1173,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 		if (!strcmp(arg, "--")) {
 			i++;
-			seen_dashdash = 1;
 			break;
 		}
 
-		/* Stop at the first non-rev */
-		if (get_sha1_with_context(arg, 0, sha1, &oc))
+		if (get_sha1_with_context(arg, 0, sha1, &oc)) {
+			if (seen_dashdash)
+				die(_("unable to resolve revision: %s"), arg);
 			break;
+		}
 
 		object = parse_object_or_die(sha1, arg);
 		if (!seen_dashdash)
@@ -1172,7 +1188,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
 	}
 
-	/* The rest are paths */
+	/*
+	 * Anything left over is presumed to be a path. But in the non-dashdash
+	 * "do what I mean" case, we verify and complain when that isn't true.
+	 */
 	if (!seen_dashdash) {
 		int j;
 		for (j = i; j < argc; j++)
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 2c1f7373e..a6011f9b1 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -982,6 +982,39 @@ test_expect_success 'grep -e -- -- path' '
 	test_cmp expected actual
 '
 
+test_expect_success 'dashdash disambiguates rev as rev' '
+	test_when_finished "rm -f master" &&
+	echo content >master &&
+	echo master:hello.c >expect &&
+	git grep -l o master -- hello.c >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'dashdash disambiguates pathspec as pathspec' '
+	test_when_finished "git rm -f master" &&
+	echo content >master &&
+	git add master &&
+	echo master:content >expect &&
+	git grep o -- master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'report bogus arg without dashdash' '
+	test_must_fail git grep o does-not-exist
+'
+
+test_expect_success 'report bogus rev with dashdash' '
+	test_must_fail git grep o hello.c --
+'
+
+test_expect_success 'allow non-existent path with dashdash' '
+	# We need a real match so grep exits with success.
+	tree=$(git ls-tree HEAD |
+	       sed s/hello.c/not-in-working-tree/ |
+	       git mktree) &&
+	git grep o "$tree" -- not-in-working-tree
+'
+
 test_expect_success 'grep --no-index pattern -- path' '
 	rm -fr non &&
 	mkdir -p non/git &&
-- 
2.12.0.rc1.471.ga79ec8999

