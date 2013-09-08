From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/14] index-pack: parse v4 commit format
Date: Sun,  8 Sep 2013 14:22:35 +0700
Message-ID: <1378624960-8919-10-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:20:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZIS-00049J-5g
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab3IHHU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:20:29 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36895 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:20:28 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so4942353pdj.32
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ZISbfejMywCV3eCsRfic7MLLLxI8aMAIPx1dnybTqw=;
        b=PR+PFqVCuvBoh/E7peUTduubr14UuyDKyi3xOoz27etPVJ6dSxfWf/CRtpb6BUIPOT
         1UmfXolJeufftHcPm4ly/CKpU65XdHnOl7JAKHVeeUQC/942PSQ6roElIPdsKAerW5k9
         RLvXUokp7MnSfJuhAQOw/+84t2gpgf9HWmhrf7Sc/sbkdUnthRvZK9NWaGWghUR2LNML
         Lnh/4QpPNifGVS0cBGejeb1gbTkQRu0RbLG16RIooqwOHBw52A7pq1h5i2R81WLA9ynh
         Y910B0Uzrxf1yWSE++Ylu57LiwF93BQD58g9/eQl80fPv2x7DWcc0pOARxonsS0w1Sxb
         bJrQ==
X-Received: by 10.67.23.71 with SMTP id hy7mr13081718pad.99.1378624828045;
        Sun, 08 Sep 2013 00:20:28 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id yk1sm9302858pac.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:20:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:23:36 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234206>

---
 builtin/index-pack.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index efb969a..473514a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -319,6 +319,30 @@ static uintmax_t read_varint(void)
 	return val;
 }
 
+static const unsigned char *read_sha1ref(void)
+{
+	unsigned int index = read_varint();
+	if (!index) {
+		static unsigned char sha1[20];
+		hashcpy(sha1, fill_and_use(20));
+		return sha1;
+	}
+	index--;
+	if (index >= nr_objects)
+		bad_object(consumed_bytes,
+			   _("bad index in read_sha1ref"));
+	return sha1_table + index * 20;
+}
+
+static const unsigned char *read_dictref(struct packv4_dict *dict)
+{
+	unsigned int index = read_varint();
+	if (index >= dict->nb_entries)
+		bad_object(consumed_bytes,
+			   _("bad index in read_dictref"));
+	return  dict->data + dict->offsets[index];
+}
+
 static const char *open_pack_file(const char *pack_name)
 {
 	if (from_stdin) {
@@ -484,6 +508,58 @@ static void read_and_inflate(unsigned long offset,
 		git_SHA1_Final(sha1, ctx);
 }
 
+static void *unpack_commit_v4(unsigned int offset, unsigned long size,
+			      unsigned char *sha1)
+{
+	unsigned int nb_parents;
+	const unsigned char *committer, *author, *ident;
+	unsigned long author_time, committer_time;
+	git_SHA_CTX ctx;
+	char hdr[32];
+	int hdrlen;
+	int16_t committer_tz, author_tz;
+	struct strbuf dst;
+
+	strbuf_init(&dst, size);
+
+	strbuf_addf(&dst, "tree %s\n", sha1_to_hex(read_sha1ref()));
+	nb_parents = read_varint();
+	while (nb_parents--)
+		strbuf_addf(&dst, "parent %s\n", sha1_to_hex(read_sha1ref()));
+
+	committer_time = read_varint();
+	ident = read_dictref(name_dict);
+	committer_tz = (ident[0] << 8) | ident[1];
+	committer = ident + 2;
+
+	author_time = read_varint();
+	ident = read_dictref(name_dict);
+	author_tz = (ident[0] << 8) | ident[1];
+	author = ident + 2;
+
+	if (author_time & 1)
+		author_time = committer_time + (author_time >> 1);
+	else
+		author_time = committer_time - (author_time >> 1);
+
+	strbuf_addf(&dst,
+		    "author %s %lu %+05d\n"
+		    "committer %s %lu %+05d\n",
+		    author, author_time, author_tz,
+		    committer, committer_time, committer_tz);
+
+	if (dst.len > size)
+		bad_object(offset, _("bad commit"));
+
+	hdrlen = sprintf(hdr, "commit %lu", size) + 1;
+	git_SHA1_Init(&ctx);
+	git_SHA1_Update(&ctx, hdr, hdrlen);
+	git_SHA1_Update(&ctx, dst.buf, dst.len);
+	read_and_inflate(offset, dst.buf + dst.len, size - dst.len,
+			 0, &ctx, sha1);
+	return dst.buf;
+}
+
 /*
  * Unpack an entry data in the streamed pack, calculate the object
  * SHA-1 if it's not a large blob. Otherwise just try to inflate the
@@ -498,6 +574,9 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size,
 	char hdr[32];
 	int hdrlen;
 
+	if (type == OBJ_PV4_COMMIT)
+		return unpack_commit_v4(offset, size, sha1);
+
 	if (!is_delta_type(type)) {
 		hdrlen = sprintf(hdr, "%s %lu", typename(type), size) + 1;
 		git_SHA1_Init(&c);
@@ -541,7 +620,13 @@ static void *unpack_raw_entry(struct object_entry *obj,
 	obj->idx.offset = consumed_bytes;
 	input_crc32 = crc32(0, NULL, 0);
 
-	read_typesize_v2(obj);
+	if (packv4) {
+		val = read_varint();
+		obj->type = val & 15;
+		obj->size = val >> 4;
+	} else
+		read_typesize_v2(obj);
+	obj->real_type = obj->type;
 
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
@@ -559,6 +644,10 @@ static void *unpack_raw_entry(struct object_entry *obj,
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		break;
+
+	case OBJ_PV4_COMMIT:
+		obj->real_type = OBJ_COMMIT;
+		break;
 	default:
 		bad_object(obj->idx.offset, _("unknown object type %d"), obj->type);
 	}
@@ -1108,7 +1197,6 @@ static void parse_pack_objects(unsigned char *sha1)
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		void *data = unpack_raw_entry(obj, &delta->base, obj->idx.sha1);
-		obj->real_type = obj->type;
 		if (is_delta_type(obj->type)) {
 			nr_deltas++;
 			delta->obj_no = i;
@@ -1120,7 +1208,7 @@ static void parse_pack_objects(unsigned char *sha1)
 			check_against_sha1table(obj->idx.sha1);
 		} else {
 			check_against_sha1table(obj->idx.sha1);
-			sha1_object(data, NULL, obj->size, obj->type,
+			sha1_object(data, NULL, obj->size, obj->real_type,
 				    obj->idx.sha1);
 		}
 		free(data);
-- 
1.8.2.83.gc99314b
