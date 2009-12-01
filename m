From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: [PATCH/RFC] Allow curl to rewind the RPC read buffer at any time
Date: Tue, 1 Dec 2009 12:37:26 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0912011236360.5582@cone.home.martin.st>
References: <Pine.LNX.4.64.0904150054470.7479@localhost.localdomain>, <Pine.LNX.4.64.0904142350140.7479@localhost.localdomain>, <1254510286-23155-1-git-send-email-nmiell@gmail.com>, <25718488.post@talk.nabble.com> <20091127234110.7b7e9993.rctay89@gmail.com>
 <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nicholas Miell <nmiell@gmail.com>,
	gsky51@gmail.com, Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 11:37:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFQ6w-0002Ge-3O
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 11:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbZLAKhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 05:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752667AbZLAKhW
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 05:37:22 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:34253 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265AbZLAKhW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 05:37:22 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by jenni2.inet.fi (8.5.014)
        id 4A777091046C7CC4; Tue, 1 Dec 2009 12:37:26 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134196>

When using multi-pass authentication methods, the curl library may
need to rewind the read buffers used for providing data to HTTP POST,
if data has been output before a 401 error is received.

This solution buffers all data read by the curl library, in order to allow
it to rewind the reading buffer at any time later.

If communicating with a HTTP server that doesn't support the
Expect: 100-continue headers, all HTTP POST data will be sent before
the server replies with the 401 error containing the authentication
challenge.

The buffering is enabled only if the rpc_service function allocates a
buffer - this should perhaps be limited to the cases where http.authAny
is enabled.

Signed-off-by: Martin Storsjo <martin@martin.st>
---
 remote-curl.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index a331bae..c1c5ccd 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -286,6 +286,10 @@ struct rpc_state {
 	size_t alloc;
 	size_t len;
 	size_t pos;
+	char *rewind_buf;
+	size_t rewind_buf_size;
+	size_t rewind_buf_write_pos;
+	size_t rewind_buf_read_pos;
 	int in;
 	int out;
 	struct strbuf result;
@@ -299,12 +303,28 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	struct rpc_state *rpc = buffer_;
 	size_t avail = rpc->len - rpc->pos;
 
+	if (rpc->rewind_buf && rpc->rewind_buf_read_pos < rpc->rewind_buf_write_pos) {
+		avail = rpc->rewind_buf_write_pos - rpc->rewind_buf_read_pos;
+		if (max < avail)
+			avail = max;
+		memcpy(ptr, rpc->rewind_buf + rpc->rewind_buf_read_pos, avail);
+		rpc->rewind_buf_read_pos += avail;
+		return avail;
+	}
+
 	if (!avail) {
 		avail = packet_read_line(rpc->out, rpc->buf, rpc->alloc);
 		if (!avail)
 			return 0;
 		rpc->pos = 0;
 		rpc->len = avail;
+
+		if (rpc->rewind_buf) {
+			ALLOC_GROW(rpc->rewind_buf, rpc->rewind_buf_write_pos + avail, rpc->rewind_buf_size);
+			memcpy(rpc->rewind_buf + rpc->rewind_buf_write_pos, rpc->buf, avail);
+			rpc->rewind_buf_write_pos += avail;
+			rpc->rewind_buf_read_pos += avail;
+		}
 	}
 
 	if (max < avail)
@@ -314,6 +334,26 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	return avail;
 }
 
+#ifndef NO_CURL_IOCTL
+curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
+{
+	struct rpc_state *rpc = clientp;
+
+	switch (cmd) {
+	case CURLIOCMD_NOP:
+		return CURLIOE_OK;
+
+	case CURLIOCMD_RESTARTREAD:
+		rpc->rewind_buf_read_pos = 0;
+		rpc->pos = rpc->len;
+		return CURLIOE_OK;
+
+	default:
+		return CURLIOE_UNKNOWNCMD;
+	}
+}
+#endif
+
 static size_t rpc_in(const void *ptr, size_t eltsize,
 		size_t nmemb, void *buffer_)
 {
@@ -370,8 +410,18 @@ static int post_rpc(struct rpc_state *rpc)
 		 */
 		headers = curl_slist_append(headers, "Expect: 100-continue");
 		headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
+		if (rpc->rewind_buf) {
+			ALLOC_GROW(rpc->rewind_buf, rpc->rewind_buf_write_pos + rpc->len, rpc->rewind_buf_size);
+			memcpy(rpc->rewind_buf, rpc->buf, rpc->len);
+			rpc->rewind_buf_read_pos = rpc->len;
+			rpc->rewind_buf_write_pos = rpc->len;
+		}
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
+#ifndef NO_CURL_IOCTL
+		curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, rpc_ioctl);
+		curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, rpc);
+#endif
 		if (options.verbosity > 1) {
 			fprintf(stderr, "POST %s (chunked)\n", rpc->service_name);
 			fflush(stderr);
@@ -472,6 +522,8 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	rpc->buf = xmalloc(rpc->alloc);
 	rpc->in = client.in;
 	rpc->out = client.out;
+	rpc->rewind_buf_size = 100;
+	rpc->rewind_buf = xmalloc(rpc->rewind_buf_size);
 	strbuf_init(&rpc->result, 0);
 
 	strbuf_addf(&buf, "%s/%s", url, svc);
@@ -503,6 +555,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	free(rpc->hdr_content_type);
 	free(rpc->hdr_accept);
 	free(rpc->buf);
+	free(rpc->rewind_buf);
 	strbuf_release(&buf);
 	return err;
 }
-- 
1.6.4.4
