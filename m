From: "Ray Chuan" <rctay89@gmail.com>
Subject: [PATCH 2/3] http-push: when sending objects, don't PUT before MOVE
Date: Sat, 17 Jan 2009 02:59:07 +0000
Message-ID: <be6fef0d0901161859g4e5d749et78b6b0231eb915ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 04:00:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO1QI-00083h-6J
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 04:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbZAQC7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 21:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbZAQC7L
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 21:59:11 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:35206 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbZAQC7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 21:59:08 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1037076wah.21
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 18:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=bQiuF13tsARkgNle8MRiDYKkqiUzr5MJe7zcfLbe/iQ=;
        b=JOHLfc7KACiGEH8lUqlWZgTYFMT40ERdIjFtCzCyLK57E0vWfBRZEKAmoX4nFJEB4j
         Zhg4kTwf46bQGDK9zsHD1u4jAsuhEY3kK/qsY04GUchgAw5gr9sDNQ4j5DrMJgMFquzm
         j+zml5cfMQ4yV/onb+gdXpfeyKcVtfFm67df4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=kd6OQkyUq7bQTr6ly2pWHyl8mR7IgGCLT3dbnOY8BzAY9kkSq/2J9al4vQLkEvBAYn
         tIC3KQvU3JU7en71KFx8FN8nRK8MAhMAdrmFQHAcE/TVI9BbRIsZ6lxquN6whykIiQTg
         cdWwU9tUeUx3XoiPmU22J22aIpA5pvl2R7EB8=
Received: by 10.115.89.1 with SMTP id r1mr2260845wal.84.1232161147213;
        Fri, 16 Jan 2009 18:59:07 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Fri, 16 Jan 2009 18:59:07 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106013>

since 753bc911f489748a837ecb5ea4b5216220b24845, the opaquelocktocken
URI isn't used, so it doesn't make sense to PUT then MOVE.

currently, git PUTs to

/repo.git/objects/1a/1a2b..._opaquelocktoken:1234-....

on some platforms, ':' isn't allowed in filenames so this fails
(assuming the server doesn't recognize it as opaquelocktoken scheme).
in fact, i don't think this is the correct implementation of the
scheme; 'opaquelocktoken: ' should come in front of the path.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 src/git-1.6.1/http-push.c |   45 +--------------------------------------------
 1 files changed, 1 insertions(+), 44 deletions(-)

diff --git a/src/git-1.6.1/http-push.c b/src/git-1.6.1/http-push.c
index a646a49..838ff6f 100644
--- a/src/git-1.6.1/http-push.c
+++ b/src/git-1.6.1/http-push.c
@@ -31,7 +31,6 @@ enum XML_Status {
 /* DAV methods */
 #define DAV_LOCK "LOCK"
 #define DAV_MKCOL "MKCOL"
-#define DAV_MOVE "MOVE"
 #define DAV_PROPFIND "PROPFIND"
 #define DAV_PUT "PUT"
 #define DAV_UNLOCK "UNLOCK"
@@ -104,7 +103,6 @@ enum transfer_state {
 	NEED_PUSH,
 	RUN_MKCOL,
 	RUN_PUT,
-	RUN_MOVE,
 	ABORTED,
 	COMPLETE,
 };
@@ -528,11 +526,6 @@ static void start_put(struct transfer_request *request)
 	posn += 2;
 	*(posn++) = '/';
 	strcpy(posn, hex + 2);
-	request->dest = xmalloc(strlen(request->url) + 14);
-	sprintf(request->dest, "Destination: %s", request->url);
-	posn += 38;
-	*(posn++) = '_';
-	strcpy(posn, request->lock->token);

 	slot = get_active_slot();
 	slot->callback_func = process_response;
@@ -557,32 +550,6 @@ static void start_put(struct transfer_request *request)
 	}
 }

-static void start_move(struct transfer_request *request)
-{
-	struct active_request_slot *slot;
-	struct curl_slist *dav_headers = NULL;
-
-	slot = get_active_slot();
-	slot->callback_func = process_response;
-	slot->callback_data = request;
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1); /* undo PUT setup */
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_MOVE);
-	dav_headers = curl_slist_append(dav_headers, request->dest);
-	dav_headers = curl_slist_append(dav_headers, "Overwrite: T");
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
-
-	if (start_active_slot(slot)) {
-		request->slot = slot;
-		request->state = RUN_MOVE;
-	} else {
-		request->state = ABORTED;
-		free(request->url);
-		request->url = NULL;
-	}
-}
-
 static int refresh_lock(struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
@@ -705,23 +672,13 @@ static void finish_request(struct
transfer_request *request)
 		}
 	} else if (request->state == RUN_PUT) {
 		if (request->curl_result == CURLE_OK) {
-			start_move(request);
-		} else {
-			fprintf(stderr,	"PUT %s failed, aborting (%d/%ld)\n",
-				sha1_to_hex(request->obj->sha1),
-				request->curl_result, request->http_code);
-			request->state = ABORTED;
-			aborted = 1;
-		}
-	} else if (request->state == RUN_MOVE) {
-		if (request->curl_result == CURLE_OK) {
 			if (push_verbosely)
 				fprintf(stderr, "    sent %s\n",
 					sha1_to_hex(request->obj->sha1));
 			request->obj->flags |= REMOTE;
 			release_request(request);
 		} else {
-			fprintf(stderr, "MOVE %s failed, aborting (%d/%ld)\n",
+			fprintf(stderr,	"PUT %s failed, aborting (%d/%ld)\n",
 				sha1_to_hex(request->obj->sha1),
 				request->curl_result, request->http_code);
 			request->state = ABORTED;
-- 
1.6.0.4
