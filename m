From: Jeff King <peff@peff.net>
Subject: [PATCH 3/9] http: refactor options to http_get_*
Date: Sat, 28 Sep 2013 04:31:23 -0400
Message-ID: <20130928083122.GC2131@sigill.intra.peff.net>
References: <20130928082956.GA22610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 10:31:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPpw2-0002Ab-VA
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 10:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab3I1Ib1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 04:31:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:35137 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab3I1IbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 04:31:25 -0400
Received: (qmail 8614 invoked by uid 102); 28 Sep 2013 08:31:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Sep 2013 03:31:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Sep 2013 04:31:23 -0400
Content-Disposition: inline
In-Reply-To: <20130928082956.GA22610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235492>

Over time, the http_get_strbuf function has grown several
optional parameters. We now have a bitfield with multiple
boolean options, as well as an optional strbuf for returning
the content-type of the response. And a future patch in this
series is going to add another strbuf option.

Treating these as separate arguments has a few downsides:

  1. Most call sites need to add extra NULLs and 0s for the
     options they aren't interested in.

  2. The http_get_* functions are actually wrappers around
     2 layers of low-level implementation functions. We have
     to pass these options through individually.

  3. The http_get_strbuf wrapper learned these options, but
     nobody bothered to do so for http_get_file, even though
     it is backed by the same function that does understand
     the options.

Let's consolidate the options into a single struct. For the
common case of the default options, we'll allow callers to
simply pass a NULL for the options struct.

The resulting code is often a few lines longer, but it ends
up being easier to read (and to change as we add new
options, since we do not need to update each call site).

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c   |  4 ++--
 http.c        | 44 +++++++++++++++++++++++++-------------------
 http.h        | 15 ++++++++++-----
 remote-curl.c |  9 +++++++--
 4 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/http-push.c b/http-push.c
index 69200ba..34cb70f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1542,7 +1542,7 @@ static int remote_exists(const char *path)
 
 	sprintf(url, "%s%s", repo->url, path);
 
-	switch (http_get_strbuf(url, NULL, NULL, 0)) {
+	switch (http_get_strbuf(url, NULL, NULL)) {
 	case HTTP_OK:
 		ret = 1;
 		break;
@@ -1566,7 +1566,7 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 	url = xmalloc(strlen(repo->url) + strlen(path) + 1);
 	sprintf(url, "%s%s", repo->url, path);
 
-	if (http_get_strbuf(url, NULL, &buffer, 0) != HTTP_OK)
+	if (http_get_strbuf(url, &buffer, NULL) != HTTP_OK)
 		die("Couldn't get %s for remote symref\n%s", url,
 		    curl_errorstr);
 	free(url);
diff --git a/http.c b/http.c
index d325669..41ee7aa 100644
--- a/http.c
+++ b/http.c
@@ -853,8 +853,9 @@ static CURLcode curlinfo_strbuf(CURL *curl, CURLINFO info, struct strbuf *buf)
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
 
-static int http_request(const char *url, struct strbuf *type,
-			void *result, int target, int options)
+static int http_request(const char *url,
+			void *result, int target,
+			const struct http_get_options *options)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
@@ -887,9 +888,9 @@ static int http_request(const char *url, struct strbuf *type,
 	}
 
 	strbuf_addstr(&buf, "Pragma:");
-	if (options & HTTP_NO_CACHE)
+	if (options && options->no_cache)
 		strbuf_addstr(&buf, " no-cache");
-	if (options & HTTP_KEEP_ERROR)
+	if (options && options->keep_error)
 		curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 
 	headers = curl_slist_append(headers, buf.buf);
@@ -907,8 +908,9 @@ static int http_request(const char *url, struct strbuf *type,
 		ret = HTTP_START_FAILED;
 	}
 
-	if (type)
-		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE, type);
+	if (options && options->content_type)
+		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE,
+				options->content_type);
 
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
@@ -917,11 +919,10 @@ static int http_request_reauth(const char *url,
 }
 
 static int http_request_reauth(const char *url,
-			       struct strbuf *type,
 			       void *result, int target,
-			       int options)
+			       struct http_get_options *options)
 {
-	int ret = http_request(url, type, result, target, options);
+	int ret = http_request(url, result, target, options);
 	if (ret != HTTP_REAUTH)
 		return ret;
 
@@ -931,7 +932,7 @@ static int http_request_reauth(const char *url,
 	 * making our next request. We only know how to do this for
 	 * the strbuf case, but that is enough to satisfy current callers.
 	 */
-	if (options & HTTP_KEEP_ERROR) {
+	if (options && options->keep_error) {
 		switch (target) {
 		case HTTP_REQUEST_STRBUF:
 			strbuf_reset(result);
@@ -940,15 +941,14 @@ int http_get_strbuf(const char *url,
 			die("BUG: HTTP_KEEP_ERROR is only supported with strbufs");
 		}
 	}
-	return http_request(url, type, result, target, options);
+	return http_request(url, result, target, options);
 }
 
 int http_get_strbuf(const char *url,
-		    struct strbuf *type,
-		    struct strbuf *result, int options)
+		    struct strbuf *result,
+		    struct http_get_options *options)
 {
-	return http_request_reauth(url, type, result,
-				   HTTP_REQUEST_STRBUF, options);
+	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options);
 }
 
 /*
@@ -957,7 +957,8 @@ int http_get_strbuf(const char *url,
  * If a previous interrupted download is detected (i.e. a previous temporary
  * file is still around) the download is resumed.
  */
-static int http_get_file(const char *url, const char *filename, int options)
+static int http_get_file(const char *url, const char *filename,
+			 struct http_get_options *options)
 {
 	int ret;
 	struct strbuf tmpfile = STRBUF_INIT;
@@ -971,7 +972,7 @@ static int http_get_file(const char *url, const char *filename, int options)
 		goto cleanup;
 	}
 
-	ret = http_request_reauth(url, NULL, result, HTTP_REQUEST_FILE, options);
+	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
 	fclose(result);
 
 	if (ret == HTTP_OK && move_temp_to_file(tmpfile.buf, filename))
@@ -983,12 +984,15 @@ int http_fetch_ref(const char *base, struct ref *ref)
 
 int http_fetch_ref(const char *base, struct ref *ref)
 {
+	struct http_get_options options = {0};
 	char *url;
 	struct strbuf buffer = STRBUF_INIT;
 	int ret = -1;
 
+	options.no_cache = 1;
+
 	url = quote_ref_url(base, ref->name);
-	if (http_get_strbuf(url, NULL, &buffer, HTTP_NO_CACHE) == HTTP_OK) {
+	if (http_get_strbuf(url, &buffer, &options) == HTTP_OK) {
 		strbuf_rtrim(&buffer);
 		if (buffer.len == 40)
 			ret = get_sha1_hex(buffer.buf, ref->old_sha1);
@@ -1072,6 +1076,7 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 
 int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 {
+	struct http_get_options options = {0};
 	int ret = 0, i = 0;
 	char *url, *data;
 	struct strbuf buf = STRBUF_INIT;
@@ -1081,7 +1086,8 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 	strbuf_addstr(&buf, "objects/info/packs");
 	url = strbuf_detach(&buf, NULL);
 
-	ret = http_get_strbuf(url, NULL, &buf, HTTP_NO_CACHE);
+	options.no_cache = 1;
+	ret = http_get_strbuf(url, &buf, &options);
 	if (ret != HTTP_OK)
 		goto cleanup;
 
diff --git a/http.h b/http.h
index d77c1b5..40404b4 100644
--- a/http.h
+++ b/http.h
@@ -125,11 +125,16 @@ extern char *get_remote_object_url(const char *url, const char *hex,
 extern char *get_remote_object_url(const char *url, const char *hex,
 				   int only_two_digit_prefix);
 
-/* Options for http_request_*() */
-#define HTTP_NO_CACHE		1
-#define HTTP_KEEP_ERROR		2
+/* Options for http_get_*() */
+struct http_get_options {
+	unsigned no_cache:1,
+		 keep_error:1;
 
-/* Return values for http_request_*() */
+	/* If non-NULL, returns the content-type of the response. */
+	struct strbuf *content_type;
+};
+
+/* Return values for http_get_*() */
 #define HTTP_OK			0
 #define HTTP_MISSING_TARGET	1
 #define HTTP_ERROR		2
@@ -142,7 +147,7 @@ extern char *get_remote_object_url(const char *url, const char *hex,
  *
  * If the result pointer is NULL, a HTTP HEAD request is made instead of GET.
  */
-int http_get_strbuf(const char *url, struct strbuf *content_type, struct strbuf *result, int options);
+int http_get_strbuf(const char *url, struct strbuf *result, struct http_get_options *options);
 
 extern int http_fetch_ref(const char *base, struct ref *ref);
 
diff --git a/remote-curl.c b/remote-curl.c
index b5ebe01..66705bb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -206,6 +206,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	struct discovery *last = last_discovery;
 	char *refs_url;
 	int http_ret, maybe_smart = 0;
+	struct http_get_options options;
 
 	if (last && !strcmp(service, last->service))
 		return last;
@@ -223,8 +224,12 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	}
 	refs_url = strbuf_detach(&buffer, NULL);
 
-	http_ret = http_get_strbuf(refs_url, &type, &buffer,
-				   HTTP_NO_CACHE | HTTP_KEEP_ERROR);
+	memset(&options, 0, sizeof(options));
+	options.content_type = &type;
+	options.no_cache = 1;
+	options.keep_error = 1;
+
+	http_ret = http_get_strbuf(refs_url, &buffer, &options);
 	switch (http_ret) {
 	case HTTP_OK:
 		break;
-- 
1.8.4.rc3.19.g9da5bf6
