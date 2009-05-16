From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 08/11] http*: add fetch_http_pack_index
Date: Sat, 16 May 2009 11:51:52 +0800
Message-ID: <20090516115152.5137d4b3.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 16 05:56:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5B0V-0005js-6q
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 05:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbZEPDzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 23:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756778AbZEPDzm
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 23:55:42 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:32965 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814AbZEPDzj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 23:55:39 -0400
Received: by mail-px0-f123.google.com with SMTP id 29so1312541pxi.33
        for <git@vger.kernel.org>; Fri, 15 May 2009 20:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=C/gicxtiGl7NN2vSWlBwuR62OPVz8hs2A/uDuUpUKh0=;
        b=bWmkGghcamsK+sg3v6ahYZjObJ0380Wm5EY5190LkCXUqlQgp67eQi/TQtuqh2N75x
         9XxkWt5u3xQfgHpvrMJot4ESeL9qaWcJCV2uHp4ZG8xb5cjdZ7yIlPsPxS1G+Of1qvWc
         UgNGCWs6zyG0R1rS9NNy13iEmJwM53aVAH/dI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=v+RLgxrxQETWNyOT15rn+wg7+ipGI2Xedt8uUK/SHJa/7CjUSRi7uWTXVK8rOXwiIs
         h4zCPjTQLEgRTeRUrktH/G/jfPKSfce69ZZqb8oV+dOHz0qGCJT7gaB/OgLVTkLoKQOt
         kB5nxXDAtKlzePfL/grOaeynvThBBt2wWXf7I=
Received: by 10.115.108.5 with SMTP id k5mr6112966wam.90.1242446141267;
        Fri, 15 May 2009 20:55:41 -0700 (PDT)
Received: from your-cukc5e3z5n (cm112.zeta149.maxonline.com.sg [116.87.149.112])
        by mx.google.com with ESMTPS id m31sm2147702wag.16.2009.05.15.20.55.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 20:55:40 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119331>

The code handling the fetching of pack indices in http-push.c and
http-walker.c, namely, the fetch_index and setup_index methods,
have been refactored and moved to http.c.

fetch_index has been moved to http.c, and is not meant to be used
outside of http.c. It invokes end_url_with_slash with base_url;
apart from that change, the code is identical.

setup_index has been moved and renamed to fetch_http_pack_index.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c   |  117 +------------------------------------------------------
 http-walker.c |  119 +-------------------------------------------------------
 http.c        |  122 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 http.h        |    4 ++
 4 files changed, 128 insertions(+), 234 deletions(-)

diff --git a/http-push.c b/http-push.c
index 7cbc8cf..ece7a43 100644
--- a/http-push.c
+++ b/http-push.c
@@ -949,121 +949,6 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	return 1;
 }
 
-static int fetch_index(unsigned char *sha1)
-{
-	int ret = 0;
-	char *hex = xstrdup(sha1_to_hex(sha1));
-	char *filename;
-	char *url;
-	char tmpfile[PATH_MAX];
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
-
-	FILE *indexfile;
-	struct active_request_slot *slot;
-	struct slot_results results;
-
-	/* Don't use the index if the pack isn't there */
-	url = xmalloc(strlen(repo->url) + 64);
-	sprintf(url, "%sobjects/pack/pack-%s.pack", repo->url, hex);
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			ret = error("Unable to verify pack %s is available",
-				    hex);
-			goto cleanup_pack;
-		}
-	} else {
-		ret = error("Unable to start request");
-		goto cleanup_pack;
-	}
-
-	if (has_pack_index(sha1)) {
-		ret = 0;
-		goto cleanup_pack;
-	}
-
-	if (push_verbosely)
-		fprintf(stderr, "Getting index for pack %s\n", hex);
-
-	sprintf(url, "%sobjects/pack/pack-%s.idx", repo->url, hex);
-
-	filename = sha1_pack_index_name(sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	indexfile = fopen(tmpfile, "a");
-	if (!indexfile) {
-		ret = error("Unable to open local file %s for pack index",
-			    tmpfile);
-		goto cleanup_pack;
-	}
-
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
-	slot->local = indexfile;
-
-	/*
-	 * If there is data present from a previous transfer attempt,
-	 * resume where it left off
-	 */
-	prev_posn = ftell(indexfile);
-	if (prev_posn>0) {
-		if (push_verbosely)
-			fprintf(stderr,
-				"Resuming fetch of index for pack %s at byte %ld\n",
-				hex, prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
-	}
-
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			ret = error("Unable to get pack index %s\n%s", url,
-				    curl_errorstr);
-			goto cleanup_index;
-		}
-	} else {
-		ret = error("Unable to start request");
-		goto cleanup_index;
-	}
-
-	ret = move_temp_to_file(tmpfile, filename);
-
-cleanup_index:
-	fclose(indexfile);
-cleanup_pack:
-	free(url);
-	free(hex);
-	return ret;
-}
-
-static int setup_index(unsigned char *sha1)
-{
-	struct packed_git *new_pack;
-
-	if (fetch_index(sha1))
-		return -1;
-
-	new_pack = parse_pack_index(sha1);
-	if (!new_pack)
-		return -1; /* parse_pack_index() already issued error message */
-	new_pack->next = repo->packs;
-	repo->packs = new_pack;
-	return 0;
-}
-
 static int fetch_indices(void)
 {
 	unsigned char sha1[20];
@@ -1113,7 +998,7 @@ static int fetch_indices(void)
 			    !prefixcmp(data + i, " pack-") &&
 			    !prefixcmp(data + i + 46, ".pack\n")) {
 				get_sha1_hex(data + i + 6, sha1);
-				setup_index(sha1);
+				fetch_http_pack_index(&repo->packs, sha1, repo->url);
 				i += 51;
 				break;
 			}
diff --git a/http-walker.c b/http-walker.c
index 024ed58..3a0c021 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -368,123 +368,6 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 #endif
 }
 
-static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
-{
-	int ret = 0;
-	char *hex = xstrdup(sha1_to_hex(sha1));
-	char *filename;
-	char *url;
-	char tmpfile[PATH_MAX];
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
-
-	FILE *indexfile;
-	struct active_request_slot *slot;
-	struct slot_results results;
-
-	/* Don't use the index if the pack isn't there */
-	url = xmalloc(strlen(repo->base) + 64);
-	sprintf(url, "%s/objects/pack/pack-%s.pack", repo->base, hex);
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			ret = error("Unable to verify pack %s is available",
-				     hex);
-			goto cleanup_pack;
-		}
-	} else {
-		ret = error("Unable to start request");
-		goto cleanup_pack;
-	}
-
-	if (has_pack_index(sha1)) {
-		ret = 0;
-		goto cleanup_pack;
-	}
-
-	if (walker->get_verbosely)
-		fprintf(stderr, "Getting index for pack %s\n", hex);
-
-	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
-
-	filename = sha1_pack_index_name(sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	indexfile = fopen(tmpfile, "a");
-	if (!indexfile) {
-		ret = error("Unable to open local file %s for pack index",
-			    tmpfile);
-		goto cleanup_pack;
-	}
-
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
-	slot->local = indexfile;
-
-	/*
-	 * If there is data present from a previous transfer attempt,
-	 * resume where it left off
-	 */
-	prev_posn = ftell(indexfile);
-	if (prev_posn>0) {
-		if (walker->get_verbosely)
-			fprintf(stderr,
-				"Resuming fetch of index for pack %s at byte %ld\n",
-				hex, prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
-	}
-
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			ret = error("Unable to get pack index %s\n%s", url,
-				    curl_errorstr);
-			goto cleanup_index;
-		}
-	} else {
-		ret = error("Unable to start request");
-		goto cleanup_index;
-	}
-
-	ret = move_temp_to_file(tmpfile, filename);
-
-cleanup_index:
-	fclose(indexfile);
-cleanup_pack:
-	free(url);
-	free(hex);
-	return ret;
-}
-
-static int setup_index(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
-{
-	struct packed_git *new_pack;
-	if (has_pack_file(sha1))
-		return 0; /* don't list this as something we can get */
-
-	if (fetch_index(walker, repo, sha1))
-		return -1;
-
-	new_pack = parse_pack_index(sha1);
-	if (!new_pack)
-		return -1; /* parse_pack_index() already issued error message */
-	new_pack->next = repo->packs;
-	repo->packs = new_pack;
-	return 0;
-}
-
 static void process_alternates_response(void *callback_data)
 {
 	struct alternates_request *alt_req =
@@ -735,7 +618,7 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 			    !prefixcmp(data + i, " pack-") &&
 			    !prefixcmp(data + i + 46, ".pack\n")) {
 				get_sha1_hex(data + i + 6, sha1);
-				setup_index(walker, repo, sha1);
+				fetch_http_pack_index(&repo->packs, sha1, repo->base);
 				i += 51;
 				break;
 			}
diff --git a/http.c b/http.c
index 75fce9e..91c6bf6 100644
--- a/http.c
+++ b/http.c
@@ -703,3 +703,125 @@ int http_fetch_ref(const char *base, struct ref *ref)
 	free(url);
 	return ret;
 }
+
+/* Helpers for fetching packs */
+static int fetch_index(unsigned char *sha1, const char *base_url)
+{
+	int ret = 0;
+	char *hex = xstrdup(sha1_to_hex(sha1));
+	char *filename;
+	char *url;
+	char tmpfile[PATH_MAX];
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct strbuf buf = STRBUF_INIT;
+	struct curl_slist *range_header = NULL;
+
+	FILE *indexfile;
+	struct active_request_slot *slot;
+	struct slot_results results;
+
+	/* Don't use the index if the pack isn't there */
+	end_url_with_slash(&buf, base_url);
+	strbuf_addf(&buf, "objects/pack/pack-%s.pack", hex);
+	url = strbuf_detach(&buf, 0);
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK) {
+			ret = error("Unable to verify pack %s is available",
+				    hex);
+			goto cleanup_pack;
+		}
+	} else {
+		ret = error("Unable to start request");
+		goto cleanup_pack;
+	}
+
+	if (has_pack_index(sha1)) {
+		ret = 0;
+		goto cleanup_pack;
+	}
+
+	if (http_is_verbose)
+		fprintf(stderr, "Getting index for pack %s\n", hex);
+
+	end_url_with_slash(&buf, base_url);
+	strbuf_addf(&buf, "objects/pack/pack-%s.idx", hex);
+	url = strbuf_detach(&buf, NULL);
+
+	filename = sha1_pack_index_name(sha1);
+	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
+	indexfile = fopen(tmpfile, "a");
+	if (!indexfile) {
+		ret = error("Unable to open local file %s for pack index",
+			    tmpfile);
+		goto cleanup_pack;
+	}
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
+	slot->local = indexfile;
+
+	/*
+	 * If there is data present from a previous transfer attempt,
+	 * resume where it left off
+	 */
+	prev_posn = ftell(indexfile);
+	if (prev_posn>0) {
+		if (http_is_verbose)
+			fprintf(stderr,
+				"Resuming fetch of index for pack %s at byte %ld\n",
+				hex, prev_posn);
+		sprintf(range, "Range: bytes=%ld-", prev_posn);
+		range_header = curl_slist_append(range_header, range);
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
+	}
+
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK) {
+			ret = error("Unable to get pack index %s\n%s",
+				    url, curl_errorstr);
+			goto cleanup_index;
+		}
+	} else {
+		ret = error("Unable to start request");
+		goto cleanup_index;
+	}
+
+	ret = move_temp_to_file(tmpfile, filename);
+
+cleanup_index:
+	fclose(indexfile);
+cleanup_pack:
+	free(hex);
+	free(url);
+	return ret;
+}
+
+int fetch_http_pack_index(struct packed_git **packs_head, unsigned char *sha1,
+	const char *base_url)
+{
+	struct packed_git *new_pack;
+
+	if (fetch_index(sha1, base_url))
+		return -1;
+
+	new_pack = parse_pack_index(sha1);
+	if (!new_pack)
+		return -1; /* parse_pack_index() already issued error message */
+	new_pack->next = *packs_head;
+	*packs_head = new_pack;
+	return 0;
+}
diff --git a/http.h b/http.h
index 1ef7dc1..cd2920b 100644
--- a/http.h
+++ b/http.h
@@ -116,4 +116,8 @@ static inline int missing__target(int code, int result)
 
 extern int http_fetch_ref(const char *base, struct ref *ref);
 
+/* Helpers for fetching packs */
+extern int fetch_http_pack_index(struct packed_git **packs_head,
+	unsigned char *sha1, const char *base_url);
+
 #endif /* HTTP_H */
-- 
1.6.3.rc0
