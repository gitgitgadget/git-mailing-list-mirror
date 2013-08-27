From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 17/23] pack v4: load delta candidate for encoding tree objects
Date: Tue, 27 Aug 2013 00:26:01 -0400
Message-ID: <1377577567-27655-18-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:26:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAro-0007MP-FP
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab3H0E0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47516 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab3H0E0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:34 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600F6D9O5GV90@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:30 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id DB56B2DA052D	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233052>

The SHA1 of the base object is retrieved and the corresponding object
is loaded in memory for conv_to_dict_tree() to look at.  Simple but
effective.  Obviously this relies on the delta matching already performed
during the pack v3 delta search.  Some native delta search for pack v4
could be investigated eventually.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index 744514c..ed67eb6 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -832,18 +832,62 @@ static unsigned long copy_object_data(struct sha1file *f, struct packed_git *p,
 	return written;
 }
 
+static unsigned char *get_delta_base(struct packed_git *p, off_t offset,
+				     unsigned char *sha1_buf)
+{
+	struct pack_window *w_curs = NULL;
+	enum object_type type;
+	unsigned long avail, size;
+	int hdrlen;
+	unsigned char *src;
+	const unsigned char *base_sha1 = NULL; ;
+
+	src = use_pack(p, &w_curs, offset, &avail);
+	hdrlen = unpack_object_header_buffer(src, avail, &type, &size);
+
+	if (type == OBJ_OFS_DELTA) {
+		struct revindex_entry *revidx;
+		unsigned char c = src[hdrlen++];
+		off_t base_offset = c & 127;
+		while (c & 128) {
+			base_offset += 1;
+			if (!base_offset || MSB(base_offset, 7))
+				error("delta offset overflow");
+			c = src[hdrlen++];
+			base_offset = (base_offset << 7) + (c & 127);
+		}
+		base_offset = offset - base_offset;
+		if (base_offset <= 0 || base_offset >= offset)
+			error("delta offset out of bound");
+		revidx = find_pack_revindex(p, base_offset);
+		base_sha1 = nth_packed_object_sha1(p, revidx->nr);
+	} else if (type == OBJ_REF_DELTA) {
+		base_sha1 = src + hdrlen;
+	} else {
+		error("expected to get a delta but got a %s", typename(type));
+	}
+
+	unuse_pack(&w_curs);
+
+	if (!base_sha1)
+		return NULL;
+	hashcpy(sha1_buf, base_sha1);
+	return sha1_buf;
+}
+
 static off_t packv4_write_object(struct sha1file *f, struct packed_git *p,
 				 struct pack_idx_entry *obj)
 {
 	void *src, *result;
 	struct object_info oi = {};
-	enum object_type type;
+	enum object_type type, packed_type;
 	unsigned long size;
 	unsigned int hdrlen;
 
 	oi.typep = &type;
 	oi.sizep = &size;
-	if (packed_object_info(p, obj->offset, &oi) < 0)
+	packed_type = packed_object_info(p, obj->offset, &oi);
+	if (packed_type < 0)
 		die("cannot get type of %s from %s",
 		    sha1_to_hex(obj->sha1), p->pack_name);
 
@@ -870,7 +914,26 @@ static off_t packv4_write_object(struct sha1file *f, struct packed_git *p,
 		result = conv_to_dict_commit(src, &size);
 		break;
 	case OBJ_TREE:
-		result = conv_to_dict_tree(src, &size, NULL, 0, NULL);
+		if (packed_type != OBJ_TREE) {
+			unsigned char sha1_buf[20], *ref_sha1;
+			void *ref;
+			enum object_type ref_type;
+			unsigned long ref_size;
+
+			ref_sha1 = get_delta_base(p, obj->offset, sha1_buf);
+			if (!ref_sha1)
+				die("unable to get delta base sha1 for %s",
+						sha1_to_hex(obj->sha1));
+			ref = read_sha1_file(ref_sha1, &ref_type, &ref_size);
+			if (!ref || ref_type != OBJ_TREE)
+				die("cannot obtain delta base for %s",
+						sha1_to_hex(obj->sha1));
+			result = conv_to_dict_tree(src, &size,
+					ref, ref_size, ref_sha1);
+			free(ref);
+		} else {
+			result = conv_to_dict_tree(src, &size, NULL, 0, NULL);
+		}
 		break;
 	default:
 		die("unexpected object type %d", type);
-- 
1.8.4.22.g54757b7
