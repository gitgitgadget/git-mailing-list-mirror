From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 2/5] Make http-fetch request types more clear
Date: Fri, 18 Nov 2005 11:03:04 -0800
Message-ID: <20051118190304.GG3968@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 18 20:03:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdBVt-0006bS-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 20:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbVKRTDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 14:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKRTDG
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 14:03:06 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:50779 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750776AbVKRTDE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 14:03:04 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAIJ34SH026719
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 11:03:04 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAIJ34vX026717
	for git@vger.kernel.org; Fri, 18 Nov 2005 11:03:04 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12244>

Rename object request functions and data to make it more clear which type
of request is being processed - this is a response to the introduction of
slot callbacks and the definition of different types of requests such as
alternates_request.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |  275 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 139 insertions(+), 136 deletions(-)

applies-to: ca1aeba57d4c1ac8d7e6550dba68ead4539696e5
d3d94b6074099a6aa68280430d38678028268678
diff --git a/http-fetch.c b/http-fetch.c
index 6a9eaf3..53a7dbf 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -21,14 +21,14 @@ struct alt_base
 
 static struct alt_base *alt = NULL;
 
-enum transfer_state {
+enum object_request_state {
 	WAITING,
 	ABORTED,
 	ACTIVE,
 	COMPLETE,
 };
 
-struct transfer_request
+struct object_request
 {
 	unsigned char sha1[20];
 	struct alt_base *repo;
@@ -36,7 +36,7 @@ struct transfer_request
 	char filename[PATH_MAX];
 	char tmpfile[PATH_MAX];
 	int local;
-	enum transfer_state state;
+	enum object_request_state state;
 	CURLcode curl_result;
 	char errorstr[CURL_ERROR_SIZE];
 	long http_code;
@@ -46,10 +46,10 @@ struct transfer_request
 	int zret;
 	int rename;
 	struct active_request_slot *slot;
-	struct transfer_request *next;
+	struct object_request *next;
 };
 
-struct alt_request {
+struct alternates_request {
 	char *base;
 	char *url;
 	struct buffer *buffer;
@@ -57,7 +57,7 @@ struct alt_request {
 	int http_specific;
 };
 
-static struct transfer_request *request_queue_head = NULL;
+static struct object_request *object_queue_head = NULL;
 
 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 			       void *data)
@@ -65,24 +65,24 @@ static size_t fwrite_sha1_file(void *ptr
 	unsigned char expn[4096];
 	size_t size = eltsize * nmemb;
 	int posn = 0;
-	struct transfer_request *request = (struct transfer_request *)data;
+	struct object_request *obj_req = (struct object_request *)data;
 	do {
-		ssize_t retval = write(request->local,
+		ssize_t retval = write(obj_req->local,
 				       ptr + posn, size - posn);
 		if (retval < 0)
 			return posn;
 		posn += retval;
 	} while (posn < size);
 
-	request->stream.avail_in = size;
-	request->stream.next_in = ptr;
+	obj_req->stream.avail_in = size;
+	obj_req->stream.next_in = ptr;
 	do {
-		request->stream.next_out = expn;
-		request->stream.avail_out = sizeof(expn);
-		request->zret = inflate(&request->stream, Z_SYNC_FLUSH);
-		SHA1_Update(&request->c, expn,
-			    sizeof(expn) - request->stream.avail_out);
-	} while (request->stream.avail_in && request->zret == Z_OK);
+		obj_req->stream.next_out = expn;
+		obj_req->stream.avail_out = sizeof(expn);
+		obj_req->zret = inflate(&obj_req->stream, Z_SYNC_FLUSH);
+		SHA1_Update(&obj_req->c, expn,
+			    sizeof(expn) - obj_req->stream.avail_out);
+	} while (obj_req->stream.avail_in && obj_req->zret == Z_OK);
 	data_received++;
 	return size;
 }
@@ -91,9 +91,9 @@ static void fetch_alternates(char *base)
 
 static void process_object_response(void *callback_data);
 
-static void start_request(struct transfer_request *request)
+static void start_object_request(struct object_request *obj_req)
 {
-	char *hex = sha1_to_hex(request->sha1);
+	char *hex = sha1_to_hex(obj_req->sha1);
 	char prevfile[PATH_MAX];
 	char *url;
 	char *posn;
@@ -105,53 +105,53 @@ static void start_request(struct transfe
 	struct curl_slist *range_header = NULL;
 	struct active_request_slot *slot;
 
-	snprintf(prevfile, sizeof(prevfile), "%s.prev", request->filename);
+	snprintf(prevfile, sizeof(prevfile), "%s.prev", obj_req->filename);
 	unlink(prevfile);
-	rename(request->tmpfile, prevfile);
-	unlink(request->tmpfile);
+	rename(obj_req->tmpfile, prevfile);
+	unlink(obj_req->tmpfile);
 
-	if (request->local != -1)
-		error("fd leakage in start: %d", request->local);
-	request->local = open(request->tmpfile,
+	if (obj_req->local != -1)
+		error("fd leakage in start: %d", obj_req->local);
+	obj_req->local = open(obj_req->tmpfile,
 			      O_WRONLY | O_CREAT | O_EXCL, 0666);
 	/* This could have failed due to the "lazy directory creation";
 	 * try to mkdir the last path component.
 	 */
-	if (request->local < 0 && errno == ENOENT) {
-		char *dir = strrchr(request->tmpfile, '/');
+	if (obj_req->local < 0 && errno == ENOENT) {
+		char *dir = strrchr(obj_req->tmpfile, '/');
 		if (dir) {
 			*dir = 0;
-			mkdir(request->tmpfile, 0777);
+			mkdir(obj_req->tmpfile, 0777);
 			*dir = '/';
 		}
-		request->local = open(request->tmpfile,
+		obj_req->local = open(obj_req->tmpfile,
 				      O_WRONLY | O_CREAT | O_EXCL, 0666);
 	}
 
-	if (request->local < 0) {
-		request->state = ABORTED;
+	if (obj_req->local < 0) {
+		obj_req->state = ABORTED;
 		error("Couldn't create temporary file %s for %s: %s\n",
-		      request->tmpfile, request->filename, strerror(errno));
+		      obj_req->tmpfile, obj_req->filename, strerror(errno));
 		return;
 	}
 
-	memset(&request->stream, 0, sizeof(request->stream));
+	memset(&obj_req->stream, 0, sizeof(obj_req->stream));
 
-	inflateInit(&request->stream);
+	inflateInit(&obj_req->stream);
 
-	SHA1_Init(&request->c);
+	SHA1_Init(&obj_req->c);
 
-	url = xmalloc(strlen(request->repo->base) + 50);
-	request->url = xmalloc(strlen(request->repo->base) + 50);
-	strcpy(url, request->repo->base);
-	posn = url + strlen(request->repo->base);
+	url = xmalloc(strlen(obj_req->repo->base) + 50);
+	obj_req->url = xmalloc(strlen(obj_req->repo->base) + 50);
+	strcpy(url, obj_req->repo->base);
+	posn = url + strlen(obj_req->repo->base);
 	strcpy(posn, "objects/");
 	posn += 8;
 	memcpy(posn, hex, 2);
 	posn += 2;
 	*(posn++) = '/';
 	strcpy(posn, hex + 2);
-	strcpy(request->url, url);
+	strcpy(obj_req->url, url);
 
 	/* If a previous temp file is present, process what was already
 	   fetched. */
@@ -163,7 +163,7 @@ static void start_request(struct transfe
 				if (fwrite_sha1_file(prev_buf,
 						     1,
 						     prev_read,
-						     request) == prev_read) {
+						     obj_req) == prev_read) {
 					prev_posn += prev_read;
 				} else {
 					prev_read = -1;
@@ -177,24 +177,24 @@ static void start_request(struct transfe
 	/* Reset inflate/SHA1 if there was an error reading the previous temp
 	   file; also rewind to the beginning of the local file. */
 	if (prev_read == -1) {
-		memset(&request->stream, 0, sizeof(request->stream));
-		inflateInit(&request->stream);
-		SHA1_Init(&request->c);
+		memset(&obj_req->stream, 0, sizeof(obj_req->stream));
+		inflateInit(&obj_req->stream);
+		SHA1_Init(&obj_req->c);
 		if (prev_posn>0) {
 			prev_posn = 0;
-			lseek(request->local, SEEK_SET, 0);
-			ftruncate(request->local, 0);
+			lseek(obj_req->local, SEEK_SET, 0);
+			ftruncate(obj_req->local, 0);
 		}
 	}
 
 	slot = get_active_slot();
 	slot->callback_func = process_object_response;
-	slot->callback_data = request;
-	request->slot = slot;
+	slot->callback_data = obj_req;
+	obj_req->slot = slot;
 
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, request);
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, obj_req);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
-	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
+	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, obj_req->errorstr);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
 
@@ -212,109 +212,111 @@ static void start_request(struct transfe
 	}
 
 	/* Try to get the request started, abort the request on error */
-	request->state = ACTIVE;
+	obj_req->state = ACTIVE;
 	if (!start_active_slot(slot)) {
-		request->state = ABORTED;
-		request->slot = NULL;
-		close(request->local); request->local = -1;
-		free(request->url);
+		obj_req->state = ABORTED;
+		obj_req->slot = NULL;
+		close(obj_req->local); obj_req->local = -1;
+		free(obj_req->url);
+		return;
 	}
+	
 }
 
-static void finish_request(struct transfer_request *request)
+static void finish_object_request(struct object_request *obj_req)
 {
 	struct stat st;
 
-	fchmod(request->local, 0444);
-	close(request->local); request->local = -1;
+	fchmod(obj_req->local, 0444);
+	close(obj_req->local); obj_req->local = -1;
 
-	if (request->http_code == 416) {
+	if (obj_req->http_code == 416) {
 		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
-	} else if (request->curl_result != CURLE_OK) {
-		if (stat(request->tmpfile, &st) == 0)
+	} else if (obj_req->curl_result != CURLE_OK) {
+		if (stat(obj_req->tmpfile, &st) == 0)
 			if (st.st_size == 0)
-				unlink(request->tmpfile);
+				unlink(obj_req->tmpfile);
 		return;
 	}
 
-	inflateEnd(&request->stream);
-	SHA1_Final(request->real_sha1, &request->c);
-	if (request->zret != Z_STREAM_END) {
-		unlink(request->tmpfile);
+	inflateEnd(&obj_req->stream);
+	SHA1_Final(obj_req->real_sha1, &obj_req->c);
+	if (obj_req->zret != Z_STREAM_END) {
+		unlink(obj_req->tmpfile);
 		return;
 	}
-	if (memcmp(request->sha1, request->real_sha1, 20)) {
-		unlink(request->tmpfile);
+	if (memcmp(obj_req->sha1, obj_req->real_sha1, 20)) {
+		unlink(obj_req->tmpfile);
 		return;
 	}
-	request->rename =
-		move_temp_to_file(request->tmpfile, request->filename);
+	obj_req->rename =
+		move_temp_to_file(obj_req->tmpfile, obj_req->filename);
 
-	if (request->rename == 0)
-		pull_say("got %s\n", sha1_to_hex(request->sha1));
+	if (obj_req->rename == 0)
+		pull_say("got %s\n", sha1_to_hex(obj_req->sha1));
 }
 
 static void process_object_response(void *callback_data)
 {
-	struct transfer_request *request =
-		(struct transfer_request *)callback_data;
+	struct object_request *obj_req =
+		(struct object_request *)callback_data;
 
-	request->curl_result = request->slot->curl_result;
-	request->http_code = request->slot->http_code;
-	request->slot = NULL;
-	request->state = COMPLETE;
+	obj_req->curl_result = obj_req->slot->curl_result;
+	obj_req->http_code = obj_req->slot->http_code;
+	obj_req->slot = NULL;
+	obj_req->state = COMPLETE;
 
 	/* Use alternates if necessary */
-	if (request->http_code == 404) {
+	if (obj_req->http_code == 404) {
 		fetch_alternates(alt->base);
-		if (request->repo->next != NULL) {
-			request->repo =
-				request->repo->next;
-			close(request->local);
-			request->local = -1;
-			start_request(request);
+		if (obj_req->repo->next != NULL) {
+			obj_req->repo =
+				obj_req->repo->next;
+			close(obj_req->local);
+			obj_req->local = -1;
+			start_object_request(obj_req);
 			return;
 		}
 	}
 
-	finish_request(request);
+	finish_object_request(obj_req);
 }
 
-static void release_request(struct transfer_request *request)
+static void release_object_request(struct object_request *obj_req)
 {
-	struct transfer_request *entry = request_queue_head;
+	struct object_request *entry = object_queue_head;
 
-	if (request->local != -1)
-		error("fd leakage in release: %d", request->local);
-	if (request == request_queue_head) {
-		request_queue_head = request->next;
+	if (obj_req->local != -1)
+		error("fd leakage in release: %d", obj_req->local);
+	if (obj_req == object_queue_head) {
+		object_queue_head = obj_req->next;
 	} else {
-		while (entry->next != NULL && entry->next != request)
+		while (entry->next != NULL && entry->next != obj_req)
 			entry = entry->next;
-		if (entry->next == request)
+		if (entry->next == obj_req)
 			entry->next = entry->next->next;
 	}
 
-	free(request->url);
-	free(request);
+	free(obj_req->url);
+	free(obj_req);
 }
 
 #ifdef USE_CURL_MULTI
 void fill_active_slots(void)
 {
-	struct transfer_request *request = request_queue_head;
+	struct object_request *obj_req = object_queue_head;
 	struct active_request_slot *slot = active_queue_head;
 	int num_transfers;
 
-	while (active_requests < max_requests && request != NULL) {
-		if (request->state == WAITING) {
-			if (has_sha1_file(request->sha1))
-				release_request(request);
+	while (active_requests < max_requests && obj_req != NULL) {
+		if (obj_req->state == WAITING) {
+			if (has_sha1_file(obj_req->sha1))
+				release_object_request(obj_req);
 			else
-				start_request(request);
+				start_object_request(obj_req);
 			curl_multi_perform(curlm, &num_transfers);
 		}
-		request = request->next;
+		obj_req = obj_req->next;
 	}
 
 	while (slot != NULL) {
@@ -329,8 +331,8 @@ void fill_active_slots(void)
 
 void prefetch(unsigned char *sha1)
 {
-	struct transfer_request *newreq;
-	struct transfer_request *tail;
+	struct object_request *newreq;
+	struct object_request *tail;
 	char *filename = sha1_file_name(sha1);
 
 	newreq = xmalloc(sizeof(*newreq));
@@ -344,10 +346,10 @@ void prefetch(unsigned char *sha1)
 		 "%s.temp", filename);
 	newreq->next = NULL;
 
-	if (request_queue_head == NULL) {
-		request_queue_head = newreq;
+	if (object_queue_head == NULL) {
+		object_queue_head = newreq;
 	} else {
-		tail = request_queue_head;
+		tail = object_queue_head;
 		while (tail->next != NULL) {
 			tail = tail->next;
 		}
@@ -441,9 +443,10 @@ static int setup_index(struct alt_base *
 	return 0;
 }
 
-static void process_alternates(void *callback_data)
+static void process_alternates_response(void *callback_data)
 {
-	struct alt_request *alt_req = (struct alt_request *)callback_data;
+	struct alternates_request *alt_req =
+		(struct alternates_request *)callback_data;
 	struct active_request_slot *slot = alt_req->slot;
 	struct alt_base *tail = alt;
 	char *base = alt_req->base;
@@ -548,7 +551,7 @@ static void fetch_alternates(char *base)
 	char *url;
 	char *data;
 	struct active_request_slot *slot;
-	static struct alt_request alt_req;
+	static struct alternates_request alt_req;
 
 	/* If another request has already started fetching alternates,
 	   wait for them to arrive and return to processing this request's
@@ -580,7 +583,7 @@ static void fetch_alternates(char *base)
 	/* Use a callback to process the result, since another request
 	   may fail and need to have alternates loaded before continuing */
 	slot = get_active_slot();
-	slot->callback_func = process_alternates;
+	slot->callback_func = process_alternates_response;
 	slot->callback_data = &alt_req;
 
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
@@ -760,54 +763,54 @@ static int fetch_object(struct alt_base 
 {
 	char *hex = sha1_to_hex(sha1);
 	int ret = 0;
-	struct transfer_request *request = request_queue_head;
+	struct object_request *obj_req = object_queue_head;
 
-	while (request != NULL && memcmp(request->sha1, sha1, 20))
-		request = request->next;
-	if (request == NULL)
+	while (obj_req != NULL && memcmp(obj_req->sha1, sha1, 20))
+		obj_req = obj_req->next;
+	if (obj_req == NULL)
 		return error("Couldn't find request for %s in the queue", hex);
 
-	if (has_sha1_file(request->sha1)) {
-		release_request(request);
+	if (has_sha1_file(obj_req->sha1)) {
+		release_object_request(obj_req);
 		return 0;
 	}
 
 #ifdef USE_CURL_MULTI
-	while (request->state == WAITING) {
+	while (obj_req->state == WAITING) {
 		step_active_slots();
 	}
 #else
-	start_request(request);
+	start_object_request(obj_req);
 #endif
 
-	while (request->state == ACTIVE) {
-		run_active_slot(request->slot);
+	while (obj_req->state == ACTIVE) {
+		run_active_slot(obj_req->slot);
 	}
-	if (request->local != -1) {
-		close(request->local); request->local = -1;
+	if (obj_req->local != -1) {
+		close(obj_req->local); obj_req->local = -1;
 	}
 
-	if (request->state == ABORTED) {
+	if (obj_req->state == ABORTED) {
 		ret = error("Request for %s aborted", hex);
-	} else if (request->curl_result != CURLE_OK &&
-		   request->http_code != 416) {
-		if (request->http_code == 404)
+	} else if (obj_req->curl_result != CURLE_OK &&
+		   obj_req->http_code != 416) {
+		if (obj_req->http_code == 404)
 			ret = -1; /* Be silent, it is probably in a pack. */
 		else
 			ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
-				    request->errorstr, request->curl_result,
-				    request->http_code, hex);
-	} else if (request->zret != Z_STREAM_END) {
-		ret = error("File %s (%s) corrupt\n", hex, request->url);
-	} else if (memcmp(request->sha1, request->real_sha1, 20)) {
+				    obj_req->errorstr, obj_req->curl_result,
+				    obj_req->http_code, hex);
+	} else if (obj_req->zret != Z_STREAM_END) {
+		ret = error("File %s (%s) corrupt\n", hex, obj_req->url);
+	} else if (memcmp(obj_req->sha1, obj_req->real_sha1, 20)) {
 		ret = error("File %s has bad hash\n", hex);
-	} else if (request->rename < 0) {
+	} else if (obj_req->rename < 0) {
 		ret = error("unable to write sha1 filename %s: %s",
-			    request->filename,
-			    strerror(request->rename));
+			    obj_req->filename,
+			    strerror(obj_req->rename));
 	}
 
-	release_request(request);
+	release_object_request(obj_req);
 	return ret;
 }
 
---
0.99.9.GIT
