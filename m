From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 5/6] http-push: support for updating remote info/refs
Date: Fri, 10 Mar 2006 20:18:18 -0800
Message-ID: <20060311041818.GG3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 11 05:18:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHvYe-0004ul-Dm
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 05:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWCKESU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 23:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWCKESU
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 23:18:20 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:23264 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932413AbWCKEST (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 23:18:19 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2B4IIFb007668
	for <git@vger.kernel.org>; Fri, 10 Mar 2006 20:18:18 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2B4IIcD007666
	for git@vger.kernel.org; Fri, 10 Mar 2006 20:18:18 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17489>

If info/refs exists on the remote, get a lock on info/refs, make sure that
there is a local copy of the object referenced in each remote ref (in case
someone else added a tag we don't have locally), do all the refspec updates,
and generate and send an updated info/refs file.

---

 http-push.c |  547 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 536 insertions(+), 11 deletions(-)

b29c6a3ec299241894a3effd8cea4d00ea117a8c
diff --git a/http-push.c b/http-push.c
index ece40da..65c6664 100644
--- a/http-push.c
+++ b/http-push.c
@@ -22,6 +22,7 @@ enum XML_Status {
 #define XML_STATUS_ERROR 0
 #endif
 
+#define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
 
 /* DAV methods */
@@ -58,9 +59,10 @@ enum XML_Status {
 
 /* bits #0-4 in revision.h */
 
-#define LOCAL   (1u << 5)
-#define REMOTE  (1u << 6)
-#define PUSHING (1u << 7)
+#define LOCAL    (1u << 5)
+#define REMOTE   (1u << 6)
+#define FETCHING (1u << 7)
+#define PUSHING  (1u << 8)
 
 static int pushing = 0;
 static int aborted = 0;
@@ -79,6 +81,9 @@ struct repo
 {
 	char *url;
 	int path_len;
+	int has_info_refs;
+	int can_update_info_refs;
+	int has_info_packs;
 	struct packed_git *packs;
 	struct remote_lock *locks;
 };
@@ -86,6 +91,9 @@ struct repo
 static struct repo *remote = NULL;
 
 enum transfer_state {
+	NEED_FETCH,
+	RUN_FETCH_LOOSE,
+	RUN_FETCH_PACKED,
 	NEED_PUSH,
 	RUN_MKCOL,
 	RUN_PUT,
@@ -104,6 +112,8 @@ struct transfer_request
 	struct buffer buffer;
 	char filename[PATH_MAX];
 	char tmpfile[PATH_MAX];
+	int local_fileno;
+	FILE *local_stream;
 	enum transfer_state state;
 	CURLcode curl_result;
 	char errorstr[CURL_ERROR_SIZE];
@@ -113,6 +123,7 @@ struct transfer_request
 	z_stream stream;
 	int zret;
 	int rename;
+	void *userData;
 	struct active_request_slot *slot;
 	struct transfer_request *next;
 };
@@ -159,6 +170,7 @@ struct remote_ls_ctx
 };
 
 static void finish_request(struct transfer_request *request);
+static void release_request(struct transfer_request *request);
 
 static void process_response(void *callback_data)
 {
@@ -168,6 +180,258 @@ static void process_response(void *callb
 	finish_request(request);
 }
 
+static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
+			       void *data)
+{
+	unsigned char expn[4096];
+	size_t size = eltsize * nmemb;
+	int posn = 0;
+	struct transfer_request *request = (struct transfer_request *)data;
+	do {
+		ssize_t retval = write(request->local_fileno,
+				       ptr + posn, size - posn);
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
+		request->zret = inflate(&request->stream, Z_SYNC_FLUSH);
+		SHA1_Update(&request->c, expn,
+			    sizeof(expn) - request->stream.avail_out);
+	} while (request->stream.avail_in && request->zret == Z_OK);
+	data_received++;
+	return size;
+}
+
+static void start_fetch_loose(struct transfer_request *request)
+{
+	char *hex = sha1_to_hex(request->obj->sha1);
+	char *filename;
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
+	filename = sha1_file_name(request->obj->sha1);
+	snprintf(request->filename, sizeof(request->filename), "%s", filename);
+	snprintf(request->tmpfile, sizeof(request->tmpfile),
+		 "%s.temp", filename);
+
+	snprintf(prevfile, sizeof(prevfile), "%s.prev", request->filename);
+	unlink(prevfile);
+	rename(request->tmpfile, prevfile);
+	unlink(request->tmpfile);
+
+	if (request->local_fileno != -1)
+		error("fd leakage in start: %d", request->local_fileno);
+	request->local_fileno = open(request->tmpfile,
+				     O_WRONLY | O_CREAT | O_EXCL, 0666);
+	/* This could have failed due to the "lazy directory creation";
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
+		request->state = ABORTED;
+		error("Couldn't create temporary file %s for %s: %s",
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
+	url = xmalloc(strlen(remote->url) + 50);
+	request->url = xmalloc(strlen(remote->url) + 50);
+	strcpy(url, remote->url);
+	posn = url + strlen(remote->url);
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
+			lseek(request->local_fileno, SEEK_SET, 0);
+			ftruncate(request->local_fileno, 0);
+		}
+	}
+
+	slot = get_active_slot();
+	slot->callback_func = process_response;
+	slot->callback_data = request;
+	request->slot = slot;
+
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, request);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
+	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
+
+	/* If we have successfully processed data from a previous fetch
+	   attempt, only fetch the data we don't already have. */
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
+
+	/* Try to get the request started, abort the request on error */
+	request->state = RUN_FETCH_LOOSE;
+	if (!start_active_slot(slot)) {
+		fprintf(stderr, "Unable to start GET request\n");
+		remote->can_update_info_refs = 0;
+		release_request(request);
+	}
+}
+
+static void start_fetch_packed(struct transfer_request *request)
+{
+	char *url;
+	struct packed_git *target;
+	FILE *packfile;
+	char *filename;
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct curl_slist *range_header = NULL;
+
+	struct transfer_request *check_request = request_queue_head;
+	struct active_request_slot *slot;
+
+	target = find_sha1_pack(request->obj->sha1, remote->packs);
+	if (!target) {
+		fprintf(stderr, "Unable to fetch %s, will not be able to update server info refs\n", sha1_to_hex(request->obj->sha1));
+		remote->can_update_info_refs = 0;
+		release_request(request);
+		return;
+	}
+
+	fprintf(stderr,	"Fetching pack %s\n", sha1_to_hex(target->sha1));
+	fprintf(stderr, " which contains %s\n", sha1_to_hex(request->obj->sha1));
+
+	filename = sha1_pack_name(target->sha1);
+	snprintf(request->filename, sizeof(request->filename), "%s", filename);
+	snprintf(request->tmpfile, sizeof(request->tmpfile),
+		 "%s.temp", filename);
+
+	url = xmalloc(strlen(remote->url) + 64);
+	sprintf(url, "%sobjects/pack/pack-%s.pack",
+		remote->url, sha1_to_hex(target->sha1));
+
+	/* Make sure there isn't another open request for this pack */
+	while (check_request) {
+		if (check_request->state == RUN_FETCH_PACKED &&
+		    !strcmp(check_request->url, url)) {
+			free(url);
+			release_request(request);
+			return;
+		}
+		check_request = check_request->next;
+	}
+
+	packfile = fopen(request->tmpfile, "a");
+	if (!packfile) {
+		fprintf(stderr, "Unable to open local file %s for pack",
+			filename);
+		remote->can_update_info_refs = 0;
+		free(url);
+		return;
+	}
+
+	slot = get_active_slot();
+	slot->callback_func = process_response;
+	slot->callback_data = request;
+	request->slot = slot;
+	request->local_stream = packfile;
+	request->userData = target;
+
+	request->url = url;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, packfile);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
+	slot->local = packfile;
+
+	/* If there is data present from a previous transfer attempt,
+	   resume where it left off */
+	prev_posn = ftell(packfile);
+	if (prev_posn>0) {
+		if (push_verbosely)
+			fprintf(stderr,
+				"Resuming fetch of pack %s at byte %ld\n",
+				sha1_to_hex(target->sha1), prev_posn);
+		sprintf(range, "Range: bytes=%ld-", prev_posn);
+		range_header = curl_slist_append(range_header, range);
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
+	}
+
+	/* Try to get the request started, abort the request on error */
+	request->state = RUN_FETCH_PACKED;
+	if (!start_active_slot(slot)) {
+		fprintf(stderr, "Unable to start GET request\n");
+		remote->can_update_info_refs = 0;
+		release_request(request);
+	}
+}
+
 static void start_mkcol(struct transfer_request *request)
 {
 	char *hex = sha1_to_hex(request->obj->sha1);
@@ -388,6 +652,10 @@ static void release_request(struct trans
 			entry->next = entry->next->next;
 	}
 
+	if (request->local_fileno != -1)
+		close(request->local_fileno);
+	if (request->local_stream)
+		fclose(request->local_stream);
 	if (request->url != NULL)
 		free(request->url);
 	free(request);
@@ -395,7 +663,11 @@ static void release_request(struct trans
 
 static void finish_request(struct transfer_request *request)
 {
-	request->curl_result =	request->slot->curl_result;
+	struct stat st;
+	struct packed_git *target;
+	struct packed_git **lst;
+
+	request->curl_result = request->slot->curl_result;
 	request->http_code = request->slot->http_code;
 	request->slot = NULL;
 
@@ -437,7 +709,6 @@ static void finish_request(struct transf
 		if (request->curl_result == CURLE_OK) {
 			fprintf(stderr, "    sent %s\n",
 				sha1_to_hex(request->obj->sha1));
-			request->state = COMPLETE;
 			request->obj->flags |= REMOTE;
 			release_request(request);
 		} else {
@@ -447,12 +718,73 @@ static void finish_request(struct transf
 			request->state = ABORTED;
 			aborted = 1;
 		}
+	} else if (request->state == RUN_FETCH_LOOSE) {
+		fchmod(request->local_fileno, 0444);
+		close(request->local_fileno); request->local_fileno = -1;
+
+		if (request->curl_result != CURLE_OK &&
+		    request->http_code != 416) {
+			if (stat(request->tmpfile, &st) == 0) {
+				if (st.st_size == 0)
+					unlink(request->tmpfile);
+			}
+		} else {
+			if (request->http_code == 416)
+				fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
+
+			inflateEnd(&request->stream);
+			SHA1_Final(request->real_sha1, &request->c);
+			if (request->zret != Z_STREAM_END) {
+				unlink(request->tmpfile);
+			} else if (memcmp(request->obj->sha1, request->real_sha1, 20)) {
+				unlink(request->tmpfile);
+			} else {
+				request->rename =
+					move_temp_to_file(
+						request->tmpfile,
+						request->filename);
+				if (request->rename == 0) {
+					request->obj->flags |= (LOCAL | REMOTE);
+				}
+			}
+		}
+
+		/* Try fetching packed if necessary */
+		if (request->obj->flags & LOCAL)
+			release_request(request);
+		else
+			start_fetch_packed(request);
+
+	} else if (request->state == RUN_FETCH_PACKED) {
+		if (request->curl_result != CURLE_OK) {
+			fprintf(stderr, "Unable to get pack file %s\n%s",
+				request->url, curl_errorstr);
+			remote->can_update_info_refs = 0;
+		} else {
+			fclose(request->local_stream);
+			request->local_stream = NULL;
+			if (!move_temp_to_file(request->tmpfile,
+					       request->filename)) {
+				target = (struct packed_git *)request->userData;
+				lst = &remote->packs;
+				while (*lst != target)
+					lst = &((*lst)->next);
+				*lst = (*lst)->next;
+
+				if (!verify_pack(target, 0))
+					install_packed_git(target);
+				else
+					remote->can_update_info_refs = 0;
+			}
+		}
+		release_request(request);
 	}
 }
 
 void fill_active_slots(void)
 {
 	struct transfer_request *request = request_queue_head;
+	struct transfer_request *next;
 	struct active_request_slot *slot = active_queue_head;
 	int num_transfers;
 
@@ -460,7 +792,10 @@ void fill_active_slots(void)
 		return;
 
 	while (active_requests < max_requests && request != NULL) {
-		if (pushing && request->state == NEED_PUSH) {
+		next = request->next;
+		if (request->state == NEED_FETCH) {
+			start_fetch_loose(request);
+		} else if (pushing && request->state == NEED_PUSH) {
 			if (remote_dir_exists[request->obj->sha1[0]] == 1) {
 				start_put(request);
 			} else {
@@ -468,7 +803,7 @@ void fill_active_slots(void)
 			}
 			curl_multi_perform(curlm, &num_transfers);
 		}
-		request = request->next;
+		request = next;
 	}
 
 	while (slot != NULL) {
@@ -482,7 +817,38 @@ void fill_active_slots(void)
 
 static void get_remote_object_list(unsigned char parent);
 
-static void add_request(struct object *obj, struct remote_lock *lock)
+static void add_fetch_request(struct object *obj)
+{
+	struct transfer_request *request;
+
+	check_locks();
+
+	/*
+	 * Don't fetch the object if it's known to exist locally
+	 * or is already in the request queue
+	 */
+	if (remote_dir_exists[obj->sha1[0]] == -1)
+		get_remote_object_list(obj->sha1[0]);
+	if (obj->flags & (LOCAL | FETCHING))
+		return;
+
+	obj->flags |= FETCHING;
+	request = xmalloc(sizeof(*request));
+	request->obj = obj;
+	request->url = NULL;
+	request->lock = NULL;
+	request->headers = NULL;
+	request->local_fileno = -1;
+	request->local_stream = NULL;
+	request->state = NEED_FETCH;
+	request->next = request_queue_head;
+	request_queue_head = request;
+
+	fill_active_slots();
+	step_active_slots();
+}
+
+static void add_send_request(struct object *obj, struct remote_lock *lock)
 {
 	struct transfer_request *request = request_queue_head;
 	struct packed_git *target;
@@ -510,6 +876,8 @@ static void add_request(struct object *o
 	request->url = NULL;
 	request->lock = lock;
 	request->headers = NULL;
+	request->local_fileno = -1;
+	request->local_stream = NULL;
 	request->state = NEED_PUSH;
 	request->next = request_queue_head;
 	request_queue_head = request;
@@ -1375,7 +1743,7 @@ static void get_delta(struct rev_info *r
 		p = process_tree(commit->tree, p, NULL, "");
 		commit->object.flags |= LOCAL;
 		if (!(commit->object.flags & UNINTERESTING))
-			add_request(&commit->object, lock);
+			add_send_request(&commit->object, lock);
 	}
 
 	for (pending = revs->pending_objects; pending; pending = pending->next) {
@@ -1402,7 +1770,7 @@ static void get_delta(struct rev_info *r
 
 	while (objects) {
 		if (!(objects->item->flags & UNINTERESTING))
-			add_request(objects->item, lock);
+			add_send_request(objects->item, lock);
 		objects = objects->next;
 	}
 }
@@ -1483,6 +1851,7 @@ static void one_remote_ref(char *refname
 {
 	struct ref *ref;
 	unsigned char remote_sha1[20];
+	struct object *obj;
 
 	if (fetch_ref(refname, remote_sha1) != 0) {
 		fprintf(stderr,
@@ -1491,6 +1860,19 @@ static void one_remote_ref(char *refname
 		return;
 	}
 
+	/*
+	 * Fetch a copy of the object if it doesn't exist locally - it
+	 * may be required for updating server info later.
+	 */
+	if (remote->can_update_info_refs && !has_sha1_file(remote_sha1)) {
+		obj = lookup_unknown_object(remote_sha1);
+		if (obj) {
+			fprintf(stderr,	"  fetch %s for %s\n",
+				sha1_to_hex(remote_sha1), refname);
+			add_fetch_request(obj);
+		}
+	}
+
 	int len = strlen(refname) + 1;
 	ref = xcalloc(1, sizeof(*ref) + len);
 	memcpy(ref->old_sha1, remote_sha1, 20);
@@ -1596,6 +1978,125 @@ static void mark_edges_uninteresting(str
 	}
 }
 
+static void add_remote_info_ref(struct remote_ls_ctx *ls)
+{
+	struct buffer *buf = (struct buffer *)ls->userData;
+	unsigned char remote_sha1[20];
+	struct object *o;
+	int len;
+	char *ref_info;
+
+	if (fetch_ref(ls->dentry_name, remote_sha1) != 0) {
+		fprintf(stderr,
+			"Unable to fetch ref %s from %s\n",
+			ls->dentry_name, remote->url);
+		aborted = 1;
+		return;
+	}
+
+	o = parse_object(remote_sha1);
+	if (!o) {
+		fprintf(stderr,
+			"Unable to parse object %s for remote ref %s\n",
+			sha1_to_hex(remote_sha1), ls->dentry_name);
+		aborted = 1;
+		return;
+	}
+
+	len = strlen(ls->dentry_name) + 42;
+	ref_info = xcalloc(len + 1, 1);
+	sprintf(ref_info, "%s	%s\n",
+		sha1_to_hex(remote_sha1), ls->dentry_name);
+	fwrite_buffer(ref_info, 1, len, buf);
+	free(ref_info);
+
+	if (o->type == tag_type) {
+		o = deref_tag(o, ls->dentry_name, 0);
+		if (o) {
+			len = strlen(ls->dentry_name) + 45;
+			ref_info = xcalloc(len + 1, 1);
+			sprintf(ref_info, "%s	%s^{}\n",
+				sha1_to_hex(o->sha1), ls->dentry_name);
+			fwrite_buffer(ref_info, 1, len, buf);
+			free(ref_info);
+		}
+	}
+}
+
+static void update_remote_info_refs(struct remote_lock *lock)
+{
+	struct buffer buffer;
+	struct active_request_slot *slot;
+	struct slot_results results;
+	char *if_header;
+	struct curl_slist *dav_headers = NULL;
+
+	buffer.buffer = xmalloc(4096);
+	memset(buffer.buffer, 0, 4096);
+	buffer.size = 4096;
+	buffer.posn = 0;
+	remote_ls("refs/", (PROCESS_FILES | RECURSIVE),
+		  add_remote_info_ref, &buffer);
+	if (!aborted) {
+		if_header = xmalloc(strlen(lock->token) + 25);
+		sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
+		dav_headers = curl_slist_append(dav_headers, if_header);
+
+		slot = get_active_slot();
+		slot->results = &results;
+		curl_easy_setopt(slot->curl, CURLOPT_INFILE, &buffer);
+		curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, buffer.posn);
+		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
+		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
+		curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
+		curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_PUT, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
+				
+		buffer.posn = 0;
+
+		if (start_active_slot(slot)) {
+			run_active_slot(slot);
+			if (results.curl_result != CURLE_OK) {
+				fprintf(stderr,
+					"PUT error: curl result=%d, HTTP code=%ld\n",
+					results.curl_result, results.http_code);
+			}
+		}
+		free(if_header);
+	}
+	free(buffer.buffer);
+}
+
+static int remote_exists(const char *path)
+{
+	char *url = xmalloc(strlen(remote->url) + strlen(path) + 1);
+	struct active_request_slot *slot;
+	struct slot_results results;
+
+	sprintf(url, "%s%s", remote->url, path);
+
+        slot = get_active_slot();
+	slot->results = &results;
+        curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+        curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
+
+        if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.http_code == 404)
+			return 0;
+		else if (results.curl_result == CURLE_OK)
+			return 1;
+		else
+			fprintf(stderr, "HEAD HTTP error %ld\n", results.http_code);
+	} else {
+		fprintf(stderr, "Unable to start HEAD request\n");
+	}
+
+	return -1;
+}
+
 int main(int argc, char **argv)
 {
 	struct transfer_request *request;
@@ -1603,6 +2104,7 @@ int main(int argc, char **argv)
 	int nr_refspec = 0;
 	char **refspec = NULL;
 	struct remote_lock *ref_lock = NULL;
+	struct remote_lock *info_ref_lock = NULL;
 	struct rev_info revs;
 	int rc = 0;
 	int i;
@@ -1667,6 +2169,18 @@ int main(int argc, char **argv)
 		goto cleanup;
 	}
 
+	/* Check whether the remote has server info files */
+	remote->can_update_info_refs = 0;
+	remote->has_info_refs = remote_exists("info/refs");
+	remote->has_info_packs = remote_exists("objects/info/packs");
+	if (remote->has_info_refs) {
+		info_ref_lock = lock_remote("info/refs", LOCK_TIME);
+		if (info_ref_lock)
+			remote->can_update_info_refs = 1;
+	}
+	if (remote->has_info_packs)
+		fetch_indices();
+
 	/* Get a list of all local and remote heads to validate refspecs */
 	get_local_heads();
 	fprintf(stderr, "Fetching remote heads...\n");
@@ -1769,7 +2283,6 @@ int main(int argc, char **argv)
 		pushing = 0;
 		prepare_revision_walk(&revs);
 		mark_edges_uninteresting(revs.commits);
-		fetch_indices();
 		get_delta(&revs, ref_lock);
 		finish_all_active_slots();
 
@@ -1792,6 +2305,18 @@ int main(int argc, char **argv)
 		check_locks();
 	}
 
+	/* Update remote server info if appropriate */
+	if (remote->has_info_refs && new_refs) {
+		if (info_ref_lock && remote->can_update_info_refs) {
+			fprintf(stderr, "Updating remote server info\n");
+			update_remote_info_refs(info_ref_lock);
+		} else {
+			fprintf(stderr, "Unable to update server info\n");
+		}
+	}
+	if (info_ref_lock)
+		unlock_remote(info_ref_lock);
+
  cleanup:
 	free(remote);
 
-- 
1.2.4.g8e81-dirty
