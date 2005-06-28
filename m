From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Obtain sha1_file_info() for deltified pack entry
 properly.
Date: Mon, 27 Jun 2005 23:58:08 -0700
Message-ID: <7vk6kfx91b.fsf@assigned-by-dhcp.cox.net>
References: <20050624.212009.92584730.davem@davemloft.net>
	<42BCE026.8050405@pobox.com>
	<Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
	<42BCF02B.5090706@pobox.com>
	<Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
	<Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
	<7vzmtdq7wy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506261206170.19755@ppc970.osdl.org>
	<7vll4wq4va.fsf@assigned-by-dhcp.cox.net>
	<7v1x6om6o5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506271227160.19755@ppc970.osdl.org>
	<7v64vzyqyw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpsu7x94t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 08:55:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn9zM-0002g4-TM
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 08:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVF1HBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 03:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVF1G7f
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 02:59:35 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:51639 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261535AbVF1G6M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 02:58:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628065809.LPYA17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Jun 2005 02:58:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vpsu7x94t.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 27 Jun 2005 23:56:02 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH 1/3] Obtain sha1_file_info() for deltified pack entry properly.

The initial one was not doing enough to figure things out
without uncompressing too much.  It also fixes a potential
segfault resulting from missing use_packed_git() call.

We would need to introduce unuse_packed_git() call and do proper
use counting to figure out when it is safe to unmap, but
currently we do not unmap packed file yet.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 sha1_file.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 69 insertions(+), 4 deletions(-)

d2f58b4aef500835489f30ac5df7985bc21e3c24
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -601,9 +601,70 @@ void * unpack_sha1_file(void *map, unsig
 	return unpack_sha1_rest(&stream, hdr, *size);
 }
 
-/* Returns 0 on fast-path success, returns 1 on deltified
- * and need to unpack to see info.
- */
+static int packed_delta_info(unsigned char *base_sha1,
+			     unsigned long delta_size,
+			     unsigned long left,
+			     char *type,
+			     unsigned long *sizep)
+{
+	unsigned char *data;
+	unsigned char delta_head[64];
+	int i;
+	unsigned char cmd;
+	unsigned long data_size, result_size, base_size, verify_base_size;
+	z_stream stream;
+	int st;
+
+	if (left < 20)
+		die("truncated pack file");
+	if (sha1_object_info(base_sha1, type, &base_size))
+		die("cannot get info for delta-pack base");
+
+	data = base_sha1 + 20;
+	data_size = left - 20;
+
+	memset(&stream, 0, sizeof(stream));
+
+	stream.next_in = data;
+	stream.avail_in = data_size;
+	stream.next_out = delta_head;
+	stream.avail_out = sizeof(delta_head);
+
+	inflateInit(&stream);
+	st = inflate(&stream, Z_FINISH);
+	inflateEnd(&stream);
+	if ((st != Z_STREAM_END) && stream.total_out != sizeof(delta_head))
+		die("delta data unpack-initial failed");
+
+	/* Examine the initial part of the delta to figure out
+	 * the result size.  Verify the base size while we are at it.
+	 */
+	data = delta_head;
+	verify_base_size = i = 0;
+	cmd = *data++;
+	while (cmd) {
+		if (cmd & 1)
+			verify_base_size |= *data++ << i;
+		i += 8;
+		cmd >>= 1;
+	}
+
+	/* Read the result size */
+	result_size = i = 0;
+	cmd = *data++;
+	while (cmd) {
+		if (cmd & 1)
+			result_size |= *data++ << i;
+		i += 8;
+		cmd >>= 1;
+	}
+	if (verify_base_size != base_size)
+		die("delta base size mismatch");
+
+	*sizep = result_size;
+	return 0;
+}
+
 static int packed_object_info(struct pack_entry *entry,
 			      char *type, unsigned long *sizep)
 {
@@ -614,12 +675,16 @@ static int packed_object_info(struct pac
 	offset = entry->offset;
 	if (p->pack_size - 5 < offset)
 		die("object offset outside of pack file");
+
+	if (use_packed_git(p))
+		die("cannot map packed file");
+
 	pack = p->pack_base + offset;
 	size = (pack[1] << 24) + (pack[2] << 16) + (pack[3] << 8) + pack[4];
 	left = p->pack_size - offset - 5;
 	switch (*pack) {
 	case 'D':
-		return 1;
+		return packed_delta_info(pack+5, size, left, type, sizep);
 		break;
 	case 'C':
 		strcpy(type, "commit");
------------
