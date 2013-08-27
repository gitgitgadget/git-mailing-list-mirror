From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 08/23] pack v4: basic references encoding
Date: Tue, 27 Aug 2013 00:25:52 -0400
Message-ID: <1377577567-27655-9-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:27:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAsf-00080x-PO
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab3H0E11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:27:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47516 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab3H0E0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:31 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600DCD9O4IO90@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:29 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 40D902DA066A	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233070>

Add variable length number encoding.  Let's apply the same encoding
currently used for the offset to base of OBJ_OFS_DELTA objects which
is the most efficient way to do this, and apply it to everything with
pack version 4.

Also add SHA1 reference encoding.  This one is either an index into a
SHA1 table encoded using the variable length number encoding, or the
literal 20 bytes SHA1 prefixed with a 0.

The index 0 discriminates between an actual index value or the literal
SHA1.  Therefore when the index is used its value must be increased by 1.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index 012129b..bf33d15 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -245,6 +245,50 @@ static void dict_dump(void)
 	dump_dict_table(tree_path_table);
 }
 
+/*
+ * Encode a numerical value with variable length into the destination buffer
+ */
+static unsigned char *add_number(unsigned char *dst, uint64_t value)
+{
+	unsigned char buf[20];
+	unsigned pos = sizeof(buf) - 1;
+	buf[pos] = value & 127;
+	while (value >>= 7)
+		buf[--pos] = 128 | (--value & 127);
+	do {
+		*dst++ = buf[pos++];
+	} while (pos < sizeof(buf));
+	return dst;
+}
+
+/*
+ * Encode an object SHA1 reference with either an object index into the
+ * pack SHA1 table incremented by 1, or the literal SHA1 value prefixed
+ * with a zero byte if the needed SHA1 is not available in the table.
+ */
+static struct pack_idx_entry *all_objs;
+static unsigned all_objs_nr;
+static unsigned char *add_sha1_ref(unsigned char *dst, const unsigned char *sha1)
+{
+	unsigned lo = 0, hi = all_objs_nr;
+
+	do {
+		unsigned mi = (lo + hi) / 2;
+		int cmp = hashcmp(all_objs[mi].sha1, sha1);
+
+		if (cmp == 0)
+			return add_number(dst, mi + 1);
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi+1;
+	} while (lo < hi);
+
+	*dst++ = 0;
+	hashcpy(dst, sha1);
+	return dst + 20;
+}
+
 static struct pack_idx_entry *get_packed_object_list(struct packed_git *p)
 {
 	unsigned i, nr_objects = p->num_objects;
-- 
1.8.4.22.g54757b7
