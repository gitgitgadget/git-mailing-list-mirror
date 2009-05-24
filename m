From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 15/18] http*: add http_get_info_packs
Date: Sun, 24 May 2009 22:20:03 +0800
Message-ID: <20090524222003.7da46ff8.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:23:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Ec4-0006Oo-4P
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbZEXOW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754521AbZEXOW1
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:22:27 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:55668 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbZEXOW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:22:26 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so2113664pzk.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=UHeZ+wi/hP1TP4EzTYl/D7F796G2+1f1AscbjIexKqc=;
        b=R5bWRhcuurta+qTl7VHgCkuxESQSwobG5tfHn6gGK+hSV+T8hChq661hDc0JUeqBdN
         nwRoaAUJFIyOr5CGWdLaFoM1NUl5Z4RldafNuI8UncN/fnnMvlcdXYVtypatKdCL1pTp
         w4D6Jn85DVNj+I5H/yUaDey8IgfBK7aQctiak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=aaNQPElf4LSW8yyeMMEwv0opdOMItwFYdDYAnBmyiZdHE9iJ0WESDXu7NwFd+S19pn
         PFi3dspx7ZpAefVLZjAV0BfJa+NwR4DnWRHp1cMNKH9jgIsPZaSMkBhoGZ5dSUA8ckGY
         Xruqtluf9ztUF0qPulJvuyu0vBh+yjuqDOBwo=
Received: by 10.114.184.7 with SMTP id h7mr12415330waf.151.1243174948038;
        Sun, 24 May 2009 07:22:28 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id j31sm12506735waf.61.2009.05.24.07.22.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:22:27 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119836>

http-push.c and http-walker.c no longer have to use fetch_index or
setup_index; they simply need to use http_get_info_packs, a new http
method, in their fetch_indices implementations.

The code handling the fetching of pack indices in http-push.c and
http-walker.c, namely, the fetch_index and setup_index methods,
have been refactored and moved to http.c.

fetch_index has been moved to http.c, and is not meant to be used
outside of http.c. It invokes end_url_with_slash with base_url;
apart from that change, the code is identical.

setup_index has been moved and renamed to fetch_http_pack_index.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c   |  172 +-----------------------------------------------------
 http-walker.c |  179 ++------------------------------------------------------
 http.c        |  167 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 http.h        |    4 +
 4 files changed, 182 insertions(+), 340 deletions(-)

diff --git a/http-push.c b/http-push.c
index 7aa4fc4..df3e8bf 100644
--- a/http-push.c
+++ b/http-push.c
@@ -950,182 +950,18 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
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
-	unsigned char sha1[20];
-	char *url;
-	struct strbuf buffer = STRBUF_INIT;
-	char *data;
-	int i = 0;
-
-	struct active_request_slot *slot;
 	struct slot_results results;

 	if (push_verbosely)
 		fprintf(stderr, "Getting pack list\n");

-	url = xmalloc(strlen(repo->url) + 20);
-	sprintf(url, "%sobjects/info/packs", repo->url);
-
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			strbuf_release(&buffer);
-			free(url);
-			if (results.http_code == 404)
-				return 0;
-			else
-				return error("%s", curl_errorstr);
-		}
-	} else {
-		strbuf_release(&buffer);
-		free(url);
-		return error("Unable to start request");
-	}
-	free(url);
-
-	data = buffer.buf;
-	while (i < buffer.len) {
-		switch (data[i]) {
-		case 'P':
-			i++;
-			if (i + 52 < buffer.len &&
-			    !prefixcmp(data + i, " pack-") &&
-			    !prefixcmp(data + i + 46, ".pack\n")) {
-				get_sha1_hex(data + i + 6, sha1);
-				setup_index(sha1);
-				i += 51;
-				break;
-			}
-		default:
-			while (data[i] != '\n')
-				i++;
-		}
-		i++;
-	}
+	if (http_get_info_packs(repo->url, &repo->packs) == HTTP_OK)
+		return 0;
+	else
+		return -1;

-	strbuf_release(&buffer);
 	return 0;
 }

diff --git a/http-walker.c b/http-walker.c
index 7d6795c..2aed391 100644
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
@@ -683,14 +566,7 @@ static void fetch_alternates(struct walker *walker, const char *base)

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

 	if (repo->got_indices)
@@ -699,57 +575,16 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 	if (walker->get_verbosely)
 		fprintf(stderr, "Getting pack list for %s\n", repo->base);

-	url = xmalloc(strlen(repo->base) + 21);
-	sprintf(url, "%s/objects/info/packs", repo->base);
-
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			if (missing_target(&results)) {
-				repo->got_indices = 1;
-				goto cleanup;
-			} else {
-				repo->got_indices = 0;
-				ret = error("%s", curl_errorstr);
-				goto cleanup;
-			}
-		}
-	} else {
+	switch (http_get_info_packs(repo->base, &repo->packs)) {
+	case HTTP_OK:
+	case HTTP_MISSING_TARGET:
+		repo->got_indices = 1;
+		break;
+	default:
 		repo->got_indices = 0;
-		ret = error("Unable to start request");
-		goto cleanup;
+		ret = -1;
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
-				setup_index(walker, repo, sha1);
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
-	repo->got_indices = 1;
-cleanup:
-	strbuf_release(&buffer);
-	free(url);
 	return ret;
 }

diff --git a/http.c b/http.c
index c640510..ea46075 100644
--- a/http.c
+++ b/http.c
@@ -789,3 +789,170 @@ int http_fetch_ref(const char *base, struct ref *ref)
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
+
+int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
+{
+	int ret = 0;
+	char *url;
+	struct strbuf buf = STRBUF_INIT;
+	struct http_info_packs_request *req;
+
+	end_url_with_slash(&buf, base_url);
+	strbuf_addstr(&buf, "objects/info/packs");
+	url = strbuf_detach(&buf, NULL);
+
+	ret = http_get_strbuf(url, &buf, HTTP_NO_CACHE);
+	if (ret != HTTP_OK)
+		goto cleanup;
+
+	char *data;
+	int i = 0;
+	unsigned char sha1[20];
+
+	data = buf.buf;
+	while (i < buf.len) {
+		switch (data[i]) {
+		case 'P':
+			i++;
+			if (i + 52 <= buf.len &&
+			    !prefixcmp(data + i, " pack-") &&
+			    !prefixcmp(data + i + 46, ".pack\n")) {
+				get_sha1_hex(data + i + 6, sha1);
+				fetch_http_pack_index(packs_head, sha1,
+						      base_url);
+				i += 51;
+				break;
+			}
+		default:
+			while (i < buf.len && data[i] != '\n')
+				i++;
+		}
+		i++;
+	}
+
+cleanup:
+	free(url);
+	return ret;
+}
diff --git a/http.h b/http.h
index 3d878d5..180b1c2 100644
--- a/http.h
+++ b/http.h
@@ -146,4 +146,8 @@ int http_error(const char *url, int ret);

 extern int http_fetch_ref(const char *base, struct ref *ref);

+/* Helpers for fetching packs */
+extern int http_get_info_packs(const char *base_url,
+	struct packed_git **packs_head);
+
 #endif /* HTTP_H */
--
1.6.3.1
