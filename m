From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] remote-curl: pass curl slot_results back through run_slot
Date: Thu, 31 Oct 2013 02:36:26 -0400
Message-ID: <20131031063626.GB5812@sigill.intra.peff.net>
References: <20131031063451.GA5513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Oct 31 07:36:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vblrt-0001Au-Cc
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 07:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab3JaGg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 02:36:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:59004 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752732Ab3JaGg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 02:36:29 -0400
Received: (qmail 18259 invoked by uid 102); 31 Oct 2013 06:36:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Oct 2013 01:36:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Oct 2013 02:36:26 -0400
Content-Disposition: inline
In-Reply-To: <20131031063451.GA5513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237081>

Some callers may want to know more than just the integer
error code we return. Let them optionally pass a
slot_results struct to fill in (or NULL if they do not
care). In either case we continue to return the integer
code.

We can also give probe_rpc the same treatment (since it
builds directly on run_slot).

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index b5ebe01..79db21e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -383,25 +383,29 @@ static size_t rpc_in(char *ptr, size_t eltsize,
 	return size;
 }
 
-static int run_slot(struct active_request_slot *slot)
+static int run_slot(struct active_request_slot *slot,
+		    struct slot_results *results)
 {
 	int err;
-	struct slot_results results;
+	struct slot_results results_buf;
 
-	slot->results = &results;
+	if (!results)
+		results = &results_buf;
+
+	slot->results = results;
 	slot->curl_result = curl_easy_perform(slot->curl);
 	finish_active_slot(slot);
 
-	err = handle_curl_result(&results);
+	err = handle_curl_result(results);
 	if (err != HTTP_OK && err != HTTP_REAUTH) {
 		error("RPC failed; result=%d, HTTP code = %ld",
-		      results.curl_result, results.http_code);
+		      results->curl_result, results->http_code);
 	}
 
 	return err;
 }
 
-static int probe_rpc(struct rpc_state *rpc)
+static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 {
 	struct active_request_slot *slot;
 	struct curl_slist *headers = NULL;
@@ -423,7 +427,7 @@ static int probe_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
 
-	err = run_slot(slot);
+	err = run_slot(slot, results);
 
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
@@ -462,7 +466,7 @@ static int post_rpc(struct rpc_state *rpc)
 
 	if (large_request) {
 		do {
-			err = probe_rpc(rpc);
+			err = probe_rpc(rpc, NULL);
 		} while (err == HTTP_REAUTH);
 		if (err != HTTP_OK)
 			return -1;
@@ -561,7 +565,7 @@ retry:
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
 
-	err = run_slot(slot);
+	err = run_slot(slot, NULL);
 	if (err == HTTP_REAUTH && !large_request)
 		goto retry;
 	if (err != HTTP_OK)
-- 
1.8.4.1.898.g8bf8a41.dirty
