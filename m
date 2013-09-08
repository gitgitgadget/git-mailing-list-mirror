From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/14] index-pack: parse v4 tree format
Date: Sun,  8 Sep 2013 14:22:36 +0700
Message-ID: <1378624960-8919-11-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:20:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZIW-0004BK-KK
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878Ab3IHHUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:20:36 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62101 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHUe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:20:34 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so5031805pab.13
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qfT/CiLQdLkO/QjqOcmIoGt57qDtZXcv7a4VuVp6WaA=;
        b=CvpFfAq0F1mokI2b9CNp4bCUSI5CFBsfWPpmgjoJLeq45FvVyTa3CFrqx3xYfNmlRS
         gjpGsqKaoTRWIHXexfDf7IzRYuBJOco3MfmYU9fU3ZsqA+WkvQGPVMdezmVC1/tP5UFF
         s02EJ4irgY7o4qFCudSNCTsSjc1dClO1zRvgfi7qzW2rqy866kU+OH61YG0hfeUFD/Hz
         IcYcFZTQqb1/edQp/BccaUQqRlNWMZhigrqi9SuOxJuVXYSxDidS4l5dHff20tfL+f2E
         wguy6dEd8Tvben7zGYJnKCYrr9zqobvZAhzgpCtL5KW+gi9dieuljQGujXURCIa3WLr9
         KEpA==
X-Received: by 10.67.11.103 with SMTP id eh7mr50575pad.153.1378624833896;
        Sun, 08 Sep 2013 00:20:33 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id gg10sm8410841pbc.46.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:20:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:23:42 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234207>

---
 builtin/index-pack.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 473514a..dcb6409 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -334,6 +334,14 @@ static const unsigned char *read_sha1ref(void)
 	return sha1_table + index * 20;
 }
 
+static const unsigned char *read_sha1table_ref(void)
+{
+	const unsigned char *sha1 = read_sha1ref();
+	if (sha1 < sha1_table || sha1 >= sha1_table + nr_objects * 20)
+		check_against_sha1table(sha1);
+	return sha1;
+}
+
 static const unsigned char *read_dictref(struct packv4_dict *dict)
 {
 	unsigned int index = read_varint();
@@ -561,21 +569,105 @@ static void *unpack_commit_v4(unsigned int offset, unsigned long size,
 }
 
 /*
+ * v4 trees are actually kind of deltas and we don't do delta in the
+ * first pass. This function only walks through a tree object to find
+ * the end offset, register object dependencies and performs limited
+ * validation. For v4 trees that have no dependencies, we do
+ * uncompress and calculate their SHA-1.
+ */
+static void *unpack_tree_v4(struct object_entry *obj,
+			    unsigned int offset, unsigned long size,
+			    unsigned char *sha1)
+{
+	unsigned int nr = read_varint();
+	const unsigned char *last_base = NULL;
+	struct strbuf sb = STRBUF_INIT;
+	while (nr) {
+		unsigned int copy_start_or_path = read_varint();
+		if (copy_start_or_path & 1) { /* copy_start */
+			unsigned int copy_count = read_varint();
+			if (copy_count & 1) { /* first delta */
+				last_base = read_sha1table_ref();
+			} else if (!last_base)
+				bad_object(offset,
+					   _("missing delta base unpack_tree_v4"));
+			copy_count >>= 1;
+			if (!copy_count || copy_count > nr)
+				bad_object(offset,
+					   _("bad copy count index in unpack_tree_v4"));
+			nr -= copy_count;
+		} else {	/* path */
+			unsigned int path_idx = copy_start_or_path >> 1;
+			const unsigned char *entry_sha1;
+
+			if (path_idx >= path_dict->nb_entries)
+				bad_object(offset,
+					   _("bad path index in unpack_tree_v4"));
+			entry_sha1 = read_sha1ref();
+			nr--;
+
+			/*
+			 * Attempt to rebuild a canonical (base) tree.
+			 * If last_base is set, this tree depends on
+			 * another tree, which we have no access at this
+			 * stage, so reconstruction must be delayed until
+			 * the second pass.
+			 */
+			if (!last_base) {
+				const unsigned char *path;
+				unsigned mode;
+
+				path = path_dict->data + path_dict->offsets[path_idx];
+				mode = (path[0] << 8) | path[1];
+				strbuf_addf(&sb, "%o %s%c", mode, path+2, '\0');
+				strbuf_add(&sb, entry_sha1, 20);
+				if (sb.len > size)
+					bad_object(offset,
+						   _("tree larger than expected"));
+			}
+		}
+	}
+
+	if (last_base) {
+		strbuf_release(&sb);
+		return NULL;
+	} else {
+		git_SHA_CTX ctx;
+		char hdr[32];
+		int hdrlen;
+
+		if (sb.len != size)
+			bad_object(offset, _("tree size mismatch"));
+
+		hdrlen = sprintf(hdr, "tree %lu", size) + 1;
+		git_SHA1_Init(&ctx);
+		git_SHA1_Update(&ctx, hdr, hdrlen);
+		git_SHA1_Update(&ctx, sb.buf, size);
+		git_SHA1_Final(sha1, &ctx);
+		return strbuf_detach(&sb, NULL);
+	}
+}
+
+/*
  * Unpack an entry data in the streamed pack, calculate the object
  * SHA-1 if it's not a large blob. Otherwise just try to inflate the
  * object to /dev/null to determine the end of the entry in the pack.
  */
-static void *unpack_entry_data(unsigned long offset, unsigned long size,
-			       enum object_type type, unsigned char *sha1)
+static void *unpack_entry_data(struct object_entry *obj, unsigned char *sha1)
 {
 	static char fixed_buf[8192];
 	void *buf;
 	git_SHA_CTX c;
 	char hdr[32];
 	int hdrlen;
+	unsigned long offset = obj->idx.offset;
+	unsigned long size = obj->size;
+	enum object_type type = obj->type;
 
 	if (type == OBJ_PV4_COMMIT)
 		return unpack_commit_v4(offset, size, sha1);
+	if (type == OBJ_PV4_TREE)
+		return unpack_tree_v4(obj, offset, size, sha1);
 
 	if (!is_delta_type(type)) {
 		hdrlen = sprintf(hdr, "%s %lu", typename(type), size) + 1;
@@ -644,16 +736,19 @@ static void *unpack_raw_entry(struct object_entry *obj,
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		break;
-
 	case OBJ_PV4_COMMIT:
 		obj->real_type = OBJ_COMMIT;
 		break;
+	case OBJ_PV4_TREE:
+		obj->real_type = OBJ_TREE;
+		break;
+
 	default:
 		bad_object(obj->idx.offset, _("unknown object type %d"), obj->type);
 	}
 	obj->hdr_size = consumed_bytes - obj->idx.offset;
 
-	data = unpack_entry_data(obj->idx.offset, obj->size, obj->type, sha1);
+	data = unpack_entry_data(obj, sha1);
 	obj->idx.crc32 = input_crc32;
 	return data;
 }
@@ -1201,6 +1296,8 @@ static void parse_pack_objects(unsigned char *sha1)
 			nr_deltas++;
 			delta->obj_no = i;
 			delta++;
+		} else if (!data && obj->type == OBJ_PV4_TREE) {
+			/* delay sha1_object() until second pass */
 		} else if (!data) {
 			/* large blobs, check later */
 			obj->real_type = OBJ_BAD;
-- 
1.8.2.83.gc99314b
