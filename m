From: Jeff King <peff@peff.net>
Subject: [PATCH 9/9] remote-curl: reencode http error messages
Date: Wed, 21 May 2014 06:33:53 -0400
Message-ID: <20140521103353.GI30464@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 12:33:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn3qR-0007b0-Ar
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 12:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbaEUKd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 06:33:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:56429 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980AbaEUKdz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 06:33:55 -0400
Received: (qmail 444 invoked by uid 102); 21 May 2014 10:33:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 05:33:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 06:33:53 -0400
Content-Disposition: inline
In-Reply-To: <20140521102524.GA30301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249790>

As of the last commit, we now recognize an error message
with a content-type "text/plain; charset=utf-16" as text,
but we ignore the charset parameter entirely. Let's encode
it to log_output_encoding, which is presumably something the
user's terminal can handle.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c              | 37 +++++++++++++++++++++++++++++++++----
 t/lib-httpd/error.sh       |  4 ++++
 t/t5550-http-fetch-dumb.sh |  5 +++++
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 6d1b206..1dc90d7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -194,11 +194,34 @@ static void free_discovery(struct discovery *d)
 	}
 }
 
+static char *find_param(const char *str, const char *name)
+{
+	int len = strlen(name);
+
+	for (; *str; str++) {
+		const char *p;
+
+		if (*p++ != ' ')
+			continue;
+
+		if (strncmp(p, name, len))
+			continue;
+		p += len;
+
+		if (*p++ != '=')
+			continue;
+
+		return xstrndup(p, strchrnul(p, ' ') - p);
+	}
+
+	return NULL;
+}
+
 /*
  * We only show text/plain parts, as other types are likely
  * to be ugly to look at on the user's terminal.
  */
-static int content_type_is_terminal_friendly(struct strbuf *type)
+static int content_type_is_terminal_friendly(struct strbuf *type, char **charset)
 {
 	const char *p;
 
@@ -206,17 +229,23 @@ static int content_type_is_terminal_friendly(struct strbuf *type)
 	if (!p || (*p && *p != ';'))
 		return 0;
 
+	*charset = find_param(p, "charset");
+	/* default charset from rfc2616 */
+	if (!*charset)
+		*charset = xstrdup("iso8859-1");
+
 	return 1;
 }
 
 static int show_http_message(struct strbuf *type, struct strbuf *msg)
 {
 	const char *p, *eol;
+	char *charset;
 
-	if (!content_type_is_terminal_friendly(type))
+	if (!content_type_is_terminal_friendly(type, &charset))
 		return -1;
-
-	/* TODO should record charset and reencode msg to logOutputEncoding */
+	strbuf_reencode(msg, charset, get_log_output_encoding());
+	free(charset);
 
 	strbuf_trim(msg);
 	if (!msg->len)
diff --git a/t/lib-httpd/error.sh b/t/lib-httpd/error.sh
index 02e80b3..4efbce7 100755
--- a/t/lib-httpd/error.sh
+++ b/t/lib-httpd/error.sh
@@ -15,6 +15,10 @@ case "$PATH_INFO" in
 	printf "text/plain; charset=utf-8"
 	charset=utf-8
 	;;
+*utf16*)
+	printf "text/plain; charset=utf-16"
+	charset=utf-16
+	;;
 esac
 printf "\n"
 
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index b35b261..01b8aae 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -186,5 +186,10 @@ test_expect_success 'git client shows text/plain with a charset' '
 	grep "this is the error message" stderr
 '
 
+test_expect_success 'http error messages are reencoded' '
+	test_must_fail git clone "$HTTPD_URL/error/utf16" 2>stderr &&
+	grep "this is the error message" stderr
+'
+
 stop_httpd
 test_done
-- 
2.0.0.rc1.436.g03cb729
