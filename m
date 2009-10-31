From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 24/28] Smart HTTP fetch: gzip requests
Date: Fri, 30 Oct 2009 17:47:43 -0700
Message-ID: <1256950067-27938-26-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:49:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N429s-0001yQ-DJ
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933175AbZJaAsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757565AbZJaAsi
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:48:38 -0400
Received: from george.spearce.org ([209.20.77.23]:36965 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933106AbZJaAsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:48:00 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C56C938200; Sat, 31 Oct 2009 00:48:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1082E3811E;
	Sat, 31 Oct 2009 00:47:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131811>

The upload-pack requests are mostly plain text and they compress
rather well.  Deflating them with Content-Encoding: gzip can easily
drop the size of the request by 50%, reducing the amount of data
to transfer as we negotiate the common commits.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 remote-curl.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0eb6fc4..0d7cf16 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -289,6 +289,7 @@ struct rpc_state {
 	int in;
 	int out;
 	struct strbuf result;
+	unsigned gzip_request : 1;
 };
 
 static size_t rpc_out(void *ptr, size_t eltsize,
@@ -327,6 +328,8 @@ static int post_rpc(struct rpc_state *rpc)
 	struct active_request_slot *slot;
 	struct slot_results results;
 	struct curl_slist *headers = NULL;
+	int use_gzip = rpc->gzip_request;
+	char *gzip_body = NULL;
 	int err = 0, large_request = 0;
 
 	/* Try to load the entire request, if we can fit it into the
@@ -340,6 +343,7 @@ static int post_rpc(struct rpc_state *rpc)
 
 		if (left < LARGE_PACKET_MAX) {
 			large_request = 1;
+			use_gzip = 0;
 			break;
 		}
 
@@ -355,6 +359,7 @@ static int post_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
+	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
@@ -372,6 +377,49 @@ static int post_rpc(struct rpc_state *rpc)
 			fflush(stderr);
 		}
 
+	} else if (use_gzip && 1024 < rpc->len) {
+		/* The client backend isn't giving us compressed data so
+		 * we can try to deflate it ourselves, this may save on.
+		 * the transfer time.
+		 */
+		size_t size;
+		z_stream stream;
+		int ret;
+
+		memset(&stream, 0, sizeof(stream));
+		ret = deflateInit2(&stream, Z_BEST_COMPRESSION,
+				Z_DEFLATED, (15 + 16),
+				8, Z_DEFAULT_STRATEGY);
+		if (ret != Z_OK)
+			die("cannot deflate request; zlib init error %d", ret);
+		size = deflateBound(&stream, rpc->len);
+		gzip_body = xmalloc(size);
+
+		stream.next_in = (unsigned char *)rpc->buf;
+		stream.avail_in = rpc->len;
+		stream.next_out = (unsigned char *)gzip_body;
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
+		if (options.verbosity > 1) {
+			fprintf(stderr, "POST %s (gzip %lu to %lu bytes)\n",
+				rpc->service_name,
+				(unsigned long)rpc->len, (unsigned long)size);
+			fflush(stderr);
+		}
 	} else {
 		/* We know the complete request size in advance, use the
 		 * more normal Content-Length approach.
@@ -398,6 +446,7 @@ static int post_rpc(struct rpc_state *rpc)
 	}
 
 	curl_slist_free_all(headers);
+	free(gzip_body);
 	return err;
 }
 
@@ -523,6 +572,7 @@ static int fetch_git(struct discovery *heads,
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name = "git-upload-pack",
 	rpc.argv = argv;
+	rpc.gzip_request = 1;
 
 	err = rpc_service(&rpc, heads);
 	if (rpc.result.len)
-- 
1.6.5.2.181.gd6f41
