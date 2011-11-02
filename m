From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] http.c: Use curl_multi_fdset to select on curl fds
 instead of just sleeping
Date: Wed, 2 Nov 2011 16:35:43 -0400
Message-ID: <20111102203543.GC5628@sigill.intra.peff.net>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320265288-12647-2-git-send-email-mika.fischer@zoopnet.de>
 <20111102203221.GB5628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, daniel@haxx.se
To: Mika Fischer <mika.fischer@zoopnet.de>
X-From: git-owner@vger.kernel.org Wed Nov 02 21:35:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLhXS-000314-IB
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 21:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab1KBUfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 16:35:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60385
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186Ab1KBUfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 16:35:46 -0400
Received: (qmail 16092 invoked by uid 107); 2 Nov 2011 20:41:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Nov 2011 16:41:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2011 16:35:43 -0400
Content-Disposition: inline
In-Reply-To: <20111102203221.GB5628@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184668>

On Wed, Nov 02, 2011 at 04:32:21PM -0400, Jeff King wrote:

> At least that's my reading. I am working on unrelated patches that clean
> up the handling of data_received, but if it could go away altogether,
> that would be even simpler.

That patch, btw, looks like this:

-- >8 --
Subject: [PATCH] http: remove "local" member from slot struct

The curl-multi http code does something like this:

  while (!finished) {
	  try_to_read_from_slots();
	  if (!data_received)
		  wait_for_50_ms();
  }

Which is horrible enough in itself, because of the
hard-coded 50ms wait.

But there's some additional complexity: the method for
finding whether we received data is to actually run ftell()
on the file we are writing to to see if it got anything. So
the "local" member of the slot struct contains the FILE
pointer. Except that sometimes we don't have a file, because
we're writing to a strbuf. In that case, since curl calls
our custom callback, we just increment the data_received
flag when curl gives data to our callback.

Let's do the same thing for the write-to-file case as we do
for the write-to-strbuf case: use a thin wrapper callback
and increment the received flag. This makes both methods
consistent with each other, and saves us from managing the
"local" struct member at all, reducing the code size.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c |   23 +++++++----------------
 http.h |    1 -
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/http.c b/http.c
index a4bc770..99386ef 100644
--- a/http.c
+++ b/http.c
@@ -93,6 +93,12 @@ curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
 }
 #endif
 
+size_t fwrite_file(char *ptr, size_t eltsize, size_t nmemb, void *handle)
+{
+	data_received++;
+	return fwrite(ptr, eltsize, nmemb, handle);
+}
+
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
@@ -538,7 +544,6 @@ struct active_request_slot *get_active_slot(void)
 
 	active_requests++;
 	slot->in_use = 1;
-	slot->local = NULL;
 	slot->results = NULL;
 	slot->finished = NULL;
 	slot->callback_data = NULL;
@@ -642,8 +647,6 @@ void step_active_slots(void)
 void run_active_slot(struct active_request_slot *slot)
 {
 #ifdef USE_CURL_MULTI
-	long last_pos = 0;
-	long current_pos;
 	fd_set readfds;
 	fd_set writefds;
 	fd_set excfds;
@@ -656,13 +659,6 @@ void run_active_slot(struct active_request_slot *slot)
 		data_received = 0;
 		step_active_slots();
 
-		if (!data_received && slot->local != NULL) {
-			current_pos = ftell(slot->local);
-			if (current_pos > last_pos)
-				data_received++;
-			last_pos = current_pos;
-		}
-
 		if (slot->in_use && !data_received) {
 			max_fd = 0;
 			FD_ZERO(&readfds);
@@ -818,13 +814,12 @@ static int http_request(const char *url, void *result, int target, int options)
 		if (target == HTTP_REQUEST_FILE) {
 			long posn = ftell(result);
 			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-					 fwrite);
+					 fwrite_file);
 			if (posn > 0) {
 				strbuf_addf(&buf, "Range: bytes=%ld-", posn);
 				headers = curl_slist_append(headers, buf.buf);
 				strbuf_reset(&buf);
 			}
-			slot->local = result;
 		} else
 			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
 					 fwrite_buffer);
@@ -871,7 +866,6 @@ static int http_request(const char *url, void *result, int target, int options)
 		ret = HTTP_START_FAILED;
 	}
 
-	slot->local = NULL;
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
 
@@ -1066,7 +1060,6 @@ void release_http_pack_request(struct http_pack_request *preq)
 	if (preq->packfile != NULL) {
 		fclose(preq->packfile);
 		preq->packfile = NULL;
-		preq->slot->local = NULL;
 	}
 	if (preq->range_header != NULL) {
 		curl_slist_free_all(preq->range_header);
@@ -1088,7 +1081,6 @@ int finish_http_pack_request(struct http_pack_request *preq)
 
 	fclose(preq->packfile);
 	preq->packfile = NULL;
-	preq->slot->local = NULL;
 
 	lst = preq->lst;
 	while (*lst != p)
@@ -1157,7 +1149,6 @@ struct http_pack_request *new_http_pack_request(
 	}
 
 	preq->slot = get_active_slot();
-	preq->slot->local = preq->packfile;
 	curl_easy_setopt(preq->slot->curl, CURLOPT_FILE, preq->packfile);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, preq->url);
diff --git a/http.h b/http.h
index 3c332a9..7429381 100644
--- a/http.h
+++ b/http.h
@@ -49,7 +49,6 @@ struct slot_results {
 
 struct active_request_slot {
 	CURL *curl;
-	FILE *local;
 	int in_use;
 	CURLcode curl_result;
 	long http_code;
-- 
1.7.7.rc3.12.g571d67
