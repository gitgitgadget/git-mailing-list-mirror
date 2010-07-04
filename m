From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t0006: test timezone parsing
Date: Sun, 4 Jul 2010 06:48:35 -0400
Message-ID: <20100704104834.GA23070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 12:54:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVMq1-0005j9-Kv
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 12:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757313Ab0GDKsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jul 2010 06:48:41 -0400
Received: from peff.net ([208.65.91.99]:50197 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756858Ab0GDKsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 06:48:40 -0400
Received: (qmail 29553 invoked by uid 107); 4 Jul 2010 10:49:33 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 04 Jul 2010 06:49:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Jul 2010 06:48:35 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150221>

Previously, test-date simply ignored the parsed timezone and
told show_date() to use UTC. Instead, let's print out what
we actually parsed.

While we're at it, let's make it easy for tests to work in a specific
timezone.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a good idea anyway, but it also makes it easy to write a test
for the next patch.

 t/t0006-date.sh |    5 +++--
 test-date.c     |    9 ++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 75b02af..3ea4f9e 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -28,8 +28,8 @@ check_show 31449600 '12 months ago'
 
 check_parse() {
 	echo "$1 -> $2" >expect
-	test_expect_${3:-success} "parse date ($1)" "
-	test-date parse '$1' >actual &&
+	test_expect_${4:-success} "parse date ($1${3:+ TZ=$3})" "
+	TZ=${3:-$TZ} test-date parse '$1' >actual &&
 	test_cmp expect actual
 	"
 }
@@ -38,6 +38,7 @@ check_parse 2008 bad
 check_parse 2008-02 bad
 check_parse 2008-02-14 bad
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
+check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
 
 check_approxidate() {
 	echo "$1 -> $2 +0000" >expect
diff --git a/test-date.c b/test-date.c
index a9e705f..ac6854a 100644
--- a/test-date.c
+++ b/test-date.c
@@ -21,12 +21,15 @@ static void parse_dates(char **argv, struct timeval *now)
 	for (; *argv; argv++) {
 		char result[100];
 		time_t t;
+		int tz;
 
 		result[0] = 0;
 		parse_date(*argv, result, sizeof(result));
-		t = strtoul(result, NULL, 0);
-		printf("%s -> %s\n", *argv,
-			t ? show_date(t, 0, DATE_ISO8601) : "bad");
+		if (sscanf(result, "%ld %d", &t, &tz) == 2)
+			printf("%s -> %s\n",
+			       *argv, show_date(t, tz, DATE_ISO8601));
+		else
+			printf("%s -> bad\n", *argv);
 	}
 }
 
-- 
1.7.2.rc1.209.g2a36c
