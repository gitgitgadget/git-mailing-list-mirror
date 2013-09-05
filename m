From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 11/38] pack v4: tree object encoding
Date: Thu, 05 Sep 2013 02:19:34 -0400
Message-ID: <1378362001-1738-12-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:21:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSwR-0008CG-9u
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346Ab3IEGUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21517 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295Ab3IEGUS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:18 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G402XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id E3C6B2DA05B8	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:14 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233914>

This goes as follows:

- Number of tree entries: variable length encoded.

Then for each tree entry:

- Path component reference: variable length encoded index into the path
  dictionary table which also covers the entry mode. To make the overall
  encoding efficient, the path table is already sorted by usage frequency
  so the most used path names are first and require the shortest index
  encoding.

- SHA1 reference: either variable length encoding of the index into the
  SHA1 table or the literal SHA1 prefixed by 0 (see encode_sha1ref()).

Rationale: all the tree object data is densely encoded while requiring
no zlib inflate processing on access, and all SHA1 references are most
likely to be direct indices into the pack index file requiring no SHA1
search.  Path filtering can be accomplished on the path index directly
without any string comparison during the tree traversal.

Still lacking is some kind of delta encoding for multiple tree objects
with only small differences between them.  But that'll come later.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index d4a79f4..b91ee0b 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -393,6 +393,72 @@ bad:
 	return NULL;
 }
 
+/*
+ * This converts a canonical tree object buffer into its
+ * tightly packed representation using the already populated
+ * and sorted tree_path_table dictionary.  The parsing is
+ * strict so to ensure the canonical version may always be
+ * regenerated and produce the same hash.
+ */
+void *pv4_encode_tree(void *_buffer, unsigned long *sizep)
+{
+	unsigned long size = *sizep;
+	unsigned char *in, *out, *end, *buffer = _buffer;
+	struct tree_desc desc;
+	struct name_entry name_entry;
+	int nb_entries;
+
+	if (!size)
+		return NULL;
+
+	/*
+	 * We can't make sure the result will always be smaller than the
+	 * input. The smallest possible entry is "0 x\0<40 byte SHA1>"
+	 * or 44 bytes.  The output entry may have a realistic path index
+	 * encoding using up to 3 bytes, and a non indexable SHA1 meaning
+	 * 41 bytes.  And the output data already has the nb_entries
+	 * headers.  In practice the output size will be significantly
+	 * smaller but for now let's make it simple.
+	 */
+	in = buffer;
+	out = xmalloc(size + 48);
+	end = out + size + 48;
+	buffer = out;
+
+	/* let's count how many entries there are */
+	init_tree_desc(&desc, in, size);
+	nb_entries = 0;
+	while (tree_entry(&desc, &name_entry))
+		nb_entries++;
+	out += encode_varint(nb_entries, out);
+
+	init_tree_desc(&desc, in, size);
+	while (tree_entry(&desc, &name_entry)) {
+		int pathlen, index;
+
+		if (end - out < 48) {
+			unsigned long sofar = out - buffer;
+			buffer = xrealloc(buffer, (sofar + 48)*2);
+			end = buffer + (sofar + 48)*2;
+			out = buffer + sofar;
+		}
+
+		pathlen = tree_entry_len(&name_entry);
+		index = dict_add_entry(tree_path_table, name_entry.mode,
+				       name_entry.path, pathlen);
+		if (index < 0) {
+			error("missing tree dict entry");
+			free(buffer);
+			return NULL;
+		}
+		out += encode_varint(index, out);
+		out += encode_sha1ref(name_entry.sha1, out);
+	}
+
+	*sizep = out - buffer;
+	return buffer;
+}
+
 static struct pack_idx_entry *get_packed_object_list(struct packed_git *p)
 {
 	unsigned i, nr_objects = p->num_objects;
-- 
1.8.4.38.g317e65b
