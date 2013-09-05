From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 35/38] pack v4: decode tree objects
Date: Thu, 05 Sep 2013 02:19:58 -0400
Message-ID: <1378362001-1738-36-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:20:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSvw-0007xc-V9
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757477Ab3IEGUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22894 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757405Ab3IEGUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:22 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G3W2XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:16 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 4C1662DA05B8	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:16 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233903>

For now we recreate the whole tree object in its canonical form.

Eventually, the core code should grow some ability to walk packv4 tree
entries directly which would be way more efficient.  Not only would that
avoid double tree entry parsing, but the pack v4 encoding allows for
getting at child objects without going through the SHA1 search.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-parse.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 131 insertions(+), 6 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index b80b73e..04eab46 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -151,19 +151,15 @@ static void load_path_dict(struct packed_git *p)
 	p->path_dict = paths;
 }
 
-const unsigned char *get_pathref(struct packed_git *p, const unsigned char **srcp)
+const unsigned char *get_pathref(struct packed_git *p, unsigned int index)
 {
-	unsigned int index;
-
 	if (!p->path_dict)
 		load_path_dict(p);
 
-	index = decode_varint(srcp);
-	if (index < 1 || index - 1 >= p->path_dict->nb_entries) {
+	if (index >= p->path_dict->nb_entries) {
 		error("%s: index overflow", __func__);
 		return NULL;
 	}
-	index -= 1;
 	return p->path_dict->data + p->path_dict->offsets[index];
 }
 
@@ -240,3 +236,132 @@ void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 
 	return dst;
 }
+
+static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
+			  off_t offset, unsigned int start, unsigned int count,
+			  unsigned char **dstp, unsigned long *sizep, int hdr)
+{
+	unsigned long avail;
+	unsigned int nb_entries;
+	const unsigned char *src, *scp;
+	off_t copy_objoffset = 0;
+
+	src = use_pack(p, w_curs, offset, &avail);
+	scp = src;
+
+	if (hdr) {
+		/* we need to skip over the object header */
+		while (*scp & 128)
+			if (++scp - src >= avail - 20)
+				return -1;
+		/* let's still make sure this is actually a tree */
+		if ((*scp++ & 0xf) != OBJ_TREE)
+			return -1;
+	}
+
+	nb_entries = decode_varint(&scp);
+	if (scp == src || start > nb_entries || count > nb_entries - start)
+		return -1;
+	offset += scp - src;
+	avail -= scp - src;
+	src = scp;
+
+	while (count) {
+		unsigned int what;
+
+		if (avail < 20) {
+			src = use_pack(p, w_curs, offset, &avail);
+			if (avail < 20)
+				return -1;
+		}
+		scp = src;
+
+		what = decode_varint(&scp);
+		if (scp == src)
+			return -1;
+
+		if (!(what & 1) && start != 0) {
+			/*
+			 * This is a single entry and we have to skip it.
+			 * The path index was parsed and is in 'what'.
+			 * Skip over the SHA1 index.
+			 */
+			while (*scp++ & 128);
+			start--;
+		} else if (!(what & 1) && start == 0) {
+			/*
+			 * This is an actual tree entry to recreate.
+			 */
+			const unsigned char *path, *sha1;
+			unsigned mode;
+			int len;
+
+			path = get_pathref(p, what >> 1);
+			sha1 = get_sha1ref(p, &scp);
+			if (!path || !sha1)
+				return -1;
+			mode = (path[0] << 8) | path[1];
+			len = snprintf((char *)*dstp, *sizep, "%o %s%c",
+					   mode, path+2, '\0');
+			if (len + 20 > *sizep)
+				return -1;
+			hashcpy(*dstp + len, sha1);
+			*dstp += len + 20;
+			*sizep -= len + 20;
+			count--;
+		} else if (what & 1) {
+			/*
+			 * Copy from another tree object.
+			 */
+			unsigned int copy_start, copy_count;
+
+			copy_start = what >> 1;
+			copy_count = decode_varint(&scp);
+			if (!copy_count)
+				return -1;
+
+			/*
+			 * The LSB of copy_count is a flag indicating if
+			 * a third value is provided to specify the source
+			 * object.  This may be omitted when it doesn't
+			 * change, but has to be specified at least for the
+			 * first copy sequence.
+			 */
+			if (copy_count & 1) {
+				unsigned index = decode_varint(&scp);
+				if (!index)  /* thin pack */
+					return -1;
+				copy_objoffset =
+					nth_packed_object_offset(p, index - 1);
+			}
+			if (!copy_objoffset)
+				return -1;
+			copy_count >>= 1;
+
+			if (start >= copy_count) {
+				start -= copy_count;
+			} else {
+				int ret;
+				copy_count -= start;
+				copy_start += start;
+				start = 0;
+				if (copy_count > count)
+					copy_count = count;
+				count -= copy_count;
+				ret = decode_entries(p, w_curs,
+					copy_objoffset, copy_start, copy_count,
+					dstp, sizep, 1);
+				if (ret)
+					return ret;
+				/* force pack window readjustment */
+				avail = scp - src;
+			}
+		}
+
+		offset += scp - src;
+		avail -= scp - src;
+		src = scp;
+	}
+
+	return 0;
+}
-- 
1.8.4.38.g317e65b
