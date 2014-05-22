From: Jeff King <peff@peff.net>
Subject: [PATCH v2 5/8] http: optionally extract charset parameter from
 content-type
Date: Thu, 22 May 2014 05:30:05 -0400
Message-ID: <20140522093005.GE15032@sigill.intra.peff.net>
References: <20140522092824.GA14530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 11:30:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnPKK-0003xZ-9H
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbaEVJaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:30:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:57249 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754202AbaEVJaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:30:07 -0400
Received: (qmail 11628 invoked by uid 102); 22 May 2014 09:30:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:30:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:30:05 -0400
Content-Disposition: inline
In-Reply-To: <20140522092824.GA14530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249890>

Since the previous commit, we now give a sanitized,
shortened version of the content-type header to any callers
who ask for it.

This patch adds back a way for them to cleanly access
specific parameters to the type. We could easily extract all
parameters and make them available via a string_list, but:

  1. That complicates the interface and memory management.

  2. In practice, no planned callers care about anything
     except the charset.

This patch therefore goes with the simplest thing, and we
can expand or change the interface later if it becomes
necessary.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 http.h |  7 +++++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index 4edf5b9..e26ee8b 100644
--- a/http.c
+++ b/http.c
@@ -907,14 +907,44 @@ static CURLcode curlinfo_strbuf(CURL *curl, CURLINFO info, struct strbuf *buf)
 }
 
 /*
+ * Check for and extract a content-type parameter. "raw"
+ * should be positioned at the start of the potential
+ * parameter, with any whitespace already removed.
+ *
+ * "name" is the name of the parameter. The value is appended
+ * to "out".
+ */
+static int extract_param(const char *raw, const char *name,
+			 struct strbuf *out)
+{
+	size_t len = strlen(name);
+
+	if (strncasecmp(raw, name, len))
+		return -1;
+	raw += len;
+
+	if (*raw != '=')
+		return -1;
+	raw++;
+
+	while (*raw && !isspace(*raw))
+		strbuf_addch(out, *raw++);
+	return 0;
+}
+
+/*
  * Extract a normalized version of the content type, with any
  * spaces suppressed, all letters lowercased, and no trailing ";"
  * or parameters.
  *
+ * If the "charset" argument is not NULL, store the value of any
+ * charset parameter there.
+ *
  * Example:
- *   "TEXT/PLAIN; charset=utf-8" -> "text/plain"
+ *   "TEXT/PLAIN; charset=utf-8" -> "text/plain", "utf-8"
  */
-static void extract_content_type(struct strbuf *raw, struct strbuf *type)
+static void extract_content_type(struct strbuf *raw, struct strbuf *type,
+				 struct strbuf *charset)
 {
 	const char *p;
 
@@ -923,10 +953,25 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type)
 	for (p = raw->buf; *p; p++) {
 		if (isspace(*p))
 			continue;
-		if (*p == ';')
+		if (*p == ';') {
+			p++;
 			break;
+		}
 		strbuf_addch(type, tolower(*p));
 	}
+
+	if (!charset)
+		return;
+
+	strbuf_reset(charset);
+	while (*p) {
+		while (isspace(*p))
+			p++;
+		if (!extract_param(p, "charset", charset))
+			return;
+		while (*p && !isspace(*p))
+			p++;
+	}
 }
 
 /* http_request() targets */
@@ -983,7 +1028,8 @@ static int http_request(const char *url,
 	if (options && options->content_type) {
 		struct strbuf raw = STRBUF_INIT;
 		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE, &raw);
-		extract_content_type(&raw, options->content_type);
+		extract_content_type(&raw, options->content_type,
+				     options->charset);
 		strbuf_release(&raw);
 	}
 
diff --git a/http.h b/http.h
index e64084f..473179b 100644
--- a/http.h
+++ b/http.h
@@ -144,6 +144,13 @@ struct http_get_options {
 	struct strbuf *content_type;
 
 	/*
+	 * If non-NULL, and content_type above is non-NULL, returns
+	 * the charset parameter from the content-type. If none is
+	 * present, returns an empty string.
+	 */
+	struct strbuf *charset;
+
+	/*
 	 * If non-NULL, returns the URL we ended up at, including any
 	 * redirects we followed.
 	 */
-- 
2.0.0.rc1.436.g03cb729
