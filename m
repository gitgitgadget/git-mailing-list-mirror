From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Add support for parallel HTTP transfers
Date: Thu, 6 Oct 2005 11:54:12 -0700
Message-ID: <20051006185412.GG15593@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 06 20:57:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENaso-0000WB-6B
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 20:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVJFSyS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 14:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVJFSyS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 14:54:18 -0400
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:8946 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751306AbVJFSyR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 14:54:17 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j96IsCpJ032448
	for <git@vger.kernel.org>; Thu, 6 Oct 2005 11:54:12 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j96IsC2t032446
	for git@vger.kernel.org; Thu, 6 Oct 2005 11:54:12 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9778>

Add support for parallel HTTP transfers.  Prefetch populates a queue of
objects to transfer and starts feeding requests to an active request
queue for processing; fetch_object keeps the active queue moving
while the specified object is being transferred.  The size of the active
queue can be restricted using -r and defaults to 5 concurrent transfers.
Requests for objects that are not prefetched are also processed via the
active queue.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

This patch replaces the previous version.  It seems that the instability
I experienced with empty server responses was related to request timeouts
because the active queue wasn't being processed during a non-object fetch.


 http-fetch.c |  810 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 587 insertions(+), 223 deletions(-)

8dcb9f1bdfa5d4229ef031f8d01cc8cde0d54bbc
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -6,6 +6,8 @@
 #include <curl/curl.h>
 #include <curl/easy.h>
 
+#define DEFAULT_MAX_REQUESTS 5
+
 #if LIBCURL_VERSION_NUM < 0x070704
 #define curl_global_cleanup() do { /* nothing */ } while(0)
 #endif
@@ -16,13 +18,16 @@
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
 
-static CURL *curl;
+static int max_requests = DEFAULT_MAX_REQUESTS;
+static int active_requests = 0;
+static int data_received;
+
+static CURLM *curlm;
+static CURL *curl_default;
 static struct curl_slist *no_pragma_header;
 static struct curl_slist *no_range_header;
 static char curl_errorstr[CURL_ERROR_SIZE];
 
-static char *initial_base;
-
 struct alt_base
 {
 	char *base;
@@ -33,11 +38,46 @@ struct alt_base
 
 static struct alt_base *alt = NULL;
 
-static SHA_CTX c;
-static z_stream stream;
+enum transfer_state {
+	WAITING,
+	ABORTED,
+	ACTIVE,
+	COMPLETE,
+};
+
+struct transfer_request
+{
+	unsigned char sha1[20];
+	struct alt_base *repo;
+	char *url;
+	char filename[PATH_MAX];
+	char tmpfile[PATH_MAX];
+	int local;
+	enum transfer_state state;
+	CURLcode curl_result;
+	char errorstr[CURL_ERROR_SIZE];
+	long http_code;
+	unsigned char real_sha1[20];
+	SHA_CTX c;
+	z_stream stream;
+	int zret;
+	int rename;
+	struct active_request_slot *slot;
+	struct transfer_request *next;
+};
+
+struct active_request_slot
+{
+	CURL *curl;
+	FILE *local;
+	int in_use;
+	int done;
+	CURLcode curl_result;
+	struct active_request_slot *next;
+};
 
-static int local;
-static int zret;
+static struct transfer_request *request_queue_head = NULL;
+static struct active_request_slot *active_queue_head = NULL;
 
 static int curl_ssl_verify;
 static char *ssl_cert;
@@ -60,6 +100,7 @@ static size_t fwrite_buffer(void *ptr, s
                 size = buffer->size - buffer->posn;
         memcpy(buffer->buffer + buffer->posn, ptr, size);
         buffer->posn += size;
+	data_received++;
         return size;
 }
 
@@ -69,28 +110,28 @@ static size_t fwrite_sha1_file(void *ptr
 	unsigned char expn[4096];
 	size_t size = eltsize * nmemb;
 	int posn = 0;
+	struct transfer_request *request = (struct transfer_request *)data;
 	do {
-		ssize_t retval = write(local, ptr + posn, size - posn);
+		ssize_t retval = write(request->local,
+				       ptr + posn, size - posn);
 		if (retval < 0)
 			return posn;
 		posn += retval;
 	} while (posn < size);
 
-	stream.avail_in = size;
-	stream.next_in = ptr;
+	request->stream.avail_in = size;
+	request->stream.next_in = ptr;
 	do {
-		stream.next_out = expn;
-		stream.avail_out = sizeof(expn);
-		zret = inflate(&stream, Z_SYNC_FLUSH);
-		SHA1_Update(&c, expn, sizeof(expn) - stream.avail_out);
-	} while (stream.avail_in && zret == Z_OK);
+		request->stream.next_out = expn;
+		request->stream.avail_out = sizeof(expn);
+		request->zret = inflate(&request->stream, Z_SYNC_FLUSH);
+		SHA1_Update(&request->c, expn,
+			    sizeof(expn) - request->stream.avail_out);
+	} while (request->stream.avail_in && request->zret == Z_OK);
+	data_received++;
 	return size;
 }
 
-void prefetch(unsigned char *sha1)
-{
-}
-
 int relink_or_rename(char *old, char *new) {
 	int ret;
 
@@ -110,10 +151,369 @@ int relink_or_rename(char *old, char *ne
 	return 0;
 }
 
+void process_curl_messages();
+void process_request_queue();
+
+struct active_request_slot *get_active_slot()
+{
+	struct active_request_slot *slot = active_queue_head;
+	struct active_request_slot *newslot;
+	int num_transfers;
+
+	/* Wait for a slot to open up if the queue is full */
+	while (active_requests >= max_requests) {
+		curl_multi_perform(curlm, &num_transfers);
+		if (num_transfers < active_requests) {
+			process_curl_messages();
+		}
+	}
+
+	while (slot != NULL && slot->in_use) {
+		slot = slot->next;
+	}
+	if (slot == NULL) {
+		newslot = xmalloc(sizeof(*newslot));
+		newslot->curl = curl_easy_duphandle(curl_default);
+		newslot->in_use = 0;
+		newslot->next = NULL;
+
+		slot = active_queue_head;
+		if (slot == NULL) {
+			active_queue_head = newslot;
+		} else {
+			while (slot->next != NULL) {
+				slot = slot->next;
+			}
+			slot->next = newslot;
+		}
+		slot = newslot;
+	}
+
+	active_requests++;
+	slot->in_use = 1;
+	slot->done = 0;
+	slot->local = NULL;
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_range_header);
+	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
+
+	return slot;
+}
+
+int start_active_slot(struct active_request_slot *slot)
+{
+	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
+
+	if (curlm_result != CURLM_OK &&
+	    curlm_result != CURLM_CALL_MULTI_PERFORM) {
+		active_requests--;
+		slot->in_use = 0;
+		return 0;
+	}
+
+	return 1;
+}
+
+void run_active_slot(struct active_request_slot *slot)
+{
+	int num_transfers;
+	long last_pos = 0;
+	long current_pos;
+	fd_set readfds;
+	fd_set writefds;
+	fd_set excfds;
+	int max_fd;
+	struct timeval select_timeout;
+	CURLMcode curlm_result;
+
+	while (!slot->done) {
+		data_received = 0;
+		do {
+			curlm_result = curl_multi_perform(curlm,
+							  &num_transfers);
+		} while (curlm_result == CURLM_CALL_MULTI_PERFORM);
+		if (num_transfers < active_requests) {
+			process_curl_messages();
+			process_request_queue();
+		}
+
+		if (!data_received && slot->local != NULL) {
+			current_pos = ftell(slot->local);
+			if (current_pos > last_pos)
+				data_received++;
+			last_pos = current_pos;
+		}
+
+		if (!slot->done && !data_received) {
+			max_fd = 0;
+			FD_ZERO(&readfds);
+			FD_ZERO(&writefds);
+			FD_ZERO(&excfds);
+			select_timeout.tv_sec = 0;
+			select_timeout.tv_usec = 50000;
+			select(max_fd, &readfds, &writefds,
+			       &excfds, &select_timeout);
+		}
+	}
+}
+
+void start_request(struct transfer_request *request)
+{
+	char *hex = sha1_to_hex(request->sha1);
+	char prevfile[PATH_MAX];
+	char *url;
+	char *posn;
+	int prevlocal;
+	unsigned char prev_buf[PREV_BUF_SIZE];
+	ssize_t prev_read = 0;
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct curl_slist *range_header = NULL;
+	struct active_request_slot *slot;
+
+	snprintf(prevfile, sizeof(prevfile), "%s.prev", request->filename);
+	unlink(prevfile);
+	rename(request->tmpfile, prevfile);
+	unlink(request->tmpfile);
+
+	request->local = open(request->tmpfile,
+			      O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (request->local < 0) {
+		request->state = ABORTED;
+		error("Couldn't create temporary file %s for %s: %s\n",
+		      request->tmpfile, request->filename, strerror(errno));
+		return;
+	}
+
+	memset(&request->stream, 0, sizeof(request->stream));
+
+	inflateInit(&request->stream);
+
+	SHA1_Init(&request->c);
+
+	url = xmalloc(strlen(request->repo->base) + 50);
+	request->url = xmalloc(strlen(request->repo->base) + 50);
+	strcpy(url, request->repo->base);
+	posn = url + strlen(request->repo->base);
+	strcpy(posn, "objects/");
+	posn += 8;
+	memcpy(posn, hex, 2);
+	posn += 2;
+	*(posn++) = '/';
+	strcpy(posn, hex + 2);
+	strcpy(request->url, url);
+
+	/* If a previous temp file is present, process what was already
+	   fetched. */
+	prevlocal = open(prevfile, O_RDONLY);
+	if (prevlocal != -1) {
+		do {
+			prev_read = read(prevlocal, prev_buf, PREV_BUF_SIZE);
+			if (prev_read>0) {
+				if (fwrite_sha1_file(prev_buf,
+						     1,
+						     prev_read,
+						     request) == prev_read) {
+					prev_posn += prev_read;
+				} else {
+					prev_read = -1;
+				}
+			}
+		} while (prev_read > 0);
+		close(prevlocal);
+	}
+	unlink(prevfile);
+
+	/* Reset inflate/SHA1 if there was an error reading the previous temp
+	   file; also rewind to the beginning of the local file. */
+	if (prev_read == -1) {
+		memset(&request->stream, 0, sizeof(request->stream));
+		inflateInit(&request->stream);
+		SHA1_Init(&request->c);
+		if (prev_posn>0) {
+			prev_posn = 0;
+			lseek(request->local, SEEK_SET, 0);
+			ftruncate(request->local, 0);
+		}
+	}
+
+	slot = get_active_slot();
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, request);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
+	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+
+	/* If we have successfully processed data from a previous fetch
+	   attempt, only fetch the data we don't already have. */
+	if (prev_posn>0) {
+		if (get_verbosely)
+			fprintf(stderr,
+				"Resuming fetch of object %s at byte %ld\n",
+				hex, prev_posn);
+		sprintf(range, "Range: bytes=%ld-", prev_posn);
+		range_header = curl_slist_append(range_header, range);
+		curl_easy_setopt(slot->curl,
+				 CURLOPT_HTTPHEADER, range_header);
+	}
+
+	/* Try to add to multi handle, abort the request on error */
+	if (!start_active_slot(slot)) {
+		request->state = ABORTED;
+		close(request->local);
+		free(request->url);
+		return;
+	}
+	
+	request->slot = slot;
+	request->state = ACTIVE;
+}
+
+void finish_request(struct transfer_request *request)
+{
+	fchmod(request->local, 0444);
+	close(request->local);
+
+	if (request->http_code == 416) {
+		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
+	} else if (request->curl_result != CURLE_OK) {
+		return;
+	}
+
+	inflateEnd(&request->stream);
+	SHA1_Final(request->real_sha1, &request->c);
+	if (request->zret != Z_STREAM_END) {
+		unlink(request->tmpfile);
+		return;
+	}
+	if (memcmp(request->sha1, request->real_sha1, 20)) {
+		unlink(request->tmpfile);
+		return;
+	}
+	request->rename =
+		relink_or_rename(request->tmpfile, request->filename);
+
+	if (request->rename == 0)
+		pull_say("got %s\n", sha1_to_hex(request->sha1));
+}
+
+void release_request(struct transfer_request *request)
+{
+	struct transfer_request *entry = request_queue_head;
+
+	if (request == request_queue_head) {
+		request_queue_head = request->next;
+	} else {
+		while (entry->next != NULL && entry->next != request)
+			entry = entry->next;
+		if (entry->next == request)
+			entry->next = entry->next->next;
+	}
+
+	free(request->url);
+	free(request);
+}
+
+void process_curl_messages()
+{
+	int num_messages;
+	struct active_request_slot *slot;
+	struct transfer_request *request = NULL;
+	CURLMsg *curl_message = curl_multi_info_read(curlm, &num_messages);
+
+	while (curl_message != NULL) {
+		if (curl_message->msg == CURLMSG_DONE) {
+			slot = active_queue_head;
+			while (slot != NULL &&
+			       slot->curl != curl_message->easy_handle)
+				slot = slot->next;
+			if (slot != NULL) {
+				curl_multi_remove_handle(curlm, slot->curl);
+				active_requests--;
+				slot->done = 1;
+				slot->in_use = 0;
+				slot->curl_result = curl_message->data.result;
+				request = request_queue_head;
+				while (request != NULL &&
+				       request->slot != slot)
+					request = request->next;
+			} else {
+				fprintf(stderr, "Received DONE message for unknown request!\n");
+			}
+			if (request != NULL) {
+				request->curl_result =
+					curl_message->data.result;
+				curl_easy_getinfo(slot->curl,
+						  CURLINFO_HTTP_CODE,
+						  &request->http_code);
+				request->slot = NULL;
+
+				/* Use alternates if necessary */
+				if (request->http_code == 404 &&
+				    request->repo->next != NULL) {
+					request->repo = request->repo->next;
+					start_request(request);
+				} else {
+					finish_request(request);
+					request->state = COMPLETE;
+				}
+			}
+		} else {
+			fprintf(stderr, "Unknown CURL message received: %d\n",
+				(int)curl_message->msg);
+		}
+		curl_message = curl_multi_info_read(curlm, &num_messages);
+	}
+}
+
+void process_request_queue()
+{
+	struct transfer_request *request = request_queue_head;
+	int num_transfers;
+
+	while (active_requests < max_requests && request != NULL) {
+		if (request->state == WAITING) {
+			start_request(request);
+			curl_multi_perform(curlm, &num_transfers);
+		}
+		request = request->next;
+	}
+}
+
+void prefetch(unsigned char *sha1)
+{
+	struct transfer_request *newreq;
+	struct transfer_request *tail;
+	char *filename = sha1_file_name(sha1);
+
+	newreq = xmalloc(sizeof(*newreq));
+	memcpy(newreq->sha1, sha1, 20);
+	newreq->repo = alt;
+	newreq->url = NULL;
+	newreq->local = -1;
+	newreq->state = WAITING;
+	snprintf(newreq->filename, sizeof(newreq->filename), "%s", filename);
+	snprintf(newreq->tmpfile, sizeof(newreq->tmpfile),
+		 "%s.temp", filename);
+	newreq->next = NULL;
+
+	if (request_queue_head == NULL) {
+		request_queue_head = newreq;
+	} else {
+		tail = request_queue_head;
+		while (tail->next != NULL) {
+			tail = tail->next;
+		}
+		tail->next = newreq;
+	}
+	process_request_queue();
+	process_curl_messages();
+}
+
 static int got_alternates = 0;
 
 static int fetch_index(struct alt_base *repo, unsigned char *sha1)
 {
+	char *hex = sha1_to_hex(sha1);
 	char *filename;
 	char *url;
 	char tmpfile[PATH_MAX];
@@ -121,20 +521,18 @@ static int fetch_index(struct alt_base *
 	long prev_posn = 0;
 	char range[RANGE_HEADER_SIZE];
 	struct curl_slist *range_header = NULL;
-	CURLcode curl_result;
 
 	FILE *indexfile;
+	struct active_request_slot *slot;
 
 	if (has_pack_index(sha1))
 		return 0;
 
 	if (get_verbosely)
-		fprintf(stderr, "Getting index for pack %s\n",
-			sha1_to_hex(sha1));
+		fprintf(stderr, "Getting index for pack %s\n", hex);
 	
 	url = xmalloc(strlen(repo->base) + 64);
-	sprintf(url, "%s/objects/pack/pack-%s.idx",
-		repo->base, sha1_to_hex(sha1));
+	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
 	
 	filename = sha1_pack_index_name(sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
@@ -143,12 +541,12 @@ static int fetch_index(struct alt_base *
 		return error("Unable to open local file %s for pack index",
 			     filename);
 
-	curl_easy_setopt(curl, CURLOPT_FILE, indexfile);
-	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
-	curl_easy_setopt(curl, CURLOPT_URL, url);
-	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
-	curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, curl_errorstr);
-	
+	slot = get_active_slot();
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	slot->local = indexfile;
+
 	/* If there is data present from a previous transfer attempt,
 	   resume where it left off */
 	prev_posn = ftell(indexfile);
@@ -156,20 +554,21 @@ static int fetch_index(struct alt_base *
 		if (get_verbosely)
 			fprintf(stderr,
 				"Resuming fetch of index for pack %s at byte %ld\n",
-				sha1_to_hex(sha1), prev_posn);
+				hex, prev_posn);
 		sprintf(range, "Range: bytes=%ld-", prev_posn);
 		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(curl, CURLOPT_HTTPHEADER, range_header);
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
 	}
 
-	/* Clear out the Range: header after performing the request, so
-	   other curl requests don't inherit inappropriate header data */
-	curl_result = curl_easy_perform(curl);
-	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_range_header);
-	if (curl_result != 0) {
-		fclose(indexfile);
-		return error("Unable to get pack index %s\n%s", url,
-			     curl_errorstr);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (slot->curl_result != CURLE_OK) {
+			fclose(indexfile);
+			return error("Unable to get pack index %s\n%s", url,
+				     curl_errorstr);
+		}
+	} else {
+		return error("Unable to start request");
 	}
 
 	fclose(indexfile);
@@ -205,6 +604,9 @@ static int fetch_alternates(char *base)
 	char *data;
 	int i = 0;
 	int http_specific = 1;
+	struct alt_base *tail = alt;
+
+	struct active_request_slot *slot;
 	if (got_alternates)
 		return 0;
 	data = xmalloc(4096);
@@ -218,22 +620,31 @@ static int fetch_alternates(char *base)
 	url = xmalloc(strlen(base) + 31);
 	sprintf(url, "%s/objects/info/http-alternates", base);
 
-	curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(curl, CURLOPT_URL, url);
-
-	if (curl_easy_perform(curl) || !buffer.posn) {
-		http_specific = 0;
-
-		sprintf(url, "%s/objects/info/alternates", base);
-		
-		curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
-		curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-		curl_easy_setopt(curl, CURLOPT_URL, url);
-		
-		if (curl_easy_perform(curl)) {
-			return 0;
+	slot = get_active_slot();
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (slot->curl_result != CURLE_OK || !buffer.posn) {
+			http_specific = 0;
+
+			sprintf(url, "%s/objects/info/alternates", base);
+
+			slot = get_active_slot();
+			curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
+					 fwrite_buffer);
+			curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+			if (start_active_slot(slot)) {
+				run_active_slot(slot);
+				if (slot->curl_result != CURLE_OK) {
+					return 0;
+				}
+			}
 		}
+	} else {
+		return 0;
 	}
 
 	data[buffer.posn] = '\0';
@@ -283,11 +694,13 @@ static int fetch_alternates(char *base)
 					fprintf(stderr, 
 						"Also look at %s\n", target);
 				newalt = xmalloc(sizeof(*newalt));
-				newalt->next = alt;
+				newalt->next = NULL;
 				newalt->base = target;
 				newalt->got_indices = 0;
 				newalt->packs = NULL;
-				alt = newalt;
+				while (tail->next != NULL)
+					tail = tail->next;
+				tail->next = newalt;
 				ret++;
 			}
 		}
@@ -306,6 +719,8 @@ static int fetch_indices(struct alt_base
 	char *data;
 	int i = 0;
 
+	struct active_request_slot *slot;
+
 	if (repo->got_indices)
 		return 0;
 
@@ -320,14 +735,18 @@ static int fetch_indices(struct alt_base
 	url = xmalloc(strlen(repo->base) + 21);
 	sprintf(url, "%s/objects/info/packs", repo->base);
 
-	curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(curl, CURLOPT_URL, url);
-	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, NULL);
-	curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, curl_errorstr);
-	
-	if (curl_easy_perform(curl))
-		return error("%s", curl_errorstr);
+	slot = get_active_slot();
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (slot->curl_result != CURLE_OK)
+			return error("%s", curl_errorstr);
+	} else {
+		return error("Unable to start request");
+	}
 
 	while (i < buffer.posn) {
 		switch (data[i]) {
@@ -364,7 +783,8 @@ static int fetch_pack(struct alt_base *r
 	long prev_posn = 0;
 	char range[RANGE_HEADER_SIZE];
 	struct curl_slist *range_header = NULL;
-	CURLcode curl_result;
+
+	struct active_request_slot *slot;
 
 	if (fetch_indices(repo))
 		return -1;
@@ -390,11 +810,11 @@ static int fetch_pack(struct alt_base *r
 		return error("Unable to open local file %s for pack",
 			     filename);
 
-	curl_easy_setopt(curl, CURLOPT_FILE, packfile);
-	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
-	curl_easy_setopt(curl, CURLOPT_URL, url);
-	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
-	curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, curl_errorstr);
+	slot = get_active_slot();
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, packfile);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	slot->local = packfile;
 
 	/* If there is data present from a previous transfer attempt,
 	   resume where it left off */
@@ -406,17 +826,18 @@ static int fetch_pack(struct alt_base *r
 				sha1_to_hex(target->sha1), prev_posn);
 		sprintf(range, "Range: bytes=%ld-", prev_posn);
 		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(curl, CURLOPT_HTTPHEADER, range_header);
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
 	}
 
-	/* Clear out the Range: header after performing the request, so
-	   other curl requests don't inherit inappropriate header data */
-	curl_result = curl_easy_perform(curl);
-	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_range_header);
-	if (curl_result != 0) {
-		fclose(packfile);
-		return error("Unable to get pack file %s\n%s", url,
-			     curl_errorstr);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (slot->curl_result != CURLE_OK) {
+			fclose(packfile);
+			return error("Unable to get pack file %s\n%s", url,
+				     curl_errorstr);
+		}
+	} else {
+		return error("Unable to start request");
 	}
 
 	fclose(packfile);
@@ -441,155 +862,73 @@ static int fetch_pack(struct alt_base *r
 static int fetch_object(struct alt_base *repo, unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
-	char *filename = sha1_file_name(sha1);
-	unsigned char real_sha1[20];
-	char tmpfile[PATH_MAX];
-	char prevfile[PATH_MAX];
 	int ret;
-	char *url;
-	char *posn;
-	int prevlocal;
-	unsigned char prev_buf[PREV_BUF_SIZE];
-	ssize_t prev_read = 0;
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
-	CURLcode curl_result;
-
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	snprintf(prevfile, sizeof(prevfile), "%s.prev", filename);
-
-	if (unlink(prevfile) && (errno != ENOENT))
-		return error("Failed to unlink %s (%s)",
-			     prevfile, strerror(errno));
-	if (rename(tmpfile, prevfile) && (errno != ENOENT))
-		return error("Failed to rename %s to %s (%s)",
-			     tmpfile, prevfile, strerror(errno));
-
-	local = open(tmpfile, O_WRONLY | O_CREAT | O_EXCL, 0666);
-
-	/* Note: if another instance starts now, it will turn our new
-	   tmpfile into its prevfile. */
-
-	if (local < 0)
-		return error("Couldn't create temporary file %s for %s: %s\n",
-			     tmpfile, filename, strerror(errno));
+	struct transfer_request *request = request_queue_head;
+	int num_transfers;
 
-	memset(&stream, 0, sizeof(stream));
-
-	inflateInit(&stream);
-
-	SHA1_Init(&c);
-
-	curl_easy_setopt(curl, CURLOPT_FAILONERROR, 1);
-	curl_easy_setopt(curl, CURLOPT_FILE, NULL);
-	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
-	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
-	curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, curl_errorstr);
-
-	url = xmalloc(strlen(repo->base) + 50);
-	strcpy(url, repo->base);
-	posn = url + strlen(repo->base);
-	strcpy(posn, "objects/");
-	posn += 8;
-	memcpy(posn, hex, 2);
-	posn += 2;
-	*(posn++) = '/';
-	strcpy(posn, hex + 2);
+	while (request != NULL && memcmp(request->sha1, sha1, 20))
+		request = request->next;
+	if (request == NULL)
+		return error("Couldn't find request for %s in the queue", hex);
+
+	while (request->state == WAITING) {
+		curl_multi_perform(curlm, &num_transfers);
+		if (num_transfers < active_requests) {
+			process_curl_messages();
+			process_request_queue();
+		}
+	}
 
-	curl_easy_setopt(curl, CURLOPT_URL, url);
+	if (request->state == ACTIVE)
+		run_active_slot(request->slot);
 
-	/* If a previous temp file is present, process what was already
-	   fetched. */
-	prevlocal = open(prevfile, O_RDONLY);
-	if (prevlocal != -1) {
-		do {
-			prev_read = read(prevlocal, prev_buf, PREV_BUF_SIZE);
-			if (prev_read>0) {
-				if (fwrite_sha1_file(prev_buf,
-						     1,
-						     prev_read,
-						     NULL) == prev_read) {
-					prev_posn += prev_read;
-				} else {
-					prev_read = -1;
-				}
-			}
-		} while (prev_read > 0);
-		close(prevlocal);
+	if (request->state == ABORTED) {
+		release_request(request);
+		return error("Request for %s aborted", hex);
 	}
-	unlink(prevfile);
 
-	/* Reset inflate/SHA1 if there was an error reading the previous temp
-	   file; also rewind to the beginning of the local file. */
-	if (prev_read == -1) {
-		memset(&stream, 0, sizeof(stream));
-		inflateInit(&stream);
-		SHA1_Init(&c);
-		if (prev_posn>0) {
-			prev_posn = 0;
-			lseek(local, SEEK_SET, 0);
-			ftruncate(local, 0);
-		}
+	if (request->curl_result != CURLE_OK && request->http_code != 416) {
+		ret = error("%s", request->errorstr);
+		release_request(request);
+		return ret;
 	}
 
-	/* If we have successfully processed data from a previous fetch
-	   attempt, only fetch the data we don't already have. */
-	if (prev_posn>0) {
-		if (get_verbosely)
-			fprintf(stderr,
-				"Resuming fetch of object %s at byte %ld\n",
-				hex, prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(curl, CURLOPT_HTTPHEADER, range_header);
+	if (request->zret != Z_STREAM_END) {
+		ret = error("File %s (%s) corrupt\n", hex, request->url);
+		release_request(request);
+		return ret;
 	}
 
-	/* Clear out the Range: header after performing the request, so
-	   other curl requests don't inherit inappropriate header data */
-	curl_result = curl_easy_perform(curl);
-	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_range_header);
-	if (curl_result != 0) {
-		return error("%s", curl_errorstr);
-	}
-
-	fchmod(local, 0444);
-	close(local);
-	inflateEnd(&stream);
-	SHA1_Final(real_sha1, &c);
-	if (zret != Z_STREAM_END) {
-		unlink(tmpfile);
-		return error("File %s (%s) corrupt\n", hex, url);
-	}
-	if (memcmp(sha1, real_sha1, 20)) {
-		unlink(tmpfile);
+	if (memcmp(request->sha1, request->real_sha1, 20)) {
+		release_request(request);
 		return error("File %s has bad hash\n", hex);
 	}
-	ret = relink_or_rename(tmpfile, filename);
-	if (ret)
-		return error("unable to write sha1 filename %s: %s",
-			     filename, strerror(ret));
 
-	pull_say("got %s\n", hex);
+	if (request->rename < 0) {
+		ret = error("unable to write sha1 filename %s: %s",
+			    request->filename,
+			    strerror(request->rename));
+		release_request(request);
+		return ret;
+	}
+
+	release_request(request);
 	return 0;
 }
 
 int fetch(unsigned char *sha1)
 {
 	struct alt_base *altbase = alt;
+
+	if (!fetch_object(altbase, sha1))
+		return 0;
 	while (altbase) {
-		if (!fetch_object(altbase, sha1))
-			return 0;
 		if (!fetch_pack(altbase, sha1))
 			return 0;
-		if (fetch_alternates(altbase->base) > 0) {
-			altbase = alt;
-			continue;
-		}
 		altbase = altbase->next;
 	}
 	return error("Unable to find %s under %s\n", sha1_to_hex(sha1), 
-		     initial_base);
+		     alt->base);
 }
 
 int fetch_ref(char *ref, unsigned char *sha1)
@@ -597,17 +936,13 @@ int fetch_ref(char *ref, unsigned char *
         char *url, *posn;
         char hex[42];
         struct buffer buffer;
-	char *base = initial_base;
+	char *base = alt->base;
+	struct active_request_slot *slot;
         buffer.size = 41;
         buffer.posn = 0;
         buffer.buffer = hex;
         hex[41] = '\0';
         
-        curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
-        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, NULL);
-	curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, curl_errorstr);
-
         url = xmalloc(strlen(base) + 6 + strlen(ref));
         strcpy(url, base);
         posn = url + strlen(base);
@@ -615,11 +950,19 @@ int fetch_ref(char *ref, unsigned char *
         posn += 5;
         strcpy(posn, ref);
 
-        curl_easy_setopt(curl, CURLOPT_URL, url);
-
-        if (curl_easy_perform(curl))
-                return error("Couldn't get %s for %s\n%s",
-			     url, ref, curl_errorstr);
+	slot = get_active_slot();
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (slot->curl_result != CURLE_OK)
+			return error("Couldn't get %s for %s\n%s",
+				     url, ref, curl_errorstr);
+	} else {
+		return error("Unable to start request");
+	}
 
         hex[40] = '\0';
         get_sha1_hex(hex, sha1);
@@ -631,6 +974,7 @@ int main(int argc, char **argv)
 	char *commit_id;
 	char *url;
 	int arg = 1;
+	struct active_request_slot *slot;
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
@@ -648,6 +992,11 @@ int main(int argc, char **argv)
 			arg++;
 		} else if (!strcmp(argv[arg], "--recover")) {
 			get_recover = 1;
+		} else if (argv[arg][1] == 'r') {
+			max_requests = atoi(argv[arg + 1]);
+			if (max_requests < 1)
+				max_requests = DEFAULT_MAX_REQUESTS;
+			arg++;
 		}
 		arg++;
 	}
@@ -660,44 +1009,59 @@ int main(int argc, char **argv)
 
 	curl_global_init(CURL_GLOBAL_ALL);
 
-	curl = curl_easy_init();
+	curlm = curl_multi_init();
+	if (curlm == NULL) {
+		fprintf(stderr, "Error creating curl multi handle.\n");
+		return 1;
+	}
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 	no_range_header = curl_slist_append(no_range_header, "Range:");
 
+	curl_default = curl_easy_init();
+
 	curl_ssl_verify = getenv("GIT_SSL_NO_VERIFY") ? 0 : 1;
-	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
+	curl_easy_setopt(curl_default, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
 #if LIBCURL_VERSION_NUM >= 0x070907
-	curl_easy_setopt(curl, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
+	curl_easy_setopt(curl_default, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
 
 	if ((ssl_cert = getenv("GIT_SSL_CERT")) != NULL) {
-		curl_easy_setopt(curl, CURLOPT_SSLCERT, ssl_cert);
+		curl_easy_setopt(curl_default, CURLOPT_SSLCERT, ssl_cert);
 	}
 #if LIBCURL_VERSION_NUM >= 0x070902
 	if ((ssl_key = getenv("GIT_SSL_KEY")) != NULL) {
-		curl_easy_setopt(curl, CURLOPT_SSLKEY, ssl_key);
+		curl_easy_setopt(curl_default, CURLOPT_SSLKEY, ssl_key);
 	}
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
 	if ((ssl_capath = getenv("GIT_SSL_CAPATH")) != NULL) {
-		curl_easy_setopt(curl, CURLOPT_CAPATH, ssl_capath);
+		curl_easy_setopt(curl_default, CURLOPT_CAPATH, ssl_capath);
 	}
 #endif
 	if ((ssl_cainfo = getenv("GIT_SSL_CAINFO")) != NULL) {
-		curl_easy_setopt(curl, CURLOPT_CAINFO, ssl_cainfo);
+		curl_easy_setopt(curl_default, CURLOPT_CAINFO, ssl_cainfo);
 	}
+	curl_easy_setopt(curl_default, CURLOPT_FAILONERROR, 1);
 
 	alt = xmalloc(sizeof(*alt));
 	alt->base = url;
 	alt->got_indices = 0;
 	alt->packs = NULL;
 	alt->next = NULL;
-	initial_base = url;
+	fetch_alternates(alt->base);
 
 	if (pull(commit_id))
 		return 1;
 
 	curl_slist_free_all(no_pragma_header);
+	curl_slist_free_all(no_range_header);
+	curl_easy_cleanup(curl_default);
+	slot = active_queue_head;
+	while (slot != NULL) {
+		curl_easy_cleanup(slot->curl);
+		slot = slot->next;
+	}
+	curl_multi_cleanup(curlm);
 	curl_global_cleanup();
 	return 0;
 }
