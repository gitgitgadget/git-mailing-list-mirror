From: Jeff King <peff@peff.net>
Subject: http: never use curl_easy_perform
Date: Tue, 18 Feb 2014 05:34:20 -0500
Message-ID: <20140218103420.GA2848@sigill.intra.peff.net>
References: <20140216040538.GA4754@sigill.intra.peff.net>
 <377DF3F4-1F9B-4CB0-A9BF-658E561F4349@gmail.com>
 <alpine.DEB.2.00.1402161307160.10435@tvnag.unkk.fr>
 <20140217235625.GB20499@sigill.intra.peff.net>
 <alpine.DEB.2.00.1402180806070.15465@tvnag.unkk.fr>
 <20140218075534.GB29804@sigill.intra.peff.net>
 <alpine.DEB.2.00.1402181001540.15465@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Feb 18 11:34:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFi0R-0007Vs-FE
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 11:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbaBRKeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 05:34:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:52586 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754135AbaBRKeW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 05:34:22 -0500
Received: (qmail 27494 invoked by uid 102); 18 Feb 2014 10:34:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Feb 2014 04:34:22 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Feb 2014 05:34:20 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1402181001540.15465@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242295>

On Tue, Feb 18, 2014 at 10:09:29AM +0100, Daniel Stenberg wrote:

> Okey, I checked this closer now and this is the full explanation to
> what happens. It seems to work as intended:

Thanks, your explanation makes perfect sense.

I think we should apply the patch below for git to consistently use the
multi interface. With this (and the recent patch for the NTLM issue), I
can do a whole smart-http clone over a single connection. This doesn't
make a huge difference for github.com, because the ssl session cache
eliminates most of the repeated work, but for servers which do not
implement ssl session caching, it may be more noticeable.

-- >8 --
Subject: http: never use curl_easy_perform

We currently don't reuse http connections when fetching via
the smart-http protocol. This is bad because the TCP
handshake introduces latency, and especially because SSL
connection setup may be non-trivial.

We can fix it by consistently using curl's "multi"
interface.  The reason is rather complicated:

Our http code has two ways of being used: queuing many
"slots" to be fetched in parallel, or fetching a single
request in a blocking manner. The parallel code is built on
curl's "multi" interface. Most of the single-request code
uses http_request, which is built on top of the parallel
code (we just feed it one slot, and wait until it finishes).

However, one could also accomplish the single-request scheme
by avoiding curl's multi interface entirely and just using
curl_easy_perform. This is simpler, and is used by post_rpc
in the smart-http protocol.

It does work to use the same curl handle in both contexts,
as long as it is not at the same time.  However, internally
curl may not share all of the cached resources between both
contexts. In particular, a connection formed using the
"multi" code will go into a reuse pool connected to the
"multi" object. Further requests using the "easy" interface
will not be able to reuse that connection.

The smart http protocol does ref discovery via http_request,
which uses the "multi" interface, and then follows up with
the "easy" interface for its rpc calls. As a result, we make
two HTTP connections rather than reusing a single one.

We could teach the ref discovery to use the "easy"
interface. But it is only once we have done this discovery
that we know whether the protocol will be smart or dumb. If
it is dumb, then our further requests, which want to fetch
objects in parallel, will not be able to reuse the same
connection.

Instead, this patch switches post_rpc to build on the
parallel interface, which means that we use it consistently
everywhere. It's a little more complicated to use, but since
we have the infrastructure already, it doesn't add any code;
we can just factor out the relevant bits from http_request.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c        | 24 +++++++++++++++---------
 http.h        |  9 +++++++++
 remote-curl.c |  5 +----
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/http.c b/http.c
index 70eaa26..1212c58 100644
--- a/http.c
+++ b/http.c
@@ -880,6 +880,20 @@ int handle_curl_result(struct slot_results *results)
 	}
 }
 
+int run_one_slot(struct active_request_slot *slot,
+		 struct slot_results *results)
+{
+	slot->results = results;
+	if (!start_active_slot(slot)) {
+		snprintf(curl_errorstr, sizeof(curl_errorstr),
+			 "failed to start HTTP request");
+		return HTTP_START_FAILED;
+	}
+
+	run_active_slot(slot);
+	return handle_curl_result(results);
+}
+
 static CURLcode curlinfo_strbuf(CURL *curl, CURLINFO info, struct strbuf *buf)
 {
 	char *ptr;
@@ -907,7 +921,6 @@ static int http_request(const char *url,
 	int ret;
 
 	slot = get_active_slot();
-	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 
 	if (result == NULL) {
@@ -942,14 +955,7 @@ static int http_request(const char *url,
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
 
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		ret = handle_curl_result(&results);
-	} else {
-		snprintf(curl_errorstr, sizeof(curl_errorstr),
-			 "failed to start HTTP request");
-		ret = HTTP_START_FAILED;
-	}
+	ret = run_one_slot(slot, &results);
 
 	if (options && options->content_type)
 		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE,
diff --git a/http.h b/http.h
index cd37d58..a828884 100644
--- a/http.h
+++ b/http.h
@@ -90,6 +90,15 @@ extern void finish_active_slot(struct active_request_slot *slot);
 extern void finish_all_active_slots(void);
 extern int handle_curl_result(struct slot_results *results);
 
+/*
+ * This will run one slot to completion in a blocking manner, similar to how
+ * curl_easy_perform would work (but we don't want to use that, because
+ * we do not want to intermingle calls to curl_multi and curl_easy).
+ *
+ */
+int run_one_slot(struct active_request_slot *slot,
+		 struct slot_results *results);
+
 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
 extern void add_fill_function(void *data, int (*fill)(void *));
diff --git a/remote-curl.c b/remote-curl.c
index 10cb011..52c2d96 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -423,11 +423,8 @@ static int run_slot(struct active_request_slot *slot,
 	if (!results)
 		results = &results_buf;
 
-	slot->results = results;
-	slot->curl_result = curl_easy_perform(slot->curl);
-	finish_active_slot(slot);
+	err = run_one_slot(slot, results);
 
-	err = handle_curl_result(results);
 	if (err != HTTP_OK && err != HTTP_REAUTH) {
 		error("RPC failed; result=%d, HTTP code = %ld",
 		      results->curl_result, results->http_code);
-- 
1.8.5.2.500.g8060133
