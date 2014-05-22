From: Jeff King <peff@peff.net>
Subject: [PATCH v2 4/8] http: extract type/subtype portion of content-type
Date: Thu, 22 May 2014 05:29:47 -0400
Message-ID: <20140522092947.GD15032@sigill.intra.peff.net>
References: <20140522092824.GA14530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 11:29:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnPJx-0003U6-3G
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbaEVJ3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:29:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:57244 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752805AbaEVJ3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:29:48 -0400
Received: (qmail 11604 invoked by uid 102); 22 May 2014 09:29:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:29:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:29:47 -0400
Content-Disposition: inline
In-Reply-To: <20140522092824.GA14530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249889>

When we get a content-type from curl, we get the whole
header line, including any parameters, and without any
normalization (like downcasing or whitespace) applied.
If we later try to match it with strcmp() or even
strcasecmp(), we may get false negatives.

This could cause two visible behaviors:

  1. We might fail to recognize a smart-http server by its
     content-type.

  2. We might fail to relay text/plain error messages to
     users (especially if they contain a charset parameter).

This patch teaches the http code to extract and normalize
just the type/subtype portion of the string. This is
technically passing out less information to the callers, who
can no longer see the parameters. But none of the current
callers cares, and a future patch will add back an
easier-to-use method for accessing those parameters.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c                     | 32 +++++++++++++++++++++++++++++---
 remote-curl.c              |  2 +-
 t/lib-httpd/error.sh       |  8 +++++++-
 t/t5550-http-fetch-dumb.sh |  5 +++++
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 94e1afd..4edf5b9 100644
--- a/http.c
+++ b/http.c
@@ -906,6 +906,29 @@ static CURLcode curlinfo_strbuf(CURL *curl, CURLINFO info, struct strbuf *buf)
 	return ret;
 }
 
+/*
+ * Extract a normalized version of the content type, with any
+ * spaces suppressed, all letters lowercased, and no trailing ";"
+ * or parameters.
+ *
+ * Example:
+ *   "TEXT/PLAIN; charset=utf-8" -> "text/plain"
+ */
+static void extract_content_type(struct strbuf *raw, struct strbuf *type)
+{
+	const char *p;
+
+	strbuf_reset(type);
+	strbuf_grow(type, raw->len);
+	for (p = raw->buf; *p; p++) {
+		if (isspace(*p))
+			continue;
+		if (*p == ';')
+			break;
+		strbuf_addch(type, tolower(*p));
+	}
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -957,9 +980,12 @@ static int http_request(const char *url,
 
 	ret = run_one_slot(slot, &results);
 
-	if (options && options->content_type)
-		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE,
-				options->content_type);
+	if (options && options->content_type) {
+		struct strbuf raw = STRBUF_INIT;
+		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE, &raw);
+		extract_content_type(&raw, options->content_type);
+		strbuf_release(&raw);
+	}
 
 	if (options && options->effective_url)
 		curlinfo_strbuf(slot->curl, CURLINFO_EFFECTIVE_URL,
diff --git a/remote-curl.c b/remote-curl.c
index 52c2d96..a5ab977 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -205,7 +205,7 @@ static int show_http_message(struct strbuf *type, struct strbuf *msg)
 	 * TODO should handle "; charset=XXX", and re-encode into
 	 * logoutputencoding
 	 */
-	if (strcasecmp(type->buf, "text/plain"))
+	if (strcmp(type->buf, "text/plain"))
 		return -1;
 
 	strbuf_trim(msg);
diff --git a/t/lib-httpd/error.sh b/t/lib-httpd/error.sh
index 786f281..23cec97 100755
--- a/t/lib-httpd/error.sh
+++ b/t/lib-httpd/error.sh
@@ -3,6 +3,7 @@
 printf "Status: 500 Intentional Breakage\n"
 
 printf "Content-Type: "
+charset=iso-8859-1
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
