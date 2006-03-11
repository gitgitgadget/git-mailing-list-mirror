From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 4/6] http-push: improve remote lock management
Date: Fri, 10 Mar 2006 20:18:12 -0800
Message-ID: <20060311041812.GF3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 11 05:18:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHvYg-0004ul-02
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 05:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWCKESO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 23:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWCKESN
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 23:18:13 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:47055 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932410AbWCKESM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 23:18:12 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2B4ICIm007659
	for <git@vger.kernel.org>; Fri, 10 Mar 2006 20:18:12 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2B4ICNN007657
	for git@vger.kernel.org; Fri, 10 Mar 2006 20:18:12 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17491>

Associate the remote locks with the remote repo, add a function to check
and refresh all current locks.

---

 http-push.c |  149 ++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 76 insertions(+), 73 deletions(-)

fd1de0bf29e5e0fa63b851cb2195fbe05ebf80c2
diff --git a/http-push.c b/http-push.c
index 755bcb8..ece40da 100644
--- a/http-push.c
+++ b/http-push.c
@@ -80,10 +80,10 @@ struct repo
 	char *url;
 	int path_len;
 	struct packed_git *packs;
+	struct remote_lock *locks;
 };
 
 static struct repo *remote = NULL;
-static struct remote_lock *remote_locks = NULL;
 
 enum transfer_state {
 	NEED_PUSH,
@@ -135,7 +135,6 @@ struct remote_lock
 	char *token;
 	time_t start_time;
 	long timeout;
-	int active;
 	int refreshing;
 	struct remote_lock *next;
 };
@@ -311,64 +310,69 @@ static void start_move(struct transfer_r
 	}
 }
 
-static int refresh_lock(struct remote_lock *check_lock)
+static int refresh_lock(struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
 	char *if_header;
 	char timeout_header[25];
 	struct curl_slist *dav_headers = NULL;
-	struct remote_lock *lock;
-	int time_remaining;
-	time_t current_time;
+	int rc = 0;
 
-	/* Refresh all active locks if they're close to expiring */
-	for (lock = remote_locks; lock; lock = lock->next) {
-		if (!lock->active)
-			continue;
+	lock->refreshing = 1;
 
-		current_time = time(NULL);
-		time_remaining = lock->start_time + lock->timeout
-			- current_time;
-		if (time_remaining > LOCK_REFRESH)
-			continue;
+	if_header = xmalloc(strlen(lock->token) + 25);
+	sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
+	sprintf(timeout_header, "Timeout: Second-%ld", lock->timeout);
+	dav_headers = curl_slist_append(dav_headers, if_header);
+	dav_headers = curl_slist_append(dav_headers, timeout_header);
 
-		lock->refreshing = 1;
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
+	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_LOCK);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 
-		if_header = xmalloc(strlen(lock->token) + 25);
-		sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
-		sprintf(timeout_header, "Timeout: Second-%ld", lock->timeout);
-		dav_headers = curl_slist_append(dav_headers, if_header);
-		dav_headers = curl_slist_append(dav_headers, timeout_header);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK) {
+			fprintf(stderr, "LOCK HTTP error %ld\n",
+				results.http_code);
+		} else {
+			lock->start_time = time(NULL);
+			rc = 1;
+		}
+	}
 
-		slot = get_active_slot();
-		slot->results = &results;
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-		curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
-		curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_LOCK);
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
+	lock->refreshing = 0;
+	curl_slist_free_all(dav_headers);
+	free(if_header);
 
-		if (start_active_slot(slot)) {
-			run_active_slot(slot);
-			if (results.curl_result != CURLE_OK) {
-				fprintf(stderr, "Got HTTP error %ld\n", results.http_code);
-				lock->active = 0;
-			} else {
-				lock->active = 1;
-				lock->start_time = time(NULL);
+	return rc;
+}
+
+static void check_locks()
+{
+	struct remote_lock *lock = remote->locks;
+	time_t current_time = time(NULL);
+	int time_remaining;
+
+	while (lock) {
+		time_remaining = lock->start_time + lock->timeout -
+			current_time;
+		if (!lock->refreshing && time_remaining < LOCK_REFRESH) {
+			if (!refresh_lock(lock)) {
+				fprintf(stderr,
+					"Unable to refresh lock for %s\n",
+					lock->url);
+				aborted = 1;
+				return;
 			}
 		}
-
-		lock->refreshing = 0;
-		curl_slist_free_all(dav_headers);
-		free(if_header);
+		lock = lock->next;
 	}
-
-	if (check_lock)
-		return check_lock->active;
-	else
-		return 0;
 }
 
 static void release_request(struct transfer_request *request)
@@ -396,7 +400,7 @@ static void finish_request(struct transf
 	request->slot = NULL;
 
 	/* Keep locks active */
-	refresh_lock(request->lock);
+	check_locks();
 
 	if (request->headers != NULL)
 		curl_slist_free_all(request->headers);
@@ -483,6 +487,9 @@ static void add_request(struct object *o
 	struct transfer_request *request = request_queue_head;
 	struct packed_git *target;
 
+	/* Keep locks active */
+	check_locks();
+
 	/*
 	 * Don't push the object if it's known to exist on the remote
 	 * or is already in the request queue
@@ -893,7 +900,7 @@ static struct remote_lock *lock_remote(c
 	char *url;
 	char *ep;
 	char timeout_header[25];
-	struct remote_lock *lock = remote_locks;
+	struct remote_lock *lock = NULL;
 	XML_Parser parser = XML_ParserCreate(NULL);
 	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
@@ -902,18 +909,6 @@ static struct remote_lock *lock_remote(c
 	url = xmalloc(strlen(remote->url) + strlen(path) + 1);
 	sprintf(url, "%s%s", remote->url, path);
 
-	/* Make sure the url is not already locked */
-	while (lock && strcmp(lock->url, url)) {
-		lock = lock->next;
-	}
-	if (lock) {
-		free(url);
-		if (refresh_lock(lock))
-			return lock;
-		else
-			return NULL;
-	}
-
 	/* Make sure leading directories exist for the remote ref */
 	ep = strchr(url + strlen(remote->url) + 11, '/');
 	while (ep) {
@@ -971,10 +966,7 @@ static struct remote_lock *lock_remote(c
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 
 	lock = xcalloc(1, sizeof(*lock));
-	lock->owner = NULL;
-	lock->token = NULL;
 	lock->timeout = -1;
-	lock->refreshing = 0;
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
@@ -1016,10 +1008,9 @@ static struct remote_lock *lock_remote(c
 		lock = NULL;
 	} else {
 		lock->url = url;
-		lock->active = 1;
 		lock->start_time = time(NULL);
-		lock->next = remote_locks;
-		remote_locks = lock;
+		lock->next = remote->locks;
+		remote->locks = lock;
 	}
 
 	return lock;
@@ -1029,6 +1020,7 @@ static int unlock_remote(struct remote_l
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
+	struct remote_lock *prev = remote->locks;
 	char *lock_token_header;
 	struct curl_slist *dav_headers = NULL;
 	int rc = 0;
@@ -1050,16 +1042,29 @@ static int unlock_remote(struct remote_l
 		if (results.curl_result == CURLE_OK)
 			rc = 1;
 		else
-			fprintf(stderr, "Got HTTP error %ld\n",
+			fprintf(stderr, "UNLOCK HTTP error %ld\n",
 				results.http_code);
 	} else {
-		fprintf(stderr, "Unable to start request\n");
+		fprintf(stderr, "Unable to start UNLOCK request\n");
 	}
 
 	curl_slist_free_all(dav_headers);
 	free(lock_token_header);
 
-	lock->active = 0;
+	if (remote->locks == lock) {
+		remote->locks = lock->next;
+	} else {
+		while (prev && prev->next != lock)
+			prev = prev->next;
+		if (prev)
+			prev->next = prev->next->next;			
+	}
+
+	if (lock->owner != NULL)
+		free(lock->owner);
+	free(lock->url);
+	free(lock->token);
+	free(lock);
 
 	return rc;
 }
@@ -1597,7 +1602,7 @@ int main(int argc, char **argv)
 	struct transfer_request *next_request;
 	int nr_refspec = 0;
 	char **refspec = NULL;
-	struct remote_lock *ref_lock;
+	struct remote_lock *ref_lock = NULL;
 	struct rev_info revs;
 	int rc = 0;
 	int i;
@@ -1605,10 +1610,7 @@ int main(int argc, char **argv)
 	setup_git_directory();
 	setup_ident();
 
-	remote = xmalloc(sizeof(*remote));
-	remote->url = NULL;
-	remote->path_len = 0;
-	remote->packs = NULL;
+	remote = xcalloc(sizeof(*remote), 1);
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
@@ -1787,6 +1789,7 @@ int main(int argc, char **argv)
 		if (!rc)
 			fprintf(stderr, "    done\n");
 		unlock_remote(ref_lock);
+		check_locks();
 	}
 
  cleanup:
-- 
1.2.4.g8e81-dirty
