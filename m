From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 30/38] pack v4: code to recreate a canonical commit object
Date: Thu, 05 Sep 2013 02:19:53 -0400
Message-ID: <1378362001-1738-31-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:21:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSw9-000832-ON
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab3IEGUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43577 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757254Ab3IEGUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:21 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G422XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:16 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 0CC372DA0547	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:16 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233909>

Usage of snprintf() is possibly not the most efficient approach.
For example we could simply copy the needed strings and generate
the SHA1 hex strings directly into the destination buffer.  But
such optimizations may come later.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-parse.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/packv4-parse.c b/packv4-parse.c
index 074e107..bca1a97 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -129,3 +129,77 @@ const unsigned char *get_nameref(struct packed_git *p, const unsigned char **src
 	}
 	return p->name_dict->data + p->name_dict->offsets[index];
 }
+
+void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
+		     off_t offset, unsigned long size)
+{
+	unsigned long avail;
+	git_zstream stream;
+	int len, st;
+	unsigned int nb_parents;
+	unsigned char *dst, *dcp;
+	const unsigned char *src, *scp, *sha1, *name;
+	unsigned long time;
+	int16_t tz;
+
+	dst = xmallocz(size);
+	dcp = dst;
+
+	src = use_pack(p, w_curs, offset, &avail);
+	scp = src;
+
+	sha1 = get_sha1ref(p, &scp);
+	len = snprintf((char *)dcp, size, "tree %s\n", sha1_to_hex(sha1));
+	dcp += len;
+	size -= len;
+
+	nb_parents = decode_varint(&scp);
+	while (nb_parents--) {
+		sha1 = get_sha1ref(p, &scp);
+		len = snprintf((char *)dcp, size, "parent %s\n", sha1_to_hex(sha1));
+		if (len >= size)
+			die("overflow in %s", __func__);
+		dcp += len;
+		size -= len;
+	}
+
+	name = get_nameref(p, &scp);
+	tz = (name[0] << 8) | name[1];
+	time = decode_varint(&scp);
+	len = snprintf((char *)dcp, size, "author %s %lu %+05d\n", name+2, time, tz);
+	if (len >= size)
+		die("overflow in %s", __func__);
+	dcp += len;
+	size -= len;
+
+	name = get_nameref(p, &scp);
+	tz = (name[0] << 8) | name[1];
+	time = decode_varint(&scp);
+	len = snprintf((char *)dcp, size, "committer %s %lu %+05d\n", name+2, time, tz);
+	if (len >= size)
+		die("overflow in %s", __func__);
+	dcp += len;
+	size -= len;
+
+	if (scp - src > avail)
+		die("overflow in %s", __func__);
+	offset += scp - src;
+
+	memset(&stream, 0, sizeof(stream));
+	stream.next_out = dcp;
+	stream.avail_out = size + 1;
+	git_inflate_init(&stream);
+	do {
+		src = use_pack(p, w_curs, offset, &stream.avail_in);
+		stream.next_in = (unsigned char *)src;
+		st = git_inflate(&stream, Z_FINISH);
+		offset += stream.next_in - src;
+	} while ((st == Z_OK || st == Z_BUF_ERROR) && stream.avail_out);
+	git_inflate_end(&stream);
+	if (st != Z_STREAM_END || stream.total_out != size) {
+		free(dst);
+		return NULL;
+	}
+
+	return dst;
+}
-- 
1.8.4.38.g317e65b
