From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 18/18] http*: add helper methods for fetching objects
 (loose)
Date: Sun, 24 May 2009 22:20:08 +0800
Message-ID: <20090524222008.b9de3f45.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:23:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Ec6-0006Oo-Rj
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbZEXOWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754521AbZEXOWn
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:22:43 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:48930 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbZEXOWl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:22:41 -0400
Received: by mail-px0-f103.google.com with SMTP id 1so2153790pxi.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Ky6Kk8gX7iw/OaExLNj4IroanR1UvwXV5QKEuAtRk0E=;
        b=Q3RL6wawgeZAIz18bKCjHxH3BTpz7x0WliuwHg6HRGaSXFX1mA/DtrjUArsGqDyfVQ
         TUjCqxI3KxJDRq7QXWvqKW40TbqRaEUPpHXW3VArb/ZjDdNkU7behkMaaTwkCLuYh5Ax
         ycu4BvVWh+4AWmudETeX5vNO3rrNvoaAxP/VI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=MVd6agzo1jASthozaDKuKUxM5oXVYNP2Bc9eoWqsJ9zSJVYLKgtfp48xGp8wpOZJrl
         fLeN23oyfVKUrFo/STI0Q+xjL4cT59ab4iZa1Lin2HuI5EUizFG94GtUD+qPj3IpKRsL
         8tJlKIgASvn41R3N6QEXNLi8LxLWgt7ZKtk4U=
Received: by 10.114.180.1 with SMTP id c1mr12681980waf.206.1243174963442;
        Sun, 24 May 2009 07:22:43 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id f20sm12500689waf.52.2009.05.24.07.22.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:22:42 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119839>

The code handling the fetching of loose objects in http-push.c and
http-walker.c have been refactored into new methods and a new struct
(object_http_request) in http.c. They are not meant to be invoked
elsewhere.

The new methods in http.c are
 *new_http_object_request
 *process_http_object_request
 *finish_http_object_request
 *abort_http_object_request
 *release_http_object_request

and the new struct is http_object_request.

RANGER_HEADER_SIZE and no_pragma_header is no longer made available
outside of http.c, since there are no other users outside of http.c.

***http-push.c***
Several members of the transfer_request struct have been removed,
including filename, real_sha1 and zret, as they are used only by code
involving the fetching of loose objects.

The methods append_remote_object_url and get_remote_object_url have
been moved to http.c. Additionally, get_remote_object_url is no longer
defined only when USE_CURL_MULTI is on, since non-USE_CURL_MULTI code
in http.c uses it (namely, in new_http_object_request).

The logic moved out from start_fetch_loose is exactly identical to
that in new_http_object_request.

The logic moved out from finish_request is almost identical to that in
finish_http_object_request, but behaves similarly. If the invocation
returns 0, the rename flag is checked and the FLAG_BITS flag is set, as
before.

The closing of the file descriptor (originally local_fileno in
transfer_request) in release_request is now done in
finish_http_pack_request and release_http_object_request.

When cleaning up, release_http_object_request is invoked separately from
release_request.

***http-walker.c***
Several members of the transfer_request struct have been removed,
including filename, real_sha1 and zret, as they are used only by code
involving the fetching of loose objects.

The logic moved out from start_object_fetch_request is exactly
identical to that in new_http_object_request.

The logic moved out from finish_object_request is exactly identical to
that in finish_http_object_request.

The logic moved out from process_object_request is exactly identical to
that in process_http_object_request. Although finish_object_request
invokes process_object_request internally later on, its invocation by
process_object_response (to check if fetching alternates is needed) is
safe.

abort_object_request no longer closes the file descriptor and release
the slot. This is done by abort_http_object_request, invoked separately.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c   |  212 +++------------------------------------------
 http-walker.c |  266 +++++++++------------------------------------------------
 http.c        |  250 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 http.h        |   37 +++++++-
 4 files changed, 336 insertions(+), 429 deletions(-)

diff --git a/http-push.c b/http-push.c
index 3b681b8..d6b7508 100644
--- a/http-push.c
+++ b/http-push.c
@@ -115,18 +115,10 @@ struct transfer_request
 	struct remote_lock *lock;
 	struct curl_slist *headers;
 	struct buffer buffer;
-	char filename[PATH_MAX];
-	char tmpfile[PATH_MAX];
-	int local_fileno;
 	enum transfer_state state;
 	CURLcode curl_result;
 	char errorstr[CURL_ERROR_SIZE];
 	long http_code;
-	unsigned char real_sha1[20];
-	git_SHA_CTX c;
-	z_stream stream;
-	int zret;
-	int rename;
 	void *userData;
 	struct active_request_slot *slot;
 	struct transfer_request *next;
@@ -232,15 +224,6 @@ static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum d
 	return dav_headers;
 }

-static void append_remote_object_url(struct strbuf *buf, const char *url,
-				     const char *hex,
-				     int only_two_digit_prefix)
-{
-	strbuf_addf(buf, "%sobjects/%.*s/", url, 2, hex);
-	if (!only_two_digit_prefix)
-		strbuf_addf(buf, "%s", hex+2);
-}
-
 static void finish_request(struct transfer_request *request);
 static void release_request(struct transfer_request *request);

@@ -254,169 +237,29 @@ static void process_response(void *callback_data)

 #ifdef USE_CURL_MULTI

-static char *get_remote_object_url(const char *url, const char *hex,
-				   int only_two_digit_prefix)
-{
-	struct strbuf buf = STRBUF_INIT;
-	append_remote_object_url(&buf, url, hex, only_two_digit_prefix);
-	return strbuf_detach(&buf, NULL);
-}
-
-static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
-			       void *data)
-{
-	unsigned char expn[4096];
-	size_t size = eltsize * nmemb;
-	int posn = 0;
-	struct transfer_request *request = (struct transfer_request *)data;
-	do {
-		ssize_t retval = xwrite(request->local_fileno,
-					(char *) ptr + posn, size - posn);
-		if (retval < 0)
-			return posn;
-		posn += retval;
-	} while (posn < size);
-
-	request->stream.avail_in = size;
-	request->stream.next_in = ptr;
-	do {
-		request->stream.next_out = expn;
-		request->stream.avail_out = sizeof(expn);
-		request->zret = git_inflate(&request->stream, Z_SYNC_FLUSH);
-		git_SHA1_Update(&request->c, expn,
-				sizeof(expn) - request->stream.avail_out);
-	} while (request->stream.avail_in && request->zret == Z_OK);
-	data_received++;
-	return size;
-}
-
 static void start_fetch_loose(struct transfer_request *request)
 {
-	char *hex = sha1_to_hex(request->obj->sha1);
-	char *filename;
-	char prevfile[PATH_MAX];
-	char *url;
-	int prevlocal;
-	unsigned char prev_buf[PREV_BUF_SIZE];
-	ssize_t prev_read = 0;
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
 	struct active_request_slot *slot;
+	struct http_object_request *obj_req;

-	filename = sha1_file_name(request->obj->sha1);
-	snprintf(request->filename, sizeof(request->filename), "%s", filename);
-	snprintf(request->tmpfile, sizeof(request->tmpfile),
-		 "%s.temp", filename);
-
-	snprintf(prevfile, sizeof(prevfile), "%s.prev", request->filename);
-	unlink_or_warn(prevfile);
-	rename(request->tmpfile, prevfile);
-	unlink_or_warn(request->tmpfile);
-
-	if (request->local_fileno != -1)
-		error("fd leakage in start: %d", request->local_fileno);
-	request->local_fileno = open(request->tmpfile,
-				     O_WRONLY | O_CREAT | O_EXCL, 0666);
-	/*
-	 * This could have failed due to the "lazy directory creation";
-	 * try to mkdir the last path component.
-	 */
-	if (request->local_fileno < 0 && errno == ENOENT) {
-		char *dir = strrchr(request->tmpfile, '/');
-		if (dir) {
-			*dir = 0;
-			mkdir(request->tmpfile, 0777);
-			*dir = '/';
-		}
-		request->local_fileno = open(request->tmpfile,
-					     O_WRONLY | O_CREAT | O_EXCL, 0666);
-	}
-
-	if (request->local_fileno < 0) {
+	obj_req = new_http_object_request(repo->url, request->obj->sha1);
+	if (obj_req == NULL) {
 		request->state = ABORTED;
-		error("Couldn't create temporary file %s for %s: %s",
-		      request->tmpfile, request->filename, strerror(errno));
 		return;
 	}

-	memset(&request->stream, 0, sizeof(request->stream));
-
-	git_inflate_init(&request->stream);
-
-	git_SHA1_Init(&request->c);
-
-	url = get_remote_object_url(repo->url, hex, 0);
-	request->url = xstrdup(url);
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
-						     request) == prev_read)
-					prev_posn += prev_read;
-				else
-					prev_read = -1;
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
-		memset(&request->stream, 0, sizeof(request->stream));
-		git_inflate_init(&request->stream);
-		git_SHA1_Init(&request->c);
-		if (prev_posn>0) {
-			prev_posn = 0;
-			lseek(request->local_fileno, 0, SEEK_SET);
-			ftruncate(request->local_fileno, 0);
-		}
-	}
-
-	slot = get_active_slot();
+	slot = obj_req->slot;
 	slot->callback_func = process_response;
 	slot->callback_data = request;
 	request->slot = slot;
-
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, request);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
-	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
-
-	/*
-	 * If we have successfully processed data from a previous fetch
-	 * attempt, only fetch the data we don't already have.
-	 */
-	if (prev_posn>0) {
-		if (push_verbosely)
-			fprintf(stderr,
-				"Resuming fetch of object %s at byte %ld\n",
-				hex, prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(slot->curl,
-				 CURLOPT_HTTPHEADER, range_header);
-	}
+	request->userData = obj_req;

 	/* Try to get the request started, abort the request on error */
 	request->state = RUN_FETCH_LOOSE;
 	if (!start_active_slot(slot)) {
 		fprintf(stderr, "Unable to start GET request\n");
 		repo->can_update_info_refs = 0;
+		release_http_object_request(obj_req);
 		release_request(request);
 	}
 }
@@ -675,8 +518,6 @@ static void release_request(struct transfer_request *request)
 			entry->next = entry->next->next;
 	}

-	if (request->local_fileno != -1)
-		close(request->local_fileno);
 	free(request->url);
 	free(request);
 }
@@ -685,6 +526,7 @@ static void finish_request(struct transfer_request *request)
 {
 	struct stat st;
 	struct http_pack_request *preq;
+	struct http_object_request *obj_req;

 	request->curl_result = request->slot->curl_result;
 	request->http_code = request->slot->http_code;
@@ -739,39 +581,17 @@ static void finish_request(struct transfer_request *request)
 			aborted = 1;
 		}
 	} else if (request->state == RUN_FETCH_LOOSE) {
-		close(request->local_fileno);
-		request->local_fileno = -1;
-
-		if (request->curl_result != CURLE_OK &&
-		    request->http_code != 416) {
-			if (stat(request->tmpfile, &st) == 0) {
-				if (st.st_size == 0)
-					unlink_or_warn(request->tmpfile);
-			}
-		} else {
-			if (request->http_code == 416)
-				warning("requested range invalid; we may already have all the data.");
-
-			git_inflate_end(&request->stream);
-			git_SHA1_Final(request->real_sha1, &request->c);
-			if (request->zret != Z_STREAM_END) {
-				unlink_or_warn(request->tmpfile);
-			} else if (hashcmp(request->obj->sha1, request->real_sha1)) {
-				unlink_or_warn(request->tmpfile);
-			} else {
-				request->rename =
-					move_temp_to_file(
-						request->tmpfile,
-						request->filename);
-				if (request->rename == 0)
-					request->obj->flags |= (LOCAL | REMOTE);
-			}
-		}
+		obj_req = (struct http_object_request *)request->userData;
+
+		if (finish_http_object_request(obj_req) == 0)
+			if (obj_req->rename == 0)
+				request->obj->flags |= (LOCAL | REMOTE);

 		/* Try fetching packed if necessary */
-		if (request->obj->flags & LOCAL)
+		if (request->obj->flags & LOCAL) {
+			release_http_object_request(obj_req);
 			release_request(request);
-		else
+		} else
 			start_fetch_packed(request);

 	} else if (request->state == RUN_FETCH_PACKED) {
@@ -843,7 +663,6 @@ static void add_fetch_request(struct object *obj)
 	request->url = NULL;
 	request->lock = NULL;
 	request->headers = NULL;
-	request->local_fileno = -1;
 	request->state = NEED_FETCH;
 	request->next = request_queue_head;
 	request_queue_head = request;
@@ -882,7 +701,6 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	request->url = NULL;
 	request->lock = lock;
 	request->headers = NULL;
-	request->local_fileno = -1;
 	request->state = NEED_PUSH;
 	request->next = request_queue_head;
 	request_queue_head = request;
diff --git a/http-walker.c b/http-walker.c
index cea2755..496af79 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -3,8 +3,6 @@
 #include "walker.h"
 #include "http.h"

-#define PREV_BUF_SIZE 4096
-
 struct alt_base
 {
 	char *base;
@@ -25,20 +23,8 @@ struct object_request
 	struct walker *walker;
 	unsigned char sha1[20];
 	struct alt_base *repo;
-	char *url;
-	char filename[PATH_MAX];
-	char tmpfile[PATH_MAX];
-	int local;
 	enum object_request_state state;
-	CURLcode curl_result;
-	char errorstr[CURL_ERROR_SIZE];
-	long http_code;
-	unsigned char real_sha1[20];
-	git_SHA_CTX c;
-	z_stream stream;
-	int zret;
-	int rename;
-	struct active_request_slot *slot;
+	struct http_object_request *req;
 	struct object_request *next;
 };

@@ -59,34 +45,6 @@ struct walker_data {

 static struct object_request *object_queue_head;

-static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
-			       void *data)
-{
-	unsigned char expn[4096];
-	size_t size = eltsize * nmemb;
-	int posn = 0;
-	struct object_request *obj_req = (struct object_request *)data;
-	do {
-		ssize_t retval = xwrite(obj_req->local,
-					(char *) ptr + posn, size - posn);
-		if (retval < 0)
-			return posn;
-		posn += retval;
-	} while (posn < size);
-
-	obj_req->stream.avail_in = size;
-	obj_req->stream.next_in = ptr;
-	do {
-		obj_req->stream.next_out = expn;
-		obj_req->stream.avail_out = sizeof(expn);
-		obj_req->zret = git_inflate(&obj_req->stream, Z_SYNC_FLUSH);
-		git_SHA1_Update(&obj_req->c, expn,
-				sizeof(expn) - obj_req->stream.avail_out);
-	} while (obj_req->stream.avail_in && obj_req->zret == Z_OK);
-	data_received++;
-	return size;
-}
-
 static void fetch_alternates(struct walker *walker, const char *base);

 static void process_object_response(void *callback_data);
@@ -94,172 +52,35 @@ static void process_object_response(void *callback_data);
 static void start_object_request(struct walker *walker,
 				 struct object_request *obj_req)
 {
-	char *hex = sha1_to_hex(obj_req->sha1);
-	char prevfile[PATH_MAX];
-	char *url;
-	char *posn;
-	int prevlocal;
-	unsigned char prev_buf[PREV_BUF_SIZE];
-	ssize_t prev_read = 0;
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
 	struct active_request_slot *slot;
+	struct http_object_request *req;

-	snprintf(prevfile, sizeof(prevfile), "%s.prev", obj_req->filename);
-	unlink_or_warn(prevfile);
-	rename(obj_req->tmpfile, prevfile);
-	unlink_or_warn(obj_req->tmpfile);
-
-	if (obj_req->local != -1)
-		error("fd leakage in start: %d", obj_req->local);
-	obj_req->local = open(obj_req->tmpfile,
-			      O_WRONLY | O_CREAT | O_EXCL, 0666);
-	/*
-	 * This could have failed due to the "lazy directory creation";
-	 * try to mkdir the last path component.
-	 */
-	if (obj_req->local < 0 && errno == ENOENT) {
-		char *dir = strrchr(obj_req->tmpfile, '/');
-		if (dir) {
-			*dir = 0;
-			mkdir(obj_req->tmpfile, 0777);
-			*dir = '/';
-		}
-		obj_req->local = open(obj_req->tmpfile,
-				      O_WRONLY | O_CREAT | O_EXCL, 0666);
-	}
-
-	if (obj_req->local < 0) {
+	req = new_http_object_request(obj_req->repo->base, obj_req->sha1);
+	if (req == NULL) {
 		obj_req->state = ABORTED;
-		error("Couldn't create temporary file %s for %s: %s",
-		      obj_req->tmpfile, obj_req->filename, strerror(errno));
 		return;
 	}
+	obj_req->req = req;

-	memset(&obj_req->stream, 0, sizeof(obj_req->stream));
-
-	git_inflate_init(&obj_req->stream);
-
-	git_SHA1_Init(&obj_req->c);
-
-	url = xmalloc(strlen(obj_req->repo->base) + 51);
-	obj_req->url = xmalloc(strlen(obj_req->repo->base) + 51);
-	strcpy(url, obj_req->repo->base);
-	posn = url + strlen(obj_req->repo->base);
-	strcpy(posn, "/objects/");
-	posn += 9;
-	memcpy(posn, hex, 2);
-	posn += 2;
-	*(posn++) = '/';
-	strcpy(posn, hex + 2);
-	strcpy(obj_req->url, url);
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
-						     obj_req) == prev_read)
-					prev_posn += prev_read;
-				else
-					prev_read = -1;
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
-		memset(&obj_req->stream, 0, sizeof(obj_req->stream));
-		git_inflate_init(&obj_req->stream);
-		git_SHA1_Init(&obj_req->c);
-		if (prev_posn>0) {
-			prev_posn = 0;
-			lseek(obj_req->local, 0, SEEK_SET);
-			ftruncate(obj_req->local, 0);
-		}
-	}
-
-	slot = get_active_slot();
+	slot = req->slot;
 	slot->callback_func = process_object_response;
 	slot->callback_data = obj_req;
-	obj_req->slot = slot;
-
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, obj_req);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
-	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, obj_req->errorstr);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
-
-	/*
-	 * If we have successfully processed data from a previous fetch
-	 * attempt, only fetch the data we don't already have.
-	 */
-	if (prev_posn>0) {
-		if (walker->get_verbosely)
-			fprintf(stderr,
-				"Resuming fetch of object %s at byte %ld\n",
-				hex, prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(slot->curl,
-				 CURLOPT_HTTPHEADER, range_header);
-	}

 	/* Try to get the request started, abort the request on error */
 	obj_req->state = ACTIVE;
 	if (!start_active_slot(slot)) {
 		obj_req->state = ABORTED;
-		obj_req->slot = NULL;
-		close(obj_req->local);
-		obj_req->local = -1;
-		free(obj_req->url);
+		release_http_object_request(req);
 		return;
 	}
 }

 static void finish_object_request(struct object_request *obj_req)
 {
-	struct stat st;
-
-	close(obj_req->local);
-	obj_req->local = -1;
-
-	if (obj_req->http_code == 416) {
-		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
-	} else if (obj_req->curl_result != CURLE_OK) {
-		if (stat(obj_req->tmpfile, &st) == 0)
-			if (st.st_size == 0)
-				unlink_or_warn(obj_req->tmpfile);
+	if (finish_http_object_request(obj_req->req))
 		return;
-	}
-
-	git_inflate_end(&obj_req->stream);
-	git_SHA1_Final(obj_req->real_sha1, &obj_req->c);
-	if (obj_req->zret != Z_STREAM_END) {
-		unlink_or_warn(obj_req->tmpfile);
-		return;
-	}
-	if (hashcmp(obj_req->sha1, obj_req->real_sha1)) {
-		unlink_or_warn(obj_req->tmpfile);
-		return;
-	}
-	obj_req->rename =
-		move_temp_to_file(obj_req->tmpfile, obj_req->filename);

-	if (obj_req->rename == 0)
+	if (obj_req->req->rename == 0)
 		walker_say(obj_req->walker, "got %s\n", sha1_to_hex(obj_req->sha1));
 }

@@ -271,19 +92,16 @@ static void process_object_response(void *callback_data)
 	struct walker_data *data = walker->data;
 	struct alt_base *alt = data->alt;

-	obj_req->curl_result = obj_req->slot->curl_result;
-	obj_req->http_code = obj_req->slot->http_code;
-	obj_req->slot = NULL;
+	process_http_object_request(obj_req->req);
 	obj_req->state = COMPLETE;

 	/* Use alternates if necessary */
-	if (missing_target(obj_req)) {
+	if (missing_target(obj_req->req)) {
 		fetch_alternates(walker, alt->base);
 		if (obj_req->repo->next != NULL) {
 			obj_req->repo =
 				obj_req->repo->next;
-			close(obj_req->local);
-			obj_req->local = -1;
+			release_http_object_request(obj_req->req);
 			start_object_request(walker, obj_req);
 			return;
 		}
@@ -296,8 +114,8 @@ static void release_object_request(struct object_request *obj_req)
 {
 	struct object_request *entry = object_queue_head;

-	if (obj_req->local != -1)
-		error("fd leakage in release: %d", obj_req->local);
+	if (obj_req->req !=NULL && obj_req->req->localfile != -1)
+		error("fd leakage in release: %d", obj_req->req->localfile);
 	if (obj_req == object_queue_head) {
 		object_queue_head = obj_req->next;
 	} else {
@@ -307,7 +125,6 @@ static void release_object_request(struct object_request *obj_req)
 			entry->next = entry->next->next;
 	}

-	free(obj_req->url);
 	free(obj_req);
 }

@@ -341,13 +158,8 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 	newreq->walker = walker;
 	hashcpy(newreq->sha1, sha1);
 	newreq->repo = data->alt;
-	newreq->url = NULL;
-	newreq->local = -1;
 	newreq->state = WAITING;
-	snprintf(newreq->filename, sizeof(newreq->filename), "%s", filename);
-	snprintf(newreq->tmpfile, sizeof(newreq->tmpfile),
-		 "%s.temp", filename);
-	newreq->slot = NULL;
+	newreq->req = NULL;
 	newreq->next = NULL;

 	http_is_verbose = walker->get_verbosely;
@@ -638,15 +450,6 @@ abort:

 static void abort_object_request(struct object_request *obj_req)
 {
-	if (obj_req->local >= 0) {
-		close(obj_req->local);
-		obj_req->local = -1;
-	}
-	unlink_or_warn(obj_req->tmpfile);
-	if (obj_req->slot) {
-		release_active_slot(obj_req->slot);
-		obj_req->slot = NULL;
-	}
 	release_object_request(obj_req);
 }

@@ -655,6 +458,7 @@ static int fetch_object(struct walker *walker, struct alt_base *repo, unsigned c
 	char *hex = sha1_to_hex(sha1);
 	int ret = 0;
 	struct object_request *obj_req = object_queue_head;
+	struct http_object_request *req;

 	while (obj_req != NULL && hashcmp(obj_req->sha1, sha1))
 		obj_req = obj_req->next;
@@ -662,6 +466,8 @@ static int fetch_object(struct walker *walker, struct alt_base *repo, unsigned c
 		return error("Couldn't find request for %s in the queue", hex);

 	if (has_sha1_file(obj_req->sha1)) {
+		if (obj_req->req != NULL)
+			abort_http_object_request(obj_req->req);
 		abort_object_request(obj_req);
 		return 0;
 	}
@@ -673,34 +479,42 @@ static int fetch_object(struct walker *walker, struct alt_base *repo, unsigned c
 	start_object_request(walker, obj_req);
 #endif

+	/*
+	 * obj_req->req might change when fetching alternates in the callback
+	 * process_object_response; therefore, the "shortcut" variable, req,
+	 * is used only after we're done with slots.
+	 */
 	while (obj_req->state == ACTIVE)
-		run_active_slot(obj_req->slot);
+		run_active_slot(obj_req->req->slot);
+
+	req = obj_req->req;

-	if (obj_req->local != -1) {
-		close(obj_req->local);
-		obj_req->local = -1;
+	if (req->localfile != -1) {
+		close(req->localfile);
+		req->localfile = -1;
 	}

 	if (obj_req->state == ABORTED) {
 		ret = error("Request for %s aborted", hex);
-	} else if (obj_req->curl_result != CURLE_OK &&
-		   obj_req->http_code != 416) {
-		if (missing_target(obj_req))
+	} else if (req->curl_result != CURLE_OK &&
+		   req->http_code != 416) {
+		if (missing_target(req))
 			ret = -1; /* Be silent, it is probably in a pack. */
 		else
 			ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
-				    obj_req->errorstr, obj_req->curl_result,
-				    obj_req->http_code, hex);
-	} else if (obj_req->zret != Z_STREAM_END) {
+				    req->errorstr, req->curl_result,
+				    req->http_code, hex);
+	} else if (req->zret != Z_STREAM_END) {
 		walker->corrupt_object_found++;
-		ret = error("File %s (%s) corrupt", hex, obj_req->url);
-	} else if (hashcmp(obj_req->sha1, obj_req->real_sha1)) {
+		ret = error("File %s (%s) corrupt", hex, req->url);
+	} else if (hashcmp(obj_req->sha1, req->real_sha1)) {
 		ret = error("File %s has bad hash", hex);
-	} else if (obj_req->rename < 0) {
+	} else if (req->rename < 0) {
 		ret = error("unable to write sha1 filename %s",
-			    obj_req->filename);
+			    req->filename);
 	}

+	release_http_object_request(req);
 	release_object_request(obj_req);
 	return ret;
 }
diff --git a/http.c b/http.c
index 2b4aaaa..6a417a4 100644
--- a/http.c
+++ b/http.c
@@ -12,6 +12,10 @@ static CURLM *curlm;
 #ifndef NO_CURL_EASY_DUPHANDLE
 static CURL *curl_default;
 #endif
+
+#define PREV_BUF_SIZE 4096
+#define RANGE_HEADER_SIZE 30
+
 char curl_errorstr[CURL_ERROR_SIZE];

 static int curl_ssl_verify = -1;
@@ -30,8 +34,7 @@ static const char *curl_http_proxy;
 static char *user_name, *user_pass;

 static struct curl_slist *pragma_header;
-
-struct curl_slist *no_pragma_header;
+static struct curl_slist *no_pragma_header;

 static struct active_request_slot *active_queue_head;

@@ -666,6 +669,23 @@ static char *quote_ref_url(const char *base, const char *ref)
 	return strbuf_detach(&buf, NULL);
 }

+void append_remote_object_url(struct strbuf *buf, const char *url,
+			      const char *hex,
+			      int only_two_digit_prefix)
+{
+	strbuf_addf(buf, "%s/objects/%.*s/", url, 2, hex);
+	if (!only_two_digit_prefix)
+		strbuf_addf(buf, "%s", hex+2);
+}
+
+char *get_remote_object_url(const char *url, const char *hex,
+			    int only_two_digit_prefix)
+{
+	struct strbuf buf = STRBUF_INIT;
+	append_remote_object_url(&buf, url, hex, only_two_digit_prefix);
+	return strbuf_detach(&buf, NULL);
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -996,3 +1016,229 @@ abort:
 	free(filename);
 	return NULL;
 }
+
+/* Helpers for fetching objects (loose) */
+static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
+			       void *data)
+{
+	unsigned char expn[4096];
+	size_t size = eltsize * nmemb;
+	int posn = 0;
+	struct http_object_request *freq =
+		(struct http_object_request *)data;
+	do {
+		ssize_t retval = xwrite(freq->localfile,
+					(char *) ptr + posn, size - posn);
+		if (retval < 0)
+			return posn;
+		posn += retval;
+	} while (posn < size);
+
+	freq->stream.avail_in = size;
+	freq->stream.next_in = ptr;
+	do {
+		freq->stream.next_out = expn;
+		freq->stream.avail_out = sizeof(expn);
+		freq->zret = git_inflate(&freq->stream, Z_SYNC_FLUSH);
+		git_SHA1_Update(&freq->c, expn,
+				sizeof(expn) - freq->stream.avail_out);
+	} while (freq->stream.avail_in && freq->zret == Z_OK);
+	data_received++;
+	return size;
+}
+
+struct http_object_request *new_http_object_request(const char *base_url,
+	unsigned char *sha1)
+{
+	char *hex = sha1_to_hex(sha1);
+	char *filename;
+	char prevfile[PATH_MAX];
+	char *url;
+	int prevlocal;
+	unsigned char prev_buf[PREV_BUF_SIZE];
+	ssize_t prev_read = 0;
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct curl_slist *range_header = NULL;
+	struct http_object_request *freq;
+
+	freq = xmalloc(sizeof(*freq));
+	hashcpy(freq->sha1, sha1);
+	freq->localfile = -1;
+
+	filename = sha1_file_name(sha1);
+	snprintf(freq->filename, sizeof(freq->filename), "%s", filename);
+	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
+		 "%s.temp", filename);
+
+	snprintf(prevfile, sizeof(prevfile), "%s.prev", filename);
+	unlink_or_warn(prevfile);
+	rename(freq->tmpfile, prevfile);
+	unlink_or_warn(freq->tmpfile);
+
+	if (freq->localfile != -1)
+		error("fd leakage in start: %d", freq->localfile);
+	freq->localfile = open(freq->tmpfile,
+			       O_WRONLY | O_CREAT | O_EXCL, 0666);
+	/*
+	 * This could have failed due to the "lazy directory creation";
+	 * try to mkdir the last path component.
+	 */
+	if (freq->localfile < 0 && errno == ENOENT) {
+		char *dir = strrchr(freq->tmpfile, '/');
+		if (dir) {
+			*dir = 0;
+			mkdir(freq->tmpfile, 0777);
+			*dir = '/';
+		}
+		freq->localfile = open(freq->tmpfile,
+				       O_WRONLY | O_CREAT | O_EXCL, 0666);
+	}
+
+	if (freq->localfile < 0) {
+		error("Couldn't create temporary file %s for %s: %s",
+		      freq->tmpfile, freq->filename, strerror(errno));
+		goto abort;
+	}
+
+	memset(&freq->stream, 0, sizeof(freq->stream));
+
+	git_inflate_init(&freq->stream);
+
+	git_SHA1_Init(&freq->c);
+
+	url = get_remote_object_url(base_url, hex, 0);
+	freq->url = xstrdup(url);
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
+						     freq) == prev_read) {
+					prev_posn += prev_read;
+				} else {
+					prev_read = -1;
+				}
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
+		memset(&freq->stream, 0, sizeof(freq->stream));
+		git_inflate_init(&freq->stream);
+		git_SHA1_Init(&freq->c);
+		if (prev_posn>0) {
+			prev_posn = 0;
+			lseek(freq->localfile, 0, SEEK_SET);
+			ftruncate(freq->localfile, 0);
+		}
+	}
+
+	freq->slot = get_active_slot();
+
+	curl_easy_setopt(freq->slot->curl, CURLOPT_FILE, freq);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
+
+	/*
+	 * If we have successfully processed data from a previous fetch
+	 * attempt, only fetch the data we don't already have.
+	 */
+	if (prev_posn>0) {
+		if (http_is_verbose)
+			fprintf(stderr,
+				"Resuming fetch of object %s at byte %ld\n",
+				hex, prev_posn);
+		sprintf(range, "Range: bytes=%ld-", prev_posn);
+		range_header = curl_slist_append(range_header, range);
+		curl_easy_setopt(freq->slot->curl,
+				 CURLOPT_HTTPHEADER, range_header);
+	}
+
+	return freq;
+
+	free(url);
+abort:
+	free(filename);
+	free(freq);
+	return NULL;
+}
+
+void process_http_object_request(struct http_object_request *freq)
+{
+	if (freq->slot == NULL)
+		return;
+	freq->curl_result = freq->slot->curl_result;
+	freq->http_code = freq->slot->http_code;
+	freq->slot = NULL;
+}
+
+int finish_http_object_request(struct http_object_request *freq)
+{
+	struct stat st;
+
+	close(freq->localfile);
+	freq->localfile = -1;
+
+	process_http_object_request(freq);
+
+	if (freq->http_code == 416) {
+		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
+	} else if (freq->curl_result != CURLE_OK) {
+		if (stat(freq->tmpfile, &st) == 0)
+			if (st.st_size == 0)
+				unlink_or_warn(freq->tmpfile);
+		return -1;
+	}
+
+	git_inflate_end(&freq->stream);
+	git_SHA1_Final(freq->real_sha1, &freq->c);
+	if (freq->zret != Z_STREAM_END) {
+		unlink_or_warn(freq->tmpfile);
+		return -1;
+	}
+	if (hashcmp(freq->sha1, freq->real_sha1)) {
+		unlink_or_warn(freq->tmpfile);
+		return -1;
+	}
+	freq->rename =
+		move_temp_to_file(freq->tmpfile, freq->filename);
+
+	return freq->rename;
+}
+
+void abort_http_object_request(struct http_object_request *freq)
+{
+	unlink_or_warn(freq->tmpfile);
+
+	release_http_object_request(freq);
+}
+
+void release_http_object_request(struct http_object_request *freq)
+{
+	if (freq->localfile != -1) {
+		close(freq->localfile);
+		freq->localfile = -1;
+	}
+	if (freq->url != NULL) {
+		free(freq->url);
+		freq->url = NULL;
+	}
+	freq->slot = NULL;
+}
diff --git a/http.h b/http.h
index 511c0c4..4c4e99c 100644
--- a/http.h
+++ b/http.h
@@ -88,10 +88,6 @@ extern void add_fill_function(void *data, int (*fill)(void *));
 extern void step_active_slots(void);
 #endif

-extern struct curl_slist *no_pragma_header;
-
-#define RANGE_HEADER_SIZE 30
-
 extern void http_init(struct remote *remote);
 extern void http_cleanup(void);

@@ -114,6 +110,13 @@ static inline int missing__target(int code, int result)

 #define missing_target(a) missing__target((a)->http_code, (a)->curl_result)

+/* Helpers for modifying and creating URLs */
+extern void append_remote_object_url(struct strbuf *buf, const char *url,
+				     const char *hex,
+				     int only_two_digit_prefix);
+extern char *get_remote_object_url(const char *url, const char *hex,
+				   int only_two_digit_prefix);
+
 /* Options for http_request_*() */
 #define HTTP_NO_CACHE		1

@@ -167,4 +170,30 @@ extern struct http_pack_request *new_http_pack_request(
 extern int finish_http_pack_request(struct http_pack_request *preq);
 extern void release_http_pack_request(struct http_pack_request *preq);

+/* Helpers for fetching object */
+struct http_object_request
+{
+	char *url;
+	char filename[PATH_MAX];
+	char tmpfile[PATH_MAX];
+	int localfile;
+	CURLcode curl_result;
+	char errorstr[CURL_ERROR_SIZE];
+	long http_code;
+	unsigned char sha1[20];
+	unsigned char real_sha1[20];
+	git_SHA_CTX c;
+	z_stream stream;
+	int zret;
+	int rename;
+	struct active_request_slot *slot;
+};
+
+extern struct http_object_request *new_http_object_request(
+	const char *base_url, unsigned char *sha1);
+extern void process_http_object_request(struct http_object_request *freq);
+extern int finish_http_object_request(struct http_object_request *freq);
+extern void abort_http_object_request(struct http_object_request *freq);
+extern void release_http_object_request(struct http_object_request *freq);
+
 #endif /* HTTP_H */
--
1.6.3.1
