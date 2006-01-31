From: mdw@distorted.org.uk (Mark Wooding)
Subject: Re: git-http-fetch failure/segfault -- alas no patch
Date: Tue, 31 Jan 2006 11:46:50 +0000
Message-ID: <17375.20010.283458.869140@metalzone.distorted.org.uk>
References: <17374.30792.548889.344768@metalzone.distorted.org.uk>
	<20060131093200.GA5154@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 12:47:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3tyt-0006Ls-3i
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 12:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWAaLrI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 06:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWAaLrH
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 06:47:07 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:57791 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1750765AbWAaLrF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 06:47:05 -0500
Received: (qmail 3152 invoked by uid 1000); 31 Jan 2006 11:46:50 -0000
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20060131093200.GA5154@informatik.uni-freiburg.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15311>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> wrote:

> The offending commit is 056211053b7516a57ff7a6dd02f503ecef6fca70:
> 
> git-clone: do not special case dumb http.

Fine, except that it's quite clear to me that the bug is actually in
git-http-fetch -- it shouldn't segfault, dammit! -- and that commit
affects only git-clone.sh.  Besides, I get the same symptoms running
git-http-fetch by hand.  That commit appears if you bisect on a test
based on git-clone because before then it fetched the pack list and pack
files before it tried to mop up the remaining objects, which obviously
hides the underlying bug.

Here's my low-level test-case.

----
#! /bin/sh

set -e
rm -rf funt
GIT_DIR=funt; export GIT_DIR
./git-init-db
./git-http-fetch -a -v \
  heads/master http://boyle.nsict.org/~mdw/git/catacomb.broken/
----

This is the `real-life' repository which has broken.  I'm using it
because the patch I made /works/ on the trivial `funt' example, but
fails miserably on the real thing.

Bisecting with this test lays the blame on 1d389ab65dc6867d30...  Which
I think is just telling me that it's always been broken.

For amusement value, my patch is below.  Here's what happens if I try to
use it.

----
got 7c40480318648672af86e03bc72bc45c07194c37
walk 7c40480318648672af86e03bc72bc45c07194c37
Getting alternates list for
http://boyle.nsict.org/~mdw/git/catacomb.broken/
got 0fd8bd4823315feb1c537a154efba002c053ed8e
Getting pack list for http://boyle.nsict.org/~mdw/git/catacomb.broken/
Getting index for pack f6d543b58ba9183c53ddbd981835f0378bdab919
Getting pack f6d543b58ba9183c53ddbd981835f0378bdab919
 which contains a137c6b3695c32ea9c42520a387a85641687662f
walk a137c6b3695c32ea9c42520a387a85641687662f
error: fd leakage in release: 4
error: fd leakage in release: 9
error: fd leakage in release: 5
error: fd leakage in release: 7
got 53124000638e53ee8aa51830fab72d8a0ce654e4
error: Couldn't find request for d2f2768351d41f80469240d1b533575d833c7370 in the queue
error: Unable to find d2f2768351d41f80469240d1b533575d833c7370 under http://boyle.nsict.org/~mdw/git/catacomb.broken/

Cannot obtain needed blob d2f2768351d41f80469240d1b533575d833c7370
while processing commit a137c6b3695c32ea9c42520a387a85641687662f.
Waiting for
http://boyle.nsict.org/~mdw/git/catacomb.broken/objects/eb/2dc153b8981ad02430bc166b925ef2457c7c36
got eb2dc153b8981ad02430bc166b925ef2457c7c36
Segmentation fault      (core dumped)
----

Without the patch, I get

----
got 7c40480318648672af86e03bc72bc45c07194c37
walk 7c40480318648672af86e03bc72bc45c07194c37
Getting alternates list for
http://boyle.nsict.org/~mdw/git/catacomb.broken/
got 0fd8bd4823315feb1c537a154efba002c053ed8e
Getting pack list for http://boyle.nsict.org/~mdw/git/catacomb.broken/
got 53124000638e53ee8aa51830fab72d8a0ce654e4
got eb2dc153b8981ad02430bc166b925ef2457c7c36
error: Unable to find a137c6b3695c32ea9c42520a387a85641687662f under http://boyle.nsict.org/~mdw/git/catacomb.broken/
----

And the patch itself.  Warning!  This DOES NOT WORK!  (But it may be of
some use to you lot anyway.)

git-http-fetch: Fix failure to find pack list.

From:  <mdw@distorted.org.uk>

  * Problem seems to be premature reuse of a slot.  In some cases, we
    end up fetching the exit status for a different fetch; if that fetch
    fails (because the object is already in a pack) then the pack list
    fetch is assumed to fail and the entire fetch falls apart.
---

 http.c   |   49 +++++++++++++++++++++++++++++++++++++++----------
 http.h   |    8 +++++++-
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/http.c b/http.c
index 75e6717..54aa9ee 100644
--- a/http.c
+++ b/http.c
@@ -1,3 +1,4 @@
+#include <assert.h>
 #include "http.h"
 
 int data_received;
@@ -192,6 +193,9 @@ static CURL* get_curl_handle(void)
 
 	curl_easy_setopt(result, CURLOPT_FOLLOWLOCATION, 1);
 
+	if (getenv("GIT_CURL_VERBOSE"))
+		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
+
 	return result;
 }
 
@@ -262,7 +266,7 @@ void http_cleanup(void)
 
 	while (slot != NULL) {
 #ifdef USE_CURL_MULTI
-		if (slot->in_use) {
+		if (slot->in_use & SLOTUSE_ACTIVE) {
 			curl_easy_getinfo(slot->curl,
 					  CURLINFO_EFFECTIVE_URL,
 					  &wait_url);
@@ -311,6 +315,7 @@ struct active_request_slot *get_active_s
 		newslot->curl = NULL;
 		newslot->in_use = 0;
 		newslot->next = NULL;
+		newslot->nrefs = 0;
 
 		slot = active_queue_head;
 		if (slot == NULL) {
@@ -333,7 +338,7 @@ struct active_request_slot *get_active_s
 	}
 
 	active_requests++;
-	slot->in_use = 1;
+	slot->in_use |= SLOTUSE_ACTIVE;
 	slot->local = NULL;
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
@@ -351,8 +356,9 @@ int start_active_slot(struct active_requ
 
 	if (curlm_result != CURLM_OK &&
 	    curlm_result != CURLM_CALL_MULTI_PERFORM) {
-		active_requests--;
-		slot->in_use = 0;
+		slot->in_use &= ~SLOTUSE_ACTIVE;
+		if (!slot->in_use)
+			active_requests--;
 		return 0;
 	}
 #endif
@@ -375,6 +381,25 @@ void step_active_slots(void)
 }
 #endif
 
+void watch_active_slot(struct active_request_slot *slot)
+{
+	if (!slot->in_use)
+		active_requests++;
+	slot->in_use |= SLOTUSE_REF;
+	slot->nrefs++;
+}
+
+void unwatch_active_slot(struct active_request_slot *slot)
+{
+	assert(slot->nrefs);
+	slot->nrefs--;
+	if (!slot->nrefs) {
+		slot->in_use &= ~SLOTUSE_REF;
+		if (!slot->in_use)
+			active_requests--;
+	}
+}
+
 void run_active_slot(struct active_request_slot *slot)
 {
 #ifdef USE_CURL_MULTI
@@ -386,7 +411,8 @@ void run_active_slot(struct active_reque
 	int max_fd;
 	struct timeval select_timeout;
 
-	while (slot->in_use) {
+	watch_active_slot(slot);
+	while (slot->in_use & SLOTUSE_ACTIVE) {
 		data_received = 0;
 		step_active_slots();
 
@@ -397,7 +423,7 @@ void run_active_slot(struct active_reque
 			last_pos = current_pos;
 		}
 
-		if (slot->in_use && !data_received) {
+		if ((slot->in_use & SLOTUSE_ACTIVE) && !data_received) {
 			max_fd = 0;
 			FD_ZERO(&readfds);
 			FD_ZERO(&writefds);
@@ -408,8 +434,9 @@ void run_active_slot(struct active_reque
 			       &excfds, &select_timeout);
 		}
 	}
+	unwatch_active_slot(slot);
 #else
-	while (slot->in_use) {
+	while (slot->in_use & SLOTUSE_ACTIVE) {
 		slot->curl_result = curl_easy_perform(slot->curl);
 		finish_active_slot(slot);
 	}
@@ -418,8 +445,10 @@ void run_active_slot(struct active_reque
 
 static void finish_active_slot(struct active_request_slot *slot)
 {
-        active_requests--;
-        slot->in_use = 0;
+	assert(slot->in_use & SLOTUSE_ACTIVE);
+        slot->in_use &= ~SLOTUSE_ACTIVE;
+	if (!slot->in_use)
+		active_requests--;
         curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
  
         /* Run callback if appropriate */
@@ -433,7 +462,7 @@ void finish_all_active_slots(void)
 	struct active_request_slot *slot = active_queue_head;
 
 	while (slot != NULL)
-		if (slot->in_use) {
+		if (slot->in_use & SLOTUSE_ACTIVE) {
 			run_active_slot(slot);
 			slot = active_queue_head;
 		} else {
diff --git a/http.h b/http.h
index ed4ea33..6913c6a 100644
--- a/http.h
+++ b/http.h
@@ -26,7 +26,8 @@ struct active_request_slot
 {
 	CURL *curl;
 	FILE *local;
-	int in_use;
+	unsigned in_use;
+	int nrefs;
 	CURLcode curl_result;
 	long http_code;
 	void *callback_data;
@@ -34,6 +35,9 @@ struct active_request_slot
 	struct active_request_slot *next;
 };
 
+#define SLOTUSE_ACTIVE 1u
+#define SLOTUSE_REF 2u
+
 struct buffer
 {
         size_t posn;
@@ -54,6 +58,8 @@ extern struct active_request_slot *get_a
 extern int start_active_slot(struct active_request_slot *slot);
 extern void run_active_slot(struct active_request_slot *slot);
 extern void finish_all_active_slots(void);
+extern void watch_active_slot(struct active_request_slot *slot);
+extern void unwatch_active_slot(struct active_request_slot *slot);
 
 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);

-- [mdw]
