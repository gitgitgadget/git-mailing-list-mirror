From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 12/38] pack v4: dictionary table output
Date: Thu, 05 Sep 2013 02:19:35 -0400
Message-ID: <1378362001-1738-13-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:20:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSvi-0007oz-KR
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381Ab3IEGUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53284 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757254Ab3IEGUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:17 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G3Y2XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id EE64A2DA05F2	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:14 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233895>

Here's the code to dump a table into a pack.  Table entries are written
according to the current sort order. This is important as objects use
this order to index into the table.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index b91ee0b..92d3662 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -544,6 +544,55 @@ static int create_pack_dictionaries(struct packed_git *p,
 	return 0;
 }
 
+static unsigned long write_dict_table(struct sha1file *f, struct dict_table *t)
+{
+	unsigned char buffer[1024];
+	unsigned hdrlen;
+	unsigned long size, datalen;
+	z_stream stream;
+	int i, status;
+
+	/*
+	 * Stored dict table format: uncompressed data length followed by
+	 * compressed content.
+	 */
+
+	datalen = t->ptr;
+	hdrlen = encode_varint(datalen, buffer);
+	sha1write(f, buffer, hdrlen);
+
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, pack_compression_level);
+
+	for (i = 0; i < t->nb_entries; i++) {
+		stream.next_in = t->data + t->entry[i].offset;
+		stream.avail_in = 2 + strlen((char *)t->data + t->entry[i].offset + 2) + 1;
+		do {
+			stream.next_out = buffer;
+			stream.avail_out = sizeof(buffer);
+			status = deflate(&stream, 0);
+			size = stream.next_out - (unsigned char *)buffer;
+			sha1write(f, buffer, size);
+		} while (status == Z_OK);
+	}
+	do {
+		stream.next_out = buffer;
+		stream.avail_out = sizeof(buffer);
+		status = deflate(&stream, Z_FINISH);
+		size = stream.next_out - (unsigned char *)buffer;
+		sha1write(f, buffer, size);
+	} while (status == Z_OK);
+	if (status != Z_STREAM_END)
+		die("unable to deflate dictionary table (%d)", status);
+	if (stream.total_in != datalen)
+		die("dict data size mismatch (%ld vs %ld)",
+		    stream.total_in, datalen);
+	datalen = stream.total_out;
+	deflateEnd(&stream);
+
+	return hdrlen + datalen;
+}
+
 static struct packed_git *open_pack(const char *path)
 {
 	char arg[PATH_MAX];
-- 
1.8.4.38.g317e65b
