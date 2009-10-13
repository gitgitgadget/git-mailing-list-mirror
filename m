From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 16/16] Smart HTTP fetch: gzip requests
Date: Mon, 12 Oct 2009 19:25:15 -0700
Message-ID: <1255400715-10508-17-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXDF-0004cs-Li
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbZJMC05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbZJMC0w
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:26:52 -0400
Received: from george.spearce.org ([209.20.77.23]:56207 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932658AbZJMC0u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:26:50 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id F2E8138269; Tue, 13 Oct 2009 02:25:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3848238222;
	Tue, 13 Oct 2009 02:25:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130116>

The upload-pack requests are mostly plain text and they compress
rather well.  Deflating them with Content-Encoding: gzip can easily
drop the size of the request by 50%, reducing the amount of data
to transfer as we negotiate the common commits.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 remote-curl.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 31d1d34..d53215d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -261,11 +261,12 @@ static size_t rpc_in(const void *ptr, size_t eltsize,
 	return size;
 }
 
-static int post_rpc(struct rpc_state *state)
+static int post_rpc(struct rpc_state *state, int use_gzip)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
 	struct curl_slist *headers = NULL;
+	unsigned char *gzip_body = NULL;
 	int err = 0, large_request = 0;
 
 	/* Try to load the entire request, if we can fit it into the
@@ -279,6 +280,7 @@ static int post_rpc(struct rpc_state *state)
 
 		if (left < LARGE_PACKET_MAX) {
 			large_request = 1;
+			use_gzip = 0;
 			break;
 		}
 
@@ -311,6 +313,48 @@ static int post_rpc(struct rpc_state *state)
 			fflush(stderr);
 		}
 
+	} else if (use_gzip && 1024 < state->len) {
+		/* The client backend isn't giving us compressed data so
+		 * we can try to deflate it ourselves, this may save on.
+		 * the transfer time.
+		 */
+		size_t size;
+		z_stream stream;
+		int ret;
+
+		memset(&stream, 0, sizeof(stream));
+		ret = deflateInit2(&stream, Z_DEFAULT_COMPRESSION,
+				Z_DEFLATED, (15 + 16),
+				8, Z_DEFAULT_STRATEGY);
+		if (ret != Z_OK)
+			die("cannot deflate request; zlib init error %d", ret);
+		size = deflateBound(&stream, state->len);
+		gzip_body = xmalloc(size);
+
+		stream.next_in = (unsigned char *)state->buf;
+		stream.avail_in = state->len;
+		stream.next_out = gzip_body;
+		stream.avail_out = size;
+
+		ret = deflate(&stream, Z_FINISH);
+		if (ret != Z_STREAM_END)
+			die("cannot deflate request; zlib deflate error %d", ret);
+
+		ret = deflateEnd(&stream);
+		if (ret != Z_OK)
+			die("cannot deflate request; zlib end error %d", ret);
+
+		size = stream.total_out;
+
+		headers = curl_slist_append(headers, "Content-Encoding: gzip");
+		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, gzip_body);
+		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, size);
+
+		if (state->verbose) {
+			fprintf(stderr, "POST %s (gzip %lu to %lu bytes)\n",
+				state->service_name, state->len, size);
+			fflush(stderr);
+		}
 	} else {
 		/* We know the complete request size in advance, use the
 		 * more normal Content-Length approach.
@@ -336,11 +380,13 @@ static int post_rpc(struct rpc_state *state)
 		}
 	}
 	curl_slist_free_all(headers);
+	free(gzip_body);
 	return err;
 }
 
 static int one_shot_rpc_service(const char *service,
 	int verbose,
+	int use_gzip,
 	const char **client_argv,
 	struct discovery *heads,
 	struct strbuf *result)
@@ -384,7 +430,7 @@ static int one_shot_rpc_service(const char *service,
 			break;
 		state.pos = 0;
 		state.len = n;
-		err |= post_rpc(&state);
+		err |= post_rpc(&state, use_gzip);
 	}
 	if (result)
 		strbuf_read(result, client.out, 0);
@@ -474,6 +520,7 @@ static int fetch_git(struct fetch_args *args,
 
 	err = one_shot_rpc_service("git-upload-pack",
 		args->verbose,
+		1 /* gzip request */,
 		argv, heads, &res);
 	if (res.len)
 		safe_write(1, res.buf, res.len);
@@ -611,6 +658,7 @@ static int push_git(struct discovery *heads,
 
 	err = one_shot_rpc_service("git-receive-pack",
 		args->verbose,
+		0 /* no gzip */,
 		argv, heads, &res);
 	if (res.len)
 		safe_write(1, res.buf, res.len);
-- 
1.6.5.52.g0ff2e
