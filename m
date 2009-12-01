From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: [PATCH/RFC] Allow curl to rewind the RPC read buffer
Date: Tue, 1 Dec 2009 12:33:39 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0912011232450.5582@cone.home.martin.st>
References: <Pine.LNX.4.64.0904150054470.7479@localhost.localdomain>, <Pine.LNX.4.64.0904142350140.7479@localhost.localdomain>, <1254510286-23155-1-git-send-email-nmiell@gmail.com>, <25718488.post@talk.nabble.com> <20091127234110.7b7e9993.rctay89@gmail.com>
 <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nicholas Miell <nmiell@gmail.com>,
	gsky51@gmail.com, Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 11:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFQ3H-0000fO-6j
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 11:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbZLAKdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 05:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbZLAKdg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 05:33:36 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:51805 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbZLAKdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 05:33:35 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by kirsi2.inet.fi (8.5.014)
        id 4A77692A04A0A608; Tue, 1 Dec 2009 12:33:40 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134195>

When using multi-pass authentication methods, the curl library may need
to rewind the read buffers used for providing data to HTTP POST, if data
has been output before a 401 error is received.

This is needed only when the first request (when the multi-pass
authentication method isn't initialized and hasn't received its challenge
yet) for a certain curl session is a chunked HTTP POST.

As long as the current rpc read buffer is the first one, we're able to
rewind without need for additional buffering.

The curl library currently starts sending data without waiting for a
response to the Expect: 100-continue header, due to a bug in curl that
exists up to curl version 7.19.7.

If the HTTP server doesn't handle Expect: 100-continue headers properly
(e.g. Lighttpd), the library has to start sending data without knowing
if the request will be successfully authenticated. In this case, this
rewinding solution is not sufficient - the whole request will be sent
before the 401 error is received.

Signed-off-by: Martin Storsjo <martin@martin.st>
---

The curl bug is yet unconfirmed upstream, discussed here:
http://article.gmane.org/gmane.comp.web.curl.library/25991

 remote-curl.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index a331bae..28b2a31 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -290,6 +290,7 @@ struct rpc_state {
 	int out;
 	struct strbuf result;
 	unsigned gzip_request : 1;
+	unsigned initial_buffer : 1;
 };
 
 static size_t rpc_out(void *ptr, size_t eltsize,
@@ -300,6 +301,7 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	size_t avail = rpc->len - rpc->pos;
 
 	if (!avail) {
+		rpc->initial_buffer = 0;
 		avail = packet_read_line(rpc->out, rpc->buf, rpc->alloc);
 		if (!avail)
 			return 0;
@@ -314,6 +316,29 @@ static size_t rpc_out(void *ptr, size_t eltsize,
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
+		if (rpc->initial_buffer) {
+			rpc->pos = 0;
+			return CURLIOE_OK;
+		}
+		fprintf(stderr, "Unable to rewind rpc post data - try increasing http.postBuffer\n");
+		return CURLIOE_FAILRESTART;
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
@@ -370,8 +395,13 @@ static int post_rpc(struct rpc_state *rpc)
 		 */
 		headers = curl_slist_append(headers, "Expect: 100-continue");
 		headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
+		rpc->initial_buffer = 1;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
+#ifndef NO_CURL_IOCTL
+		curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, rpc_ioctl);
+		curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, rpc);
+#endif
 		if (options.verbosity > 1) {
 			fprintf(stderr, "POST %s (chunked)\n", rpc->service_name);
 			fflush(stderr);
-- 
1.6.4.4
