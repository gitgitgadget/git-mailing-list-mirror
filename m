From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 9/9] http-fetch: Paranoid sanity checking for the object queue.
Date: Wed, 01 Feb 2006 11:44:43 +0000
Message-ID: <20060201114443.5042.65478.stgit@metalzone.distorted.org.uk>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Wed Feb 01 12:45:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4GPq-00055O-T8
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 12:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWBALoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 06:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWBALoq
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 06:44:46 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:7152 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1161029AbWBALoo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 06:44:44 -0500
Received: (qmail 6624 invoked from network); 1 Feb 2006 11:44:43 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?2l46ExBJLH2SZbP84uGhcXYIJSQdtJln?@127.0.0.1)
  by localhost with SMTP; 1 Feb 2006 11:44:43 -0000
To: git@vger.kernel.org
In-Reply-To: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15407>

From: Mark Wooding <mdw@distorted.org.uk>

Probably not wanted in the mainline, but useful for debugging.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 http-fetch.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index fa3eb4a..80eaa2f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -3,6 +3,7 @@
 #include "pack.h"
 #include "fetch.h"
 #include "http.h"
+#include <assert.h>
 
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
@@ -28,6 +29,13 @@ enum object_request_state {
 	COMPLETE,
 };
 
+typedef struct stash {
+	struct stash *next;
+	unsigned char sha1[20];
+	int activep;
+	int tickp;
+} stash;
+
 struct object_request
 {
 	unsigned char sha1[20];
@@ -47,6 +55,7 @@ struct object_request
 	int rename;
 	struct active_request_slot *slot;
 	struct object_request *next;
+	stash *tick;
 };
 
 struct alternates_request {
@@ -57,8 +66,60 @@ struct alternates_request {
 	int http_specific;
 };
 
+static stash *seen = 0;
+
+static stash *findstash(unsigned char *sha1)
+{
+	stash *s;
+	for (s = seen; s; s = s->next) {
+		if (memcmp(sha1, s->sha1, 20) == 0)
+			return s;
+	}
+	return NULL;
+}
+
+static stash *enstash(unsigned char *sha1)
+{
+	stash *s;
+	if ((s = findstash(sha1)) != NULL)
+		assert(!s->activep);
+	else {
+		s = xmalloc(sizeof(*s));
+		memcpy(s->sha1, sha1, 20);
+		s->next = seen;
+		seen = s;
+	}
+	s->activep = 1;
+	return s;
+}
+
+static void unstash(unsigned char *sha1)
+{
+	stash *s = findstash(sha1);
+	assert(s && s->activep);
+	s->activep = 0;
+}
+
 static struct object_request *object_queue_head = NULL;
 
+static void sanity_check_stash(void)
+{
+	stash *s;
+	struct object_request *obj_req;
+
+	for (s = seen; s; s = s->next)
+		s->tickp = 0;
+	for (obj_req = object_queue_head; obj_req; obj_req = obj_req->next) {
+		assert(obj_req->tick);
+		s = obj_req->tick;
+		assert(memcmp(s->sha1, obj_req->sha1, 20) == 0);
+		assert(s->activep);
+		s->tickp = 1;
+	}
+	for (s = seen; s; s = s->next)
+		assert(!s->tickp == !s->activep);
+}
+
 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 			       void *data)
 {
@@ -287,6 +348,7 @@ static void release_object_request(struc
 {
 	struct object_request *entry = object_queue_head;
 
+	sanity_check_stash();
 	if (obj_req->local != -1)
 		error("fd leakage in release: %d", obj_req->local);
 	if (obj_req == object_queue_head) {
@@ -298,6 +360,8 @@ static void release_object_request(struc
 			entry->next = entry->next->next;
 	}
 
+	unstash(obj_req->sha1);
+	sanity_check_stash();
 	free(obj_req->url);
 	free(obj_req);
 }
@@ -309,6 +373,7 @@ void fill_active_slots(void)
 	struct active_request_slot *slot = active_queue_head;
 	int num_transfers;
 
+	sanity_check_stash();
 	while (active_requests < max_requests && obj_req != NULL) {
 		if (obj_req->state == WAITING) {
 			if (has_sha1_file(obj_req->sha1))
@@ -327,6 +392,7 @@ void fill_active_slots(void)
 		}
 		slot = slot->next;
 	}				
+	sanity_check_stash();
 }
 #endif
 
@@ -347,6 +413,7 @@ void prefetch(unsigned char *sha1)
 		 "%s.temp", filename);
 	newreq->next = NULL;
 
+	sanity_check_stash();
 	if (object_queue_head == NULL) {
 		object_queue_head = newreq;
 	} else {
@@ -356,6 +423,8 @@ void prefetch(unsigned char *sha1)
 		}
 		tail->next = newreq;
 	}
+	newreq->tick = enstash(sha1);
+	sanity_check_stash();
 
 #ifdef USE_CURL_MULTI
 	fill_active_slots();
@@ -789,6 +858,7 @@ static int fetch_object(struct alt_base 
 	int ret = 0;
 	struct object_request *obj_req = object_queue_head;
 
+	sanity_check_stash();
 	while (obj_req != NULL && memcmp(obj_req->sha1, sha1, 20))
 		obj_req = obj_req->next;
 	if (obj_req == NULL)
