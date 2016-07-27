Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70CC3203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027AbcG0SzG (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:55:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:50033 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754303AbcG0SzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 14:55:05 -0400
Received: (qmail 2901 invoked by uid 102); 27 Jul 2016 18:55:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 14:55:05 -0400
Received: (qmail 19615 invoked by uid 107); 27 Jul 2016 18:55:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 14:55:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 14:55:02 -0400
Date:	Wed, 27 Jul 2016 14:55:02 -0400
From:	Jeff King <peff@peff.net>
To:	Phil Pennock <phil@pennock-tech.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] t4205: drop top-level &&-chaining
Message-ID: <20160727185501.GA6626@sigill.intra.peff.net>
References: <20160727185256.GA11657@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160727185256.GA11657@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The test currently does something like:

  do_one() &&
  do_two() &&
  test_expect_success ...

We generally avoid performing actions at the top-level of
the script (outside of a test_expect block) for two reasons:

  1. The test harness is not checking and reporting if they
     fail.

  2. Their output is not handled correctly (not hidden by
     default, nor shown with "-v").

Using &&-chains seems like it should help with (1), but it
doesn't. If either of the commands fails, we simply skip
running the follow-on test entirely, and the test harness
has no idea.

We can fix this by pushing that setup into its own block.
It _could_ go into the following test block, but since the
result in this case is used by multiple tests, it's more
clear to mark it explicitly as a distinct setup step.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4205-log-pretty-formats.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index d9f6242..d6518fa 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -504,8 +504,10 @@ test_expect_success 'ISO and ISO-strict date formats display the same values' '
 '
 
 # get new digests (with no abbreviations)
-head1=$(git rev-parse --verify HEAD~0) &&
-head2=$(git rev-parse --verify HEAD~1) &&
+test_expect_success 'set up log decoration tests' '
+	head1=$(git rev-parse --verify HEAD~0) &&
+	head2=$(git rev-parse --verify HEAD~1)
+'
 
 test_expect_success 'log decoration properly follows tag chain' '
 	git tag -a tag1 -m tag1 &&
-- 
2.9.2.607.g98dce7b

