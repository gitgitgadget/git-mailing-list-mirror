Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549CD1F51C
	for <e@80x24.org>; Sat, 19 May 2018 01:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeESB4l (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 21:56:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:46168 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751117AbeESB4k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 21:56:40 -0400
Received: (qmail 9193 invoked by uid 109); 19 May 2018 01:56:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 19 May 2018 01:56:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15858 invoked by uid 111); 19 May 2018 01:56:47 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 May 2018 21:56:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2018 18:56:37 -0700
Date:   Fri, 18 May 2018 18:56:37 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] http: use strbufs instead of fixed buffers
Message-ID: <20180519015636.GA32492@sigill.intra.peff.net>
References: <20180519015444.GA12080@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180519015444.GA12080@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We keep the names of incoming packs and objects in fixed
PATH_MAX-size buffers, and snprintf() into them. This is
unlikely to end up with truncated filenames, but it is
possible (especially on systems where PATH_MAX is shorter
than actual paths can be). Let's switch to using strbufs,
which makes the question go away entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
The diff is a little noisy due to the s/tmpfile/&.buf/ everywhere. The
interesting lines to look at are initialization and release, which I
think I got right.

 http.c | 66 ++++++++++++++++++++++++++++++++--------------------------
 http.h |  4 ++--
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/http.c b/http.c
index fed13b2169..260bd10f95 100644
--- a/http.c
+++ b/http.c
@@ -2082,6 +2082,7 @@ void release_http_pack_request(struct http_pack_request *preq)
 		preq->packfile = NULL;
 	}
 	preq->slot = NULL;
+	strbuf_release(&preq->tmpfile);
 	free(preq->url);
 	free(preq);
 }
@@ -2104,19 +2105,19 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	if (!strip_suffix(preq->tmpfile, ".pack.temp", &len))
+	if (!strip_suffix(preq->tmpfile.buf, ".pack.temp", &len))
 		die("BUG: pack tmpfile does not end in .pack.temp?");
-	tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile);
+	tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile.buf);
 
 	argv_array_push(&ip.args, "index-pack");
 	argv_array_pushl(&ip.args, "-o", tmp_idx, NULL);
-	argv_array_push(&ip.args, preq->tmpfile);
+	argv_array_push(&ip.args, preq->tmpfile.buf);
 	ip.git_cmd = 1;
 	ip.no_stdin = 1;
 	ip.no_stdout = 1;
 
 	if (run_command(&ip)) {
-		unlink(preq->tmpfile);
+		unlink(preq->tmpfile.buf);
 		unlink(tmp_idx);
 		free(tmp_idx);
 		return -1;
@@ -2124,7 +2125,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 
 	unlink(sha1_pack_index_name(p->sha1));
 
-	if (finalize_object_file(preq->tmpfile, sha1_pack_name(p->sha1))
+	if (finalize_object_file(preq->tmpfile.buf, sha1_pack_name(p->sha1))
 	 || finalize_object_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
 		free(tmp_idx);
 		return -1;
@@ -2143,6 +2144,7 @@ struct http_pack_request *new_http_pack_request(
 	struct http_pack_request *preq;
 
 	preq = xcalloc(1, sizeof(*preq));
+	strbuf_init(&preq->tmpfile, 0);
 	preq->target = target;
 
 	end_url_with_slash(&buf, base_url);
@@ -2150,12 +2152,11 @@ struct http_pack_request *new_http_pack_request(
 		sha1_to_hex(target->sha1));
 	preq->url = strbuf_detach(&buf, NULL);
 
-	snprintf(preq->tmpfile, sizeof(preq->tmpfile), "%s.temp",
-		sha1_pack_name(target->sha1));
-	preq->packfile = fopen(preq->tmpfile, "a");
+	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(target->sha1));
+	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
 		error("Unable to open local file %s for pack",
-		      preq->tmpfile);
+		      preq->tmpfile.buf);
 		goto abort;
 	}
 
@@ -2182,6 +2183,7 @@ struct http_pack_request *new_http_pack_request(
 	return preq;
 
 abort:
+	strbuf_release(&preq->tmpfile);
 	free(preq->url);
 	free(preq);
 	return NULL;
@@ -2232,7 +2234,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 {
 	char *hex = sha1_to_hex(sha1);
 	struct strbuf filename = STRBUF_INIT;
-	char prevfile[PATH_MAX];
+	struct strbuf prevfile = STRBUF_INIT;
 	int prevlocal;
 	char prev_buf[PREV_BUF_SIZE];
 	ssize_t prev_read = 0;
@@ -2240,40 +2242,41 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	struct http_object_request *freq;
 
 	freq = xcalloc(1, sizeof(*freq));
+	strbuf_init(&freq->tmpfile, 0);
 	hashcpy(freq->sha1, sha1);
 	freq->localfile = -1;
 
 	sha1_file_name(the_repository, &filename, sha1);
-	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
-		 "%s.temp", filename.buf);
+	strbuf_addf(&freq->tmpfile, "%s.temp", filename.buf);
 
-	snprintf(prevfile, sizeof(prevfile), "%s.prev", filename.buf);
-	unlink_or_warn(prevfile);
-	rename(freq->tmpfile, prevfile);
-	unlink_or_warn(freq->tmpfile);
+	strbuf_addf(&prevfile, "%s.prev", filename.buf);
+	unlink_or_warn(prevfile.buf);
+	rename(freq->tmpfile.buf, prevfile.buf);
+	unlink_or_warn(freq->tmpfile.buf);
 	strbuf_release(&filename);
 
 	if (freq->localfile != -1)
 		error("fd leakage in start: %d", freq->localfile);
-	freq->localfile = open(freq->tmpfile,
+	freq->localfile = open(freq->tmpfile.buf,
 			       O_WRONLY | O_CREAT | O_EXCL, 0666);
 	/*
 	 * This could have failed due to the "lazy directory creation";
 	 * try to mkdir the last path component.
 	 */
 	if (freq->localfile < 0 && errno == ENOENT) {
-		char *dir = strrchr(freq->tmpfile, '/');
+		char *dir = strrchr(freq->tmpfile.buf, '/');
 		if (dir) {
 			*dir = 0;
-			mkdir(freq->tmpfile, 0777);
+			mkdir(freq->tmpfile.buf, 0777);
 			*dir = '/';
 		}
-		freq->localfile = open(freq->tmpfile,
+		freq->localfile = open(freq->tmpfile.buf,
 				       O_WRONLY | O_CREAT | O_EXCL, 0666);
 	}
 
 	if (freq->localfile < 0) {
-		error_errno("Couldn't create temporary file %s", freq->tmpfile);
+		error_errno("Couldn't create temporary file %s",
+			    freq->tmpfile.buf);
 		goto abort;
 	}
 
@@ -2287,7 +2290,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	 * If a previous temp file is present, process what was already
 	 * fetched.
 	 */
-	prevlocal = open(prevfile, O_RDONLY);
+	prevlocal = open(prevfile.buf, O_RDONLY);
 	if (prevlocal != -1) {
 		do {
 			prev_read = xread(prevlocal, prev_buf, PREV_BUF_SIZE);
@@ -2304,7 +2307,8 @@ struct http_object_request *new_http_object_request(const char *base_url,
 		} while (prev_read > 0);
 		close(prevlocal);
 	}
-	unlink_or_warn(prevfile);
+	unlink_or_warn(prevfile.buf);
+	strbuf_release(&prevfile);
 
 	/*
 	 * Reset inflate/SHA1 if there was an error reading the previous temp
@@ -2319,7 +2323,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 			lseek(freq->localfile, 0, SEEK_SET);
 			if (ftruncate(freq->localfile, 0) < 0) {
 				error_errno("Couldn't truncate temporary file %s",
-					    freq->tmpfile);
+					    freq->tmpfile.buf);
 				goto abort;
 			}
 		}
@@ -2349,6 +2353,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	return freq;
 
 abort:
+	strbuf_release(&prevfile);
 	free(freq->url);
 	free(freq);
 	return NULL;
@@ -2376,24 +2381,24 @@ int finish_http_object_request(struct http_object_request *freq)
 	if (freq->http_code == 416) {
 		warning("requested range invalid; we may already have all the data.");
 	} else if (freq->curl_result != CURLE_OK) {
-		if (stat(freq->tmpfile, &st) == 0)
+		if (stat(freq->tmpfile.buf, &st) == 0)
 			if (st.st_size == 0)
-				unlink_or_warn(freq->tmpfile);
+				unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
 
 	git_inflate_end(&freq->stream);
 	git_SHA1_Final(freq->real_sha1, &freq->c);
 	if (freq->zret != Z_STREAM_END) {
-		unlink_or_warn(freq->tmpfile);
+		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
 	if (hashcmp(freq->sha1, freq->real_sha1)) {
-		unlink_or_warn(freq->tmpfile);
+		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
 	sha1_file_name(the_repository, &filename, freq->sha1);
-	freq->rename = finalize_object_file(freq->tmpfile, filename.buf);
+	freq->rename = finalize_object_file(freq->tmpfile.buf, filename.buf);
 	strbuf_release(&filename);
 
 	return freq->rename;
@@ -2401,7 +2406,7 @@ int finish_http_object_request(struct http_object_request *freq)
 
 void abort_http_object_request(struct http_object_request *freq)
 {
-	unlink_or_warn(freq->tmpfile);
+	unlink_or_warn(freq->tmpfile.buf);
 
 	release_http_object_request(freq);
 }
@@ -2421,4 +2426,5 @@ void release_http_object_request(struct http_object_request *freq)
 		release_active_slot(freq->slot);
 		freq->slot = NULL;
 	}
+	strbuf_release(&freq->tmpfile);
 }
diff --git a/http.h b/http.h
index 4df4a25e1a..d305ca1dc7 100644
--- a/http.h
+++ b/http.h
@@ -207,7 +207,7 @@ struct http_pack_request {
 	struct packed_git *target;
 	struct packed_git **lst;
 	FILE *packfile;
-	char tmpfile[PATH_MAX];
+	struct strbuf tmpfile;
 	struct active_request_slot *slot;
 };
 
@@ -219,7 +219,7 @@ extern void release_http_pack_request(struct http_pack_request *preq);
 /* Helpers for fetching object */
 struct http_object_request {
 	char *url;
-	char tmpfile[PATH_MAX];
+	struct strbuf tmpfile;
 	int localfile;
 	CURLcode curl_result;
 	char errorstr[CURL_ERROR_SIZE];
-- 
2.17.0.1052.g7d69f75dbf

