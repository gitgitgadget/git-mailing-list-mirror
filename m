Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4AB205C9
	for <e@80x24.org>; Fri,  6 Jan 2017 04:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939456AbdAFESV (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 23:18:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:35820 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754855AbdAFERn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 23:17:43 -0500
Received: (qmail 12848 invoked by uid 109); 6 Jan 2017 04:17:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 04:17:43 +0000
Received: (qmail 14311 invoked by uid 111); 6 Jan 2017 04:18:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Jan 2017 23:18:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jan 2017 23:17:40 -0500
Date:   Thu, 5 Jan 2017 23:17:40 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] blame: fix alignment with --abbrev=40
Message-ID: <20170106041740.cgyful3263fpnvi2@sigill.intra.peff.net>
References: <20170106041541.rjzzofal5hscv6yi@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106041541.rjzzofal5hscv6yi@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The blame command internally adds 1 to any requested sha1
abbreviation length, and then subtracts it when outputting a
boundary commit. This lets regular and boundary sha1s line
up visually, but it misses one corner case.

When the requested length is 40, we bump the value to 41.
But since we only have 40 characters, that's all we can show
(fortunately the truncation is done by a printf precision
field, so it never tries to read past the end of the
buffer).  So a normal sha1 shows 40 hex characters, and a
boundary sha1 shows "^" plus 40 hex characters. The result
is misaligned.

The "-l" option to show long sha1s gets around this by
skipping the "abbrev" variable entirely and just always
using GIT_SHA1_HEXSZ.  This avoids the "+1" issue, but it
does mean that boundary commits only have 39 characters
printed.  This is somewhat odd, but it does look good
visually: the results are aligned and left-justified. The
alternative would be to allocate an extra column that would
contain either an extra space or the "^" boundary marker.

As this is by definition the human-readable view, it's
probably not that big a deal either way (and of course
--porcelain, etc, correctly produce correct 40-hex sha1s).
But for consistency, this patch teaches --abbrev=40 to
produce the same output as "-l" (always left-aligned, with
40-hex for normal sha1s, and "^" plus 39-hex for
boundaries).

Signed-off-by: Jeff King <peff@peff.net>
---
I mostly didn't explore the extra-column solution out of a sense of
inertia. The "-l" option has behaved this way for years. But it was also
out of laziness, as I doubt anybody cares too much, and it would require
a fair bit of special-casing in the printing routines.

 builtin/blame.c  |  2 +-
 t/t8002-blame.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 4ddfadb71f..1d312542de 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2656,7 +2656,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	} else if (show_progress < 0)
 		show_progress = isatty(2);
 
-	if (0 < abbrev)
+	if (0 < abbrev && abbrev < GIT_SHA1_HEXSZ)
 		/* one more abbrev length is needed for the boundary commit */
 		abbrev++;
 
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index ab79de9544..c6347ad8fd 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -86,4 +86,32 @@ test_expect_success 'blame with showEmail config true' '
 	test_cmp expected_n result
 '
 
+test_expect_success 'set up abbrev tests' '
+	test_commit abbrev &&
+	sha1=$(git rev-parse --verify HEAD) &&
+	check_abbrev () {
+		expect=$1; shift
+		echo $sha1 | cut -c 1-$expect >expect &&
+		git blame "$@" abbrev.t >actual &&
+		perl -lne "/[0-9a-f]+/ and print \$&" <actual >actual.sha &&
+		test_cmp expect actual.sha
+	}
+'
+
+test_expect_success 'blame --abbrev=<n> works' '
+	# non-boundary commits get +1 for alignment
+	check_abbrev 31 --abbrev=30 HEAD &&
+	check_abbrev 30 --abbrev=30 ^HEAD
+'
+
+test_expect_success 'blame -l aligns regular and boundary commits' '
+	check_abbrev 40 -l HEAD &&
+	check_abbrev 39 -l ^HEAD
+'
+
+test_expect_success 'blame --abbrev=40 behaves like -l' '
+	check_abbrev 40 --abbrev=40 HEAD &&
+	check_abbrev 39 --abbrev=40 ^HEAD
+'
+
 test_done
-- 
2.11.0.519.g31435224cf

