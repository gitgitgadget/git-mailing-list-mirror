Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E97191F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfAGIen (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:34:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:56334 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725550AbfAGIem (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:34:42 -0500
Received: (qmail 1225 invoked by uid 109); 7 Jan 2019 08:34:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:34:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 723 invoked by uid 111); 7 Jan 2019 08:34:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:34:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:34:40 -0500
Date:   Mon, 7 Jan 2019 03:34:40 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 03/11] http: use struct object_id instead of bare sha1
Message-ID: <20190107083440.GC29431@sigill.intra.peff.net>
References: <20190107083150.GC21362@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107083150.GC21362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dumb-http walker code still passes around and stores object ids as
"unsigned char *sha1". Let's modernize it.

There's probably still more work to be done to handle dumb-http fetches
with a new, larger hash. But that can wait; this is enough that we can
now convert some of the low-level object routines that we call into from
here (and in fact, some of the "oid.hash" references added here will be
further improved in the next patch).

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c   |  2 +-
 http-walker.c |  6 +++---
 http.c        | 14 +++++++-------
 http.h        |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/http-push.c b/http-push.c
index cd48590912..0141b0ad53 100644
--- a/http-push.c
+++ b/http-push.c
@@ -255,7 +255,7 @@ static void start_fetch_loose(struct transfer_request *request)
 	struct active_request_slot *slot;
 	struct http_object_request *obj_req;
 
-	obj_req = new_http_object_request(repo->url, request->obj->oid.hash);
+	obj_req = new_http_object_request(repo->url, &request->obj->oid);
 	if (obj_req == NULL) {
 		request->state = ABORTED;
 		return;
diff --git a/http-walker.c b/http-walker.c
index 0a392c85b6..856716c63d 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -58,7 +58,7 @@ static void start_object_request(struct walker *walker,
 	struct active_request_slot *slot;
 	struct http_object_request *req;
 
-	req = new_http_object_request(obj_req->repo->base, obj_req->oid.hash);
+	req = new_http_object_request(obj_req->repo->base, &obj_req->oid);
 	if (req == NULL) {
 		obj_req->state = ABORTED;
 		return;
@@ -543,11 +543,11 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 	} else if (req->zret != Z_STREAM_END) {
 		walker->corrupt_object_found++;
 		ret = error("File %s (%s) corrupt", hex, req->url);
-	} else if (!hasheq(obj_req->oid.hash, req->real_sha1)) {
+	} else if (!oideq(&obj_req->oid, &req->real_oid)) {
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
-		loose_object_path(the_repository, &buf, req->sha1);
+		loose_object_path(the_repository, &buf, req->oid.hash);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index 0b6807cef9..8d42154792 100644
--- a/http.c
+++ b/http.c
@@ -2337,9 +2337,9 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 }
 
 struct http_object_request *new_http_object_request(const char *base_url,
-	unsigned char *sha1)
+						    const struct object_id *oid)
 {
-	char *hex = sha1_to_hex(sha1);
+	char *hex = oid_to_hex(oid);
 	struct strbuf filename = STRBUF_INIT;
 	struct strbuf prevfile = STRBUF_INIT;
 	int prevlocal;
@@ -2350,10 +2350,10 @@ struct http_object_request *new_http_object_request(const char *base_url,
 
 	freq = xcalloc(1, sizeof(*freq));
 	strbuf_init(&freq->tmpfile, 0);
-	hashcpy(freq->sha1, sha1);
+	oidcpy(&freq->oid, oid);
 	freq->localfile = -1;
 
-	loose_object_path(the_repository, &filename, sha1);
+	loose_object_path(the_repository, &filename, oid->hash);
 	strbuf_addf(&freq->tmpfile, "%s.temp", filename.buf);
 
 	strbuf_addf(&prevfile, "%s.prev", filename.buf);
@@ -2495,16 +2495,16 @@ int finish_http_object_request(struct http_object_request *freq)
 	}
 
 	git_inflate_end(&freq->stream);
-	git_SHA1_Final(freq->real_sha1, &freq->c);
+	git_SHA1_Final(freq->real_oid.hash, &freq->c);
 	if (freq->zret != Z_STREAM_END) {
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	if (!hasheq(freq->sha1, freq->real_sha1)) {
+	if (!oideq(&freq->oid, &freq->real_oid)) {
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	loose_object_path(the_repository, &filename, freq->sha1);
+	loose_object_path(the_repository, &filename, freq->oid.hash);
 	freq->rename = finalize_object_file(freq->tmpfile.buf, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/http.h b/http.h
index d305ca1dc7..66c52b2e1e 100644
--- a/http.h
+++ b/http.h
@@ -224,8 +224,8 @@ struct http_object_request {
 	CURLcode curl_result;
 	char errorstr[CURL_ERROR_SIZE];
 	long http_code;
-	unsigned char sha1[20];
-	unsigned char real_sha1[20];
+	struct object_id oid;
+	struct object_id real_oid;
 	git_SHA_CTX c;
 	git_zstream stream;
 	int zret;
@@ -234,7 +234,7 @@ struct http_object_request {
 };
 
 extern struct http_object_request *new_http_object_request(
-	const char *base_url, unsigned char *sha1);
+	const char *base_url, const struct object_id *oid);
 extern void process_http_object_request(struct http_object_request *freq);
 extern int finish_http_object_request(struct http_object_request *freq);
 extern void abort_http_object_request(struct http_object_request *freq);
-- 
2.20.1.470.g640a3e2614

