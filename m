From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 08/38] pack v4: basic SHA1 reference encoding
Date: Thu, 05 Sep 2013 02:19:31 -0400
Message-ID: <1378362001-1738-9-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:22:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSxC-00009K-Qr
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762639Ab3IEGVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:21:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53284 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756205Ab3IEGUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:17 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G422XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:14 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id C69942DA066B	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:14 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233927>

The SHA1 reference is either an index into a SHA1 table using the variable
length number encoding, or the literal 20 bytes SHA1 prefixed with a 0.

The index 0 discriminates between an actual index value or the literal
SHA1.  Therefore when the index is used its value must be increased by 1.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index 012129b..12527c0 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -12,6 +12,7 @@
 #include "object.h"
 #include "tree-walk.h"
 #include "pack.h"
+#include "varint.h"
 
 struct data_entry {
 	unsigned offset;
@@ -245,6 +246,34 @@ static void dict_dump(void)
 	dump_dict_table(tree_path_table);
 }
 
+/*
+ * Encode an object SHA1 reference with either an object index into the
+ * pack SHA1 table incremented by 1, or the literal SHA1 value prefixed
+ * with a zero byte if the needed SHA1 is not available in the table.
+ */
+static struct pack_idx_entry *all_objs;
+static unsigned all_objs_nr;
+static int encode_sha1ref(const unsigned char *sha1, unsigned char *buf)
+{
+	unsigned lo = 0, hi = all_objs_nr;
+
+	do {
+		unsigned mi = (lo + hi) / 2;
+		int cmp = hashcmp(all_objs[mi].sha1, sha1);
+
+		if (cmp == 0)
+			return encode_varint(mi + 1, buf);
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi+1;
+	} while (lo < hi);
+
+	*buf++ = 0;
+	hashcpy(buf, sha1);
+	return 1 + 20;
+}
+
 static struct pack_idx_entry *get_packed_object_list(struct packed_git *p)
 {
 	unsigned i, nr_objects = p->num_objects;
-- 
1.8.4.38.g317e65b
