From: Jeff King <peff@peff.net>
Subject: [PATCH 7/9] remote-curl: recognize text/plain with a charset
 parameter
Date: Wed, 21 May 2014 06:33:01 -0400
Message-ID: <20140521103301.GG30464@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 12:33:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn3pd-0006D8-0C
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 12:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbaEUKdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 06:33:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:56423 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980AbaEUKdD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 06:33:03 -0400
Received: (qmail 365 invoked by uid 102); 21 May 2014 10:33:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 05:33:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 06:33:01 -0400
Content-Disposition: inline
In-Reply-To: <20140521102524.GA30301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249788>

Commit 426e70d (remote-curl: show server content on http
errors, 2013-04-05) tried to recognize text/plain content
types, but fails to do so if they have any parameters.

This patches makes our parsing more liberal, though we still
do not do anything useful with a charset parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c              | 26 ++++++++++++++++++--------
 t/lib-httpd/error.sh       |  8 +++++++-
 t/t5550-http-fetch-dumb.sh |  5 +++++
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index a5ab977..6d1b206 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -194,20 +194,30 @@ static void free_discovery(struct discovery *d)
 	}
 }
 
+/*
+ * We only show text/plain parts, as other types are likely
+ * to be ugly to look at on the user's terminal.
+ */
+static int content_type_is_terminal_friendly(struct strbuf *type)
+{
+	const char *p;
+
+	p = skip_prefix(type->buf, "text/plain");
+	if (!p || (*p && *p != ';'))
+		return 0;
+
+	return 1;
+}
+
 static int show_http_message(struct strbuf *type, struct strbuf *msg)
 {
 	const char *p, *eol;
 
-	/*
-	 * We only show text/plain parts, as other types are likely
-	 * to be ugly to look at on the user's terminal.
-	 *
-	 * TODO should handle "; charset=XXX", and re-encode into
-	 * logoutputencoding
-	 */
-	if (strcmp(type->buf, "text/plain"))
+	if (!content_type_is_terminal_friendly(type))
 		return -1;
 
+	/* TODO should record charset and reencode msg to logOutputEncoding */
+
 	strbuf_trim(msg);
 	if (!msg->len)
 		return -1;
diff --git a/t/lib-httpd/error.sh b/t/lib-httpd/error.sh
index 786f281..02e80b3 100755
--- a/t/lib-httpd/error.sh
+++ b/t/lib-httpd/error.sh
@@ -3,6 +3,7 @@
 printf "Status: 500 Intentional Breakage\n"
 
 printf "Content-Type: "
+charset=iso8859-1
 case "$PATH_INFO" in
 *html*)
 	printf "text/html"
@@ -10,8 +11,13 @@ case "$PATH_INFO" in
 *text*)
 	printf "text/plain"
 	;;
+*charset*)
+	printf "text/plain; charset=utf-8"
+	charset=utf-8
+	;;
 esac
 printf "\n"
 
 printf "\n"
-printf "this is the error message\n"
+printf "this is the error message\n" |
+iconv -f us-ascii -t $charset
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 13defd3..b35b261 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -181,5 +181,10 @@ test_expect_success 'git client does not show html errors' '
 	! grep "this is the error message" stderr
 '
 
+test_expect_success 'git client shows text/plain with a charset' '
+	test_must_fail git clone "$HTTPD_URL/error/charset" 2>stderr &&
+	grep "this is the error message" stderr
+'
+
 stop_httpd
 test_done
-- 
2.0.0.rc1.436.g03cb729
