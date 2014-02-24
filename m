From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] log: handle integer overflow in timestamps
Date: Mon, 24 Feb 2014 02:46:37 -0500
Message-ID: <20140224074637.GD9969@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 24 08:47:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHqFt-0000Pc-Iw
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 08:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbaBXHqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 02:46:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:55863 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752471AbaBXHqj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 02:46:39 -0500
Received: (qmail 14768 invoked by uid 102); 24 Feb 2014 07:46:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 01:46:39 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 02:46:37 -0500
Content-Disposition: inline
In-Reply-To: <20140224073348.GA20221@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242569>

If an ident line has a ridiculous date value like (2^64)+1,
we currently just pass ULONG_MAX along to the date code,
which can produce nonsensical dates.

On systems with a signed long time_t (e.g., 64-bit glibc
systems), this actually doesn't end up too bad. The
ULONG_MAX is converted to -1, we apply the timezone field to
that, and the result ends up somewhere between Dec 31, 1969
and Jan 1, 1970.

However, there is still a few good reasons to detect the
overflow explicitly:

  1. On systems where "unsigned long" is smaller than
     time_t, we get a nonsensical date in the future.

  2. Even where it would produce "Dec 31, 1969", it's easier
     to recognize "midnight Jan 1" as a consistent sentinel
     value for "we could not parse this".

  3.  Values which do not overflow strtoul but do overflow a
      signed time_t produce nonsensical values in the past.
      For example, on a 64-bit system with a signed long
      time_t, a timestamp of 18446744073000000000 produces a
      date in 1947.

We also recognize overflow in the timezone field, which
could produce nonsensical results. In this case we show the
parsed date, but in UTC.

Signed-off-by: Jeff King <peff@peff.net>
---
A note on these tests. They are designed for 64-bit systems, but should
run fine on 32-bit systems (they are both just overflow, and the second
test is not doing anything novel that the first is not).

However, the second test relies on finding a value that fits into an
"unsigned long" but does not fit into a time_t. For systems with a
64-bit signed time_t, that's fine. But if a system has an unsigned
64-bit time_t, the test will fail (it will actually produce some value
300 billion years from now).

I'm inclined to include it as-is, as I do not know of any such system
(and it would be kind of lame, since it could not represent dates before
1970). If somebody comes up with such a system, we can allow either
output (we could do it preemptively, but somebody would have to
calculate the exact date/time billions of years in the future; we would
be just as likely to disagree with the system's gmtime about something
silly like leapseconds).

 pretty.c               | 10 ++++++++--
 t/t4212-log-corrupt.sh | 16 ++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 87db08b..3b811ed 100644
--- a/pretty.c
+++ b/pretty.c
@@ -401,8 +401,14 @@ static const char *show_ident_date(const struct ident_split *ident,
 
 	if (ident->date_begin && ident->date_end)
 		date = strtoul(ident->date_begin, NULL, 10);
-	if (ident->tz_begin && ident->tz_end)
-		tz = strtol(ident->tz_begin, NULL, 10);
+	if (date_overflows(date))
+		date = 0;
+	else {
+		if (ident->tz_begin && ident->tz_end)
+			tz = strtol(ident->tz_begin, NULL, 10);
+		if (tz == LONG_MAX || tz == LONG_MIN)
+			tz = 0;
+	}
 	return show_date(date, tz, mode);
 }
 
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 83de981..ba25a2e 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -65,4 +65,20 @@ test_expect_success 'unparsable dates produce sentinel value (%ad)' '
 	test_cmp expect actual
 '
 
+# date is 2^64 + 1
+test_expect_success 'date parser recognizes integer overflow' '
+	commit=$(munge_author_date HEAD 18446744073709551617) &&
+	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
+	git log -1 --format=%ad $commit >actual &&
+	test_cmp expect actual
+'
+
+# date is 2^64 - 2
+test_expect_success 'date parser recognizes time_t overflow' '
+	commit=$(munge_author_date HEAD 18446744073709551614) &&
+	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
+	git log -1 --format=%ad $commit >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.5.2.500.g8060133
