From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 1/2] index-pack: smarter memory usage when resolving deltas
Date: Sun, 11 Apr 2010 22:57:26 -0400
Message-ID: <1271041047-32563-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 04:57:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O19qG-0005vy-Gk
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 04:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809Ab0DLC5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 22:57:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40763 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab0DLC53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 22:57:29 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0Q00220TJR4XD0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 11 Apr 2010 22:57:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc1.237.ge1730.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144702>

In the same spirit as commit 9892bebafe, let's avoid allocating the full
buffer for the deflated data in get_data_from_pack() in order to inflate
it.  Let's read and inflate the data in chunks instead to reduce memory
usage.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 builtin/index-pack.c |   39 +++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b4cf8c5..c746d3b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -359,34 +359,33 @@ static void *get_data_from_pack(struct object_entry *obj)
 {
 	off_t from = obj[0].idx.offset + obj[0].hdr_size;
 	unsigned long len = obj[1].idx.offset - from;
-	unsigned long rdy = 0;
-	unsigned char *src, *data;
+	unsigned char *data, inbuf[4096];
 	z_stream stream;
-	int st;
+	int status;
 
-	src = xmalloc(len);
-	data = src;
-	do {
-		ssize_t n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
-		if (n < 0)
-			die_errno("cannot pread pack file");
-		if (!n)
-			die("premature end of pack file, %lu bytes missing",
-			    len - rdy);
-		rdy += n;
-	} while (rdy < len);
 	data = xmalloc(obj->size);
 	memset(&stream, 0, sizeof(stream));
+	git_inflate_init(&stream);
 	stream.next_out = data;
 	stream.avail_out = obj->size;
-	stream.next_in = src;
-	stream.avail_in = len;
-	git_inflate_init(&stream);
-	while ((st = git_inflate(&stream, Z_FINISH)) == Z_OK);
+
+	do {
+		ssize_t n = (len < sizeof(inbuf)) ? len : sizeof(inbuf);
+		n = pread(pack_fd, inbuf, n, from);
+		if (n < 0)
+			die_errno("cannot pread pack file");
+		if (!n)
+			die("premature end of pack file, %lu bytes missing", len);
+		from += n;
+		len -= n;
+		stream.next_in = inbuf;
+		stream.avail_in = n;
+		status = git_inflate(&stream, 0);
+	} while (len && status == Z_OK && !stream.avail_in);
 	git_inflate_end(&stream);
-	if (st != Z_STREAM_END || stream.total_out != obj->size)
+	/* This has been inflated OK when first encoumtered, so... */
+	if (status != Z_STREAM_END || stream.total_out != obj->size)
 		die("serious inflate inconsistency");
-	free(src);
 	return data;
 }
 
-- 
1.7.1.rc1.237.ge1730.dirty
