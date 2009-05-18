From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/3] http*: add helper methods for fetching
 objects/info/packs
Date: Mon, 18 May 2009 16:14:22 +0800
Message-ID: <20090518161422.f42bc0e6.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 18 10:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5yFl-0004pO-GR
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 10:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbZERIbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 04:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbZERIbE
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 04:31:04 -0400
Received: from mail-px0-f191.google.com ([209.85.216.191]:58728 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbZERIa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 04:30:59 -0400
Received: by mail-px0-f191.google.com with SMTP id 29so1855280pxi.33
        for <git@vger.kernel.org>; Mon, 18 May 2009 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Xseefydx94SBCug/Ha2SnzCcm7vGNna23xi17fmypc0=;
        b=wt2ii4JA6bJdH5AqMHk33wPZtU91u7VdKmqWKojEvZb0H9YXf3Fwe4eIkwokVnOFp2
         n53IIwaDXx0xDmm/GMdus78p36ICl89II5cVJkHfzZFUn21ImCKH6ZUqcbzXdvyebtn2
         jxhXII4xFm03KNJYT3e8d5P85kOaoMgAW3p+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=nFOpjduvZcKnGWuESRH11qp7pHN7Lg5ARN22n4yhiqwpWmx7TFrqrqSZ8kqFcwIr35
         QXBkMPOF0L7et7a5QB7AZOwslJ302IqBZ6AduQdZ60HqY8sKXV2vn1t+0Pbq0sh7c9iM
         +W+7GXFK5axqeyfRwSKDOaf0z8NaasoVZRUCQ=
Received: by 10.115.76.5 with SMTP id d5mr11183823wal.55.1242635460698;
        Mon, 18 May 2009 01:31:00 -0700 (PDT)
Received: from your-cukc5e3z5n (cm112.zeta149.maxonline.com.sg [116.87.149.112])
        by mx.google.com with ESMTPS id v9sm4675345wah.1.2009.05.18.01.30.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 01:31:00 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119428>

The code handling the fetching of objects/info/packs in http-push.c and
http-walker.c have been refactored into new methods and a new struct
in http.c. They are not meant to be invoked elsewhere.

The new methods in http.c are
 *new_http_info_packs_request
 *finish_http_info_packs_request
 *release_http_info_packs_request

and the new struct is http_info_packs_request.

A callback function wraps the invocation of fetch_http_pack_index,
invoked in finish_http_info_packs_request when parsing info/packs.

The fetching code lives in three methods to accomodate http-walker.c's
implementation, which involves the variable repo->got_indices.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c   |   59 +++++++++++++++----------------------------------------
 http-walker.c |   59 ++++++++++++++++++------------------------------------
 http.c        |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 http.h        |   18 ++++++++++++++++
 4 files changed, 115 insertions(+), 82 deletions(-)

diff --git a/http-push.c b/http-push.c
index 2694d16..3ded6ec 100644
--- a/http-push.c
+++ b/http-push.c
@@ -895,67 +895,40 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	return 1;
 }
 
-static int fetch_indices(void)
+static void fetch_indices_request_callback(unsigned char *sha1,
+	void *callback_data)
 {
-	unsigned char sha1[20];
-	char *url;
-	struct strbuf buffer = STRBUF_INIT;
-	char *data;
-	int i = 0;
+	fetch_http_pack_index(&repo->packs, sha1, repo->url);
+}
 
-	struct active_request_slot *slot;
+static int fetch_indices(void)
+{
 	struct slot_results results;
+	struct http_info_packs_request *req;
 
 	if (push_verbosely)
 		fprintf(stderr, "Getting pack list\n");
 
-	url = xmalloc(strlen(repo->url) + 20);
-	sprintf(url, "%sobjects/info/packs", repo->url);
+	req = new_http_info_packs_request(repo->url);
+	req->slot->results = &results;
+	req->callback_func = fetch_indices_request_callback;
 
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
+	if (start_active_slot(req->slot)) {
+		run_active_slot(req->slot);
 		if (results.curl_result != CURLE_OK) {
-			strbuf_release(&buffer);
-			free(url);
+			release_http_info_packs_request(req);
 			if (results.http_code == 404)
 				return 0;
 			else
 				return error("%s", curl_errorstr);
 		}
 	} else {
-		strbuf_release(&buffer);
-		free(url);
+		release_http_info_packs_request(req);
 		return error("Unable to start request");
 	}
-	free(url);
 
-	data = buffer.buf;
-	while (i < buffer.len) {
-		switch (data[i]) {
-		case 'P':
-			i++;
-			if (i + 52 < buffer.len &&
-			    !prefixcmp(data + i, " pack-") &&
-			    !prefixcmp(data + i + 46, ".pack\n")) {
-				get_sha1_hex(data + i + 6, sha1);
-				fetch_http_pack_index(&repo->packs, sha1, repo->url);
-				i += 51;
-				break;
-			}
-		default:
-			while (data[i] != '\n')
-				i++;
-		}
-		i++;
-	}
+	finish_http_info_packs_request(req);
 
-	strbuf_release(&buffer);
 	return 0;
 }
 
diff --git a/http-walker.c b/http-walker.c
index 2b8097c..20be607 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -563,17 +563,19 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	free(url);
 }
 
+static void fetch_indices_request_callback(unsigned char *sha1,
+	void *callback_data)
+{
+	struct alt_base *repo =
+		(struct alt_base *)callback_data;
+	fetch_http_pack_index(&repo->packs, sha1, repo->base);
+}
+
 static int fetch_indices(struct walker *walker, struct alt_base *repo)
 {
-	unsigned char sha1[20];
-	char *url;
-	struct strbuf buffer = STRBUF_INIT;
-	char *data;
-	int i = 0;
 	int ret = 0;
-
-	struct active_request_slot *slot;
 	struct slot_results results;
+	struct http_info_packs_request *req;
 
 	if (repo->got_indices)
 		return 0;
@@ -581,17 +583,14 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 	if (walker->get_verbosely)
 		fprintf(stderr, "Getting pack list for %s\n", repo->base);
 
-	url = xmalloc(strlen(repo->base) + 21);
-	sprintf(url, "%s/objects/info/packs", repo->base);
+	req = new_http_info_packs_request(repo->base);
+	req->slot->results = &results;
 
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
+	req->callback_data = (void *)repo;
+	req->callback_func = fetch_indices_request_callback;
+
+	if (start_active_slot(req->slot)) {
+		run_active_slot(req->slot);
 		if (results.curl_result != CURLE_OK) {
 			if (missing_target(&results)) {
 				repo->got_indices = 1;
@@ -608,30 +607,12 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 		goto cleanup;
 	}
 
-	data = buffer.buf;
-	while (i < buffer.len) {
-		switch (data[i]) {
-		case 'P':
-			i++;
-			if (i + 52 <= buffer.len &&
-			    !prefixcmp(data + i, " pack-") &&
-			    !prefixcmp(data + i + 46, ".pack\n")) {
-				get_sha1_hex(data + i + 6, sha1);
-				fetch_http_pack_index(&repo->packs, sha1, repo->base);
-				i += 51;
-				break;
-			}
-		default:
-			while (i < buffer.len && data[i] != '\n')
-				i++;
-		}
-		i++;
-	}
-
+	finish_http_info_packs_request(req);
 	repo->got_indices = 1;
+	return 0;
+
 cleanup:
-	strbuf_release(&buffer);
-	free(url);
+	release_http_info_packs_request(req);
 	return ret;
 }
 
diff --git a/http.c b/http.c
index b11c082..37d72f8 100644
--- a/http.c
+++ b/http.c
@@ -929,3 +929,64 @@ abort:
 	free(filename);
 	return NULL;
 }
+
+/* Helpers for fetching objects/info/packs */
+void release_http_info_packs_request(struct http_info_packs_request *req)
+{
+	strbuf_release(req->buffer);
+	free(req->url);
+}
+
+void finish_http_info_packs_request(struct http_info_packs_request *req)
+{
+	char *data;
+	int i = 0;
+	unsigned char sha1[20];
+
+	data = req->buffer->buf;
+	while (i < req->buffer->len) {
+		switch (data[i]) {
+		case 'P':
+			i++;
+			if (i + 52 <= req->buffer->len &&
+			    !prefixcmp(data + i, " pack-") &&
+			    !prefixcmp(data + i + 46, ".pack\n")) {
+				get_sha1_hex(data + i + 6, sha1);
+				req->callback_func(sha1, req->callback_data);
+				i += 51;
+				break;
+			}
+		default:
+			while (i < req->buffer->len && data[i] != '\n')
+				i++;
+		}
+		i++;
+	}
+
+	release_http_info_packs_request(req);
+}
+
+struct http_info_packs_request *new_http_info_packs_request(const char *base_url)
+{
+	char *url;
+	struct strbuf buf = STRBUF_INIT;
+	struct http_info_packs_request *req;
+
+	req = xmalloc(sizeof(*req));
+
+	req->buffer = xmalloc(sizeof(*req->buffer));
+	strbuf_init(req->buffer, 0);
+
+	end_url_with_slash(&buf, base_url);
+	strbuf_addstr(&buf, "objects/info/packs");
+	url = strbuf_detach(&buf, NULL);
+	req->url = xstrdup(url);
+
+	req->slot = get_active_slot();
+	curl_easy_setopt(req->slot->curl, CURLOPT_FILE, req->buffer);
+	curl_easy_setopt(req->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(req->slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(req->slot->curl, CURLOPT_HTTPHEADER, NULL);
+
+	return req;
+}
diff --git a/http.h b/http.h
index c72bcc1..c4b1204 100644
--- a/http.h
+++ b/http.h
@@ -137,4 +137,22 @@ extern struct http_pack_request *new_http_pack_request(
 extern int finish_http_pack_request(struct http_pack_request *preq);
 extern void release_http_pack_request(struct http_pack_request *preq);
 
+/* Helpers for fetching objects/info/packs */
+struct http_info_packs_request
+{
+	char *url;
+	struct strbuf *buffer;
+	struct active_request_slot *slot;
+
+	void *callback_data;
+	void (*callback_func)(unsigned char *sha1, void *callback_data);
+};
+
+extern struct http_info_packs_request *new_http_info_packs_request(
+	const char *base_url);
+extern void finish_http_info_packs_request(
+	struct http_info_packs_request *req);
+extern void release_http_info_packs_request(
+	struct http_info_packs_request *req);
+
 #endif /* HTTP_H */
-- 
1.6.3.rc0
