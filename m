From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 17/38] pack v4: tree object delta encoding
Date: Thu, 05 Sep 2013 02:19:40 -0400
Message-ID: <1378362001-1738-18-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:21:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSx3-000050-2J
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757790Ab3IEGVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:21:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22894 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757289Ab3IEGUS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:18 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G3Y2XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 42C112DA0547	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:15 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233925>

In order to be able to quickly walk tree objects, let's encode their
"delta" as a range of entries into another tree object.

In order to discriminate between a copy sequence from a regular entry,
the entry index LSB is reserved to indicate a copy sequence.  Therefore
the actual index of a path component is shifted left one bit.

The encoding allows for the base object to change so multiple base
objects can be borrowed from.  The code doesn't try to exploit this
possibility at the moment though.

The code isn't optimal at the moment as it doesn't consider the case
where a copy sequence could be larger than the local sequence it
means to replace.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 5 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index 5d76234..6830a0a 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -394,24 +394,53 @@ bad:
 	return NULL;
 }
 
+static int compare_tree_entries(struct name_entry *e1, struct name_entry *e2)
+{
+	int len1 = tree_entry_len(e1);
+	int len2 = tree_entry_len(e2);
+	int len = len1 < len2 ? len1 : len2;
+	unsigned char c1, c2;
+	int cmp;
+
+	cmp = memcmp(e1->path, e2->path, len);
+	if (cmp)
+		return cmp;
+	c1 = e1->path[len];
+	c2 = e2->path[len];
+	if (!c1 && S_ISDIR(e1->mode))
+		c1 = '/';
+	if (!c2 && S_ISDIR(e2->mode))
+		c2 = '/';
+	return c1 - c2;
+}
+
 /*
  * This converts a canonical tree object buffer into its
  * tightly packed representation using the already populated
  * and sorted tree_path_table dictionary.  The parsing is
  * strict so to ensure the canonical version may always be
  * regenerated and produce the same hash.
+ *
+ * If a delta buffer is provided, we may encode multiple ranges of tree
+ * entries against that buffer.
  */
-void *pv4_encode_tree(void *_buffer, unsigned long *sizep)
+void *pv4_encode_tree(void *_buffer, unsigned long *sizep,
+		      void *delta, unsigned long delta_size,
+		      const unsigned char *delta_sha1)
 {
 	unsigned long size = *sizep;
 	unsigned char *in, *out, *end, *buffer = _buffer;
-	struct tree_desc desc;
-	struct name_entry name_entry;
+	struct tree_desc desc, delta_desc;
+	struct name_entry name_entry, delta_entry;
 	int nb_entries;
+	unsigned int copy_start, copy_count = 0, delta_pos = 0, first_delta = 1;
 
 	if (!size)
 		return NULL;
 
+	if (!delta_size)
+		delta = NULL;
+
 	/*
 	 * We can't make sure the result will always be smaller than the
 	 * input. The smallest possible entry is "0 x\0<40 byte SHA1>"
@@ -434,9 +463,42 @@ void *pv4_encode_tree(void *_buffer, unsigned long *sizep)
 	out += encode_varint(nb_entries, out);
 
 	init_tree_desc(&desc, in, size);
+	if (delta) {
+		init_tree_desc(&delta_desc, delta, delta_size);
+		if (!tree_entry(&delta_desc, &delta_entry))
+			delta = NULL;
+	}
+
 	while (tree_entry(&desc, &name_entry)) {
 		int pathlen, index;
 
+		/*
+		 * Try to match entries against our delta object.
+		 */
+		if (delta) {
+			int ret;
+
+			do {
+				ret = compare_tree_entries(&name_entry, &delta_entry);
+				if (ret <= 0 || copy_count != 0)
+					break;
+				delta_pos++;
+				if (!tree_entry(&delta_desc, &delta_entry))
+					delta = NULL;
+			} while (delta);
+
+			if (ret == 0 && name_entry.mode == delta_entry.mode &&
+			    hashcmp(name_entry.sha1, delta_entry.sha1) == 0) {
+				if (!copy_count)
+					copy_start = delta_pos;
+				copy_count++;
+				delta_pos++;
+				if (!tree_entry(&delta_desc, &delta_entry))
+					delta = NULL;
+				continue;
+			}
+		}
+
 		if (end - out < 48) {
 			unsigned long sofar = out - buffer;
 			buffer = xrealloc(buffer, (sofar + 48)*2);
@@ -444,6 +506,32 @@ void *pv4_encode_tree(void *_buffer, unsigned long *sizep)
 			out = buffer + sofar;
 		}
 
+		if (copy_count) {
+			/*
+			 * Let's write a sequence indicating we're copying
+			 * entries from another object:
+			 *
+			 * entry_start + entry_count + object_ref
+			 *
+			 * To distinguish between 'entry_start' and an actual
+			 * entry index, we use the LSB = 1.
+			 *
+			 * Furthermore, if object_ref is the same as the
+			 * preceding one, we can omit it and save some
+			 * more space, especially if that ends up being a
+			 * full sha1 reference.  Let's steal the LSB
+			 * of entry_count for that purpose.
+			 */
+			copy_start = (copy_start << 1) | 1;
+			copy_count = (copy_count << 1) | first_delta;
+			out += encode_varint(copy_start, out);
+			out += encode_varint(copy_count, out);
+			if (first_delta)
+				out += encode_sha1ref(delta_sha1, out);
+			copy_count = 0;
+			first_delta = 0;
+		}
+
 		pathlen = tree_entry_len(&name_entry);
 		index = dict_add_entry(tree_path_table, name_entry.mode,
 				       name_entry.path, pathlen);
@@ -452,10 +540,20 @@ void *pv4_encode_tree(void *_buffer, unsigned long *sizep)
 			free(buffer);
 			return NULL;
 		}
-		out += encode_varint(index, out);
+		out += encode_varint(index << 1, out);
 		out += encode_sha1ref(name_entry.sha1, out);
 	}
 
+	if (copy_count) {
+		/* flush the trailing copy */
+		copy_start = (copy_start << 1) | 1;
+		copy_count = (copy_count << 1) | first_delta;
+		out += encode_varint(copy_start, out);
+		out += encode_varint(copy_count, out);
+		if (first_delta)
+			out += encode_sha1ref(delta_sha1, out);
+	}
+
 	*sizep = out - buffer;
 	return buffer;
 }
@@ -761,7 +859,7 @@ static off_t packv4_write_object(struct sha1file *f, struct packed_git *p,
 		result = pv4_encode_commit(src, &size);
 		break;
 	case OBJ_TREE:
-		result = pv4_encode_tree(src, &size);
+		result = pv4_encode_tree(src, &size, NULL, 0, NULL);
 		break;
 	default:
 		die("unexpected object type %d", type);
-- 
1.8.4.38.g317e65b
