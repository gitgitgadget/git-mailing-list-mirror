From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 09/11] http*: add helper methods for fetching packs
Date: Sat, 16 May 2009 11:51:57 +0800
Message-ID: <20090516115157.89be832d.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 16 05:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5B0V-0005js-Ts
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 05:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756940AbZEPDzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 23:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756778AbZEPDzr
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 23:55:47 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:32965 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756908AbZEPDzp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 23:55:45 -0400
Received: by mail-px0-f123.google.com with SMTP id 29so1312541pxi.33
        for <git@vger.kernel.org>; Fri, 15 May 2009 20:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=7wj8oegxHjWm3wfguThO8FwBcq4JQMDSuQh0f8vzH7Q=;
        b=AcdY4tZdUhdNj93hZkcrrOULgU3o+oV9gIPJR0LAbufjT3NhbJLxHhtUC2sTXatWYE
         +B6DZuwio5sCg5341a1H6B5H4poKl46S363W0YZK4zrXfhOvJu1Ev+cBGG6PcxKlupIs
         vbkpLcSUjHXcz74fVFT2JhrljtG9x/Ix/LLwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=I46kH+KD+mqb3BcjHHJyBsxg2UbLQ0tFBQd+EEgR2xP3J9O2+QOj+iVUUmOG9wSznb
         722Zo/973EKn2wo6CDqqkzL6UpEvKXogIVps4wkQzEKN8vXpckGsvSeaVzSSApRp7UZh
         kjweMawlFuk+5dz/CbYNGfK6tO/4oNvAkKxtE=
Received: by 10.114.134.1 with SMTP id h1mr6102853wad.47.1242446146702;
        Fri, 15 May 2009 20:55:46 -0700 (PDT)
Received: from your-cukc5e3z5n (cm112.zeta149.maxonline.com.sg [116.87.149.112])
        by mx.google.com with ESMTPS id j28sm2173260waf.23.2009.05.15.20.55.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 20:55:46 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119330>

The code handling the fetching of packs in http-push.c and
http-walker.c have been refactored into new methods and a new struct
(http_pack_request) in http.c. They are not meant to be invoked
elsewhere.

The new methods in http.c are
 *new_http_pack_request
 *finish_http_pack_request
 *release_http_pack_request

and the new struct is http_pack_request.

***http-push.c***
The local_stream member of the transfer_request has been removed, as
the packfile pointer will be managed in the struct http_pack_request.

The code moved out from start_fetch_packed to new_http_pack_request
deals with filenames, file and curl options, and does not change
its behaviour.

The logic moved out from finish_request is similar to that in
finish_http_pack_request. If the invocation fails, due to conditions
like a failed rename or failed pack verification,
repo->can_update_info_refs is set to 0, as before.

The closing of the file descriptor (originally local_stream in
transfer_request) in release_request is now done in
finish_http_pack_request and release_http_pack_request.

When cleaning up, release_http_pack_request is invoked separately from
release_request.

***http-walker.c***
The code moved out from fetch_pack to new_http_pack_request deals with
filenames, file and curl options; they do not change its behaviour.

The code moved out from fetch_pack to finish_http_pack_request deals
with renaming the pack, advancing the pack list, and installing the
pack; they do not change its behaviour.

When cleaning up, release_http_pack_request is invoked separately from
release_request.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c   |  103 ++++++++++++--------------------------------------------
 http-walker.c |   82 ++++++++++-----------------------------------
 http.c        |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 http.h        |   17 +++++++++
 4 files changed, 161 insertions(+), 145 deletions(-)

diff --git a/http-push.c b/http-push.c
index ece7a43..ffd484f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "commit.h"
-#include "pack.h"
 #include "tag.h"
 #include "blob.h"
 #include "http.h"
@@ -119,7 +118,6 @@ struct transfer_request
 	char filename[PATH_MAX];
 	char tmpfile[PATH_MAX];
 	int local_fileno;
-	FILE *local_stream;
 	enum transfer_state state;
 	CURLcode curl_result;
 	char errorstr[CURL_ERROR_SIZE];
@@ -452,16 +450,10 @@ static void start_mkcol(struct transfer_request *request)
 
 static void start_fetch_packed(struct transfer_request *request)
 {
-	char *url;
 	struct packed_git *target;
-	FILE *packfile;
-	char *filename;
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
 
 	struct transfer_request *check_request = request_queue_head;
-	struct active_request_slot *slot;
+	struct http_pack_request *preq;
 
 	target = find_sha1_pack(request->obj->sha1, repo->packs);
 	if (!target) {
@@ -474,68 +466,35 @@ static void start_fetch_packed(struct transfer_request *request)
 	fprintf(stderr,	"Fetching pack %s\n", sha1_to_hex(target->sha1));
 	fprintf(stderr, " which contains %s\n", sha1_to_hex(request->obj->sha1));
 
-	filename = sha1_pack_name(target->sha1);
-	snprintf(request->filename, sizeof(request->filename), "%s", filename);
-	snprintf(request->tmpfile, sizeof(request->tmpfile),
-		 "%s.temp", filename);
-
-	url = xmalloc(strlen(repo->url) + 64);
-	sprintf(url, "%sobjects/pack/pack-%s.pack",
-		repo->url, sha1_to_hex(target->sha1));
+	preq = new_http_pack_request(target, repo->url);
+	if (preq == NULL) {
+		release_http_pack_request(preq);
+		repo->can_update_info_refs = 0;
+		return;
+	}
+	preq->lst = &repo->packs;
 
 	/* Make sure there isn't another open request for this pack */
 	while (check_request) {
 		if (check_request->state == RUN_FETCH_PACKED &&
-		    !strcmp(check_request->url, url)) {
-			free(url);
+		    !strcmp(check_request->url, preq->url)) {
+			release_http_pack_request(preq);
 			release_request(request);
 			return;
 		}
 		check_request = check_request->next;
 	}
 
-	packfile = fopen(request->tmpfile, "a");
-	if (!packfile) {
-		fprintf(stderr, "Unable to open local file %s for pack",
-			request->tmpfile);
-		repo->can_update_info_refs = 0;
-		free(url);
-		return;
-	}
-
-	slot = get_active_slot();
-	slot->callback_func = process_response;
-	slot->callback_data = request;
-	request->slot = slot;
-	request->local_stream = packfile;
-	request->userData = target;
-
-	request->url = url;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, packfile);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
-	slot->local = packfile;
-
-	/*
-	 * If there is data present from a previous transfer attempt,
-	 * resume where it left off
-	 */
-	prev_posn = ftell(packfile);
-	if (prev_posn>0) {
-		if (push_verbosely)
-			fprintf(stderr,
-				"Resuming fetch of pack %s at byte %ld\n",
-				sha1_to_hex(target->sha1), prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
-	}
+	preq->slot->callback_func = process_response;
+	preq->slot->callback_data = request;
+	request->slot = preq->slot;
+	request->userData = preq;
 
 	/* Try to get the request started, abort the request on error */
 	request->state = RUN_FETCH_PACKED;
-	if (!start_active_slot(slot)) {
+	if (!start_active_slot(preq->slot)) {
 		fprintf(stderr, "Unable to start GET request\n");
+		release_http_pack_request(preq);
 		repo->can_update_info_refs = 0;
 		release_request(request);
 	}
@@ -718,8 +677,6 @@ static void release_request(struct transfer_request *request)
 
 	if (request->local_fileno != -1)
 		close(request->local_fileno);
-	if (request->local_stream)
-		fclose(request->local_stream);
 	free(request->url);
 	free(request);
 }
@@ -727,8 +684,7 @@ static void release_request(struct transfer_request *request)
 static void finish_request(struct transfer_request *request)
 {
 	struct stat st;
-	struct packed_git *target;
-	struct packed_git **lst;
+	struct http_pack_request *preq;
 
 	request->curl_result = request->slot->curl_result;
 	request->http_code = request->slot->http_code;
@@ -824,25 +780,12 @@ static void finish_request(struct transfer_request *request)
 				request->url, curl_errorstr);
 			repo->can_update_info_refs = 0;
 		} else {
-			off_t pack_size = ftell(request->local_stream);
-
-			fclose(request->local_stream);
-			request->local_stream = NULL;
-			if (!move_temp_to_file(request->tmpfile,
-					       request->filename)) {
-				target = (struct packed_git *)request->userData;
-				target->pack_size = pack_size;
-				lst = &repo->packs;
-				while (*lst != target)
-					lst = &((*lst)->next);
-				*lst = (*lst)->next;
-
-				if (!verify_pack(target))
-					install_packed_git(target);
-				else
-					repo->can_update_info_refs = 0;
-			}
+			preq = (struct http_pack_request *)request->userData;
+
+			if (finish_http_pack_request(preq))
+				repo->can_update_info_refs = 0;
 		}
+		release_http_pack_request(preq);
 		release_request(request);
 	}
 }
@@ -896,7 +839,6 @@ static void add_fetch_request(struct object *obj)
 	request->lock = NULL;
 	request->headers = NULL;
 	request->local_fileno = -1;
-	request->local_stream = NULL;
 	request->state = NEED_FETCH;
 	request->next = request_queue_head;
 	request_queue_head = request;
@@ -936,7 +878,6 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	request->lock = lock;
 	request->headers = NULL;
 	request->local_fileno = -1;
-	request->local_stream = NULL;
 	request->state = NEED_PUSH;
 	request->next = request_queue_head;
 	request_queue_head = request;
diff --git a/http-walker.c b/http-walker.c
index 3a0c021..ae140ba 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "commit.h"
-#include "pack.h"
 #include "walker.h"
 #include "http.h"
 
@@ -638,19 +637,10 @@ cleanup:
 
 static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
 {
-	char *url;
 	struct packed_git *target;
-	struct packed_git **lst;
-	FILE *packfile;
-	char *filename;
-	char tmpfile[PATH_MAX];
 	int ret;
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
-
-	struct active_request_slot *slot;
 	struct slot_results results;
+	struct http_pack_request *preq;
 
 	if (fetch_indices(walker, repo))
 		return -1;
@@ -665,69 +655,33 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 			sha1_to_hex(sha1));
 	}
 
-	url = xmalloc(strlen(repo->base) + 65);
-	sprintf(url, "%s/objects/pack/pack-%s.pack",
-		repo->base, sha1_to_hex(target->sha1));
-
-	filename = sha1_pack_name(target->sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	packfile = fopen(tmpfile, "a");
-	if (!packfile)
-		return error("Unable to open local file %s for pack",
-			     tmpfile);
+	preq = new_http_pack_request(target, repo->base);
+	if (preq == NULL)
+		goto abort;
+	preq->lst = &repo->packs;
+	preq->slot->results = &results;
 
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, packfile);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
-	slot->local = packfile;
-
-	/*
-	 * If there is data present from a previous transfer attempt,
-	 * resume where it left off
-	 */
-	prev_posn = ftell(packfile);
-	if (prev_posn>0) {
-		if (walker->get_verbosely)
-			fprintf(stderr,
-				"Resuming fetch of pack %s at byte %ld\n",
-				sha1_to_hex(target->sha1), prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
-	}
-
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
+	if (start_active_slot(preq->slot)) {
+		run_active_slot(preq->slot);
 		if (results.curl_result != CURLE_OK) {
-			fclose(packfile);
-			return error("Unable to get pack file %s\n%s", url,
-				     curl_errorstr);
+			error("Unable to get pack file %s\n%s", preq->url,
+			      curl_errorstr);
+			goto abort;
 		}
 	} else {
-		fclose(packfile);
-		return error("Unable to start request");
+		error("Unable to start request");
+		goto abort;
 	}
 
-	target->pack_size = ftell(packfile);
-	fclose(packfile);
-
-	ret = move_temp_to_file(tmpfile, filename);
+	ret = finish_http_pack_request(preq);
+	release_http_pack_request(preq);
 	if (ret)
 		return ret;
 
-	lst = &repo->packs;
-	while (*lst != target)
-		lst = &((*lst)->next);
-	*lst = (*lst)->next;
-
-	if (verify_pack(target))
-		return -1;
-	install_packed_git(target);
-
 	return 0;
+
+abort:
+	return -1;
 }
 
 static void abort_object_request(struct object_request *obj_req)
diff --git a/http.c b/http.c
index 91c6bf6..b11c082 100644
--- a/http.c
+++ b/http.c
@@ -1,4 +1,5 @@
 #include "http.h"
+#include "pack.h"
 
 int data_received;
 int active_requests;
@@ -825,3 +826,106 @@ int fetch_http_pack_index(struct packed_git **packs_head, unsigned char *sha1,
 	*packs_head = new_pack;
 	return 0;
 }
+
+void release_http_pack_request(struct http_pack_request *preq)
+{
+	if (preq->packfile != NULL) {
+		fclose(preq->packfile);
+		preq->packfile = NULL;
+	}
+	if (preq->range_header != NULL) {
+		curl_slist_free_all(preq->range_header);
+		preq->range_header = NULL;
+	}
+	preq->slot = NULL;
+	free(preq->url);
+}
+
+int finish_http_pack_request(struct http_pack_request *preq)
+{
+	int ret;
+	struct packed_git **lst;
+
+	preq->target->pack_size = ftell(preq->packfile);
+
+	if (preq->packfile != NULL) {
+		fclose(preq->packfile);
+		preq->packfile = NULL;
+	}
+
+	ret = move_temp_to_file(preq->tmpfile, preq->filename);
+	if (ret)
+		return ret;
+
+	lst = preq->lst;
+	while (*lst != preq->target)
+		lst = &((*lst)->next);
+	*lst = (*lst)->next;
+
+	if (verify_pack(preq->target))
+		return -1;
+	install_packed_git(preq->target);
+
+	return 0;
+}
+
+struct http_pack_request *new_http_pack_request(
+	struct packed_git *target, const char *base_url)
+{
+	char *url;
+	char *filename;
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct strbuf buf = STRBUF_INIT;
+	struct http_pack_request *preq;
+
+	preq = xmalloc(sizeof(*preq));
+	preq->target = target;
+	preq->range_header = NULL;
+
+	end_url_with_slash(&buf, base_url);
+	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
+		sha1_to_hex(target->sha1));
+	url = strbuf_detach(&buf, NULL);
+	preq->url = xstrdup(url);
+
+	filename = sha1_pack_name(target->sha1);
+	snprintf(preq->filename, sizeof(preq->filename), "%s", filename);
+	snprintf(preq->tmpfile, sizeof(preq->tmpfile), "%s.temp", filename);
+	preq->packfile = fopen(preq->tmpfile, "a");
+	if (!preq->packfile) {
+		error("Unable to open local file %s for pack",
+		      preq->tmpfile);
+		goto abort;
+	}
+
+	preq->slot = get_active_slot();
+	preq->slot->local = preq->packfile;
+	curl_easy_setopt(preq->slot->curl, CURLOPT_FILE, preq->packfile);
+	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
+	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
+		no_pragma_header);
+
+	/*
+	 * If there is data present from a previous transfer attempt,
+	 * resume where it left off
+	 */
+	prev_posn = ftell(preq->packfile);
+	if (prev_posn>0) {
+		if (http_is_verbose)
+			fprintf(stderr,
+				"Resuming fetch of pack %s at byte %ld\n",
+				sha1_to_hex(target->sha1), prev_posn);
+		sprintf(range, "Range: bytes=%ld-", prev_posn);
+		preq->range_header = curl_slist_append(NULL, range);
+		curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
+			preq->range_header);
+	}
+
+	return preq;
+
+abort:
+	free(filename);
+	return NULL;
+}
diff --git a/http.h b/http.h
index cd2920b..c72bcc1 100644
--- a/http.h
+++ b/http.h
@@ -120,4 +120,21 @@ extern int http_fetch_ref(const char *base, struct ref *ref);
 extern int fetch_http_pack_index(struct packed_git **packs_head,
 	unsigned char *sha1, const char *base_url);
 
+struct http_pack_request
+{
+	char *url;
+	struct packed_git *target;
+	struct packed_git **lst;
+	FILE *packfile;
+	char filename[PATH_MAX];
+	char tmpfile[PATH_MAX];
+	struct curl_slist *range_header;
+	struct active_request_slot *slot;
+};
+
+extern struct http_pack_request *new_http_pack_request(
+	struct packed_git *target, const char *base_url);
+extern int finish_http_pack_request(struct http_pack_request *preq);
+extern void release_http_pack_request(struct http_pack_request *preq);
+
 #endif /* HTTP_H */
-- 
1.6.3.rc0
