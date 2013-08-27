From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 15/23] pack v4: object writing
Date: Tue, 27 Aug 2013 00:25:59 -0400
Message-ID: <1377577567-27655-16-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:26:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAro-0007MP-W6
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132Ab3H0E0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47516 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab3H0E0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:34 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600G0I9O51090@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:30 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id BA0D62DA0669	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233053>

This adds the missing code to finally be able to produce a complete
pack file version 4.  We trap commit and tree objects as those have
a completely new encoding.  Other object types are copied almost
unchanged.

As we go the pack index entries are updated  in place to store the new
object offsets once they're written to the destination file.  This will
be needed later for writing the pack index file.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index a6dc818..a9e4fb3 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -739,6 +739,59 @@ static unsigned long copy_object_data(struct sha1file *f, struct packed_git *p,
 	return written;
 }
 
+static off_t packv4_write_object(struct sha1file *f, struct packed_git *p,
+				 struct pack_idx_entry *obj)
+{
+	void *src, *result;
+	struct object_info oi = {};
+	enum object_type type;
+	unsigned long size;
+	unsigned int hdrlen;
+
+	oi.typep = &type;
+	oi.sizep = &size;
+	if (packed_object_info(p, obj->offset, &oi) < 0)
+		die("cannot get type of %s from %s",
+		    sha1_to_hex(obj->sha1), p->pack_name);
+
+	/* Some objects are copied without decompression */
+	switch (type) {
+	case OBJ_COMMIT:
+	case OBJ_TREE:
+		break;
+	default:
+		return copy_object_data(f, p, obj->offset);
+	}
+
+	/* The rest is converted into their new format */
+	src = unpack_entry(p, obj->offset, &type, &size);
+	if (!src)
+		die("cannot unpack %s from %s",
+		    sha1_to_hex(obj->sha1), p->pack_name);
+	if (check_sha1_signature(obj->sha1, src, size, typename(type)))
+		die("packed %s from %s is corrupt",
+		    sha1_to_hex(obj->sha1), p->pack_name);
+
+	switch (type) {
+	case OBJ_COMMIT:
+		result = conv_to_dict_commit(src, &size);
+		break;
+	case OBJ_TREE:
+		result = conv_to_dict_tree(src, &size);
+		break;
+	default:
+		die("unexpected object type %d", type);
+	}
+	free(src);
+	if (!result && size)
+		die("can't convert %s object %s",
+		    typename(type), sha1_to_hex(obj->sha1));
+	hdrlen = write_object_header(f, type, size);
+	sha1write(f, result, size);
+	free(result);
+	return hdrlen + size;
+}
+
 static struct packed_git *open_pack(const char *path)
 {
 	char arg[PATH_MAX];
@@ -797,7 +850,8 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 	struct packed_git *p;
 	struct sha1file *f;
 	struct pack_idx_entry *objs, **p_objs;
-	unsigned nr_objects;
+	unsigned i, nr_objects;
+	off_t written = 0;
 
 	p = open_pack(src_pack);
 	if (!p)
@@ -808,12 +862,26 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 	p_objs = sort_objs_by_offset(objs, nr_objects);
 
 	create_pack_dictionaries(p, p_objs);
+	sort_dict_entries_by_hits(commit_name_table);
+	sort_dict_entries_by_hits(tree_path_table);
 
 	f = packv4_open(dst_pack);
 	if (!f)
 		die("unable to open destination pack");
-	packv4_write_header(f, nr_objects);
-	packv4_write_tables(f, nr_objects, objs);
+	written += packv4_write_header(f, nr_objects);
+	written += packv4_write_tables(f, nr_objects, objs);
+
+	/* Let's write objects out, updating the object index list in place */
+	all_objs = objs;
+	all_objs_nr = nr_objects;
+	for (i = 0; i < nr_objects; i++) {
+		off_t obj_pos = written;
+		struct pack_idx_entry *obj = p_objs[i];
+		written += packv4_write_object(f, p, obj);
+		obj->offset = obj_pos;
+	}
+
+	sha1close(f, NULL, CSUM_CLOSE | CSUM_FSYNC);
 }
 
 int main(int argc, char *argv[])
-- 
1.8.4.22.g54757b7
