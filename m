From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 20/23] http*: add http_get_info_packs
Date: Sat, 6 Jun 2009 16:43:59 +0800
Message-ID: <20090606164359.818a2d9f.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Clemens Buchacher <drizzd@aon.at>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:51:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrcL-0004Mp-97
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbZFFIuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbZFFIui
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:50:38 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:34239 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbZFFIug (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:50:36 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so1305746pzk.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=YEZlKQwHv8qzK/0oUmXht+jajdqi+SsLdV8oQ0ezDfM=;
        b=R0h9+1Qw1v6zULqFKLpyjDJlw0qkdKk1uCrTBXos7Erm0mHSylMx58okZ4rrWE+BpJ
         a/rSS4F27FdIeD2zAtRRC/HuwEp+Yd+S3zVyghV2uacSAEw1uYC5UuqPmYEn8Pt/bcQt
         waL4KOge+DGDOIbABPNJpGFS+g5z2FLMwyges=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=jAcCtk5tCWJ43jjW20QQvEiJdH4i4mbqplA2LEvLHnLD9uxvsWMMWKDymZiYVMwU+t
         42oqjEgQX/fW6128goihTIbWs+cYLMRjHNT3q17kqWfHN9Zybw+zyqzijQPAlz8PN/Fh
         ebI2ZmQZnS8uL4Tt+EFGDQLRcFjEDnzquyWU0=
Received: by 10.142.80.16 with SMTP id d16mr1510007wfb.181.1244278239244;
        Sat, 06 Jun 2009 01:50:39 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 27sm2708111wfa.22.2009.06.06.01.50.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:50:38 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120902>

http-push.c and http-walker.c no longer have to use fetch_index or
setup_index; they simply need to use http_get_info_packs, a new http
method, in their fetch_indices implementations.

Move fetch_index() and rename to fetch_pack_index() in http.c; this
method is not meant to be used outside of http.c. It invokes
end_url_with_slash with base_url; apart from that change, the code is
identical.

Move setup_index() and rename to fetch_and_setup_pack_index() in
http.c; this method is not meant to be used outside of http.c.

Do not immediately set ret to 0 in http-walker.c::fetch_indices();
instead do it in the HTTP_MISSING_TARGET case, to make it clear that
the HTTP_OK and HTTP_MISSING_TARGET cases both return 0.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Clemens, I've corrected the return values for
http-push.c::fetch_indices(). I won't touch repo->has_info_packs yet,
though, as I've already mentioned.

 http-push.c   |  179 +++----------------------------------------------------
 http-walker.c |  184 +++------------------------------------------------------
 http.c        |  164 ++++++++++++++++++++++++++++++++++++++++++++++++++
 http.h        |    4 +
 4 files changed, 186 insertions(+), 345 deletions(-)

diff --git a/http-push.c b/http-push.c
index 1714e4e..d6f3b8e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -953,184 +953,23 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
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
-	slot->local = NULL;
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
-	struct slot_results results;
+	int ret;

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
+	switch (http_get_info_packs(repo->url, &repo->packs)) {
+	case HTTP_OK:
+	case HTTP_MISSING_TARGET:
+		ret = 0;
+		break;
+	default:
+		ret = -1;
 	}

-	strbuf_release(&buffer);
-	return 0;
+	return ret;
 }

 static void one_remote_object(const char *hex)
diff --git a/http-walker.c b/http-walker.c
index 032a7be..ac343fd 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -368,124 +368,6 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
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
-	slot->local = NULL;
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
@@ -684,15 +566,7 @@ static void fetch_alternates(struct walker *walker, const char *base)

 static int fetch_indices(struct walker *walker, struct alt_base *repo)
 {
-	unsigned char sha1[20];
-	char *url;
-	struct strbuf buffer = STRBUF_INIT;
-	char *data;
-	int i = 0;
-	int ret = 0;
-
-	struct active_request_slot *slot;
-	struct slot_results results;
+	int ret;

 	if (repo->got_indices)
 		return 0;
@@ -700,57 +574,17 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
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
+		ret = 0;
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
index 2a49372..96d83d5 100644
--- a/http.c
+++ b/http.c
@@ -790,3 +790,167 @@ int http_fetch_ref(const char *base, struct ref *ref)
 	free(url);
 	return ret;
 }
+
+/* Helpers for fetching packs */
+static int fetch_pack_index(unsigned char *sha1, const char *base_url)
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
+	slot->local = NULL;
+cleanup_pack:
+	free(hex);
+	free(url);
+	return ret;
+}
+
+static int fetch_and_setup_pack_index(struct packed_git **packs_head,
+	unsigned char *sha1, const char *base_url)
+{
+	struct packed_git *new_pack;
+
+	if (fetch_pack_index(sha1, base_url))
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
+	int ret = 0, i = 0;
+	char *url, *data;
+	struct strbuf buf = STRBUF_INIT;
+	unsigned char sha1[20];
+
+	end_url_with_slash(&buf, base_url);
+	strbuf_addstr(&buf, "objects/info/packs");
+	url = strbuf_detach(&buf, NULL);
+
+	ret = http_get_strbuf(url, &buf, HTTP_NO_CACHE);
+	if (ret != HTTP_OK)
+		goto cleanup;
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
+				fetch_and_setup_pack_index(packs_head, sha1,
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
