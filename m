From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] Improve use of select in http backend
Date: Fri, 4 Nov 2011 13:53:33 -0400
Message-ID: <20111104175333.GB26118@sigill.intra.peff.net>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, daniel@haxx.se
To: Mika Fischer <mika.fischer@zoopnet.de>
X-From: git-owner@vger.kernel.org Fri Nov 04 18:53:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMNxT-0001jh-Qu
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 18:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514Ab1KDRxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 13:53:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33560
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754976Ab1KDRxf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 13:53:35 -0400
Received: (qmail 4142 invoked by uid 107); 4 Nov 2011 17:53:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 Nov 2011 13:53:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Nov 2011 13:53:33 -0400
Content-Disposition: inline
In-Reply-To: <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184791>

On Fri, Nov 04, 2011 at 03:19:24PM +0100, Mika Fischer wrote:

> Mika Fischer (3):
>   http.c: Use curl_multi_fdset to select on curl fds instead of just
>     sleeping
>   http.c: Use timeout suggested by curl instead of fixed 50ms timeout
>   http.c: Rely on select instead of tracking whether data was received

All three patches look good to me. Your 3/3 does most of the cleanup
from the other patch I posted, but we can also do this on top:

-- >8 --
Subject: [PATCH 4/3] http: drop "local" member from request struct

This is a FILE pointer in the case that we are sending our
output to a file. We originally used it to run ftell() to
determine whether data had been written to our file during
our last call to curl. However, as of the last patch, we no
longer care about that flag anymore. All uses of this struct
member are now just book-keeping that can go away.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c |    6 ------
 http.h |    1 -
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/http.c b/http.c
index 3c6a00b..cfa9b07 100644
--- a/http.c
+++ b/http.c
@@ -535,7 +535,6 @@ struct active_request_slot *get_active_slot(void)
 
 	active_requests++;
 	slot->in_use = 1;
-	slot->local = NULL;
 	slot->results = NULL;
 	slot->finished = NULL;
 	slot->callback_data = NULL;
@@ -829,7 +828,6 @@ static int http_request(const char *url, void *result, int target, int options)
 				headers = curl_slist_append(headers, buf.buf);
 				strbuf_reset(&buf);
 			}
-			slot->local = result;
 		} else
 			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
 					 fwrite_buffer);
@@ -876,7 +874,6 @@ static int http_request(const char *url, void *result, int target, int options)
 		ret = HTTP_START_FAILED;
 	}
 
-	slot->local = NULL;
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
 
@@ -1071,7 +1068,6 @@ void release_http_pack_request(struct http_pack_request *preq)
 	if (preq->packfile != NULL) {
 		fclose(preq->packfile);
 		preq->packfile = NULL;
-		preq->slot->local = NULL;
 	}
 	if (preq->range_header != NULL) {
 		curl_slist_free_all(preq->range_header);
@@ -1093,7 +1089,6 @@ int finish_http_pack_request(struct http_pack_request *preq)
 
 	fclose(preq->packfile);
 	preq->packfile = NULL;
-	preq->slot->local = NULL;
 
 	lst = preq->lst;
 	while (*lst != p)
@@ -1162,7 +1157,6 @@ struct http_pack_request *new_http_pack_request(
 	}
 
 	preq->slot = get_active_slot();
-	preq->slot->local = preq->packfile;
 	curl_easy_setopt(preq->slot->curl, CURLOPT_FILE, preq->packfile);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, preq->url);
diff --git a/http.h b/http.h
index 71bdf58..ee16069 100644
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
1.7.7.2.4.gfd7b9
