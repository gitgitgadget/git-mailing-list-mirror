Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1901F453
	for <e@80x24.org>; Fri, 22 Feb 2019 06:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfBVGXa (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 01:23:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:53858 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725848AbfBVGXa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 01:23:30 -0500
Received: (qmail 29201 invoked by uid 109); 22 Feb 2019 06:23:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 06:23:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19738 invoked by uid 111); 22 Feb 2019 06:23:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 01:23:43 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 01:23:28 -0500
Date:   Fri, 22 Feb 2019 01:23:28 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Bartosz Baranowski <bbaranow@redhat.com>, git@vger.kernel.org
Subject: [PATCH 3/3] bisect: make diff-tree output prettier
Message-ID: <20190222062327.GC10248@sigill.intra.peff.net>
References: <20190222061949.GA9875@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222061949.GA9875@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After completing a bisection, we print out the commit we found using an
internal version of diff-tree. The result is aesthetically lacking:

  - it shows a raw diff, which is generally less informative for human
    readers than "--stat --summary" (which we already decided was nice
    for humans in format-patch's output).

  - by not abbreviating hashes, the result is likely to wrap on most
    people's terminals

  - we don't use "-r", so if the commit touched files in a directory,
    you only get to see the top-level directory mentioned

  - we don't specify "--cc" or similar, so merges print nothing (not
    even the commit message!)

Even though bisect might be driven by scripts, there's no reason to
consider this part of the output as machine-readable (if anything, the
initial "$hash is the first bad commit" might be parsed, but we won't
touch that here). Let's make it prettier and more informative for a
human reading the output.

While we're tweaking the options, let's also switch to using the diff
"ui" config. If we're accepting that this is human-readable output, then
we should respect the user's options for how to display it.

Note that we have to touch a few tests in t6030. These check bisection
in a corrupted repository (it's missing a subtree). They didn't fail
with the previous code, because it didn't actually recurse far enough in
the diff to find the broken tree. But now we'll see the corruption and
complain.

Adjusting the tests to expect the die() is the best fix. We still
confirm that we're able to bisect within the broken repo. And we'll
still print "$hash is the first bad commit" as usual before dying;
showing that is a reasonable outcome in a corrupt repository (and was
what might happen already, if the root tree was corrupt).

Signed-off-by: Jeff King <peff@peff.net>
---
If we do care about the change in exit code from bisect, then it
probably does make sense to go with an external process. Then it can
happily die on the corruption, while bisect continues with the rest of
the high-level operation. I'm not sure it really matters much, though.
Once your repository is corrupted, all bets are off. It's nice that we
can bisect in such a state at all.

 bisect.c                    | 4 ++--
 t/t6030-bisect-porcelain.sh | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index b04d7b2f63..e87ac29a51 100644
--- a/bisect.c
+++ b/bisect.c
@@ -897,11 +897,11 @@ static void show_diff_tree(struct repository *r,
 			   struct commit *commit)
 {
 	const char *argv[] = {
-		"diff-tree", "--pretty", "--no-abbrev", "--raw", NULL
+		"diff-tree", "--pretty", "--stat", "--summary", "--cc", NULL
 	};
 	struct rev_info opt;
 
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+	git_config(git_diff_ui_config, NULL);
 	repo_init_revisions(r, &opt, prefix);
 
 	setup_revisions(ARRAY_SIZE(argv) - 1, argv, &opt, NULL);
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 55835ee4a4..49a394bd75 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -681,7 +681,7 @@ test_expect_success 'bisect: --no-checkout - target in breakage' '
 	check_same BROKEN_HASH6 BISECT_HEAD &&
 	git bisect bad BISECT_HEAD &&
 	check_same BROKEN_HASH5 BISECT_HEAD &&
-	git bisect good BISECT_HEAD &&
+	test_must_fail git bisect good BISECT_HEAD &&
 	check_same BROKEN_HASH6 bisect/bad &&
 	git bisect reset
 '
@@ -692,7 +692,7 @@ test_expect_success 'bisect: --no-checkout - target after breakage' '
 	check_same BROKEN_HASH6 BISECT_HEAD &&
 	git bisect good BISECT_HEAD &&
 	check_same BROKEN_HASH8 BISECT_HEAD &&
-	git bisect good BISECT_HEAD &&
+	test_must_fail git bisect good BISECT_HEAD &&
 	check_same BROKEN_HASH9 bisect/bad &&
 	git bisect reset
 '
@@ -701,7 +701,7 @@ test_expect_success 'bisect: demonstrate identification of damage boundary' "
 	git bisect reset &&
 	git checkout broken &&
 	git bisect start broken master --no-checkout &&
-	git bisect run \"\$SHELL_PATH\" -c '
+	test_must_fail git bisect run \"\$SHELL_PATH\" -c '
 		GOOD=\$(git for-each-ref \"--format=%(objectname)\" refs/bisect/good-*) &&
 		git rev-list --objects BISECT_HEAD --not \$GOOD >tmp.\$\$ &&
 		git pack-objects --stdout >/dev/null < tmp.\$\$
-- 
2.21.0.rc2.577.g06bbe9cbd1
