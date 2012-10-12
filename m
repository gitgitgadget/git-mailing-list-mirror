From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] remote-curl: do not call run_slot repeatedly
Date: Fri, 12 Oct 2012 03:35:33 -0400
Message-ID: <20121012073533.GA16441@sigill.intra.peff.net>
References: <20121012073053.GC17026@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brad Hein <linuxbrad@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 09:35:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMZmd-0004aB-6x
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 09:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757082Ab2JLHfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 03:35:37 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50715 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756433Ab2JLHfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 03:35:36 -0400
Received: (qmail 354 invoked by uid 107); 12 Oct 2012 07:36:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Oct 2012 03:36:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2012 03:35:33 -0400
Content-Disposition: inline
In-Reply-To: <20121012073053.GC17026@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207535>

Commit b81401c (http: prompt for credentials on failed POST)
taught post_rpc to call run_slot in a loop in order to retry
a request after asking the user for credentials. However,
after a call to run_slot we will have called
finish_active_slot. This means we have released the slot,
and we should no longer look at it.

As it happens, this does not cause any bugs in the current
code, since we know that we are not using curl_multi in this
code path, and therefore nobody will have taken over our
slot in the meantime. However, it is good form to actually
call get_active_slot again. It also future proofs us against
changes in the http code.

We can do this by jumping back to a retry label at the top
of our function. We just need to reorder a few setup lines
that should not be repeated; everything else within the loop
is either idempotent, needs to be repeated, or in a path we
do not follow (e.g., we do not even try when large_request
is set, because we don't know how much data we might have
streamed from our helper program).

Signed-off-by: Jeff King <peff@peff.net>
---
Without this future-proofing, the next patch causes test
failures.

If the goto is too ugly, we can pull it out into a loop (it
just makes the patch harder to read, because the meat of the
function gets indented further).

 remote-curl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 6054e47..4281262 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -444,6 +444,11 @@ static int post_rpc(struct rpc_state *rpc)
 			return -1;
 	}
 
+	headers = curl_slist_append(headers, rpc->hdr_content_type);
+	headers = curl_slist_append(headers, rpc->hdr_accept);
+	headers = curl_slist_append(headers, "Expect:");
+
+retry:
 	slot = get_active_slot();
 
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
@@ -451,10 +456,6 @@ static int post_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 
-	headers = curl_slist_append(headers, rpc->hdr_content_type);
-	headers = curl_slist_append(headers, rpc->hdr_accept);
-	headers = curl_slist_append(headers, "Expect:");
-
 	if (large_request) {
 		/* The request body is large and the size cannot be predicted.
 		 * We must use chunked encoding to send it.
@@ -528,9 +529,9 @@ static int post_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
 
-	do {
-		err = run_slot(slot);
-	} while (err == HTTP_REAUTH && !large_request && !use_gzip);
+	err = run_slot(slot);
+	if (err == HTTP_REAUTH && !large_request && !use_gzip)
+		goto retry;
 	if (err != HTTP_OK)
 		err = -1;
 
-- 
1.8.0.rc2.3.g303f317
