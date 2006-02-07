From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] http-fetch: Abort requests for objects which arrived in packs
Date: Tue, 07 Feb 2006 10:07:39 +0000
Message-ID: <20060207100739.22520.49089.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Tue Feb 07 11:07:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6PlA-0002SO-6v
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 11:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWBGKHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 05:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWBGKHl
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 05:07:41 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:1869 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S964835AbWBGKHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 05:07:41 -0500
Received: (qmail 22549 invoked from network); 7 Feb 2006 10:07:39 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?fz8EVbxpymiBV9gwIahif5QmDKWVbFeI?@127.0.0.1)
  by localhost with SMTP; 7 Feb 2006 10:07:39 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15689>

From: Mark Wooding <mdw@distorted.org.uk>

In fetch_object, there's a call to release an object request if the
object mysteriously arrived, say in a pack.  Unfortunately, the fetch
attempt for this object might already be in progress, and we'll leak the
descriptor.  Instead, try to tidy away the request.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 http-fetch.c |   16 +++++++++++++++-
 http.c       |   18 +++++++++++++++++-
 http.h       |    1 +
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index bddbd6b..ce3df5f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -773,6 +773,20 @@ static int fetch_pack(struct alt_base *r
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
@@ -785,7 +799,7 @@ static int fetch_object(struct alt_base 
 		return error("Couldn't find request for %s in the queue", hex);
 
 	if (has_sha1_file(obj_req->sha1)) {
-		release_object_request(obj_req);
+		abort_object_request(obj_req);
 		return 0;
 	}
 
diff --git a/http.c b/http.c
index 632c2c5..14a7669 100644
--- a/http.c
+++ b/http.c
@@ -420,10 +420,26 @@ void run_active_slot(struct active_reque
 #endif
 }
 
-static void finish_active_slot(struct active_request_slot *slot)
+static void closedown_active_slot(struct active_request_slot *slot)
 {
         active_requests--;
         slot->in_use = 0;
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
 
 	/* Store slot results so they can be read after the slot is reused */
diff --git a/http.h b/http.h
index d6dc9d8..36fa154 100644
--- a/http.h
+++ b/http.h
@@ -61,6 +61,7 @@ extern struct active_request_slot *get_a
 extern int start_active_slot(struct active_request_slot *slot);
 extern void run_active_slot(struct active_request_slot *slot);
 extern void finish_all_active_slots(void);
+extern void release_active_slot(struct active_request_slot *slot);
 
 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
