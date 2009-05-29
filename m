From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 16/17] http*: add helper methods for fetching packs
Date: Sat, 30 May 2009 01:59:48 +0800
Message-ID: <20090530015948.a9e65ecf.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 20:02:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA6PC-0000Xl-Dm
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 20:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760317AbZE2SBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 14:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760052AbZE2SBh
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 14:01:37 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:24455 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760223AbZE2SBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 14:01:36 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1285295wah.21
        for <git@vger.kernel.org>; Fri, 29 May 2009 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=xQp+49mbnGFzjUXFsvfEPQKfRCClLizA688ZuHLnUZQ=;
        b=MVGsRoMSZx49Tmkx39wnzAZLFbUIOz8cqpeJJtHeJZP2upUbBUg1zC1QGa304PsKuA
         eYi1aPoOFPCS0X+63fQGhxZ4YkD8QT4CyGzel0tI5ihw28sF937NN5rYmUjcSaQXlurz
         McKl+UNKUoLmf3eb4WzeSiFNONoQvj1unBffA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=aR6wTmL6zRYXL4WpB8zdcMagWnIR2J4/1C0yhTMn74hbQ3S3ZkbJRIQ1W74LEdsuR4
         f0GSXWd58VwmR51Q1u0vD0rfzX+otlbU4W5KyxKaK8umexCwEOtNlF/f6MylB7vWT5Qn
         +BHAg554cM0stiJSKmSAdaHSL/sWGAnpuADa4=
Received: by 10.114.159.5 with SMTP id h5mr4524745wae.201.1243620098136;
        Fri, 29 May 2009 11:01:38 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id j15sm2549333waf.16.2009.05.29.11.01.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:01:37 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code handling the fetching of packs in http-push.c and
http-walker.c have been refactored into new methods and a new struct
(http_pack_request) in http.c. They are not meant to be invoked
elsewhere.

The new methods in http.c are
 - new_http_pack_request
 - finish_http_pack_request
 - release_http_pack_request

and the new struct is http_pack_request.

Add a function, new_http_pack_request(), that deals with the details of
coming up with the filename to store the retrieved packfile, resuming a
previously aborted request, and making a new curl request. Update
http-push.c::start_fetch_packed() and http-walker.c::fetch_pack() to
use this.

Add a function, finish_http_pack_request(), that deals with renaming
the pack, advancing the pack list, and installing the pack. Update
http-push.c::finish_request() and http-walker.c::fetch_pack to use
this.

Update release_request() in http-push.c and http-walker.c to invoke
release_http_pack_request() to clean up pack request helper data.

The local_stream member of the transfer_request struct in http-push.c
has been removed, as the packfile pointer will be managed in the struct
http_pack_request.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c   |  107 ++++++++++++++-------------------------------------------
 http-walker.c |   82 +++++++++----------------------------------
 http.c        |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 http.h        |   17 +++++++++
 4 files changed, 165 insertions(+), 145 deletions(-)

diff --git a/http-push.c b/http-push.c
index fb84e36..6964433 100644
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
@@ -819,30 +775,21 @@ static void finish_request(struct transfer_request *request)
 			start_fetch_packed(request);

 	} else if (request->state == RUN_FETCH_PACKED) {
+		int fail = 1;
 		if (request->curl_result != CURLE_OK) {
 			fprintf(stderr, "Unable to get pack file %s\n%s",
 				request->url, curl_errorstr);
-			repo->can_update_info_refs = 0;
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
+			preq = (struct http_pack_request *)request->userData;
+
+			if (preq) {
+				if (finish_http_pack_request(preq) > 0)
+					fail = 0;
+				release_http_pack_request(preq);
 			}
 		}
+		if (fail)
+			repo->can_update_info_refs = 0;
 		release_request(request);
 	}
 }
@@ -897,7 +844,6 @@ static void add_fetch_request(struct object *obj)
 	request->lock = NULL;
 	request->headers = NULL;
 	request->local_fileno = -1;
-	request->local_stream = NULL;
 	request->state = NEED_FETCH;
 	request->next = request_queue_head;
 	request_queue_head = request;
@@ -937,7 +883,6 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	request->lock = lock;
 	request->headers = NULL;
 	request->local_fileno = -1;
-	request->local_stream = NULL;
 	request->state = NEED_PUSH;
 	request->next = request_queue_head;
 	request_queue_head = request;
diff --git a/http-walker.c b/http-walker.c
index c550fd9..ab43cd5 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "commit.h"
-#include "pack.h"
 #include "walker.h"
 #include "http.h"

@@ -589,19 +588,10 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)

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
@@ -616,69 +606,33 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 			sha1_to_hex(sha1));
 	}

-	url = xmalloc(strlen(repo->base) + 65);
-	sprintf(url, "%s/objects/pack/pack-%s.pack",
-		repo->base, sha1_to_hex(target->sha1));
+	preq = new_http_pack_request(target, repo->base);
+	if (preq == NULL)
+		goto abort;
+	preq->lst = &repo->packs;
+	preq->slot->results = &results;

-	filename = sha1_pack_name(target->sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	packfile = fopen(tmpfile, "a");
-	if (!packfile)
-		return error("Unable to open local file %s for pack",
-			     tmpfile);
-
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
index f123094..386556a 100644
--- a/http.c
+++ b/http.c
@@ -1,4 +1,5 @@
 #include "http.h"
+#include "pack.h"

 int data_received;
 int active_requests;
@@ -888,3 +889,106 @@ cleanup:
 	free(url);
 	return ret;
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
index 180b1c2..511c0c4 100644
--- a/http.h
+++ b/http.h
@@ -150,4 +150,21 @@ extern int http_fetch_ref(const char *base, struct ref *ref);
 extern int http_get_info_packs(const char *base_url,
 	struct packed_git **packs_head);

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
1.6.3.1
