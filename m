Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38A6C54EBE
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 03:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbjAQDEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 22:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjAQDEr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 22:04:47 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC074489
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 19:04:45 -0800 (PST)
Received: (qmail 19239 invoked by uid 109); 17 Jan 2023 03:04:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Jan 2023 03:04:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3863 invoked by uid 111); 17 Jan 2023 03:04:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Jan 2023 22:04:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Jan 2023 22:04:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 2/3] http: prefer CURLOPT_SEEKFUNCTION to
 CURLOPT_IOCTLFUNCTION
Message-ID: <Y8YQTC1SPM+flPmC@coredump.intra.peff.net>
References: <Y8YP+R/hyNr6sEFA@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8YP+R/hyNr6sEFA@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The IOCTLFUNCTION option has been deprecated, and generates a compiler
warning in recent versions of curl. We can switch to using SEEKFUNCTION
instead. It was added in 2008 via curl 7.18.0; our INSTALL file already
indicates we require at least curl 7.19.4.

But there's one catch: curl says we should use CURL_SEEKFUNC_{OK,FAIL},
and those didn't arrive until 7.19.5. One workaround would be to use a
bare 0/1 here (or define our own macros).  But let's just bump the
minimum required version to 7.19.5. That version is only a minor version
bump from our existing requirement, and is only a 2 month time bump for
versions that are almost 13 years old. So it's not likely that anybody
cares about the distinction.

Switching means we have to rewrite the ioctl functions into seek
functions. In some ways they are simpler (seeking is the only
operation), but in some ways more complex (the ioctl allowed only a full
rewind, but now we can seek to arbitrary offsets).

Curl will only ever use SEEK_SET (per their documentation), so I didn't
bother implementing anything else, since it would naturally be
completely untested. This seems unlikely to change, but I added an
assertion just in case.

Likewise, I doubt curl will ever try to seek outside of the buffer sizes
we've told it, but I erred on the defensive side here, rather than do an
out-of-bounds read.

Signed-off-by: Jeff King <peff@peff.net>
---
 INSTALL       |  2 +-
 http-push.c   |  4 ++--
 http.c        | 20 +++++++++-----------
 http.h        |  2 +-
 remote-curl.c | 28 +++++++++++++---------------
 5 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/INSTALL b/INSTALL
index 3344788397..d5694f8c47 100644
--- a/INSTALL
+++ b/INSTALL
@@ -139,7 +139,7 @@ Issues of note:
 	  not need that functionality, use NO_CURL to build without
 	  it.
 
-	  Git requires version "7.19.4" or later of "libcurl" to build
+	  Git requires version "7.19.5" or later of "libcurl" to build
 	  without NO_CURL. This version requirement may be bumped in
 	  the future.
 
diff --git a/http-push.c b/http-push.c
index 1b18e775d0..7f71316456 100644
--- a/http-push.c
+++ b/http-push.c
@@ -203,8 +203,8 @@ static void curl_setup_http(CURL *curl, const char *url,
 	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
 	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-	curl_easy_setopt(curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
-	curl_easy_setopt(curl, CURLOPT_IOCTLDATA, buffer);
+	curl_easy_setopt(curl, CURLOPT_SEEKFUNCTION, seek_buffer);
+	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
 	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
diff --git a/http.c b/http.c
index 8a5ba3f477..ca0fe80ddb 100644
--- a/http.c
+++ b/http.c
@@ -157,21 +157,19 @@ size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return size / eltsize;
 }
 
-curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
+int seek_buffer(void *clientp, curl_off_t offset, int origin)
 {
 	struct buffer *buffer = clientp;
 
-	switch (cmd) {
-	case CURLIOCMD_NOP:
-		return CURLIOE_OK;
-
-	case CURLIOCMD_RESTARTREAD:
-		buffer->posn = 0;
-		return CURLIOE_OK;
-
-	default:
-		return CURLIOE_UNKNOWNCMD;
+	if (origin != SEEK_SET)
+		BUG("seek_buffer only handles SEEK_SET");
+	if (offset < 0 || offset >= buffer->buf.len) {
+		error("curl seek would be outside of buffer");
+		return CURL_SEEKFUNC_FAIL;
 	}
+
+	buffer->posn = offset;
+	return CURL_SEEKFUNC_OK;
 }
 
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
diff --git a/http.h b/http.h
index 3c94c47910..77c042706c 100644
--- a/http.h
+++ b/http.h
@@ -40,7 +40,7 @@ struct buffer {
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
-curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
+int seek_buffer(void *clientp, curl_off_t offset, int origin);
 
 /* Slot lifecycle functions */
 struct active_request_slot *get_active_slot(void);
diff --git a/remote-curl.c b/remote-curl.c
index 72dfb8fb86..a76b6405eb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -717,25 +717,23 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	return avail;
 }
 
-static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
+static int rpc_seek(void *clientp, curl_off_t offset, int origin)
 {
 	struct rpc_state *rpc = clientp;
 
-	switch (cmd) {
-	case CURLIOCMD_NOP:
-		return CURLIOE_OK;
+	if (origin != SEEK_SET)
+		BUG("rpc_seek only handles SEEK_SET, not %d", origin);
 
-	case CURLIOCMD_RESTARTREAD:
-		if (rpc->initial_buffer) {
-			rpc->pos = 0;
-			return CURLIOE_OK;
+	if (rpc->initial_buffer) {
+		if (offset < 0 || offset > rpc->len) {
+			error("curl seek would be outside of rpc buffer");
+			return CURL_SEEKFUNC_FAIL;
 		}
-		error(_("unable to rewind rpc post data - try increasing http.postBuffer"));
-		return CURLIOE_FAILRESTART;
-
-	default:
-		return CURLIOE_UNKNOWNCMD;
+		rpc->pos = offset;
+		return CURL_SEEKFUNC_OK;
 	}
+	error(_("unable to rewind rpc post data - try increasing http.postBuffer"));
+	return CURL_SEEKFUNC_FAIL;
 }
 
 struct check_pktline_state {
@@ -959,8 +957,8 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 		rpc->initial_buffer = 1;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
-		curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, rpc_ioctl);
-		curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, rpc);
+		curl_easy_setopt(slot->curl, CURLOPT_SEEKFUNCTION, rpc_seek);
+		curl_easy_setopt(slot->curl, CURLOPT_SEEKDATA, rpc);
 		if (options.verbosity > 1) {
 			fprintf(stderr, "POST %s (chunked)\n", rpc->service_name);
 			fflush(stderr);
-- 
2.39.0.513.g00e40dbe01

