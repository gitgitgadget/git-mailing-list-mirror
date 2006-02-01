From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 3/9] http-fetch: Abort requests for objects which arrived in packs
Date: Wed, 01 Feb 2006 11:44:31 +0000
Message-ID: <20060201114430.5042.5144.stgit@metalzone.distorted.org.uk>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Wed Feb 01 12:44:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4GPe-00055O-OX
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 12:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWBALoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 06:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBALod
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 06:44:33 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:5616 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S932423AbWBALoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 06:44:32 -0500
Received: (qmail 6534 invoked from network); 1 Feb 2006 11:44:31 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?PZ0VgBMdSFHrdniCxTCcretYmjvZsoH8?@127.0.0.1)
  by localhost with SMTP; 1 Feb 2006 11:44:31 -0000
To: git@vger.kernel.org
In-Reply-To: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15403>

From: Mark Wooding <mdw@distorted.org.uk>

In fetch_object, there's a call to release an object request if the
object mysteriously arrived, say in a pack.  Unfortunately, the fetch
attempt for this object might already be in progress, and we'll leak the
descriptor.  Instead, try to tidy away the request.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 http-fetch.c |   16 +++++++++++++++-
 http.c       |   20 ++++++++++++++++++--
 http.h       |    1 +
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index b1ee836..8656070 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -770,6 +770,20 @@ static int fetch_pack(struct alt_base *r
 	return 0;
 }
 
+static void abort_object_request(struct object_request *obj_req)
+{
+	if (obj_req->local >= 0) {
+		close(obj_req->local);
+		obj_req->local = -1;
+	}
+	unlink(obj_req->tmpfile);
+	if (obj_req->slot) {
+ 		release_active_slot(obj_req->slot);
+		obj_req->slot = NULL;
+	}
+	release_object_request(obj_req);
+}
+
 static int fetch_object(struct alt_base *repo, unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
@@ -782,7 +796,7 @@ static int fetch_object(struct alt_base 
 		return error("Couldn't find request for %s in the queue", hex);
 
 	if (has_sha1_file(obj_req->sha1)) {
-		release_object_request(obj_req);
+		abort_object_request(obj_req);
 		return 0;
 	}
 
diff --git a/http.c b/http.c
index 498b4ae..0a70e1c 100644
--- a/http.c
+++ b/http.c
@@ -438,11 +438,27 @@ void run_active_slot(struct active_reque
 #endif
 }
 
-static void finish_active_slot(struct active_request_slot *slot)
+static void closedown_active_slot(struct active_request_slot *slot)
 {
-	slot->in_use &= ~SLOTUSE_ACTIVE;
+        slot->in_use &= ~SLOTUSE_ACTIVE;
 	if (!slot->in_use)
 		active_requests--;
+}
+
+void release_active_slot(struct active_request_slot *slot)
+{
+	closedown_active_slot(slot);
+	if (slot->curl) {
+		curl_multi_remove_handle(curlm, slot->curl);
+		curl_easy_cleanup(slot->curl);
+		slot->curl = NULL;
+	}
+	fill_active_slots();
+}
+
+static void finish_active_slot(struct active_request_slot *slot)
+{
+	closedown_active_slot(slot);
         curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
  
         /* Run callback if appropriate */
diff --git a/http.h b/http.h
index a66e06a..d028a5d 100644
--- a/http.h
+++ b/http.h
@@ -58,6 +58,7 @@ extern struct active_request_slot *get_a
 extern int start_active_slot(struct active_request_slot *slot);
 extern void run_active_slot(struct active_request_slot *slot);
 extern void finish_all_active_slots(void);
+extern void release_active_slot(struct active_request_slot *slot);
 
 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
