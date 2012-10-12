From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] http: do not set up curl auth after a 401
Date: Fri, 12 Oct 2012 03:35:59 -0400
Message-ID: <20121012073559.GB16441@sigill.intra.peff.net>
References: <20121012073053.GC17026@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brad Hein <linuxbrad@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 09:36:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMZn4-0004rI-W1
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 09:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137Ab2JLHgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 03:36:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50718 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757116Ab2JLHgD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 03:36:03 -0400
Received: (qmail 386 invoked by uid 107); 12 Oct 2012 07:36:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Oct 2012 03:36:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2012 03:35:59 -0400
Content-Disposition: inline
In-Reply-To: <20121012073053.GC17026@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207536>

When we get an http 401, we prompt for credentials and put
them in our global credential struct. We also feed them to
the curl handle that produced the 401, with the intent that
they will be used on a retry.

When the code was originally introduced in commit 42653c0,
this was a necessary step. However, since dfa1725, we always
feed our global credential into every curl handle when we
initialize the slot with get_active_slot. So every further
request already feeds the credential to curl.

Moreover, accessing the slot here is somewhat dubious. After
the slot has produced a response, we don't actually control
it any more.  If we are using curl_multi, it may even have
been re-initialized to handle a different request.

It just so happens that we will reuse the curl handle within
the slot in such a case, and that because we only keep one
global credential, it will be the one we want.  So the
current code is not buggy, but it is misleading.

By cleaning it up, we can remove the slot argument entirely
from handle_curl_result, making it much more obvious that
slots should not be accessed after they are marked as
finished.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c        | 6 ++----
 http.h        | 3 +--
 remote-curl.c | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/http.c b/http.c
index 9334386..0a74345 100644
--- a/http.c
+++ b/http.c
@@ -744,8 +744,7 @@ char *get_remote_object_url(const char *url, const char *hex,
 	return strbuf_detach(&buf, NULL);
 }
 
-int handle_curl_result(struct active_request_slot *slot,
-		       struct slot_results *results)
+int handle_curl_result(struct slot_results *results)
 {
 	if (results->curl_result == CURLE_OK) {
 		credential_approve(&http_auth);
@@ -758,7 +757,6 @@ int handle_curl_result(struct active_request_slot *slot,
 			return HTTP_NOAUTH;
 		} else {
 			credential_fill(&http_auth);
-			init_curl_http_auth(slot->curl);
 			return HTTP_REAUTH;
 		}
 	} else {
@@ -817,7 +815,7 @@ static int http_request(const char *url, void *result, int target, int options)
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		ret = handle_curl_result(slot, &results);
+		ret = handle_curl_result(&results);
 	} else {
 		error("Unable to start HTTP request for %s", url);
 		ret = HTTP_START_FAILED;
diff --git a/http.h b/http.h
index 0bd1e84..0a80d30 100644
--- a/http.h
+++ b/http.h
@@ -78,8 +78,7 @@ extern void finish_all_active_slots(void);
 extern void run_active_slot(struct active_request_slot *slot);
 extern void finish_active_slot(struct active_request_slot *slot);
 extern void finish_all_active_slots(void);
-extern int handle_curl_result(struct active_request_slot *slot,
-			      struct slot_results *results);
+extern int handle_curl_result(struct slot_results *results);
 
 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
diff --git a/remote-curl.c b/remote-curl.c
index 4281262..aefafd3 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -369,7 +369,7 @@ static int run_slot(struct active_request_slot *slot)
 	slot->curl_result = curl_easy_perform(slot->curl);
 	finish_active_slot(slot);
 
-	err = handle_curl_result(slot, &results);
+	err = handle_curl_result(&results);
 	if (err != HTTP_OK && err != HTTP_REAUTH) {
 		error("RPC failed; result=%d, HTTP code = %ld",
 		      results.curl_result, results.http_code);
-- 
1.8.0.rc2.3.g303f317
