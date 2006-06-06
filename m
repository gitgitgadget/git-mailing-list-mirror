From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] HTTP cleanup
Date: Tue, 06 Jun 2006 14:27:36 -0700
Message-ID: <7v4pyyotyv.fsf@assigned-by-dhcp.cox.net>
References: <20060606164131.GB3938@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 23:27:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnj5S-0001Pv-S3
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 23:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWFFV1k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 17:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWFFV1k
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 17:27:40 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:8838 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751126AbWFFV1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 17:27:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606212738.JMCP19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 17:27:38 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20060606164131.GB3938@reactrix.com> (Nick Hengeveld's message of
	"Tue, 6 Jun 2006 09:41:32 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21403>

Thanks.  I think this is needed on top of it.

-- >8 --
[PATCH] HTTP cleanup

This ifdef's out more functions that are not used while !USE_MULTI
in http code.  Also the dependency of http related objects on http.h
header file was missing in the Makefile.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Makefile    |    3 ++-
 http-push.c |   70 ++++++++++++++++++++++++++++++-----------------------------
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/Makefile b/Makefile
index 004c216..f802043 100644
--- a/Makefile
+++ b/Makefile
@@ -552,7 +552,7 @@ http.o: http.c
 	$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
 
 ifdef NO_EXPAT
-http-fetch.o: http-fetch.c
+http-fetch.o: http-fetch.c http.h
 	$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
 endif
 
@@ -576,6 +576,7 @@ git-ssh-push$X: rsh.o
 
 git-imap-send$X: imap-send.o $(LIB_FILE)
 
+http.o http-fetch.o http-push.o: http.h
 git-http-fetch$X: fetch.o http.o http-fetch.o $(LIB_FILE)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
diff --git a/http-push.c b/http-push.c
index 40524a8..b39b36b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -186,6 +186,7 @@ static void process_response(void *callb
 	finish_request(request);
 }
 
+#ifdef USE_CURL_MULTI
 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 			       void *data)
 {
@@ -349,6 +350,41 @@ static void start_fetch_loose(struct tra
 	}
 }
 
+static void start_mkcol(struct transfer_request *request)
+{
+	char *hex = sha1_to_hex(request->obj->sha1);
+	struct active_request_slot *slot;
+	char *posn;
+
+	request->url = xmalloc(strlen(remote->url) + 13);
+	strcpy(request->url, remote->url);
+	posn = request->url + strlen(remote->url);
+	strcpy(posn, "objects/");
+	posn += 8;
+	memcpy(posn, hex, 2);
+	posn += 2;
+	strcpy(posn, "/");
+
+	slot = get_active_slot();
+	slot->callback_func = process_response;
+	slot->callback_data = request;
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1); /* undo PUT setup */
+	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
+	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
+	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_MKCOL);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
+
+	if (start_active_slot(slot)) {
+		request->slot = slot;
+		request->state = RUN_MKCOL;
+	} else {
+		request->state = ABORTED;
+		free(request->url);
+		request->url = NULL;
+	}
+}
+#endif
+
 static void start_fetch_packed(struct transfer_request *request)
 {
 	char *url;
@@ -438,40 +474,6 @@ static void start_fetch_packed(struct tr
 	}
 }
 
-static void start_mkcol(struct transfer_request *request)
-{
-	char *hex = sha1_to_hex(request->obj->sha1);
-	struct active_request_slot *slot;
-	char *posn;
-
-	request->url = xmalloc(strlen(remote->url) + 13);
-	strcpy(request->url, remote->url);
-	posn = request->url + strlen(remote->url);
-	strcpy(posn, "objects/");
-	posn += 8;
-	memcpy(posn, hex, 2);
-	posn += 2;
-	strcpy(posn, "/");
-
-	slot = get_active_slot();
-	slot->callback_func = process_response;
-	slot->callback_data = request;
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1); /* undo PUT setup */
-	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
-	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_MKCOL);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-
-	if (start_active_slot(slot)) {
-		request->slot = slot;
-		request->state = RUN_MKCOL;
-	} else {
-		request->state = ABORTED;
-		free(request->url);
-		request->url = NULL;
-	}
-}
-
 static void start_put(struct transfer_request *request)
 {
 	char *hex = sha1_to_hex(request->obj->sha1);
-- 
1.4.0.rc1.g9c41
