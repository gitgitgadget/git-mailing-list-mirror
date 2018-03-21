Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCABD1FAE2
	for <e@80x24.org>; Wed, 21 Mar 2018 05:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeCUF4j (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 01:56:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:37018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751040AbeCUF4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 01:56:39 -0400
Received: (qmail 29476 invoked by uid 109); 21 Mar 2018 05:56:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 05:56:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7022 invoked by uid 111); 21 Mar 2018 05:57:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 01:57:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 01:56:37 -0400
Date:   Wed, 21 Mar 2018 01:56:37 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Brian Henderson <henderson.bj@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 6/7] diff-highlight: use flush() helper consistently
Message-ID: <20180321055636.GA15674@sigill.intra.peff.net>
References: <20180321054718.GA13936@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321054718.GA13936@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current flush() helper only shows the queued diff but
does not clear the queue. This is conceptually a bug, but it
works because we only call it once at the end of the
program.

Let's teach it to clear the queue, which will let us use it
in more places (one for now, but more in future patches).

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/DiffHighlight.pm | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index 663992e530..e07cd5931d 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -46,10 +46,7 @@ sub handle_line {
 		push @added, $_;
 	}
 	else {
-		show_hunk(\@removed, \@added);
-		@removed = ();
-		@added = ();
-
+		flush();
 		$line_cb->($_);
 		$in_hunk = /^$GRAPH*$COLOR*[\@ ]/;
 	}
@@ -71,6 +68,8 @@ sub flush {
 	# Flush any queued hunk (this can happen when there is no trailing
 	# context in the final diff of the input).
 	show_hunk(\@removed, \@added);
+	@removed = ();
+	@added = ();
 }
 
 sub highlight_stdin {
-- 
2.17.0.rc0.402.ged0b3fd1ee

