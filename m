From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] remote-curl: hoist gzip buffer size to top of post_rpc
Date: Wed, 31 Oct 2012 07:55:22 -0400
Message-ID: <20121031115522.GA21011@sigill.intra.peff.net>
References: <20121031115346.GC30879@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 12:55:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTWtX-0005Dd-75
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 12:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727Ab2JaLz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 07:55:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45005 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932556Ab2JaLzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 07:55:25 -0400
Received: (qmail 13248 invoked by uid 107); 31 Oct 2012 11:56:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Oct 2012 07:56:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2012 07:55:22 -0400
Content-Disposition: inline
In-Reply-To: <20121031115346.GC30879@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208809>

When we gzip the post data for a smart-http rpc request, we
compute the gzip body and its size inside the "use_gzip"
conditional. We keep track of the body after the conditional
ends, but not the size. Let's remember both, which will
enable us to retry failed gzip requests in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a tiny change conceptually, but the name change makes the diff
quite noisy. Thus I pulled it into a separate patch from 2/2.

 remote-curl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index aefafd3..10cd47d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -413,6 +413,7 @@ static int post_rpc(struct rpc_state *rpc)
 	struct curl_slist *headers = NULL;
 	int use_gzip = rpc->gzip_request;
 	char *gzip_body = NULL;
+	size_t gzip_size;
 	int err, large_request = 0;
 
 	/* Try to load the entire request, if we can fit it into the
@@ -478,19 +479,18 @@ retry:
 		 * we can try to deflate it ourselves, this may save on.
 		 * the transfer time.
 		 */
-		size_t size;
 		git_zstream stream;
 		int ret;
 
 		memset(&stream, 0, sizeof(stream));
 		git_deflate_init_gzip(&stream, Z_BEST_COMPRESSION);
-		size = git_deflate_bound(&stream, rpc->len);
-		gzip_body = xmalloc(size);
+		gzip_size = git_deflate_bound(&stream, rpc->len);
+		gzip_body = xmalloc(gzip_size);
 
 		stream.next_in = (unsigned char *)rpc->buf;
 		stream.avail_in = rpc->len;
 		stream.next_out = (unsigned char *)gzip_body;
-		stream.avail_out = size;
+		stream.avail_out = gzip_size;
 
 		ret = git_deflate(&stream, Z_FINISH);
 		if (ret != Z_STREAM_END)
@@ -500,16 +500,16 @@ retry:
 		if (ret != Z_OK)
 			die("cannot deflate request; zlib end error %d", ret);
 
-		size = stream.total_out;
+		gzip_size = stream.total_out;
 
 		headers = curl_slist_append(headers, "Content-Encoding: gzip");
 		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, gzip_body);
-		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, size);
+		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, gzip_size);
 
 		if (options.verbosity > 1) {
 			fprintf(stderr, "POST %s (gzip %lu to %lu bytes)\n",
 				rpc->service_name,
-				(unsigned long)rpc->len, (unsigned long)size);
+				(unsigned long)rpc->len, (unsigned long)gzip_size);
 			fflush(stderr);
 		}
 	} else {
-- 
1.8.0.207.gdf2154c
