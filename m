From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/12] index-pack: parse v4 tree format
Date: Sat,  7 Sep 2013 17:43:15 +0700
Message-ID: <1378550599-25365-9-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:41:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFxF-0002zu-He
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343Ab3IGKlV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:41:21 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:47598 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3IGKlU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:41:20 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so4163503pbc.8
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MJxI9bhbJ7DCSTZgLBRnwn6+rVBmWSurMSiIDjpd+88=;
        b=HymOVwZ45aPZkYbbK/vSsQHHLl6s1sHGcPJuQ2H3yUEJwYqbOa9B9C0CM2U/ihwENc
         6r5eUNqNhwm+52mUJ4sY1OLs1DLNbfxDmPqAvmxnJKchslrWfd+LJFF3OPRjSryrVpbV
         YwFPjw3Hpz96I05bvbMSLQxBHS5ek27/q2lm4cMSJctKwWwsOhbHyuJRqzgzxy0AVjl0
         1XO3L3WSebvXRWi3m/8sNFj0EWFWBNoFlea3mioPGFRtJeEi7g1+te7p4YYJEpjU+2bM
         ZqmR31RehqCYbM5KJ/E7BK5y3kppsJnYx3KkQOB8xpRjmaL5NefyfmFAA8Uun5lyw145
         YdzQ==
X-Received: by 10.68.41.10 with SMTP id b10mr7767317pbl.83.1378550480058;
        Sat, 07 Sep 2013 03:41:20 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id w6sm3382279pbt.32.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:41:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:44:28 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234126>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 104 +++++++++++++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 100 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 210b78d..51ca64b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -319,6 +319,21 @@ static const unsigned char *read_sha1ref(void)
 	return sha1_table + index * 20;
 }
=20
+static const unsigned char *read_sha1table_ref(void)
+{
+	const unsigned char *sha1 =3D read_sha1ref();
+	if (sha1 < sha1_table || sha1 >=3D sha1_table + nr_objects * 20) {
+		unsigned char *found;
+		found =3D bsearch(sha1, sha1_table, nr_objects, 20,
+				(int (*)(const void *, const void *))hashcmp);
+		if (!found)
+			bad_object(consumed_bytes,
+				   _("SHA-1 %s not found in SHA-1 table"),
+				   sha1_to_hex(sha1));
+	}
+	return sha1;
+}
+
 static const unsigned char *read_dictref(struct packv4_dict *dict)
 {
 	unsigned int index =3D read_varint();
@@ -561,17 +576,93 @@ static void *unpack_commit_v4(unsigned int offset=
,
 	return dst.buf;
 }
=20
-static void *unpack_entry_data(unsigned long offset, unsigned long siz=
e,
-			       enum object_type type, unsigned char *sha1)
+/*
+ * v4 trees are actually kind of deltas and we don't do delta in the
+ * first pass. This function only walks through a tree object to find
+ * the end offset, register object dependencies and performs limited
+ * validation.
+ */
+static void *unpack_tree_v4(struct object_entry *obj,
+			    unsigned int offset, unsigned long size,
+			    unsigned char *sha1)
+{
+	unsigned int nr =3D read_varint();
+	const unsigned char *last_base =3D NULL;
+	struct strbuf sb =3D STRBUF_INIT;
+	while (nr) {
+		unsigned int copy_start_or_path =3D read_varint();
+		if (copy_start_or_path & 1) { /* copy_start */
+			unsigned int copy_count =3D read_varint();
+			if (copy_count & 1) { /* first delta */
+				last_base =3D read_sha1table_ref();
+			} else if (!last_base)
+				bad_object(offset,
+					   _("bad copy count index in unpack_tree_v4"));
+			copy_count >>=3D 1;
+			if (!copy_count)
+				bad_object(offset,
+					   _("bad copy count index in unpack_tree_v4"));
+			nr -=3D copy_count;
+		} else {	/* path */
+			unsigned int path_idx =3D copy_start_or_path >> 1;
+			const unsigned char *entry_sha1;
+
+			if (path_idx >=3D path_dict->nb_entries)
+				bad_object(offset,
+					   _("bad path index in unpack_tree_v4"));
+			entry_sha1 =3D read_sha1ref();
+			nr--;
+
+			if (!last_base) {
+				const unsigned char *path;
+				unsigned mode;
+
+				path =3D path_dict->data + path_dict->offsets[path_idx];
+				mode =3D (path[0] << 8) | path[1];
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
+		if (sb.len !=3D size)
+			bad_object(offset, _("tree size mismatch"));
+
+		hdrlen =3D sprintf(hdr, "tree %lu", size) + 1;
+		git_SHA1_Init(&ctx);
+		git_SHA1_Update(&ctx, hdr, hdrlen);
+		git_SHA1_Update(&ctx, sb.buf, size);
+		git_SHA1_Final(sha1, &ctx);
+		return strbuf_detach(&sb, NULL);
+	}
+}
+
+static void *unpack_entry_data(struct object_entry *obj, unsigned char=
 *sha1)
 {
 	static char fixed_buf[8192];
 	void *buf;
 	git_SHA_CTX c;
 	char hdr[32];
 	int hdrlen;
+	unsigned long offset =3D obj->idx.offset;
+	unsigned long size =3D obj->size;
+	enum object_type type =3D obj->type;
=20
 	if (type =3D=3D OBJ_PV4_COMMIT)
 		return unpack_commit_v4(offset, size, sha1);
+	if (type =3D=3D OBJ_PV4_TREE)
+		return unpack_tree_v4(obj, offset, size, sha1);
=20
 	if (!is_delta_type(type)) {
 		hdrlen =3D sprintf(hdr, "%s %lu", typename(type), size) + 1;
@@ -640,16 +731,19 @@ static void *unpack_raw_entry(struct object_entry=
 *obj,
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		break;
-
 	case OBJ_PV4_COMMIT:
 		obj->real_type =3D OBJ_COMMIT;
 		break;
+	case OBJ_PV4_TREE:
+		obj->real_type =3D OBJ_TREE;
+		break;
+
 	default:
 		bad_object(obj->idx.offset, _("unknown object type %d"), obj->type);
 	}
 	obj->hdr_size =3D consumed_bytes - obj->idx.offset;
=20
-	data =3D unpack_entry_data(obj->idx.offset, obj->size, obj->type, sha=
1);
+	data =3D unpack_entry_data(obj, sha1);
 	obj->idx.crc32 =3D input_crc32;
 	return data;
 }
@@ -1186,6 +1280,8 @@ static void parse_pack_objects(unsigned char *sha=
1)
 			nr_deltas++;
 			delta->obj_no =3D i;
 			delta++;
+		} else if (!data && obj->type =3D=3D OBJ_PV4_TREE) {
+			/* delay sha1_object() until second pass */
 		} else if (!data) {
 			/* large blobs, check later */
 			obj->real_type =3D OBJ_BAD;
--=20
1.8.2.83.gc99314b
