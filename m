From: Jeff King <peff@peff.net>
Subject: [PATCH 6/9] http: update base URLs when we see redirects
Date: Sat, 28 Sep 2013 04:34:05 -0400
Message-ID: <20130928083405.GA2782@sigill.intra.peff.net>
References: <20130928082956.GA22610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 10:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPpyf-0004FR-KW
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 10:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab3I1IeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 04:34:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:35162 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab3I1IeI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 04:34:08 -0400
Received: (qmail 8820 invoked by uid 102); 28 Sep 2013 08:34:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Sep 2013 03:34:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Sep 2013 04:34:05 -0400
Content-Disposition: inline
In-Reply-To: <20130928082956.GA22610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235495>

If a caller asks the http_get_* functions to go to a
particular URL and we end up elsewhere due to a redirect,
the effective_url field can tell us where we went.

It would be nice to remember this redirect and short-cut
further requests for two reasons:

  1. It's more efficient. Otherwise we spend an extra http
     round-trip to the server for each subsequent request,
     just to get redirected.

  2. If we end up with an http 401 and are going to ask for
     credentials, it is to feed them to the redirect target.
     If the redirect is an http->https upgrade, this means
     our credentials may be provided on the http leg, just
     to end up redirected to https. And if the redirect
     crosses server boundaries, then curl will drop the
     credentials entirely as it follows the redirect.

However, it, it is not enough to simply record the effective
URL we saw and use that for subsequent requests. We were
originally fed a "base" url like:

   http://example.com/foo.git

and we want to figure out what the new base is, even though
the URLs we see may be:

     original: http://example.com/foo.git/info/refs
    effective: http://example.com/bar.git/info/refs

Subsequent requests will not be for "info/refs", but for
other paths relative to the base. We must ask the caller to
pass in the original base, and we must pass the redirected
base back to the caller (so that it can generte more URLs
from it). Furthermore, we need to feed the new base to the
credential code, so that requests to credential helpers (or
to the user) match the URL we will be requesting.

This patch teaches http_request_reauth to do this munging.
Since it is the caller who cares about making more URLs, it
seems at first glance that callers could simply check
effective_url themselves and handle it. However, since we
need to update the credential struct before the second
re-auth request, we have to do it inside http_request_reauth.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 http.h |  8 ++++++++
 2 files changed, 68 insertions(+)

diff --git a/http.c b/http.c
index 65a0048..8775b5c 100644
--- a/http.c
+++ b/http.c
@@ -921,11 +921,71 @@ static int http_request_reauth(const char *url,
 	return ret;
 }
 
+/*
+ * Update the "base" url to a more appropriate value, as deduced by
+ * redirects seen when requesting a URL starting with "url".
+ *
+ * The "asked" parameter is a URL that we asked curl to access, and must begin
+ * with "base".
+ *
+ * The "got" parameter is the URL that curl reported to us as where we ended
+ * up.
+ *
+ * Returns 1 if we updated the base url, 0 otherwise.
+ *
+ * Our basic strategy is to compare "base" and "asked" to find the bits
+ * specific to our request. We then strip those bits off of "got" to yield the
+ * new base. So for example, if our base is "http://example.com/foo.git",
+ * and we ask for "http://example.com/foo.git/info/refs", we might end up
+ * with "https://other.example.com/foo.git/info/refs". We would want the
+ * new URL to become "https://other.example.com/foo.git".
+ *
+ * Note that this assumes a sane redirect scheme. It's entirely possible
+ * in the example above to end up at a URL that does not even end in
+ * "info/refs".  In such a case we simply punt, as there is not much we can
+ * do (and such a scheme is unlikely to represent a real git repository,
+ * which means we are likely about to abort anyway).
+ */
+static int update_url_from_redirect(struct strbuf *base,
+				    const char *asked,
+				    const struct strbuf *got)
+{
+	const char *tail;
+	size_t tail_len;
+
+	if (!strcmp(asked, got->buf))
+		return 0;
+
+	if (strncmp(asked, base->buf, base->len))
+		die("BUG: update_url_from_redirect: %s is not a superset of %s",
+		    asked, base->buf);
+
+	tail = asked + base->len;
+	tail_len = strlen(tail);
+
+	if (got->len < tail_len ||
+	    strcmp(tail, got->buf + got->len - tail_len))
+		return 0; /* insane redirect scheme */
+
+	strbuf_reset(base);
+	strbuf_add(base, got->buf, got->len - tail_len);
+	return 1;
+}
+
 static int http_request_reauth(const char *url,
 			       void *result, int target,
 			       struct http_get_options *options)
 {
 	int ret = http_request(url, result, target, options);
+
+	if (options && options->effective_url && options->base_url) {
+		if (update_url_from_redirect(options->base_url,
+					     url, options->effective_url)) {
+			credential_from_url(&http_auth, options->base_url->buf);
+			url = options->effective_url->buf;
+		}
+	}
+
 	if (ret != HTTP_REAUTH)
 		return ret;
 
diff --git a/http.h b/http.h
index 974ede7..12ca5c8 100644
--- a/http.h
+++ b/http.h
@@ -139,6 +139,14 @@ struct http_get_options {
 	 * redirects we followed.
 	 */
 	struct strbuf *effective_url;
+
+	/*
+	 * If both base_url and effective_url are non-NULL, the base URL will
+	 * be munged to reflect any redirections going from the requested url
+	 * to effective_url. See the definition of update_url_from_redirect
+	 * for details.
+	 */
+	struct strbuf *base_url;
 };
 
 /* Return values for http_get_*() */
-- 
1.8.4.rc3.19.g9da5bf6
