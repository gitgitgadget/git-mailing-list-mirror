From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line 
 lengths)
Date: Mon, 16 Mar 2009 23:47:16 -0700
Message-ID: <7v4oxstzm3.fsf@gitster.siamese.dyndns.org>
References: <d8c371a80903162215k4c27762cva650ea64d7850afa@mail.gmail.com>
 <7v8wn4u0ip.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Amos King <amos.l.king@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 07:57:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjTEm-0003wx-EN
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 07:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbZCQGrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 02:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbZCQGrZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 02:47:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbZCQGrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 02:47:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 75CF26520;
	Tue, 17 Mar 2009 02:47:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 311B8651D; Tue,
 17 Mar 2009 02:47:18 -0400 (EDT)
In-Reply-To: <7v8wn4u0ip.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 16 Mar 2009 23:27:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 77BE980C-12BF-11DE-8021-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113425>

Junio C Hamano <gitster@pobox.com> writes:

> That is, something along these lines (this comes on top of an obvious
> patch that renames existing "remote" variable in http-push. to "repo").

And to save you the trouble, here is the "obvious" renaming patch, that
applies on top of 750d930 (http.c: CURLOPT_NETRC_OPTIONAL is not available
in ancient versions of cURL, 2009-03-12).

diff --git a/http-push.c b/http-push.c
index 30d2d34..dfbb247 100644
--- a/http-push.c
+++ b/http-push.c
@@ -97,7 +97,7 @@ struct repo
 	struct remote_lock *locks;
 };
 
-static struct repo *remote;
+static struct repo *repo;
 
 enum transfer_state {
 	NEED_FETCH,
@@ -324,7 +324,7 @@ static void start_fetch_loose(struct transfer_request *request)
 
 	git_SHA1_Init(&request->c);
 
-	url = get_remote_object_url(remote->url, hex, 0);
+	url = get_remote_object_url(repo->url, hex, 0);
 	request->url = xstrdup(url);
 
 	/* If a previous temp file is present, process what was already
@@ -389,7 +389,7 @@ static void start_fetch_loose(struct transfer_request *request)
 	request->state = RUN_FETCH_LOOSE;
 	if (!start_active_slot(slot)) {
 		fprintf(stderr, "Unable to start GET request\n");
-		remote->can_update_info_refs = 0;
+		repo->can_update_info_refs = 0;
 		release_request(request);
 	}
 }
@@ -399,7 +399,7 @@ static void start_mkcol(struct transfer_request *request)
 	char *hex = sha1_to_hex(request->obj->sha1);
 	struct active_request_slot *slot;
 
-	request->url = get_remote_object_url(remote->url, hex, 1);
+	request->url = get_remote_object_url(repo->url, hex, 1);
 
 	slot = get_active_slot();
 	slot->callback_func = process_response;
@@ -434,10 +434,10 @@ static void start_fetch_packed(struct transfer_request *request)
 	struct transfer_request *check_request = request_queue_head;
 	struct active_request_slot *slot;
 
-	target = find_sha1_pack(request->obj->sha1, remote->packs);
+	target = find_sha1_pack(request->obj->sha1, repo->packs);
 	if (!target) {
 		fprintf(stderr, "Unable to fetch %s, will not be able to update server info refs\n", sha1_to_hex(request->obj->sha1));
-		remote->can_update_info_refs = 0;
+		repo->can_update_info_refs = 0;
 		release_request(request);
 		return;
 	}
@@ -450,9 +450,9 @@ static void start_fetch_packed(struct transfer_request *request)
 	snprintf(request->tmpfile, sizeof(request->tmpfile),
 		 "%s.temp", filename);
 
-	url = xmalloc(strlen(remote->url) + 64);
+	url = xmalloc(strlen(repo->url) + 64);
 	sprintf(url, "%sobjects/pack/pack-%s.pack",
-		remote->url, sha1_to_hex(target->sha1));
+		repo->url, sha1_to_hex(target->sha1));
 
 	/* Make sure there isn't another open request for this pack */
 	while (check_request) {
@@ -469,7 +469,7 @@ static void start_fetch_packed(struct transfer_request *request)
 	if (!packfile) {
 		fprintf(stderr, "Unable to open local file %s for pack",
 			request->tmpfile);
-		remote->can_update_info_refs = 0;
+		repo->can_update_info_refs = 0;
 		free(url);
 		return;
 	}
@@ -505,7 +505,7 @@ static void start_fetch_packed(struct transfer_request *request)
 	request->state = RUN_FETCH_PACKED;
 	if (!start_active_slot(slot)) {
 		fprintf(stderr, "Unable to start GET request\n");
-		remote->can_update_info_refs = 0;
+		repo->can_update_info_refs = 0;
 		release_request(request);
 	}
 }
@@ -554,10 +554,10 @@ static void start_put(struct transfer_request *request)
 	request->buffer.buf.len = stream.total_out;
 
 	strbuf_addstr(&buf, "Destination: ");
-	append_remote_object_url(&buf, remote->url, hex, 0);
+	append_remote_object_url(&buf, repo->url, hex, 0);
 	request->dest = strbuf_detach(&buf, NULL);
 
-	append_remote_object_url(&buf, remote->url, hex, 0);
+	append_remote_object_url(&buf, repo->url, hex, 0);
 	strbuf_add(&buf, request->lock->tmpfile_suffix, 41);
 	request->url = strbuf_detach(&buf, NULL);
 
@@ -648,7 +648,7 @@ static int refresh_lock(struct remote_lock *lock)
 
 static void check_locks(void)
 {
-	struct remote_lock *lock = remote->locks;
+	struct remote_lock *lock = repo->locks;
 	time_t current_time = time(NULL);
 	int time_remaining;
 
@@ -788,7 +788,7 @@ static void finish_request(struct transfer_request *request)
 		if (request->curl_result != CURLE_OK) {
 			fprintf(stderr, "Unable to get pack file %s\n%s",
 				request->url, curl_errorstr);
-			remote->can_update_info_refs = 0;
+			repo->can_update_info_refs = 0;
 		} else {
 			off_t pack_size = ftell(request->local_stream);
 
@@ -798,7 +798,7 @@ static void finish_request(struct transfer_request *request)
 					       request->filename)) {
 				target = (struct packed_git *)request->userData;
 				target->pack_size = pack_size;
-				lst = &remote->packs;
+				lst = &repo->packs;
 				while (*lst != target)
 					lst = &((*lst)->next);
 				*lst = (*lst)->next;
@@ -806,7 +806,7 @@ static void finish_request(struct transfer_request *request)
 				if (!verify_pack(target))
 					install_packed_git(target);
 				else
-					remote->can_update_info_refs = 0;
+					repo->can_update_info_refs = 0;
 			}
 		}
 		release_request(request);
@@ -889,7 +889,7 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 		get_remote_object_list(obj->sha1[0]);
 	if (obj->flags & (REMOTE | PUSHING))
 		return 0;
-	target = find_sha1_pack(obj->sha1, remote->packs);
+	target = find_sha1_pack(obj->sha1, repo->packs);
 	if (target) {
 		obj->flags |= REMOTE;
 		return 0;
@@ -930,8 +930,8 @@ static int fetch_index(unsigned char *sha1)
 	struct slot_results results;
 
 	/* Don't use the index if the pack isn't there */
-	url = xmalloc(strlen(remote->url) + 64);
-	sprintf(url, "%sobjects/pack/pack-%s.pack", remote->url, hex);
+	url = xmalloc(strlen(repo->url) + 64);
+	sprintf(url, "%sobjects/pack/pack-%s.pack", repo->url, hex);
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
@@ -956,7 +956,7 @@ static int fetch_index(unsigned char *sha1)
 	if (push_verbosely)
 		fprintf(stderr, "Getting index for pack %s\n", hex);
 
-	sprintf(url, "%sobjects/pack/pack-%s.idx", remote->url, hex);
+	sprintf(url, "%sobjects/pack/pack-%s.idx", repo->url, hex);
 
 	filename = sha1_pack_index_name(sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
@@ -1018,8 +1018,8 @@ static int setup_index(unsigned char *sha1)
 		return -1;
 
 	new_pack = parse_pack_index(sha1);
-	new_pack->next = remote->packs;
-	remote->packs = new_pack;
+	new_pack->next = repo->packs;
+	repo->packs = new_pack;
 	return 0;
 }
 
@@ -1037,8 +1037,8 @@ static int fetch_indices(void)
 	if (push_verbosely)
 		fprintf(stderr, "Getting pack list\n");
 
-	url = xmalloc(strlen(remote->url) + 20);
-	sprintf(url, "%sobjects/info/packs", remote->url);
+	url = xmalloc(strlen(repo->url) + 20);
+	sprintf(url, "%sobjects/info/packs", repo->url);
 
 	slot = get_active_slot();
 	slot->results = &results;
@@ -1223,11 +1223,11 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	struct curl_slist *dav_headers = NULL;
 	struct xml_ctx ctx;
 
-	url = xmalloc(strlen(remote->url) + strlen(path) + 1);
-	sprintf(url, "%s%s", remote->url, path);
+	url = xmalloc(strlen(repo->url) + strlen(path) + 1);
+	sprintf(url, "%s%s", repo->url, path);
 
 	/* Make sure leading directories exist for the remote ref */
-	ep = strchr(url + strlen(remote->url) + 1, '/');
+	ep = strchr(url + strlen(repo->url) + 1, '/');
 	while (ep) {
 		char saved_character = ep[1];
 		ep[1] = '\0';
@@ -1319,8 +1319,8 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	} else {
 		lock->url = url;
 		lock->start_time = time(NULL);
-		lock->next = remote->locks;
-		remote->locks = lock;
+		lock->next = repo->locks;
+		repo->locks = lock;
 	}
 
 	return lock;
@@ -1330,7 +1330,7 @@ static int unlock_remote(struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
-	struct remote_lock *prev = remote->locks;
+	struct remote_lock *prev = repo->locks;
 	struct curl_slist *dav_headers;
 	int rc = 0;
 
@@ -1356,8 +1356,8 @@ static int unlock_remote(struct remote_lock *lock)
 
 	curl_slist_free_all(dav_headers);
 
-	if (remote->locks == lock) {
-		remote->locks = lock->next;
+	if (repo->locks == lock) {
+		repo->locks = lock->next;
 	} else {
 		while (prev && prev->next != lock)
 			prev = prev->next;
@@ -1375,7 +1375,7 @@ static int unlock_remote(struct remote_lock *lock)
 
 static void remove_locks(void)
 {
-	struct remote_lock *lock = remote->locks;
+	struct remote_lock *lock = repo->locks;
 
 	fprintf(stderr, "Removing remote locks...\n");
 	while (lock) {
@@ -1457,7 +1457,7 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 				}
 			}
 			if (path) {
-				path += remote->path_len;
+				path += repo->path_len;
 				ls->dentry_name = xstrdup(path);
 			}
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
@@ -1480,7 +1480,7 @@ static void remote_ls(const char *path, int flags,
 		      void (*userFunc)(struct remote_ls_ctx *ls),
 		      void *userData)
 {
-	char *url = xmalloc(strlen(remote->url) + strlen(path) + 1);
+	char *url = xmalloc(strlen(repo->url) + strlen(path) + 1);
 	struct active_request_slot *slot;
 	struct slot_results results;
 	struct strbuf in_buffer = STRBUF_INIT;
@@ -1496,7 +1496,7 @@ static void remote_ls(const char *path, int flags,
 	ls.userData = userData;
 	ls.userFunc = userFunc;
 
-	sprintf(url, "%s%s", remote->url, path);
+	sprintf(url, "%s%s", repo->url, path);
 
 	strbuf_addf(&out_buffer.buf, PROPFIND_ALL_REQUEST);
 
@@ -1574,7 +1574,7 @@ static int locking_available(void)
 	struct xml_ctx ctx;
 	int lock_flags = 0;
 
-	strbuf_addf(&out_buffer.buf, PROPFIND_SUPPORTEDLOCK_REQUEST, remote->url);
+	strbuf_addf(&out_buffer.buf, PROPFIND_SUPPORTEDLOCK_REQUEST, repo->url);
 
 	dav_headers = curl_slist_append(dav_headers, "Depth: 0");
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
@@ -1586,7 +1586,7 @@ static int locking_available(void)
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, remote->url);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, repo->url);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PROPFIND);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
@@ -1617,15 +1617,15 @@ static int locking_available(void)
 			XML_ParserFree(parser);
 			if (!lock_flags)
 				error("Error: no DAV locking support on %s",
-				      remote->url);
+				      repo->url);
 
 		} else {
 			error("Cannot access URL %s, return code %d",
-			      remote->url, results.curl_result);
+			      repo->url, results.curl_result);
 			lock_flags = 0;
 		}
 	} else {
-		error("Unable to start PROPFIND request on %s", remote->url);
+		error("Unable to start PROPFIND request on %s", repo->url);
 	}
 
 	strbuf_release(&out_buffer.buf);
@@ -1814,10 +1814,10 @@ static void one_remote_ref(char *refname)
 
 	ref = alloc_ref(refname);
 
-	if (http_fetch_ref(remote->url, ref) != 0) {
+	if (http_fetch_ref(repo->url, ref) != 0) {
 		fprintf(stderr,
 			"Unable to fetch ref %s from %s\n",
-			refname, remote->url);
+			refname, repo->url);
 		free(ref);
 		return;
 	}
@@ -1826,7 +1826,7 @@ static void one_remote_ref(char *refname)
 	 * Fetch a copy of the object if it doesn't exist locally - it
 	 * may be required for updating server info later.
 	 */
-	if (remote->can_update_info_refs && !has_sha1_file(ref->old_sha1)) {
+	if (repo->can_update_info_refs && !has_sha1_file(ref->old_sha1)) {
 		obj = lookup_unknown_object(ref->old_sha1);
 		if (obj) {
 			fprintf(stderr,	"  fetch %s for %s\n",
@@ -1921,10 +1921,10 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 
 	ref = alloc_ref(ls->dentry_name);
 
-	if (http_fetch_ref(remote->url, ref) != 0) {
+	if (http_fetch_ref(repo->url, ref) != 0) {
 		fprintf(stderr,
 			"Unable to fetch ref %s from %s\n",
-			ls->dentry_name, remote->url);
+			ls->dentry_name, repo->url);
 		aborted = 1;
 		free(ref);
 		return;
@@ -1999,12 +1999,12 @@ static void update_remote_info_refs(struct remote_lock *lock)
 
 static int remote_exists(const char *path)
 {
-	char *url = xmalloc(strlen(remote->url) + strlen(path) + 1);
+	char *url = xmalloc(strlen(repo->url) + strlen(path) + 1);
 	struct active_request_slot *slot;
 	struct slot_results results;
 	int ret = -1;
 
-	sprintf(url, "%s%s", remote->url, path);
+	sprintf(url, "%s%s", repo->url, path);
 
 	slot = get_active_slot();
 	slot->results = &results;
@@ -2034,8 +2034,8 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 	struct active_request_slot *slot;
 	struct slot_results results;
 
-	url = xmalloc(strlen(remote->url) + strlen(path) + 1);
-	sprintf(url, "%s%s", remote->url, path);
+	url = xmalloc(strlen(repo->url) + strlen(path) + 1);
+	sprintf(url, "%s%s", repo->url, path);
 
 	slot = get_active_slot();
 	slot->results = &results;
@@ -2150,7 +2150,7 @@ static int delete_remote_branch(char *pattern, int force)
 				     "of your current HEAD.\n"
 				     "If you are sure you want to delete it,"
 				     " run:\n\t'git http-push -D %s %s'",
-				     remote_ref->name, remote->url, pattern);
+				     remote_ref->name, repo->url, pattern);
 		}
 	}
 
@@ -2158,8 +2158,8 @@ static int delete_remote_branch(char *pattern, int force)
 	fprintf(stderr, "Removing remote branch '%s'\n", remote_ref->name);
 	if (dry_run)
 		return 0;
-	url = xmalloc(strlen(remote->url) + strlen(remote_ref->name) + 1);
-	sprintf(url, "%s%s", remote->url, remote_ref->name);
+	url = xmalloc(strlen(repo->url) + strlen(remote_ref->name) + 1);
+	sprintf(url, "%s%s", repo->url, remote_ref->name);
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
@@ -2202,7 +2202,7 @@ int main(int argc, char **argv)
 
 	setup_git_directory();
 
-	remote = xcalloc(sizeof(*remote), 1);
+	repo = xcalloc(sizeof(*repo), 1);
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
@@ -2235,14 +2235,14 @@ int main(int argc, char **argv)
 				continue;
 			}
 		}
-		if (!remote->url) {
+		if (!repo->url) {
 			char *path = strstr(arg, "//");
-			remote->url = arg;
-			remote->path_len = strlen(arg);
+			repo->url = arg;
+			repo->path_len = strlen(arg);
 			if (path) {
-				remote->path = strchr(path+2, '/');
-				if (remote->path)
-					remote->path_len = strlen(remote->path);
+				repo->path = strchr(path+2, '/');
+				if (repo->path)
+					repo->path_len = strlen(repo->path);
 			}
 			continue;
 		}
@@ -2255,7 +2255,7 @@ int main(int argc, char **argv)
 	die("git-push is not available for http/https repository when not compiled with USE_CURL_MULTI");
 #endif
 
-	if (!remote->url)
+	if (!repo->url)
 		usage(http_push_usage);
 
 	if (delete_branch && nr_refspec != 1)
@@ -2267,13 +2267,13 @@ int main(int argc, char **argv)
 
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
-	if (remote->url && remote->url[strlen(remote->url)-1] != '/') {
-		rewritten_url = xmalloc(strlen(remote->url)+2);
-		strcpy(rewritten_url, remote->url);
+	if (repo->url && repo->url[strlen(repo->url)-1] != '/') {
+		rewritten_url = xmalloc(strlen(repo->url)+2);
+		strcpy(rewritten_url, repo->url);
 		strcat(rewritten_url, "/");
-		remote->path = rewritten_url + (remote->path - remote->url);
-		remote->path_len++;
-		remote->url = rewritten_url;
+		repo->path = rewritten_url + (repo->path - repo->url);
+		repo->path_len++;
+		repo->url = rewritten_url;
 	}
 
 	/* Verify DAV compliance/lock support */
@@ -2285,20 +2285,20 @@ int main(int argc, char **argv)
 	sigchain_push_common(remove_locks_on_signal);
 
 	/* Check whether the remote has server info files */
-	remote->can_update_info_refs = 0;
-	remote->has_info_refs = remote_exists("info/refs");
-	remote->has_info_packs = remote_exists("objects/info/packs");
-	if (remote->has_info_refs) {
+	repo->can_update_info_refs = 0;
+	repo->has_info_refs = remote_exists("info/refs");
+	repo->has_info_packs = remote_exists("objects/info/packs");
+	if (repo->has_info_refs) {
 		info_ref_lock = lock_remote("info/refs", LOCK_TIME);
 		if (info_ref_lock)
-			remote->can_update_info_refs = 1;
+			repo->can_update_info_refs = 1;
 		else {
 			fprintf(stderr, "Error: cannot lock existing info/refs\n");
 			rc = 1;
 			goto cleanup;
 		}
 	}
-	if (remote->has_info_packs)
+	if (repo->has_info_packs)
 		fetch_indices();
 
 	/* Get a list of all local and remote heads to validate refspecs */
@@ -2456,8 +2456,8 @@ int main(int argc, char **argv)
 	}
 
 	/* Update remote server info if appropriate */
-	if (remote->has_info_refs && new_refs) {
-		if (info_ref_lock && remote->can_update_info_refs) {
+	if (repo->has_info_refs && new_refs) {
+		if (info_ref_lock && repo->can_update_info_refs) {
 			fprintf(stderr, "Updating remote server info\n");
 			if (!dry_run)
 				update_remote_info_refs(info_ref_lock);
@@ -2470,7 +2470,7 @@ int main(int argc, char **argv)
 	free(rewritten_url);
 	if (info_ref_lock)
 		unlock_remote(info_ref_lock);
-	free(remote);
+	free(repo);
 
 	curl_slist_free_all(no_pragma_header);
 
