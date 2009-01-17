From: "Ray Chuan" <rctay89@gmail.com>
Subject: [PATCH 2/2] http-push: remove MOVE step after PUT when sending objects to server
Date: Sat, 17 Jan 2009 20:24:47 +0000
Message-ID: <be6fef0d0901171224y35c3d95cn2d38639ac03c3b8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 21:26:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOHkD-0002sZ-Ho
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 21:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773AbZAQUYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 15:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756309AbZAQUYt
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 15:24:49 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:49795 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643AbZAQUYs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 15:24:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1160133wah.21
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 12:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=oP/hlxWGtkmCFMrFOCLhY3gWmEDO3Ix/9dyC2gYlzKw=;
        b=FOptBgsu4MmODMhTzPhNouUnTrWyayUWzVRJMwNkaF9nj7Npq4TuH1k6tLif6Eirk+
         5mTocjtUhoAH7AlJnk56HgFJYYr/PEy414+9+ZWB1INHjCE5Noon3azH9agxSrQ5N9Jg
         VQiA7AZSmpKyAGfM2nBuMlZJbaA2hLwFPUbko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=qAnjfBQSiCDgafcH2r5nhV7yzvnpiHCyO82VuGvqEvrYKXXfG2qhdn2NuUi0SgvaL4
         qh9DS68rvj51jCWqM+/ETZS3n/l+gAe7S85XYeJp6Ach3T3RVC/3xU4M35anTDzb5OEd
         j733akhSX1LHDwqRQIj3B0MSWO6HwiD5G4pSY=
Received: by 10.114.92.14 with SMTP id p14mr25926wab.140.1232223887619;
        Sat, 17 Jan 2009 12:24:47 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Sat, 17 Jan 2009 12:24:47 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106103>

Currently, git PUTs to

 /repo.git/objects/1a/1a2b...9z_opaquelocktoken:1234-....

then MOVEs to

 /repo.git/objects/1a/1a2b...9z

This is needless. In fact, the only time MOVE requests are sent is for
this sole purpose (ie. of renaming an object).

A concern raised was repository corruption in the event of failure
during PUT. "put && move" won't afford any more protection than using
simply "put", since info/refs is not updated if a PUT fails, so there
is no cause for concern.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |   45 +--------------------------------------------
 1 files changed, 1 insertions(+), 44 deletions(-)

diff --git a/http-push.c b/http-push.c
index 4517cf2..d21fd3b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -31,7 +31,6 @@ enum XML_Status {
 /* DAV methods */
 #define DAV_LOCK "LOCK"
 #define DAV_MKCOL "MKCOL"
-#define DAV_MOVE "MOVE"
 #define DAV_PROPFIND "PROPFIND"
 #define DAV_PUT "PUT"
 #define DAV_UNLOCK "UNLOCK"
@@ -105,7 +104,6 @@ enum transfer_state {
 	NEED_PUSH,
 	RUN_MKCOL,
 	RUN_PUT,
-	RUN_MOVE,
 	ABORTED,
 	COMPLETE,
 };
@@ -531,11 +529,6 @@ static void start_put(struct transfer_request *request)
 	posn += 2;
 	*(posn++) = '/';
 	strcpy(posn, hex + 2);
-	request->dest = xmalloc(strlen(request->url) + 14);
-	sprintf(request->dest, "Destination: %s", request->url);
-	posn += 38;
-	*(posn++) = '_';
-	strcpy(posn, request->lock->token);

 	if_header = xmalloc(strlen(request->lock->token) + 25);
 	sprintf(if_header, "If: <%s>", request->lock->token);
@@ -565,32 +558,6 @@ static void start_put(struct transfer_request *request)
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
@@ -713,23 +680,13 @@ static void finish_request(struct
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
1.5.6.3
