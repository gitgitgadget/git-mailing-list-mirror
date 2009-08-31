From: Jeff King <peff@peff.net>
Subject: [PATCH v2 4/4] fix approxidate parsing of relative months and years
Date: Sun, 30 Aug 2009 22:31:42 -0400
Message-ID: <20090831023142.GD5507@coredump.intra.peff.net>
References: <20090831022228.GA4833@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 04:31:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhwgS-0006KB-P7
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 04:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbZHaCbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 22:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754269AbZHaCbn
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 22:31:43 -0400
Received: from peff.net ([208.65.91.99]:51407 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754267AbZHaCbn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 22:31:43 -0400
Received: (qmail 20429 invoked by uid 107); 31 Aug 2009 02:31:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 22:31:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 22:31:42 -0400
Content-Disposition: inline
In-Reply-To: <20090831022228.GA4833@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127455>

These were broken by b5373e9. The problem is that the code
marks the month and year with "-1" for "we don't know it
yet", but the month and year code paths were not adjusted to
fill in the current time before doing their calculations
(whereas other units follow a different code path and are
fine).

Signed-off-by: Jeff King <peff@peff.net>
---
This one is new from the last series, as it fixes bugs only found in
lt/approxidate.

 date.c          |    5 ++++-
 t/t0006-date.sh |    4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/date.c b/date.c
index 8e57e5e..e9ee4aa 100644
--- a/date.c
+++ b/date.c
@@ -857,7 +857,9 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 	}
 
 	if (match_string(date, "months") >= 5) {
-		int n = tm->tm_mon - *num;
+		int n;
+		update_tm(tm, now, 0); /* fill in date fields if needed */
+		n = tm->tm_mon - *num;
 		*num = 0;
 		while (n < 0) {
 			n += 12;
@@ -868,6 +870,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 	}
 
 	if (match_string(date, "years") >= 4) {
+		update_tm(tm, now, 0); /* fill in date fields if needed */
 		tm->tm_year -= *num;
 		*num = 0;
 		return end;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 02cd565..a4d8fa8 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -53,8 +53,8 @@ check_approxidate 10.minutes.ago '2009-08-30 19:10:00'
 check_approxidate yesterday '2009-08-29 19:20:00'
 check_approxidate 3.days.ago '2009-08-27 19:20:00'
 check_approxidate 3.weeks.ago '2009-08-09 19:20:00'
-check_approxidate 3.months.ago '2009-05-30 19:20:00' failure
-check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00' failure
+check_approxidate 3.months.ago '2009-05-30 19:20:00'
+check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00'
 
 check_approxidate '6am yesterday' '2009-08-29 06:00:00'
 check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
-- 
1.6.4.2.373.g5881fd
