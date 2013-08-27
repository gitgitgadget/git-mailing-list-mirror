From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 16/23] pack v4: tree object delta encoding
Date: Tue, 27 Aug 2013 00:26:00 -0400
Message-ID: <1377577567-27655-17-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:26:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEArX-000780-Ia
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134Ab3H0E0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30513 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab3H0E0d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:33 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600F6B9O5GV90@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:30 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id CBA9F2DA056B	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233050>

In order to be able to quickly walk tree objects, let's encode their
"delta" as a range of entries into another tree object.

The encoding allows for the base object to change so multiple base
objects can be borrowed from.  The code doesn't try to exploit this
possibility at the moment though.

The code isn't optimal at the moment as it doesn't consider the case
where a borrow sequence could be larger than the local sequence it
means to replace.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 104 insertions(+), 11 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index a9e4fb3..744514c 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -409,24 +409,53 @@ bad:
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
-void * conv_to_dict_tree(void *buffer, unsigned long *psize)
+void * conv_to_dict_tree(void *buffer, unsigned long *psize,
+			 void *delta, unsigned long delta_size,
+			 const unsigned char *delta_sha1)
 {
 	unsigned long size = *psize;
 	unsigned char *in, *out, *end;
-	struct tree_desc desc;
-	struct name_entry name_entry;
+	struct tree_desc desc, delta_desc;
+	struct name_entry name_entry, delta_entry;
 	int nb_entries;
+	unsigned int delta_start, delta_pos = 0, delta_match = 0, first_delta = 1;
 
 	if (!size)
 		return NULL;
 
+	if (!delta_size)
+		delta = NULL;
+
 	/*
 	 * We can't make sure the result will always be smaller.
 	 * The smallest possible entry is "0 x\0<40 byte SHA1>"
@@ -449,21 +478,85 @@ void * conv_to_dict_tree(void *buffer, unsigned long *psize)
 	out = add_number(out, nb_entries);
 
 	init_tree_desc(&desc, in, size);
+	if (delta) {
+		init_tree_desc(&delta_desc, delta, delta_size);
+		if (!tree_entry(&delta_desc, &delta_entry))
+			delta = NULL;
+	}
+
 	while (tree_entry(&desc, &name_entry)) {
-		int pathlen = tree_entry_len(&name_entry);
-		int index = dict_add_entry(tree_path_table, name_entry.mode,
-					   name_entry.path, pathlen);
-		if (index < 0) {
-			error("missing tree dict entry");
-			free(buffer);
-			return NULL;
+		int pathlen, index;
+
+		/*
+		 * Try to match entries against our delta object.
+		 */
+		if (delta) {
+			int ret;
+
+			do {
+				ret = compare_tree_entries(&name_entry, &delta_entry);
+				if (ret < 1)
+					break;
+				if (tree_entry(&delta_desc, &delta_entry))
+					delta_pos++;
+				else
+					delta = NULL;
+			} while (delta);
+
+			if (ret == 0) {
+				if (!delta_match)
+					delta_start = delta_pos;
+				delta_match++;
+				continue;
+			}
+		}
+
+		if (delta_match) {
+			/*
+			 * Let's write a sequence indicating we're copying
+			 * entries from another object:
+			 *
+			 * 0 + start_entry + nr_entries + object_ref
+			 *
+			 * However, if object_ref is the same as the
+			 * preceeding one, we can omit it and save some
+			 * more space, especially if that ends up being a
+			 * full sha1 reference.  Let's steal the LSB
+			 * of delta_start for that purpose.
+			 */
+			if (end - out < (first_delta ? 48 : 7)) {
+				unsigned long sofar = out - (unsigned char *)buffer;
+				buffer = xrealloc(buffer, sofar + 48);
+				out = (unsigned char *)buffer + sofar;
+				end = out + 48;
+			}
+
+			delta_start <<= 1;
+			delta_start |= first_delta;
+			out = add_number(out, 0);
+			out = add_number(out, delta_start);
+			out = add_number(out, delta_match);
+			if (first_delta)
+				out = add_sha1_ref(out, delta_sha1);
+			delta_match = 0;
+			first_delta = 0;
 		}
+
 		if (end - out < 45) {
 			unsigned long sofar = out - (unsigned char *)buffer;
 			buffer = xrealloc(buffer, sofar + 45);
 			out = (unsigned char *)buffer + sofar;
 			end = out + 45;
 		}
+
+		pathlen = tree_entry_len(&name_entry);
+		index = dict_add_entry(tree_path_table, name_entry.mode,
+				       name_entry.path, pathlen);
+		if (index < 0) {
+			error("missing tree dict entry");
+			free(buffer);
+			return NULL;
+		}
 		out = add_number(out, index);
 		out = add_sha1_ref(out, name_entry.sha1);
 	}
@@ -777,7 +870,7 @@ static off_t packv4_write_object(struct sha1file *f, struct packed_git *p,
 		result = conv_to_dict_commit(src, &size);
 		break;
 	case OBJ_TREE:
-		result = conv_to_dict_tree(src, &size);
+		result = conv_to_dict_tree(src, &size, NULL, 0, NULL);
 		break;
 	default:
 		die("unexpected object type %d", type);
-- 
1.8.4.22.g54757b7
