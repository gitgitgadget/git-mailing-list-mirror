From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] date: avoid "X years, 12 months" in relative dates
Date: Wed, 20 Apr 2011 11:12:11 +0200
Message-ID: <1d0633318ffc778dfcc1c32ecf80fca0327349d6.1303290693.git.git@drmicha.warpmail.net>
References: <20110420052435.GA28597@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 11:12:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCTSP-0005cf-L1
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 11:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab1DTJMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 05:12:15 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48228 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752762Ab1DTJMN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2011 05:12:13 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6662820CB2;
	Wed, 20 Apr 2011 05:12:13 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 20 Apr 2011 05:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=s7iUM7ZSvCTf5bBkHAuy/sUAzSQ=; b=JgAB7d/IKKyGXVP6kXf7dVet19A0tO1XnSkFnm5kvhvX7B+fyKtd9BIxQmfCqsOBQtDNrajjtqzKscwm2eqW9Dg4t5FdrYlaG1LPOpT//G2lc76oaqBhsmdA8slgiW0UVmPSvvE043OG0xyZa7sTgNFyuuN6TlRHvmRKO/34/+A=
X-Sasl-enc: nm4YoSEX/QJoU5ozXPljykfHB8WoD40/6C9PSaq7j1V6 1303290732
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B2C5A40EA7F;
	Wed, 20 Apr 2011 05:12:12 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.rc1.312.g1936c
In-Reply-To: <20110420052435.GA28597@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171853>

When relative dates are more than about a year ago, we start
writing them as "Y years, M months".  At the point where we
calculate Y and M, we have the time delta specified as a
number of days. We calculate these integers as:

  Y = days / 365
  M = (days % 365 + 15) / 30

This rounds days in the latter half of a month up to the
nearest month, so that day 16 is "1 month" (or day 381 is "1
year, 1 month").

We don't round the year at all, though, meaning we can end
up with "1 year, 12 months", which is silly; it should just
be "2 years".

Implement this differently with months of size

  onemonth = 365/12

so that

  totalmonths = (long)( (days + onemonth/2)/onemonth )
  years = totalmonths / 12
  months = totalmonths % 12

In order to do this without floats, we write the first formula as

  totalmonths = (days*12*2 + 365) / (365*2)

Tests and inspiration by Jeff King.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 date.c          |    5 +++--
 t/t0006-date.sh |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 00f9eb5..cde239c 100644
--- a/date.c
+++ b/date.c
@@ -129,8 +129,9 @@ const char *show_date_relative(unsigned long time, int tz,
 	}
 	/* Give years and months for 5 years or so */
 	if (diff < 1825) {
-		unsigned long years = diff / 365;
-		unsigned long months = (diff % 365 + 15) / 30;
+		unsigned long totalmonths = (diff*12*2 + 365)/(365*2);
+		unsigned long years = totalmonths / 12;
+		unsigned long months = totalmonths % 12;
 		int n;
 		n = snprintf(timebuf, timebuf_size, "%lu year%s",
 				years, (years > 1 ? "s" : ""));
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 1d4d0a5..f87abb5 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -25,6 +25,7 @@ check_show 37500000 '1 year, 2 months ago'
 check_show 55188000 '1 year, 9 months ago'
 check_show 630000000 '20 years ago'
 check_show 31449600 '12 months ago'
+check_show 62985600 '2 years ago'
 
 check_parse() {
 	echo "$1 -> $2" >expect
-- 
1.7.5.rc1.312.g1936c
