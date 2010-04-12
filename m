From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 1/2] index-pack: smarter memory usage when resolving deltas
Date: Mon, 12 Apr 2010 12:11:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004121208560.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 18:27:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1MTT-0007yK-VN
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 18:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab0DLQ0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 12:26:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46109 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab0DLQ0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 12:26:25 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0R00E42UAJYHK0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 Apr 2010 12:11:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144752>


In the same spirit as commit 9892bebafe, let's avoid allocating the full
buffer for the deflated data in get_data_from_pack() in order to inflate
it.  Let's read and inflate the data in chunks instead to reduce memory
usage.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 builtin/index-pack.c |   46 +++++++++++++++++++++++++---------------------
 1 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b4cf8c5..127e713 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -359,34 +359,38 @@ static void *get_data_from_pack(struct object_entry *obj)
 {
 	off_t from = obj[0].idx.offset + obj[0].hdr_size;
 	unsigned long len = obj[1].idx.offset - from;
-	unsigned long rdy = 0;
-	unsigned char *src, *data;
+	unsigned char *data, *inbuf;
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
+	inbuf = xmalloc((len < 64*1024) ? len : 64*1024);
+
 	memset(&stream, 0, sizeof(stream));
+	git_inflate_init(&stream);
 	stream.next_out = data;
 	stream.avail_out = obj->size;
-	stream.next_in = src;
-	stream.avail_in = len;
-	git_inflate_init(&stream);
-	while ((st = git_inflate(&stream, Z_FINISH)) == Z_OK);
-	git_inflate_end(&stream);
-	if (st != Z_STREAM_END || stream.total_out != obj->size)
+
+	do {
+		ssize_t n = (len < 64*1024) ? len : 64*1024;
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
+
+	/* This has been inflated OK when first encountered, so... */
+	if (status != Z_STREAM_END || stream.total_out != obj->size)
 		die("serious inflate inconsistency");
-	free(src);
+
+	git_inflate_end(&stream);
+	free(inbuf);
 	return data;
 }
 
-- 
1.7.1.rc1.237.ge1730.dirty
