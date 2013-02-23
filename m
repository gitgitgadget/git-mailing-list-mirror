From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] pkt-line: Fix sparse errors and warnings
Date: Sat, 23 Feb 2013 18:44:04 +0000
Message-ID: <51290DF4.4040309@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 23 19:46:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9K6q-00021f-O6
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 19:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757814Ab3BWSpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 13:45:43 -0500
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:39955 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622Ab3BWSpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 13:45:43 -0500
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id A7DCAA0C080;
	Sat, 23 Feb 2013 18:45:40 +0000 (GMT)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 53CB3A0C073;	Sat, 23 Feb 2013 18:45:39 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Sat, 23 Feb 2013 18:45:38 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216909>


Sparse issues the following error and warnings:

    pkt-line.c:209:51: warning: Using plain integer as NULL pointer
    sideband.c:41:52: warning: Using plain integer as NULL pointer
    daemon.c:615:39: warning: Using plain integer as NULL pointer
    remote-curl.c:220:75: error: incompatible types for operation (>)
    remote-curl.c:220:75:    left side has type char *
    remote-curl.c:220:75:    right side has type int
    remote-curl.c:291:53: warning: Using plain integer as NULL pointer
    remote-curl.c:408:43: warning: Using plain integer as NULL pointer
    remote-curl.c:562:47: warning: Using plain integer as NULL pointer

All of these complaints "blame" to commit 17243606 ("pkt-line: share
buffer/descriptor reading implementation", 20-02-2013).

In order to suppress the warnings, we simply replace the integer
constant 0 with NULL.

In order to suppress the error message, we simply remove the "> 0" from
the while loop controlling expression.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jeff,

When you next re-roll your 'jk/pkt-line-cleanup' patches, could you
please squash this (or something like it) into commit 17243606
("pkt-line: share buffer/descriptor reading implementation", 20-02-2013).

Please check the resolution of the sparse error, remote-curl.c:220, since
I didn't think too deeply about it, making some assumptions ... ;-)

Note: the commit message mentions an strbuf_get_line() function, but
that is supposed to be packet_get_line(), right?

In addition, that commit adds the following code as part of function
get_packet_data():

+       /* Read up to "size" bytes from our source, whatever it is. */
+       if (src_buf && *src_buf) {
+               ret = size < *src_size ? size : *src_size;
+               memcpy(dst, *src_buf, ret);
+               *src_buf += size;
............................^^^^^
+               *src_size -= size;
+       } else {
+

This could lead to the source buffer pointer being incremented past the
"one past the end" of the buffer; ie to undefined behaviour. That use
of 'size', along with the one on the following line, should be 'ret' no?

ATB,
Ramsay Jones

 daemon.c      | 2 +-
 pkt-line.c    | 2 +-
 remote-curl.c | 8 ++++----
 sideband.c    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/daemon.c b/daemon.c
index 9a241d9..82d5bf5 100644
--- a/daemon.c
+++ b/daemon.c
@@ -612,7 +612,7 @@ static int execute(void)
 		loginfo("Connection from %s:%s", addr, port);
 
 	alarm(init_timeout ? init_timeout : timeout);
-	pktlen = packet_read(0, NULL, 0, packet_buffer, sizeof(packet_buffer), 0);
+	pktlen = packet_read(0, NULL, NULL, packet_buffer, sizeof(packet_buffer), 0);
 	alarm(0);
 
 	len = strlen(line);
diff --git a/pkt-line.c b/pkt-line.c
index 116d5f1..2793ecb 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -206,7 +206,7 @@ static char *packet_read_line_generic(int fd,
 
 char *packet_read_line(int fd, int *len_p)
 {
-	return packet_read_line_generic(fd, NULL, 0, len_p);
+	return packet_read_line_generic(fd, NULL, NULL, len_p);
 }
 
 char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
diff --git a/remote-curl.c b/remote-curl.c
index 3d2b194..93a09a6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -217,7 +217,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 		 * until a packet flush marker.  Ignore these now, but
 		 * in the future we might start to scan them.
 		 */
-		while (packet_read_line_buf(&last->buf, &last->len, NULL) > 0)
+		while (packet_read_line_buf(&last->buf, &last->len, NULL))
 			;
 
 		last->proto_git = 1;
@@ -288,7 +288,7 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 
 	if (!avail) {
 		rpc->initial_buffer = 0;
-		avail = packet_read(rpc->out, NULL, 0, rpc->buf, rpc->alloc, 0);
+		avail = packet_read(rpc->out, NULL, NULL, rpc->buf, rpc->alloc, 0);
 		if (!avail)
 			return 0;
 		rpc->pos = 0;
@@ -405,7 +405,7 @@ static int post_rpc(struct rpc_state *rpc)
 			break;
 		}
 
-		n = packet_read(rpc->out, 0, NULL, buf, left, 0);
+		n = packet_read(rpc->out, NULL, NULL, buf, left, 0);
 		if (!n)
 			break;
 		rpc->len += n;
@@ -559,7 +559,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	rpc->hdr_accept = strbuf_detach(&buf, NULL);
 
 	while (!err) {
-		int n = packet_read(rpc->out, 0, NULL, rpc->buf, rpc->alloc, 0);
+		int n = packet_read(rpc->out, NULL, NULL, rpc->buf, rpc->alloc, 0);
 		if (!n)
 			break;
 		rpc->pos = 0;
diff --git a/sideband.c b/sideband.c
index 857954c..d1125f5 100644
--- a/sideband.c
+++ b/sideband.c
@@ -38,7 +38,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 
 	while (1) {
 		int band, len;
-		len = packet_read(in_stream, NULL, 0, buf + pf, LARGE_PACKET_MAX, 0);
+		len = packet_read(in_stream, NULL, NULL, buf + pf, LARGE_PACKET_MAX, 0);
 		if (len == 0)
 			break;
 		if (len < 1) {
-- 
1.8.1
