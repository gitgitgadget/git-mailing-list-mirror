From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Trivial support for cloning and fetching via ftp://.
Date: Sat, 16 Sep 2006 10:58:20 -0700
Message-ID: <7vd59vae2r.fsf@assigned-by-dhcp.cox.net>
References: <20060914022404.GA900@sashak.voltaire.com>
	<7vk6475408.fsf@assigned-by-dhcp.cox.net>
	<20060916023717.GA13570@sashak.voltaire.com>
	<7vwt849nv6.fsf@assigned-by-dhcp.cox.net>
	<20060916100147.GA17504@sashak.voltaire.com>
	<7virjnafev.fsf@assigned-by-dhcp.cox.net>
	<20060916174134.GE17504@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 19:58:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOeQr-0000pK-Ii
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 19:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWIPR6W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 13:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWIPR6W
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 13:58:22 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:6900 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964866AbWIPR6V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 13:58:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060916175820.TPMJ6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Sep 2006 13:58:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id P5yN1V0011kojtg0000000
	Sat, 16 Sep 2006 13:58:22 -0400
To: Sasha Khapyorsky <sashak@voltaire.com>
In-Reply-To: <20060916174134.GE17504@sashak.voltaire.com> (Sasha Khapyorsky's
	message of "Sat, 16 Sep 2006 20:41:34 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27121>

Sasha Khapyorsky <sashak@voltaire.com> writes:

> Good. Am I need to send the patch or you will integrate it?

Actually, I am thinking of doing this in two steps.

The attached is the first "clean-up" step, which should be
obvious enough.

And you already know what the second one that would come on top
of this should look like ;-).

-- >8 --
http-fetch.c: consolidate code to detect missing fetch target

At a handful places we check two error codes from curl library
to see if the file we asked was missing from the remote (e.g.
we asked for a loose object when it is in a pack) to decide what
to do next.  This consolidates the check into a single function.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/http-fetch.c b/http-fetch.c
index a113bb8..bc74f30 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -144,6 +144,19 @@ static size_t fwrite_sha1_file(void *ptr
 	return size;
 }
 
+static int missing__target(int code, int result)
+{
+	return	/* file:// URL -- do we ever use one??? */
+		(result == CURLE_FILE_COULDNT_READ_FILE) ||
+		/* http:// and https:// URL */
+		(code == 404 && result == CURLE_HTTP_RETURNED_ERROR) ||
+		/* ftp:// URL */
+		(code == 550 && result == CURLE_FTP_COULDNT_RETR_FILE)
+		;
+}
+
+#define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
+
 static void fetch_alternates(const char *base);
 
 static void process_object_response(void *callback_data);
@@ -323,8 +336,7 @@ static void process_object_response(void
 	obj_req->state = COMPLETE;
 
 	/* Use alternates if necessary */
-	if (obj_req->http_code == 404 ||
-	    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE) {
+	if (missing_target(obj_req)) {
 		fetch_alternates(alt->base);
 		if (obj_req->repo->next != NULL) {
 			obj_req->repo =
@@ -537,8 +549,7 @@ static void process_alternates_response(
 			return;
 		}
 	} else if (slot->curl_result != CURLE_OK) {
-		if (slot->http_code != 404 &&
-		    slot->curl_result != CURLE_FILE_COULDNT_READ_FILE) {
+		if (!missing_target(slot)) {
 			got_alternates = -1;
 			return;
 		}
@@ -941,8 +952,7 @@ #endif
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-			if (results.http_code == 404 ||
-			    results.curl_result == CURLE_FILE_COULDNT_READ_FILE) {
+			if (missing_target(&results)) {
 				repo->got_indices = 1;
 				free(buffer.buffer);
 				return 0;
@@ -1123,8 +1133,7 @@ #endif
 		ret = error("Request for %s aborted", hex);
 	} else if (obj_req->curl_result != CURLE_OK &&
 		   obj_req->http_code != 416) {
-		if (obj_req->http_code == 404 ||
-		    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE)
+		if (missing_target(obj_req))
 			ret = -1; /* Be silent, it is probably in a pack. */
 		else
 			ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
