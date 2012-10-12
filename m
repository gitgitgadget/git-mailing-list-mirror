From: Jeff King <peff@peff.net>
Subject: [PATCH] http: fix segfault in handle_curl_result
Date: Fri, 12 Oct 2012 02:22:49 -0400
Message-ID: <20121012062249.GB17026@sigill.intra.peff.net>
References: <CAJa+X0OkzAX9E2SnDmU=on0yzzVZ9OMa2dJZgKMK=gQu2Rhf_Q@mail.gmail.com>
 <CAJa+X0MefHXTu_D7-SN8itQVO4sMyc4O7=bK=-sUP+W4GHOu9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brad Hein <linuxbrad@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 08:23:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMYeG-0000DP-Ae
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 08:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab2JLGWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 02:22:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50641 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161Ab2JLGWw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 02:22:52 -0400
Received: (qmail 32189 invoked by uid 107); 12 Oct 2012 06:23:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Oct 2012 02:23:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2012 02:22:49 -0400
Content-Disposition: inline
In-Reply-To: <CAJa+X0MefHXTu_D7-SN8itQVO4sMyc4O7=bK=-sUP+W4GHOu9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207529>

On Fri, Oct 12, 2012 at 12:58:21AM -0400, Brad Hein wrote:

> In Fedora 17
> With git-1.7.11.7-1.fc17.x86_64 (rpm)
> 
> I try to clone a particular repository but git just returns, having
> not cloned the repo. Seems like a bug. Details follow:
>   $ git clone http://gnuradio.org/git/gnuradio.git

Thanks for a thorough bug report. I can reproduce here, and it was easy
to bisect. The culprit is 8809703 (http: factor out http error code
handling, 2012-08-27). The patch below should fix it.

-- >8 --
When we create an http active_request_slot, we can set its
"results" pointer back to local storage. The http code will
fill in the details of how the request went, and we can
access those details even after the slot has been cleaned
up.

Commit 8809703 (http: factor out http error code handling)
switched us from accessing our local results struct directly
to accessing it via the "results" pointer of the slot. That
means we're accessing the slot after it has been marked as
finished, defeating the whole purpose of keeping the results
storage separate.

Most of the time this doesn't matter, as finishing the slot
does not actually clean up the pointer. However, when using
curl's multi interface with the dumb-http revision walker,
we might actually start a new request before handing control
back to the original caller. In that case, we may reuse the
slot, zeroing its results pointer, and leading the original
caller to segfault while looking for its results inside the
slot.

Instead, we need to pass a pointer to our local results
storage to the handle_curl_result function, rather than
relying on the pointer in the slot struct. This matches what
the original code did before the refactoring (which did not
use a separate function, and therefore just accessed the
results struct directly).

Signed-off-by: Jeff King <peff@peff.net>
---
Junio, this goes on top of the jk/maint-http-half-auth-push topic.

The bug is released in v1.7.11.7 and in v1.7.12.1. No clue how difficult
it is to trigger in practice (it's very repeatable with this repo, but
it does not trigger when our test scripts do dumb-http fetches, so there
may be something with the distribution of loose objects, packs, and so
forth to trigger the right sequence of requests).

We should probably not be passing the slot to handle_curl_results at
all, since it may have already been reused and is not safe to read. The
only thing we do with it is to set up any new auth information in the
curl handle.  This doesn't suffer the same problem because a reused slot
will always have a curl handle. However, it means we may be setting the
auth information for a random handle. Which is OK, since all handles use
the same auth information anyway.  But it should also be pointless,
because since dfa1725 (fix http auth with multiple curl handles) we
always refresh the curl handle's auth information whenever we get an
active slot.

However, I'm leaving that out of this patch.  Commit 8809703 was
supposed to be a refactor with zero behavior changes, but it regressed.
This fixes the regression by behaving exactly as we did beforehand. We
can build the other thing on top.

 http.c        | 7 +++----
 http.h        | 3 ++-
 remote-curl.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index 7c4a407..9334386 100644
--- a/http.c
+++ b/http.c
@@ -744,10 +744,9 @@ int handle_curl_result(struct active_request_slot *slot)
 	return strbuf_detach(&buf, NULL);
 }
 
-int handle_curl_result(struct active_request_slot *slot)
+int handle_curl_result(struct active_request_slot *slot,
+		       struct slot_results *results)
 {
-	struct slot_results *results = slot->results;
-
 	if (results->curl_result == CURLE_OK) {
 		credential_approve(&http_auth);
 		return HTTP_OK;
@@ -818,7 +817,7 @@ static int http_request(const char *url, void *result, int target, int options)
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		ret = handle_curl_result(slot);
+		ret = handle_curl_result(slot, &results);
 	} else {
 		error("Unable to start HTTP request for %s", url);
 		ret = HTTP_START_FAILED;
diff --git a/http.h b/http.h
index 12de255..0bd1e84 100644
--- a/http.h
+++ b/http.h
@@ -78,7 +78,8 @@ extern void finish_all_active_slots(void);
 extern void run_active_slot(struct active_request_slot *slot);
 extern void finish_active_slot(struct active_request_slot *slot);
 extern void finish_all_active_slots(void);
-extern int handle_curl_result(struct active_request_slot *slot);
+extern int handle_curl_result(struct active_request_slot *slot,
+			      struct slot_results *results);
 
 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
diff --git a/remote-curl.c b/remote-curl.c
index 3ec474f..6054e47 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -369,7 +369,7 @@ static int run_slot(struct active_request_slot *slot)
 	slot->curl_result = curl_easy_perform(slot->curl);
 	finish_active_slot(slot);
 
-	err = handle_curl_result(slot);
+	err = handle_curl_result(slot, &results);
 	if (err != HTTP_OK && err != HTTP_REAUTH) {
 		error("RPC failed; result=%d, HTTP code = %ld",
 		      results.curl_result, results.http_code);
-- 
1.8.0.rc2.3.g303f317
