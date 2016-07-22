Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF00A20195
	for <e@80x24.org>; Fri, 22 Jul 2016 16:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbcGVQ2r (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 12:28:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:48683 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751914AbcGVQ2r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 12:28:47 -0400
Received: (qmail 13118 invoked by uid 102); 22 Jul 2016 16:28:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 12:28:47 -0400
Received: (qmail 7280 invoked by uid 107); 22 Jul 2016 16:29:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 12:29:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2016 12:28:44 -0400
Date:	Fri, 22 Jul 2016 12:28:44 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 1/3] contrib/git-jump: fix greedy regex when matching hunks
Message-ID: <20160722162844.GA14080@sigill.intra.peff.net>
References: <20160722162707.GA13905@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160722162707.GA13905@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The hunk-header regex looks for "\+\d+" to find the
post-image line numbers, but it skips the pre-image line
numbers with a simple ".*". That means we may greedily eat
the post-image numbers and match a "\+\d" further on, in the
funcname text.

For example, commit 6b9c38e has this hunk header:

  diff --git a/t/t0006-date.sh b/t/t0006-date.sh
  [...]
  @@ -50,8 +50,8 @@ check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'

If you run:

  git checkout 6b9c38e
  git jump diff HEAD^ t/

it will erroneously match "+0000" as the starting line
number and jump there, rather than line 50.

We can fix it by just making the "skip" regex non-greedy,
taking the first "+" we see, which should be the post-image
line information.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/git-jump/git-jump | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index dc90cd6..1f1b996 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -25,7 +25,7 @@ mode_diff() {
 	perl -ne '
 	if (m{^\+\+\+ (.*)}) { $file = $1; next }
 	defined($file) or next;
-	if (m/^@@ .*\+(\d+)/) { $line = $1; next }
+	if (m/^@@ .*?\+(\d+)/) { $line = $1; next }
 	defined($line) or next;
 	if (/^ /) { $line++; next }
 	if (/^[-+]\s*(.*)/) {
-- 
2.9.2.506.g8452fe7

