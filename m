From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Fix for http-fetch from file:// URLs
Date: Thu, 22 Dec 2005 09:09:05 -0800
Message-ID: <20051222170905.GB3876@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 22 18:09:19 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpTwI-0003rj-Pw
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 18:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVLVRJL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 12:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVLVRJL
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 12:09:11 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:15985 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030202AbVLVRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 12:09:10 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jBMH952b004423
	for <git@vger.kernel.org>; Thu, 22 Dec 2005 09:09:05 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jBMH95S4004421
	for git@vger.kernel.org; Thu, 22 Dec 2005 09:09:05 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13956>

Recognize missing files when using http-fetch with file:// URLs

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

By way of explanation, our content distribution clients use a
self-referential file:// URL when fetching updates, and all actual
content servers are listed in http-alternates.  This removes the
dependency on a single external primary server so updates will
continue to work as long as any one server is available.

 http-fetch.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

applies-to: 3ca81810fe174dec38fa6ccec874559a39d8893f
92865a7cc1ea511f88d1ab8aa4c0faa50e05566b
diff --git a/http-fetch.c b/http-fetch.c
index 3cd6ef9..61b2188 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -267,7 +267,8 @@ static void process_object_response(void
 	obj_req->state = COMPLETE;
 
 	/* Use alternates if necessary */
-	if (obj_req->http_code == 404) {
+	if (obj_req->http_code == 404 ||
+	    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE) {
 		fetch_alternates(alt->base);
 		if (obj_req->repo->next != NULL) {
 			obj_req->repo =
@@ -475,7 +476,8 @@ static void process_alternates_response(
 			}
 		}
 	} else if (slot->curl_result != CURLE_OK) {
-		if (slot->http_code != 404) {
+		if (slot->http_code != 404 &&
+		    slot->curl_result != CURLE_FILE_COULDNT_READ_FILE) {
 			got_alternates = -1;
 			return;
 		}
@@ -637,7 +639,8 @@ static int fetch_indices(struct alt_base
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (slot->curl_result != CURLE_OK) {
-			if (slot->http_code == 404) {
+			if (slot->http_code == 404 ||
+			    slot->curl_result == CURLE_FILE_COULDNT_READ_FILE) {
 				repo->got_indices = 1;
 				free(buffer.buffer);
 				return 0;
@@ -802,7 +805,8 @@ static int fetch_object(struct alt_base 
 		ret = error("Request for %s aborted", hex);
 	} else if (obj_req->curl_result != CURLE_OK &&
 		   obj_req->http_code != 416) {
-		if (obj_req->http_code == 404)
+		if (obj_req->http_code == 404 ||
+		    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE)
 			ret = -1; /* Be silent, it is probably in a pack. */
 		else
 			ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
---
0.99.9.GIT
