From: Jeff King <peff@peff.net>
Subject: [PATCH 8/8] http: prompt for credentials on failed POST
Date: Mon, 27 Aug 2012 09:27:15 -0400
Message-ID: <20120827132714.GH17375@sigill.intra.peff.net>
References: <20120827132145.GA17265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:27:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5zLg-0002YE-7s
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 15:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927Ab2H0N1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 09:27:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39712 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967Ab2H0N1R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 09:27:17 -0400
Received: (qmail 12975 invoked by uid 107); 27 Aug 2012 13:27:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Aug 2012 09:27:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2012 09:27:15 -0400
Content-Disposition: inline
In-Reply-To: <20120827132145.GA17265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204341>

All of the smart-http GET requests go through the http_get_*
functions, which will prompt for credentials and retry if we
see an HTTP 401.

POST requests, however, do not go through any central point.
Moreover, it is difficult to retry in the general case; we
cannot assume the request body fits in memory or is even
seekable, and we don't know how much of it was consumed
during the attempt.

Most of the time, this is not a big deal; for both fetching
and pushing, we make a GET request before doing any POSTs,
so typically we figure out the credentials during the first
request, then reuse them during the POST. However, some
servers may allow a client to get the list of refs from
receive-pack without authentication, and then require
authentication when the client actually tries to POST the
pack.

This is not ideal, as the client may do a non-trivial amount
of work to generate the pack (e.g., delta-compressing
objects). However, for a long time it has been the
recommended example configuration in git-http-backend(1) for
setting up a repository with anonymous fetch and
authenticated push. This setup has always been broken
without putting a username into the URL. Prior to commit
986bbc0, it did work with a username in the URL, because git
would prompt for credentials before making any requests at
all. However, post-986bbc0, it is totally broken. Since it
has been advertised in the manpage for some time, we should
make sure it works.

Unfortunately, it is not as easy as simply calling post_rpc
again when it fails, due to the input issue mentioned above.
However, we can still make this specific case work by
retrying in two specific instances:

  1. If the request is large (bigger than LARGE_PACKET_MAX),
     we will first send a probe request with a single flush
     packet. Since this request is static, we can freely
     retry it.

  2. If the request is small and we are not using gzip, then
     we have the whole thing in-core, and we can freely
     retry.

That means we will not retry in some instances, including:

  1. If we are using gzip. However, we only do so when
     calling git-upload-pack, so it does not apply to
     pushes.

  2. If we have a large request, the probe succeeds, but
     then the real POST wants authentication. This is an
     extremely unlikely configuration and not worth worrying
     about.

While it might be nice to cover those instances, doing so
would be significantly more complex for very little
real-world gain. In the long run, we will be much better off
when curl learns to internally handle authentication as a
callback, and we can cleanly handle all cases that way.

Signed-off-by: Jeff King <peff@peff.net>
---
Sorry for the wordy explanation. I really tried to refactor this into a
nice single code path for making both GET and POST requests, but I think
there are just too many corner cases. Suggestions welcome if somebody
has a better idea of how to refactor it (preferably in the form of a
patch).

 remote-curl.c        | 23 +++++++++++++++--------
 t/t5541-http-push.sh |  2 +-
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 04a9d62..3ec474f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -362,16 +362,17 @@ static size_t rpc_in(char *ptr, size_t eltsize,
 
 static int run_slot(struct active_request_slot *slot)
 {
-	int err = 0;
+	int err;
 	struct slot_results results;
 
 	slot->results = &results;
 	slot->curl_result = curl_easy_perform(slot->curl);
 	finish_active_slot(slot);
 
-	if (results.curl_result != CURLE_OK) {
-		err |= error("RPC failed; result=%d, HTTP code = %ld",
-			results.curl_result, results.http_code);
+	err = handle_curl_result(slot);
+	if (err != HTTP_OK && err != HTTP_REAUTH) {
+		error("RPC failed; result=%d, HTTP code = %ld",
+		      results.curl_result, results.http_code);
 	}
 
 	return err;
@@ -436,9 +437,11 @@ static int post_rpc(struct rpc_state *rpc)
 	}
 
 	if (large_request) {
-		err = probe_rpc(rpc);
-		if (err)
-			return err;
+		do {
+			err = probe_rpc(rpc);
+		} while (err == HTTP_REAUTH);
+		if (err != HTTP_OK)
+			return -1;
 	}
 
 	slot = get_active_slot();
@@ -525,7 +528,11 @@ static int post_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
 
-	err = run_slot(slot);
+	do {
+		err = run_slot(slot);
+	} while (err == HTTP_REAUTH && !large_request && !use_gzip);
+	if (err != HTTP_OK)
+		err = -1;
 
 	curl_slist_free_all(headers);
 	free(gzip_body);
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 9b1cd60..ef6d6b6 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -280,7 +280,7 @@ test_expect_success 'push over smart http with auth' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'push to auth-only-for-push repo' '
+test_expect_success 'push to auth-only-for-push repo' '
 	cd "$ROOT_PATH/test_repo_clone" &&
 	echo push-half-auth >expect &&
 	test_commit push-half-auth &&
-- 
1.7.11.5.10.g3c8125b
