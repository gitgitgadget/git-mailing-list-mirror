Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6287205C9
	for <e@80x24.org>; Fri,  6 Jan 2017 04:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754940AbdAFESP (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 23:18:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:35822 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753483AbdAFESM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 23:18:12 -0500
Received: (qmail 12856 invoked by uid 109); 6 Jan 2017 04:18:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 04:18:11 +0000
Received: (qmail 14315 invoked by uid 111); 6 Jan 2017 04:19:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Jan 2017 23:19:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jan 2017 23:18:09 -0500
Date:   Thu, 5 Jan 2017 23:18:08 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] blame: handle --no-abbrev
Message-ID: <20170106041808.bd6ts7tkhjqyju7r@sigill.intra.peff.net>
References: <20170106041541.rjzzofal5hscv6yi@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106041541.rjzzofal5hscv6yi@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can already ask blame for full sha1s with "-l" or with
"--abbrev=40". But for consistency with other parts of Git,
we should support "--no-abbrev".

Worse, blame already accepts --no-abbrev, but it's totally
broken. When we see --no-abbrev, the abbrev variable is set
to 0, which is then used as a printf precision. For regular
sha1s, that means we print nothing at all (which is very
wrong). For boundary commits we decrement it to "-1", which
printf interprets as "no limit" (which is almost correct,
except it misses the 39-length magic explained in the
previous commit).

Let's detect --no-abbrev and behave as if --abbrev=40 was
given.

Signed-off-by: Jeff King <peff@peff.net>
---
I also wondered if we needed to clamp this within MINIMUM_ABBREV, but
that is done for us already by the parseopt handler.

 builtin/blame.c  | 2 ++
 t/t8002-blame.sh | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index 1d312542de..c6170fed81 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2659,6 +2659,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (0 < abbrev && abbrev < GIT_SHA1_HEXSZ)
 		/* one more abbrev length is needed for the boundary commit */
 		abbrev++;
+	else if (!abbrev)
+		abbrev = GIT_SHA1_HEXSZ;
 
 	if (revs_file && read_ancestry(revs_file))
 		die_errno("reading graft file '%s' failed", revs_file);
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index c6347ad8fd..380e1c1054 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -114,4 +114,8 @@ test_expect_success 'blame --abbrev=40 behaves like -l' '
 	check_abbrev 39 --abbrev=40 ^HEAD
 '
 
+test_expect_success '--no-abbrev works like --abbrev=40' '
+	check_abbrev 40 --no-abbrev
+'
+
 test_done
-- 
2.11.0.519.g31435224cf

