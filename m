From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] log: do not segfault on gmtime errors
Date: Mon, 24 Feb 2014 02:49:05 -0500
Message-ID: <20140224074905.GE9969@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 24 08:49:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHqHp-0001GE-7V
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 08:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbaBXHtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 02:49:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:55865 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751175AbaBXHtH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 02:49:07 -0500
Received: (qmail 14903 invoked by uid 102); 24 Feb 2014 07:49:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 01:49:07 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 02:49:05 -0500
Content-Disposition: inline
In-Reply-To: <20140224073348.GA20221@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242570>

Many code paths assume that show_date and show_ident_date
cannot return NULL. For the most part, we handle missing or
corrupt timestamps by showing the epoch time t=0.

However, we might still return NULL if gmtime rejects the
time_t we feed it, resulting in a segfault. Let's catch this
case and just format t=0.

Signed-off-by: Jeff King <peff@peff.net>
---
This test is of questionable portability, since we are depending on
gmtime's arbitrary point to decide that our input is crazy and return
NULL. The value is sufficiently large that I'd expect most to do so,
though, so it may be safe.

On 32-bit systems, of course, the test does nothing (it is just hitting
the integer overflow code path). But that's OK, since the output is the
same for both cases.

 date.c                 | 6 ++++--
 t/t4212-log-corrupt.sh | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 90b28f7..e1a2cee 100644
--- a/date.c
+++ b/date.c
@@ -184,8 +184,10 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 		tz = local_tzoffset(time);
 
 	tm = time_to_tm(time, tz);
-	if (!tm)
-		return NULL;
+	if (!tm) {
+		tm = time_to_tm(0, 0);
+		tz = 0;
+	}
 
 	strbuf_reset(&timebuf);
 	if (mode == DATE_SHORT)
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index ba25a2e..3fa1715 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -81,4 +81,12 @@ test_expect_success 'date parser recognizes time_t overflow' '
 	test_cmp expect actual
 '
 
+# date is within 2^63-1, but enough to choke glibc's gmtime
+test_expect_success 'absurdly far-in-future dates produce sentinel' '
+	commit=$(munge_author_date HEAD 999999999999999999) &&
+	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
+	git log -1 --format=%ad $commit >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.5.2.500.g8060133
