From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git http-push and MKCOL error (22/409)
Date: Sun, 16 Aug 2009 23:08:18 -0700
Message-ID: <7vvdkn2crx.fsf@alter.siamese.dyndns.org>
References: <200908161557.26962.thomas.schlichter@web.de>
 <7veirb5z9a.fsf@alter.siamese.dyndns.org>
 <be6fef0d0908162158y429c4b5fgb9138151446e39ef@mail.gmail.com>
 <200908170725.09592.thomas.schlichter@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	willievu <willievu@dev.java.net>,
	Sean Davis <sdavis2@mail.nih.gov>, git@vger.kernel.org
To: Thomas Schlichter <thomas.schlichter@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 08:08:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McvOY-0000I8-Np
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 08:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744AbZHQGIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 02:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbZHQGIa
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 02:08:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbZHQGI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 02:08:28 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CFFDD0FB;
	Mon, 17 Aug 2009 02:08:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F5EED0F8; Mon, 17 Aug
 2009 02:08:20 -0400 (EDT)
In-Reply-To: <200908170725.09592.thomas.schlichter@web.de> (Thomas
 Schlichter's message of "Mon\, 17 Aug 2009 07\:25\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 61A24746-8AF4-11DE-BE20-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126123>

Thomas Schlichter <thomas.schlichter@web.de> writes:

> Hmm. I hope you won't take this as an argument for not fixing it, because it 
> is a clear regression! I tried git version 1.6.3.4, and it works flawlessly 
> with exactly this server! Even during bisecting, some versions worked, some 
> didn't (these after the mentioned commit...)

If it works (without changing anything else) with one version and with a
problematic patch it doesn't, it is a clear regression.

If you revert 5424bc5 (http*: add helper methods for fetching objects
(loose), 2009-06-06) from the tip of 'master', does it make the problem go
away?  

The patch should look like something like the attached.

diff --git a/http-push.c b/http-push.c
index 00e83dc..d1ea702 100644
--- a/http-push.c
+++ b/http-push.c
@@ -115,10 +115,18 @@ struct transfer_request
 	struct remote_lock *lock;
 	struct curl_slist *headers;
 	struct buffer buffer;
+	char filename[PATH_MAX];
+	char tmpfile[PATH_MAX];
+	int local_fileno;
 	enum transfer_state state;
 	CURLcode curl_result;
 	char errorstr[CURL_ERROR_SIZE];
 	long http_code;
+	unsigned char real_sha1[20];
+	git_SHA_CTX c;
+	z_stream stream;
+	int zret;
+	int rename;
 	void *userData;
 	struct active_request_slot *slot;
 	struct transfer_request *next;
@@ -226,6 +234,15 @@ static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum d
 	return dav_headers;
 }
 
+static void append_remote_object_url(struct strbuf *buf, const char *url,
+				     const char *hex,
+				     int only_two_digit_prefix)
+{
+	strbuf_addf(buf, "%sobjects/%.*s/", url, 2, hex);
+	if (!only_two_digit_prefix)
+		strbuf_addf(buf, "%s", hex+2);
+}
+
 static void finish_request(struct transfer_request *request);
 static void release_request(struct transfer_request *request);
 
@@ -239,29 +256,169 @@ static void process_response(void *callback_data)
 
 #ifdef USE_CURL_MULTI
 
+static char *get_remote_object_url(const char *url, const char *hex,
+				   int only_two_digit_prefix)
+{
+	struct strbuf buf = STRBUF_INIT;
+	append_remote_object_url(&buf, url, hex, only_two_digit_prefix);
+	return strbuf_detach(&buf, NULL);
+}
+
+static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
+			       void *data)
+{
+	unsigned char expn[4096];
+	size_t size = eltsize * nmemb;
+	int posn = 0;
+	struct transfer_request *request = (struct transfer_request *)data;
+	do {
+		ssize_t retval = xwrite(request->local_fileno,
+					(char *) ptr + posn, size - posn);
+		if (retval < 0)
+			return posn;
+		posn += retval;
+	} while (posn < size);
+
+	request->stream.avail_in = size;
+	request->stream.next_in = ptr;
+	do {
+		request->stream.next_out = expn;
+		request->stream.avail_out = sizeof(expn);
+		request->zret = git_inflate(&request->stream, Z_SYNC_FLUSH);
+		git_SHA1_Update(&request->c, expn,
+				sizeof(expn) - request->stream.avail_out);
+	} while (request->stream.avail_in && request->zret == Z_OK);
+	data_received++;
+	return size;
+}
+
 static void start_fetch_loose(struct transfer_request *request)
 {
+	char *hex = sha1_to_hex(request->obj->sha1);
+	char *filename;
+	char prevfile[PATH_MAX];
+	char *url;
+	int prevlocal;
+	unsigned char prev_buf[PREV_BUF_SIZE];
+	ssize_t prev_read = 0;
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct curl_slist *range_header = NULL;
 	struct active_request_slot *slot;
-	struct http_object_request *obj_req;
 
-	obj_req = new_http_object_request(repo->url, request->obj->sha1);
-	if (obj_req == NULL) {
+	filename = sha1_file_name(request->obj->sha1);
+	snprintf(request->filename, sizeof(request->filename), "%s", filename);
+	snprintf(request->tmpfile, sizeof(request->tmpfile),
+		 "%s.temp", filename);
+
+	snprintf(prevfile, sizeof(prevfile), "%s.prev", request->filename);
+	unlink_or_warn(prevfile);
+	rename(request->tmpfile, prevfile);
+	unlink_or_warn(request->tmpfile);
+
+	if (request->local_fileno != -1)
+		error("fd leakage in start: %d", request->local_fileno);
+	request->local_fileno = open(request->tmpfile,
+				     O_WRONLY | O_CREAT | O_EXCL, 0666);
+	/*
+	 * This could have failed due to the "lazy directory creation";
+	 * try to mkdir the last path component.
+	 */
+	if (request->local_fileno < 0 && errno == ENOENT) {
+		char *dir = strrchr(request->tmpfile, '/');
+		if (dir) {
+			*dir = 0;
+			mkdir(request->tmpfile, 0777);
+			*dir = '/';
+		}
+		request->local_fileno = open(request->tmpfile,
+					     O_WRONLY | O_CREAT | O_EXCL, 0666);
+	}
+
+	if (request->local_fileno < 0) {
 		request->state = ABORTED;
+		error("Couldn't create temporary file %s for %s: %s",
+		      request->tmpfile, request->filename, strerror(errno));
 		return;
 	}
 
-	slot = obj_req->slot;
+	memset(&request->stream, 0, sizeof(request->stream));
+
+	git_inflate_init(&request->stream);
+
+	git_SHA1_Init(&request->c);
+
+	url = get_remote_object_url(repo->url, hex, 0);
+	request->url = xstrdup(url);
+
+	/*
+	 * If a previous temp file is present, process what was already
+	 * fetched.
+	 */
+	prevlocal = open(prevfile, O_RDONLY);
+	if (prevlocal != -1) {
+		do {
+			prev_read = xread(prevlocal, prev_buf, PREV_BUF_SIZE);
+			if (prev_read>0) {
+				if (fwrite_sha1_file(prev_buf,
+						     1,
+						     prev_read,
+						     request) == prev_read)
+					prev_posn += prev_read;
+				else
+					prev_read = -1;
+			}
+		} while (prev_read > 0);
+		close(prevlocal);
+	}
+	unlink_or_warn(prevfile);
+
+	/*
+	 * Reset inflate/SHA1 if there was an error reading the previous temp
+	 * file; also rewind to the beginning of the local file.
+	 */
+	if (prev_read == -1) {
+		memset(&request->stream, 0, sizeof(request->stream));
+		git_inflate_init(&request->stream);
+		git_SHA1_Init(&request->c);
+		if (prev_posn>0) {
+			prev_posn = 0;
+			lseek(request->local_fileno, 0, SEEK_SET);
+			ftruncate(request->local_fileno, 0);
+		}
+	}
+
+	slot = get_active_slot();
 	slot->callback_func = process_response;
 	slot->callback_data = request;
 	request->slot = slot;
-	request->userData = obj_req;
+
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, request);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
+	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
+
+	/*
+	 * If we have successfully processed data from a previous fetch
+	 * attempt, only fetch the data we don't already have.
+	 */
+	if (prev_posn>0) {
+		if (push_verbosely)
+			fprintf(stderr,
+				"Resuming fetch of object %s at byte %ld\n",
+				hex, prev_posn);
+		sprintf(range, "Range: bytes=%ld-", prev_posn);
+		range_header = curl_slist_append(range_header, range);
+		curl_easy_setopt(slot->curl,
+				 CURLOPT_HTTPHEADER, range_header);
+	}
 
 	/* Try to get the request started, abort the request on error */
 	request->state = RUN_FETCH_LOOSE;
 	if (!start_active_slot(slot)) {
 		fprintf(stderr, "Unable to start GET request\n");
 		repo->can_update_info_refs = 0;
-		release_http_object_request(obj_req);
 		release_request(request);
 	}
 }
@@ -520,14 +677,16 @@ static void release_request(struct transfer_request *request)
 			entry->next = entry->next->next;
 	}
 
+	if (request->local_fileno != -1)
+		close(request->local_fileno);
 	free(request->url);
 	free(request);
 }
 
 static void finish_request(struct transfer_request *request)
 {
+	struct stat st;
 	struct http_pack_request *preq;
-	struct http_object_request *obj_req;
 
 	request->curl_result = request->slot->curl_result;
 	request->http_code = request->slot->http_code;
@@ -582,17 +741,39 @@ static void finish_request(struct transfer_request *request)
 			aborted = 1;
 		}
 	} else if (request->state == RUN_FETCH_LOOSE) {
-		obj_req = (struct http_object_request *)request->userData;
-
-		if (finish_http_object_request(obj_req) == 0)
-			if (obj_req->rename == 0)
-				request->obj->flags |= (LOCAL | REMOTE);
+		close(request->local_fileno);
+		request->local_fileno = -1;
+
+		if (request->curl_result != CURLE_OK &&
+		    request->http_code != 416) {
+			if (stat(request->tmpfile, &st) == 0) {
+				if (st.st_size == 0)
+					unlink_or_warn(request->tmpfile);
+			}
+		} else {
+			if (request->http_code == 416)
+				warning("requested range invalid; we may already have all the data.");
+
+			git_inflate_end(&request->stream);
+			git_SHA1_Final(request->real_sha1, &request->c);
+			if (request->zret != Z_STREAM_END) {
+				unlink_or_warn(request->tmpfile);
+			} else if (hashcmp(request->obj->sha1, request->real_sha1)) {
+				unlink_or_warn(request->tmpfile);
+			} else {
+				request->rename =
+					move_temp_to_file(
+						request->tmpfile,
+						request->filename);
+				if (request->rename == 0)
+					request->obj->flags |= (LOCAL | REMOTE);
+			}
+		}
 
 		/* Try fetching packed if necessary */
-		if (request->obj->flags & LOCAL) {
-			release_http_object_request(obj_req);
+		if (request->obj->flags & LOCAL)
 			release_request(request);
-		} else
+		else
 			start_fetch_packed(request);
 
 	} else if (request->state == RUN_FETCH_PACKED) {
@@ -664,6 +845,7 @@ static void add_fetch_request(struct object *obj)
 	request->url = NULL;
 	request->lock = NULL;
 	request->headers = NULL;
+	request->local_fileno = -1;
 	request->state = NEED_FETCH;
 	request->next = request_queue_head;
 	request_queue_head = request;
@@ -702,6 +884,7 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	request->url = NULL;
 	request->lock = lock;
 	request->headers = NULL;
+	request->local_fileno = -1;
 	request->state = NEED_PUSH;
 	request->next = request_queue_head;
 	request_queue_head = request;
diff --git a/http-walker.c b/http-walker.c
index 700bc13..8f7a975 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -3,6 +3,8 @@
 #include "walker.h"
 #include "http.h"
 
+#define PREV_BUF_SIZE 4096
+
 struct alt_base
 {
 	char *base;
@@ -23,8 +25,20 @@ struct object_request
 	struct walker *walker;
 	unsigned char sha1[20];
 	struct alt_base *repo;
+	char *url;
+	char filename[PATH_MAX];
+	char tmpfile[PATH_MAX];
+	int local;
 	enum object_request_state state;
-	struct http_object_request *req;
+	CURLcode curl_result;
+	char errorstr[CURL_ERROR_SIZE];
+	long http_code;
+	unsigned char real_sha1[20];
+	git_SHA_CTX c;
+	z_stream stream;
+	int zret;
+	int rename;
+	struct active_request_slot *slot;
 	struct object_request *next;
 };
 
@@ -45,6 +59,34 @@ struct walker_data {
 
 static struct object_request *object_queue_head;
 
+static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
+			       void *data)
+{
+	unsigned char expn[4096];
+	size_t size = eltsize * nmemb;
+	int posn = 0;
+	struct object_request *obj_req = (struct object_request *)data;
+	do {
+		ssize_t retval = xwrite(obj_req->local,
+					(char *) ptr + posn, size - posn);
+		if (retval < 0)
+			return posn;
+		posn += retval;
+	} while (posn < size);
+
+	obj_req->stream.avail_in = size;
+	obj_req->stream.next_in = ptr;
+	do {
+		obj_req->stream.next_out = expn;
+		obj_req->stream.avail_out = sizeof(expn);
+		obj_req->zret = git_inflate(&obj_req->stream, Z_SYNC_FLUSH);
+		git_SHA1_Update(&obj_req->c, expn,
+				sizeof(expn) - obj_req->stream.avail_out);
+	} while (obj_req->stream.avail_in && obj_req->zret == Z_OK);
+	data_received++;
+	return size;
+}
+
 static void fetch_alternates(struct walker *walker, const char *base);
 
 static void process_object_response(void *callback_data);
@@ -52,35 +94,172 @@ static void process_object_response(void *callback_data);
 static void start_object_request(struct walker *walker,
 				 struct object_request *obj_req)
 {
+	char *hex = sha1_to_hex(obj_req->sha1);
+	char prevfile[PATH_MAX];
+	char *url;
+	char *posn;
+	int prevlocal;
+	unsigned char prev_buf[PREV_BUF_SIZE];
+	ssize_t prev_read = 0;
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct curl_slist *range_header = NULL;
 	struct active_request_slot *slot;
-	struct http_object_request *req;
 
-	req = new_http_object_request(obj_req->repo->base, obj_req->sha1);
-	if (req == NULL) {
+	snprintf(prevfile, sizeof(prevfile), "%s.prev", obj_req->filename);
+	unlink_or_warn(prevfile);
+	rename(obj_req->tmpfile, prevfile);
+	unlink_or_warn(obj_req->tmpfile);
+
+	if (obj_req->local != -1)
+		error("fd leakage in start: %d", obj_req->local);
+	obj_req->local = open(obj_req->tmpfile,
+			      O_WRONLY | O_CREAT | O_EXCL, 0666);
+	/*
+	 * This could have failed due to the "lazy directory creation";
+	 * try to mkdir the last path component.
+	 */
+	if (obj_req->local < 0 && errno == ENOENT) {
+		char *dir = strrchr(obj_req->tmpfile, '/');
+		if (dir) {
+			*dir = 0;
+			mkdir(obj_req->tmpfile, 0777);
+			*dir = '/';
+		}
+		obj_req->local = open(obj_req->tmpfile,
+				      O_WRONLY | O_CREAT | O_EXCL, 0666);
+	}
+
+	if (obj_req->local < 0) {
 		obj_req->state = ABORTED;
+		error("Couldn't create temporary file %s for %s: %s",
+		      obj_req->tmpfile, obj_req->filename, strerror(errno));
 		return;
 	}
-	obj_req->req = req;
 
-	slot = req->slot;
+	memset(&obj_req->stream, 0, sizeof(obj_req->stream));
+
+	git_inflate_init(&obj_req->stream);
+
+	git_SHA1_Init(&obj_req->c);
+
+	url = xmalloc(strlen(obj_req->repo->base) + 51);
+	obj_req->url = xmalloc(strlen(obj_req->repo->base) + 51);
+	strcpy(url, obj_req->repo->base);
+	posn = url + strlen(obj_req->repo->base);
+	strcpy(posn, "/objects/");
+	posn += 9;
+	memcpy(posn, hex, 2);
+	posn += 2;
+	*(posn++) = '/';
+	strcpy(posn, hex + 2);
+	strcpy(obj_req->url, url);
+
+	/*
+	 * If a previous temp file is present, process what was already
+	 * fetched.
+	 */
+	prevlocal = open(prevfile, O_RDONLY);
+	if (prevlocal != -1) {
+		do {
+			prev_read = xread(prevlocal, prev_buf, PREV_BUF_SIZE);
+			if (prev_read>0) {
+				if (fwrite_sha1_file(prev_buf,
+						     1,
+						     prev_read,
+						     obj_req) == prev_read)
+					prev_posn += prev_read;
+				else
+					prev_read = -1;
+			}
+		} while (prev_read > 0);
+		close(prevlocal);
+	}
+	unlink_or_warn(prevfile);
+
+	/*
+	 * Reset inflate/SHA1 if there was an error reading the previous temp
+	 * file; also rewind to the beginning of the local file.
+	 */
+	if (prev_read == -1) {
+		memset(&obj_req->stream, 0, sizeof(obj_req->stream));
+		git_inflate_init(&obj_req->stream);
+		git_SHA1_Init(&obj_req->c);
+		if (prev_posn>0) {
+			prev_posn = 0;
+			lseek(obj_req->local, 0, SEEK_SET);
+			ftruncate(obj_req->local, 0);
+		}
+	}
+
+	slot = get_active_slot();
 	slot->callback_func = process_object_response;
 	slot->callback_data = obj_req;
+	obj_req->slot = slot;
+
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, obj_req);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
+	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, obj_req->errorstr);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
+
+	/*
+	 * If we have successfully processed data from a previous fetch
+	 * attempt, only fetch the data we don't already have.
+	 */
+	if (prev_posn>0) {
+		if (walker->get_verbosely)
+			fprintf(stderr,
+				"Resuming fetch of object %s at byte %ld\n",
+				hex, prev_posn);
+		sprintf(range, "Range: bytes=%ld-", prev_posn);
+		range_header = curl_slist_append(range_header, range);
+		curl_easy_setopt(slot->curl,
+				 CURLOPT_HTTPHEADER, range_header);
+	}
 
 	/* Try to get the request started, abort the request on error */
 	obj_req->state = ACTIVE;
 	if (!start_active_slot(slot)) {
 		obj_req->state = ABORTED;
-		release_http_object_request(req);
+		obj_req->slot = NULL;
+		close(obj_req->local);
+		obj_req->local = -1;
+		free(obj_req->url);
 		return;
 	}
 }
 
 static void finish_object_request(struct object_request *obj_req)
 {
-	if (finish_http_object_request(obj_req->req))
+	struct stat st;
+
+	close(obj_req->local);
+	obj_req->local = -1;
+
+	if (obj_req->http_code == 416) {
+		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
+	} else if (obj_req->curl_result != CURLE_OK) {
+		if (stat(obj_req->tmpfile, &st) == 0)
+			if (st.st_size == 0)
+				unlink_or_warn(obj_req->tmpfile);
 		return;
+	}
+
+	git_inflate_end(&obj_req->stream);
+	git_SHA1_Final(obj_req->real_sha1, &obj_req->c);
+	if (obj_req->zret != Z_STREAM_END) {
+		unlink_or_warn(obj_req->tmpfile);
+		return;
+	}
+	if (hashcmp(obj_req->sha1, obj_req->real_sha1)) {
+		unlink_or_warn(obj_req->tmpfile);
+		return;
+	}
+	obj_req->rename =
+		move_temp_to_file(obj_req->tmpfile, obj_req->filename);
 
-	if (obj_req->req->rename == 0)
+	if (obj_req->rename == 0)
 		walker_say(obj_req->walker, "got %s\n", sha1_to_hex(obj_req->sha1));
 }
 
@@ -92,16 +271,19 @@ static void process_object_response(void *callback_data)
 	struct walker_data *data = walker->data;
 	struct alt_base *alt = data->alt;
 
-	process_http_object_request(obj_req->req);
+	obj_req->curl_result = obj_req->slot->curl_result;
+	obj_req->http_code = obj_req->slot->http_code;
+	obj_req->slot = NULL;
 	obj_req->state = COMPLETE;
 
 	/* Use alternates if necessary */
-	if (missing_target(obj_req->req)) {
+	if (missing_target(obj_req)) {
 		fetch_alternates(walker, alt->base);
 		if (obj_req->repo->next != NULL) {
 			obj_req->repo =
 				obj_req->repo->next;
-			release_http_object_request(obj_req->req);
+			close(obj_req->local);
+			obj_req->local = -1;
 			start_object_request(walker, obj_req);
 			return;
 		}
@@ -114,8 +296,8 @@ static void release_object_request(struct object_request *obj_req)
 {
 	struct object_request *entry = object_queue_head;
 
-	if (obj_req->req !=NULL && obj_req->req->localfile != -1)
-		error("fd leakage in release: %d", obj_req->req->localfile);
+	if (obj_req->local != -1)
+		error("fd leakage in release: %d", obj_req->local);
 	if (obj_req == object_queue_head) {
 		object_queue_head = obj_req->next;
 	} else {
@@ -125,6 +307,7 @@ static void release_object_request(struct object_request *obj_req)
 			entry->next = entry->next->next;
 	}
 
+	free(obj_req->url);
 	free(obj_req);
 }
 
@@ -152,13 +335,19 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 	struct object_request *newreq;
 	struct object_request *tail;
 	struct walker_data *data = walker->data;
+	char *filename = sha1_file_name(sha1);
 
 	newreq = xmalloc(sizeof(*newreq));
 	newreq->walker = walker;
 	hashcpy(newreq->sha1, sha1);
 	newreq->repo = data->alt;
+	newreq->url = NULL;
+	newreq->local = -1;
 	newreq->state = WAITING;
-	newreq->req = NULL;
+	snprintf(newreq->filename, sizeof(newreq->filename), "%s", filename);
+	snprintf(newreq->tmpfile, sizeof(newreq->tmpfile),
+		 "%s.temp", filename);
+	newreq->slot = NULL;
 	newreq->next = NULL;
 
 	http_is_verbose = walker->get_verbosely;
@@ -449,6 +638,15 @@ abort:
 
 static void abort_object_request(struct object_request *obj_req)
 {
+	if (obj_req->local >= 0) {
+		close(obj_req->local);
+		obj_req->local = -1;
+	}
+	unlink_or_warn(obj_req->tmpfile);
+	if (obj_req->slot) {
+		release_active_slot(obj_req->slot);
+		obj_req->slot = NULL;
+	}
 	release_object_request(obj_req);
 }
 
@@ -457,7 +655,6 @@ static int fetch_object(struct walker *walker, struct alt_base *repo, unsigned c
 	char *hex = sha1_to_hex(sha1);
 	int ret = 0;
 	struct object_request *obj_req = object_queue_head;
-	struct http_object_request *req;
 
 	while (obj_req != NULL && hashcmp(obj_req->sha1, sha1))
 		obj_req = obj_req->next;
@@ -465,8 +662,6 @@ static int fetch_object(struct walker *walker, struct alt_base *repo, unsigned c
 		return error("Couldn't find request for %s in the queue", hex);
 
 	if (has_sha1_file(obj_req->sha1)) {
-		if (obj_req->req != NULL)
-			abort_http_object_request(obj_req->req);
 		abort_object_request(obj_req);
 		return 0;
 	}
@@ -478,42 +673,34 @@ static int fetch_object(struct walker *walker, struct alt_base *repo, unsigned c
 	start_object_request(walker, obj_req);
 #endif
 
-	/*
-	 * obj_req->req might change when fetching alternates in the callback
-	 * process_object_response; therefore, the "shortcut" variable, req,
-	 * is used only after we're done with slots.
-	 */
 	while (obj_req->state == ACTIVE)
-		run_active_slot(obj_req->req->slot);
-
-	req = obj_req->req;
+		run_active_slot(obj_req->slot);
 
-	if (req->localfile != -1) {
-		close(req->localfile);
-		req->localfile = -1;
+	if (obj_req->local != -1) {
+		close(obj_req->local);
+		obj_req->local = -1;
 	}
 
 	if (obj_req->state == ABORTED) {
 		ret = error("Request for %s aborted", hex);
-	} else if (req->curl_result != CURLE_OK &&
-		   req->http_code != 416) {
-		if (missing_target(req))
+	} else if (obj_req->curl_result != CURLE_OK &&
+		   obj_req->http_code != 416) {
+		if (missing_target(obj_req))
 			ret = -1; /* Be silent, it is probably in a pack. */
 		else
 			ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
-				    req->errorstr, req->curl_result,
-				    req->http_code, hex);
-	} else if (req->zret != Z_STREAM_END) {
+				    obj_req->errorstr, obj_req->curl_result,
+				    obj_req->http_code, hex);
+	} else if (obj_req->zret != Z_STREAM_END) {
 		walker->corrupt_object_found++;
-		ret = error("File %s (%s) corrupt", hex, req->url);
-	} else if (hashcmp(obj_req->sha1, req->real_sha1)) {
+		ret = error("File %s (%s) corrupt", hex, obj_req->url);
+	} else if (hashcmp(obj_req->sha1, obj_req->real_sha1)) {
 		ret = error("File %s has bad hash", hex);
-	} else if (req->rename < 0) {
+	} else if (obj_req->rename < 0) {
 		ret = error("unable to write sha1 filename %s",
-			    req->filename);
+			    obj_req->filename);
 	}
 
-	release_http_object_request(req);
 	release_object_request(obj_req);
 	return ret;
 }
diff --git a/http.c b/http.c
index 14d5357..ad7b6f8 100644
--- a/http.c
+++ b/http.c
@@ -12,10 +12,6 @@ static CURLM *curlm;
 #ifndef NO_CURL_EASY_DUPHANDLE
 static CURL *curl_default;
 #endif
-
-#define PREV_BUF_SIZE 4096
-#define RANGE_HEADER_SIZE 30
-
 char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
@@ -45,7 +41,8 @@ static char *ssl_cert_password;
 static int ssl_cert_password_required;
 
 static struct curl_slist *pragma_header;
-static struct curl_slist *no_pragma_header;
+
+struct curl_slist *no_pragma_header;
 
 static struct active_request_slot *active_queue_head;
 
@@ -715,23 +712,6 @@ static char *quote_ref_url(const char *base, const char *ref)
 	return strbuf_detach(&buf, NULL);
 }
 
-void append_remote_object_url(struct strbuf *buf, const char *url,
-			      const char *hex,
-			      int only_two_digit_prefix)
-{
-	strbuf_addf(buf, "%s/objects/%.*s/", url, 2, hex);
-	if (!only_two_digit_prefix)
-		strbuf_addf(buf, "%s", hex+2);
-}
-
-char *get_remote_object_url(const char *url, const char *hex,
-			    int only_two_digit_prefix)
-{
-	struct strbuf buf = STRBUF_INIT;
-	append_remote_object_url(&buf, url, hex, only_two_digit_prefix);
-	return strbuf_detach(&buf, NULL);
-}
-
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -1061,231 +1041,3 @@ abort:
 	free(preq);
 	return NULL;
 }
-
-/* Helpers for fetching objects (loose) */
-static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
-			       void *data)
-{
-	unsigned char expn[4096];
-	size_t size = eltsize * nmemb;
-	int posn = 0;
-	struct http_object_request *freq =
-		(struct http_object_request *)data;
-	do {
-		ssize_t retval = xwrite(freq->localfile,
-					(char *) ptr + posn, size - posn);
-		if (retval < 0)
-			return posn;
-		posn += retval;
-	} while (posn < size);
-
-	freq->stream.avail_in = size;
-	freq->stream.next_in = ptr;
-	do {
-		freq->stream.next_out = expn;
-		freq->stream.avail_out = sizeof(expn);
-		freq->zret = git_inflate(&freq->stream, Z_SYNC_FLUSH);
-		git_SHA1_Update(&freq->c, expn,
-				sizeof(expn) - freq->stream.avail_out);
-	} while (freq->stream.avail_in && freq->zret == Z_OK);
-	data_received++;
-	return size;
-}
-
-struct http_object_request *new_http_object_request(const char *base_url,
-	unsigned char *sha1)
-{
-	char *hex = sha1_to_hex(sha1);
-	char *filename;
-	char prevfile[PATH_MAX];
-	int prevlocal;
-	unsigned char prev_buf[PREV_BUF_SIZE];
-	ssize_t prev_read = 0;
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
-	struct http_object_request *freq;
-
-	freq = xmalloc(sizeof(*freq));
-	hashcpy(freq->sha1, sha1);
-	freq->localfile = -1;
-
-	filename = sha1_file_name(sha1);
-	snprintf(freq->filename, sizeof(freq->filename), "%s", filename);
-	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
-		 "%s.temp", filename);
-
-	snprintf(prevfile, sizeof(prevfile), "%s.prev", filename);
-	unlink_or_warn(prevfile);
-	rename(freq->tmpfile, prevfile);
-	unlink_or_warn(freq->tmpfile);
-
-	if (freq->localfile != -1)
-		error("fd leakage in start: %d", freq->localfile);
-	freq->localfile = open(freq->tmpfile,
-			       O_WRONLY | O_CREAT | O_EXCL, 0666);
-	/*
-	 * This could have failed due to the "lazy directory creation";
-	 * try to mkdir the last path component.
-	 */
-	if (freq->localfile < 0 && errno == ENOENT) {
-		char *dir = strrchr(freq->tmpfile, '/');
-		if (dir) {
-			*dir = 0;
-			mkdir(freq->tmpfile, 0777);
-			*dir = '/';
-		}
-		freq->localfile = open(freq->tmpfile,
-				       O_WRONLY | O_CREAT | O_EXCL, 0666);
-	}
-
-	if (freq->localfile < 0) {
-		error("Couldn't create temporary file %s for %s: %s",
-		      freq->tmpfile, freq->filename, strerror(errno));
-		goto abort;
-	}
-
-	memset(&freq->stream, 0, sizeof(freq->stream));
-
-	git_inflate_init(&freq->stream);
-
-	git_SHA1_Init(&freq->c);
-
-	freq->url = get_remote_object_url(base_url, hex, 0);
-
-	/*
-	 * If a previous temp file is present, process what was already
-	 * fetched.
-	 */
-	prevlocal = open(prevfile, O_RDONLY);
-	if (prevlocal != -1) {
-		do {
-			prev_read = xread(prevlocal, prev_buf, PREV_BUF_SIZE);
-			if (prev_read>0) {
-				if (fwrite_sha1_file(prev_buf,
-						     1,
-						     prev_read,
-						     freq) == prev_read) {
-					prev_posn += prev_read;
-				} else {
-					prev_read = -1;
-				}
-			}
-		} while (prev_read > 0);
-		close(prevlocal);
-	}
-	unlink_or_warn(prevfile);
-
-	/*
-	 * Reset inflate/SHA1 if there was an error reading the previous temp
-	 * file; also rewind to the beginning of the local file.
-	 */
-	if (prev_read == -1) {
-		memset(&freq->stream, 0, sizeof(freq->stream));
-		git_inflate_init(&freq->stream);
-		git_SHA1_Init(&freq->c);
-		if (prev_posn>0) {
-			prev_posn = 0;
-			lseek(freq->localfile, 0, SEEK_SET);
-			if (ftruncate(freq->localfile, 0) < 0) {
-				error("Couldn't truncate temporary file %s for %s: %s",
-					  freq->tmpfile, freq->filename, strerror(errno));
-				goto abort;
-			}
-		}
-	}
-
-	freq->slot = get_active_slot();
-
-	curl_easy_setopt(freq->slot->curl, CURLOPT_FILE, freq);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
-
-	/*
-	 * If we have successfully processed data from a previous fetch
-	 * attempt, only fetch the data we don't already have.
-	 */
-	if (prev_posn>0) {
-		if (http_is_verbose)
-			fprintf(stderr,
-				"Resuming fetch of object %s at byte %ld\n",
-				hex, prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(freq->slot->curl,
-				 CURLOPT_HTTPHEADER, range_header);
-	}
-
-	return freq;
-
-abort:
-	free(filename);
-	free(freq->url);
-	free(freq);
-	return NULL;
-}
-
-void process_http_object_request(struct http_object_request *freq)
-{
-	if (freq->slot == NULL)
-		return;
-	freq->curl_result = freq->slot->curl_result;
-	freq->http_code = freq->slot->http_code;
-	freq->slot = NULL;
-}
-
-int finish_http_object_request(struct http_object_request *freq)
-{
-	struct stat st;
-
-	close(freq->localfile);
-	freq->localfile = -1;
-
-	process_http_object_request(freq);
-
-	if (freq->http_code == 416) {
-		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
-	} else if (freq->curl_result != CURLE_OK) {
-		if (stat(freq->tmpfile, &st) == 0)
-			if (st.st_size == 0)
-				unlink_or_warn(freq->tmpfile);
-		return -1;
-	}
-
-	git_inflate_end(&freq->stream);
-	git_SHA1_Final(freq->real_sha1, &freq->c);
-	if (freq->zret != Z_STREAM_END) {
-		unlink_or_warn(freq->tmpfile);
-		return -1;
-	}
-	if (hashcmp(freq->sha1, freq->real_sha1)) {
-		unlink_or_warn(freq->tmpfile);
-		return -1;
-	}
-	freq->rename =
-		move_temp_to_file(freq->tmpfile, freq->filename);
-
-	return freq->rename;
-}
-
-void abort_http_object_request(struct http_object_request *freq)
-{
-	unlink_or_warn(freq->tmpfile);
-
-	release_http_object_request(freq);
-}
-
-void release_http_object_request(struct http_object_request *freq)
-{
-	if (freq->localfile != -1) {
-		close(freq->localfile);
-		freq->localfile = -1;
-	}
-	if (freq->url != NULL) {
-		free(freq->url);
-		freq->url = NULL;
-	}
-	freq->slot = NULL;
-}
diff --git a/http.h b/http.h
index 4c4e99c..511c0c4 100644
--- a/http.h
+++ b/http.h
@@ -88,6 +88,10 @@ extern void add_fill_function(void *data, int (*fill)(void *));
 extern void step_active_slots(void);
 #endif
 
+extern struct curl_slist *no_pragma_header;
+
+#define RANGE_HEADER_SIZE 30
+
 extern void http_init(struct remote *remote);
 extern void http_cleanup(void);
 
@@ -110,13 +114,6 @@ static inline int missing__target(int code, int result)
 
 #define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
 
-/* Helpers for modifying and creating URLs */
-extern void append_remote_object_url(struct strbuf *buf, const char *url,
-				     const char *hex,
-				     int only_two_digit_prefix);
-extern char *get_remote_object_url(const char *url, const char *hex,
-				   int only_two_digit_prefix);
-
 /* Options for http_request_*() */
 #define HTTP_NO_CACHE		1
 
@@ -170,30 +167,4 @@ extern struct http_pack_request *new_http_pack_request(
 extern int finish_http_pack_request(struct http_pack_request *preq);
 extern void release_http_pack_request(struct http_pack_request *preq);
 
-/* Helpers for fetching object */
-struct http_object_request
-{
-	char *url;
-	char filename[PATH_MAX];
-	char tmpfile[PATH_MAX];
-	int localfile;
-	CURLcode curl_result;
-	char errorstr[CURL_ERROR_SIZE];
-	long http_code;
-	unsigned char sha1[20];
-	unsigned char real_sha1[20];
-	git_SHA_CTX c;
-	z_stream stream;
-	int zret;
-	int rename;
-	struct active_request_slot *slot;
-};
-
-extern struct http_object_request *new_http_object_request(
-	const char *base_url, unsigned char *sha1);
-extern void process_http_object_request(struct http_object_request *freq);
-extern int finish_http_object_request(struct http_object_request *freq);
-extern void abort_http_object_request(struct http_object_request *freq);
-extern void release_http_object_request(struct http_object_request *freq);
-
 #endif /* HTTP_H */
