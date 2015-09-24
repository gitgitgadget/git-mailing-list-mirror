From: Jeff King <peff@peff.net>
Subject: [PATCH 39/68] http-walker: store url in a strbuf
Date: Thu, 24 Sep 2015 17:07:31 -0400
Message-ID: <20150924210731.GJ30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:07:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDk8-00028o-1U
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbbIXVHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:35991 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753523AbbIXVHe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:34 -0400
Received: (qmail 12058 invoked by uid 102); 24 Sep 2015 21:07:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:34 -0500
Received: (qmail 29318 invoked by uid 107); 24 Sep 2015 21:07:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:31 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278590>

We do an unchecked sprintf directly into our url buffer.
This doesn't overflow because we know that it was sized for
"$base/objects/info/http-alternates", and we are writing
"$base/objects/info/alternates", which must be smaller. But
that is not immediately obvious to a reader who is looking
for buffer overflows. Let's switch to a strbuf, so that we
do not have to think about this issue at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-walker.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 88da546..2c721f0 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -29,7 +29,7 @@ struct object_request {
 struct alternates_request {
 	struct walker *walker;
 	const char *base;
-	char *url;
+	struct strbuf *url;
 	struct strbuf *buffer;
 	struct active_request_slot *slot;
 	int http_specific;
@@ -195,10 +195,11 @@ static void process_alternates_response(void *callback_data)
 
 			/* Try reusing the slot to get non-http alternates */
 			alt_req->http_specific = 0;
-			sprintf(alt_req->url, "%s/objects/info/alternates",
-				base);
+			strbuf_reset(alt_req->url);
+			strbuf_addf(alt_req->url, "%s/objects/info/alternates",
+				    base);
 			curl_easy_setopt(slot->curl, CURLOPT_URL,
-					 alt_req->url);
+					 alt_req->url->buf);
 			active_requests++;
 			slot->in_use = 1;
 			if (slot->finished != NULL)
@@ -312,7 +313,7 @@ static void process_alternates_response(void *callback_data)
 static void fetch_alternates(struct walker *walker, const char *base)
 {
 	struct strbuf buffer = STRBUF_INIT;
-	char *url;
+	struct strbuf url = STRBUF_INIT;
 	struct active_request_slot *slot;
 	struct alternates_request alt_req;
 	struct walker_data *cdata = walker->data;
@@ -338,7 +339,7 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	if (walker->get_verbosely)
 		fprintf(stderr, "Getting alternates list for %s\n", base);
 
-	url = xstrfmt("%s/objects/info/http-alternates", base);
+	strbuf_addf(&url, "%s/objects/info/http-alternates", base);
 
 	/*
 	 * Use a callback to process the result, since another request
@@ -351,10 +352,10 @@ static void fetch_alternates(struct walker *walker, const char *base)
 
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url.buf);
 
 	alt_req.base = base;
-	alt_req.url = url;
+	alt_req.url = &url;
 	alt_req.buffer = &buffer;
 	alt_req.http_specific = 1;
 	alt_req.slot = slot;
@@ -365,7 +366,7 @@ static void fetch_alternates(struct walker *walker, const char *base)
 		cdata->got_alternates = -1;
 
 	strbuf_release(&buffer);
-	free(url);
+	strbuf_release(&url);
 }
 
 static int fetch_indices(struct walker *walker, struct alt_base *repo)
-- 
2.6.0.rc3.454.g204ad51
