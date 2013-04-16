From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Mon, 15 Apr 2013 20:30:38 -0400
Message-ID: <20130416003038.GA5336@sigill.intra.peff.net>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <20130415232532.GA7134@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 02:30:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URtnO-00037H-4u
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 02:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934813Ab3DPAap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 20:30:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47285 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933603Ab3DPAap (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 20:30:45 -0400
Received: (qmail 31344 invoked by uid 107); 16 Apr 2013 00:32:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 20:32:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 20:30:38 -0400
Content-Disposition: inline
In-Reply-To: <20130415232532.GA7134@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221336>

On Mon, Apr 15, 2013 at 07:25:32PM -0400, Jeff King wrote:

> On Mon, Apr 15, 2013 at 01:28:53PM -0700, Junio C Hamano wrote:
> 
> > * jk/http-error-messages (2013-04-06) 9 commits
> [...]
> ...the tip of your current master does not currently pass the test
> suite[1]. I bisected the problem to "show server content on http
> errors" from the above topic, but haven't figure it out past that. I
> typically run "make test" before submitting, so I'm guessing it is an
> interaction with another topic that graduated around the same time
> (though it's also possible that I just failed to test after the last
> rebase).

This patch on top of jk/http-error-messages fixes it.

-- >8 --
Subject: [PATCH] http: set curl FAILONERROR each time we select a handle

Because we reuse curl handles for multiple requests, the
setup of a handle happens in two stages: stable, global
setup and per-request setup. The lifecycle of a handle is
something like:

  1. get_curl_handle; do basic global setup that will last
     through the whole program (e.g., setting the user
     agent, ssl options, etc)

  2. get_active_slot; set up a per-request baseline (e.g.,
     clearing the read/write functions, making it a GET
     request, etc)

  3. perform the request with curl_*_perform functions

  4. goto step 2 to perform another request

Breaking it down this way means we can avoid doing global
setup from step (1) repeatedly, but we still finish step (2)
with a predictable baseline setup that callers can rely on.

Until commit 6d052d7 (http: add HTTP_KEEP_ERROR option,
2013-04-05), setting curl's FAILONERROR option was a global
setup; we never changed it. However, 6d052d7 introduced in
option where some requests might turn off FAILONERROR. Later
requests using the same handle would have the option
unexpectedly turned off, which meant they would not notice
http failures at all.

This could easily be seen in the test-suite for the
"half-auth" cases of t5541 and t5551. The initial requests
turned off FAILONERROR, which meant it was erroneously off
for the rpc POST. That worked fine for a successful request,
but meant that we failed to react properly to the HTTP 401
(instead, we treated whatever the server handed us as a
successful message body).

The solution is simple: now that FAILONERROR is a
per-request setting, we move it to get_active_slot to make
sure it is reset for each request.

Signed-off-by: Jeff King <peff@peff.net>
---
Hmph. I have no idea how this ever passed the tests, so I can only
assume that I screwed up in running them. I even recall considering this
issue while writing the patches, but I mixed up which of get_curl_handle
and get_active_slot it needed to be in when I did so.

 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 58c063c..48d4ff6 100644
--- a/http.c
+++ b/http.c
@@ -282,7 +282,6 @@ static CURL *get_curl_handle(void)
 #endif
 	if (ssl_cainfo != NULL)
 		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
-	curl_easy_setopt(result, CURLOPT_FAILONERROR, 1);
 
 	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
 		curl_easy_setopt(result, CURLOPT_LOW_SPEED_LIMIT,
@@ -506,6 +505,7 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
 	if (http_auth.password)
 		init_curl_http_auth(slot->curl);
 
-- 
1.8.2.8.g44e4c28
