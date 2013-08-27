From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 14/23] pack v4: object data copy
Date: Tue, 27 Aug 2013 00:25:58 -0400
Message-ID: <1377577567-27655-15-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:27:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAsI-0007jK-RR
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab3H0E07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47516 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab3H0E0d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:33 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600G0G9O51090@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:29 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id A955F2DA05FA	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233058>

Blob and tag objects have no particular changes except for their object
header.

Delta objects are also copied as is, except for their delta base reference
which is converted to the new way as used elsewhere in pack v4 encoding
i.e. an index into the SHA1 table or a literal SHA1 prefixed by 0 if not
found in the table (see add_sha1_ref).  This is true for both REF_DELTA
as well as OFS_DELTA.

Object payload is validated against the recorded CRC32 in the source
pack index file when possible.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index 6e0bb1d..a6dc818 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -12,6 +12,7 @@
 #include "object.h"
 #include "tree-walk.h"
 #include "pack.h"
+#include "pack-revindex.h"
 
 
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
@@ -673,6 +674,71 @@ static unsigned int write_object_header(struct sha1file *f, enum object_type typ
 	return end - buf;
 }
 
+static unsigned long copy_object_data(struct sha1file *f, struct packed_git *p,
+				      off_t offset)
+{
+	struct pack_window *w_curs = NULL;
+	struct revindex_entry *revidx;
+	enum object_type type;
+	unsigned long avail, size, datalen, written;
+	int hdrlen, idx_nr;
+	unsigned char *src, *end, buf[24];
+
+	revidx = find_pack_revindex(p, offset);
+	idx_nr = revidx->nr;
+	datalen = revidx[1].offset - offset;
+
+	src = use_pack(p, &w_curs, offset, &avail);
+	hdrlen = unpack_object_header_buffer(src, avail, &type, &size);
+
+	written = write_object_header(f, type, size);
+
+	if (type == OBJ_OFS_DELTA) {
+		unsigned char c = src[hdrlen++];
+		off_t base_offset = c & 127;
+		while (c & 128) {
+			base_offset += 1;
+			if (!base_offset || MSB(base_offset, 7))
+				die("delta offset overflow");
+			c = src[hdrlen++];
+			base_offset = (base_offset << 7) + (c & 127);
+		}
+		base_offset = offset - base_offset;
+		if (base_offset <= 0 || base_offset >= offset)
+			die("delta offset out of bound");
+		revidx = find_pack_revindex(p, base_offset);
+		end = add_sha1_ref(buf, nth_packed_object_sha1(p, revidx->nr));
+		sha1write(f, buf, end - buf);
+		written += end - buf;
+	} else if (type == OBJ_REF_DELTA) {
+		end = add_sha1_ref(buf, src + hdrlen);
+		hdrlen += 20;
+		sha1write(f, buf, end - buf);
+		written += end - buf;
+	}
+
+	if (p->index_version > 1 &&
+	    check_pack_crc(p, &w_curs, offset, datalen, idx_nr))
+		die("bad CRC for object at offset %"PRIuMAX" in %s",
+		    (uintmax_t)offset, p->pack_name);
+
+	offset += hdrlen;
+	datalen -= hdrlen;
+
+	while (datalen) {
+		src = use_pack(p, &w_curs, offset, &avail);
+		if (avail > datalen)
+			avail = datalen;
+		sha1write(f, src, avail);
+		written += avail;
+		offset += avail;
+		datalen -= avail;
+	}
+	unuse_pack(&w_curs);
+
+	return written;
+}
+
 static struct packed_git *open_pack(const char *path)
 {
 	char arg[PATH_MAX];
-- 
1.8.4.22.g54757b7
