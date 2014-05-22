From: Jeff King <peff@peff.net>
Subject: [PATCH v2 7/8] remote-curl: reencode http error messages
Date: Thu, 22 May 2014 05:30:29 -0400
Message-ID: <20140522093029.GG15032@sigill.intra.peff.net>
References: <20140522092824.GA14530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 11:30:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnPKd-0004QN-Bq
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312AbaEVJac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:30:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:57257 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752825AbaEVJab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:30:31 -0400
Received: (qmail 11687 invoked by uid 102); 22 May 2014 09:30:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:30:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:30:29 -0400
Content-Disposition: inline
In-Reply-To: <20140522092824.GA14530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249892>

We currently recognize an error message with a content-type
"text/plain; charset=utf-16" as text, but we ignore the
charset parameter entirely. Let's encode it to
log_output_encoding, which is presumably something the
user's terminal can handle.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c              | 17 ++++++++++-------
 t/lib-httpd/error.sh       |  4 ++++
 t/t5550-http-fetch-dumb.sh |  5 +++++
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index a5ab977..4493b38 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -194,19 +194,19 @@ static void free_discovery(struct discovery *d)
 	}
 }
 
-static int show_http_message(struct strbuf *type, struct strbuf *msg)
+static int show_http_message(struct strbuf *type, struct strbuf *charset,
+			     struct strbuf *msg)
 {
 	const char *p, *eol;
 
 	/*
 	 * We only show text/plain parts, as other types are likely
 	 * to be ugly to look at on the user's terminal.
-	 *
-	 * TODO should handle "; charset=XXX", and re-encode into
-	 * logoutputencoding
 	 */
 	if (strcmp(type->buf, "text/plain"))
 		return -1;
+	if (charset->len)
+		strbuf_reencode(msg, charset->buf, get_log_output_encoding());
 
 	strbuf_trim(msg);
 	if (!msg->len)
@@ -225,6 +225,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 {
 	struct strbuf exp = STRBUF_INIT;
 	struct strbuf type = STRBUF_INIT;
+	struct strbuf charset = STRBUF_INIT;
 	struct strbuf buffer = STRBUF_INIT;
 	struct strbuf refs_url = STRBUF_INIT;
 	struct strbuf effective_url = STRBUF_INIT;
@@ -249,6 +250,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 
 	memset(&options, 0, sizeof(options));
 	options.content_type = &type;
+	options.charset = &charset;
 	options.effective_url = &effective_url;
 	options.base_url = &url;
 	options.no_cache = 1;
@@ -259,13 +261,13 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	case HTTP_OK:
 		break;
 	case HTTP_MISSING_TARGET:
-		show_http_message(&type, &buffer);
+		show_http_message(&type, &charset, &buffer);
 		die("repository '%s' not found", url.buf);
 	case HTTP_NOAUTH:
-		show_http_message(&type, &buffer);
+		show_http_message(&type, &charset, &buffer);
 		die("Authentication failed for '%s'", url.buf);
 	default:
-		show_http_message(&type, &buffer);
+		show_http_message(&type, &charset, &buffer);
 		die("unable to access '%s': %s", url.buf, curl_errorstr);
 	}
 
@@ -310,6 +312,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	strbuf_release(&refs_url);
 	strbuf_release(&exp);
 	strbuf_release(&type);
+	strbuf_release(&charset);
 	strbuf_release(&effective_url);
 	strbuf_release(&buffer);
 	last_discovery = last;
diff --git a/t/lib-httpd/error.sh b/t/lib-httpd/error.sh
index 23cec97..eafc9d2 100755
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
