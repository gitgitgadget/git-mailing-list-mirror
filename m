From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/4] Make function to refill http queue a callback
Date: Sun, 22 Jul 2007 18:09:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707221808540.29679@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:09:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjcM-0000IM-HS
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759382AbXGVWJZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759352AbXGVWJY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:09:24 -0400
Received: from iabervon.org ([66.92.72.58]:3834 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756112AbXGVWJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:09:23 -0400
Received: (qmail 29519 invoked by uid 1000); 22 Jul 2007 22:09:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jul 2007 22:09:22 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53339>

This eliminates the last function provided by the code using http.h as
a global symbol, so it should be possible to have multiple programs
using http.h in the same executable, and it also adds an argument to
that callback, so that info can be passed into the callback without
being global.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 http-fetch.c |    6 +++++-
 http-push.c  |    3 ++-
 http.c       |   30 ++++++++++++++++++++++++++++--
 http.h       |    4 +---
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index e9b9f30..7786110 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -317,7 +317,7 @@ static void release_object_request(struct object_request *obj_req)
 }
 
 #ifdef USE_CURL_MULTI
-int fill_active_slot(void)
+static int fill_active_slot(void *unused)
 {
 	struct object_request *obj_req;
 
@@ -1035,6 +1035,10 @@ int main(int argc, const char **argv)
 	alt->packs = NULL;
 	alt->next = NULL;
 
+#ifdef USE_CURL_MULTI
+	add_fill_function(NULL, fill_active_slot);
+#endif
+
 	if (pull(commits, commit_id, write_ref, url))
 		rc = 1;
 
diff --git a/http-push.c b/http-push.c
index c7471fa..c54230b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -795,7 +795,7 @@ static void finish_request(struct transfer_request *request)
 }
 
 #ifdef USE_CURL_MULTI
-int fill_active_slot(void)
+static int fill_active_slot(void *unused)
 {
 	struct transfer_request *request = request_queue_head;
 
@@ -2496,6 +2496,7 @@ int main(int argc, char **argv)
 				objects_to_send);
 #ifdef USE_CURL_MULTI
 		fill_active_slots();
+		add_fill_function(NULL, fill_active_slot);
 #endif
 		finish_all_active_slots();
 
diff --git a/http.c b/http.c
index 1f305bd..a95483b 100644
--- a/http.c
+++ b/http.c
@@ -391,13 +391,39 @@ int start_active_slot(struct active_request_slot *slot)
 }
 
 #ifdef USE_CURL_MULTI
+struct fill_chain {
+	void *data;
+	int (*fill)(void *);
+	struct fill_chain *next;
+};
+
+static struct fill_chain *fill_cfg = NULL;
+
+void add_fill_function(void *data, int (*fill)(void *))
+{
+	struct fill_chain *new = malloc(sizeof(*new));
+	struct fill_chain **linkp = &fill_cfg;
+	new->data = data;
+	new->fill = fill;
+	new->next = NULL;
+	while (*linkp)
+		linkp = &(*linkp)->next;
+	*linkp = new;
+}
+
 void fill_active_slots(void)
 {
 	struct active_request_slot *slot = active_queue_head;
 
-	while (active_requests < max_requests)
-		if (!fill_active_slot())
+	while (active_requests < max_requests) {
+		struct fill_chain *fill;
+		for (fill = fill_cfg; fill; fill = fill->next)
+			if (fill->fill(fill->data))
+				break;
+
+		if (!fill)
 			break;
+	}
 
 	while (slot != NULL) {
 		if (!slot->in_use && slot->curl != NULL) {
diff --git a/http.h b/http.h
index 559105c..72abac2 100644
--- a/http.h
+++ b/http.h
@@ -70,10 +70,8 @@ extern void release_active_slot(struct active_request_slot *slot);
 
 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
+extern void add_fill_function(void *data, int (*fill)(void *));
 extern void step_active_slots(void);
-
-/* Provided by the program using http. */
-extern int fill_active_slot(void);
 #endif
 
 extern void http_init(void);
-- 
1.5.3.rc1.818.g84b7
