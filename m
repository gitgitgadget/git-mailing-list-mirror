From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] index-pack: reduce memory usage when the pack has large blobs
Date: Fri, 24 Feb 2012 19:23:21 +0700
Message-ID: <1330086201-13916-2-git-send-email-pclouds@gmail.com>
References: <1330086201-13916-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ian Kumlien <pomac@vapor.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 13:24:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0uCN-00061D-JT
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 13:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766Ab2BXMYY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 07:24:24 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63314 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab2BXMYX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 07:24:23 -0500
Received: by mail-pw0-f46.google.com with SMTP id un15so2595871pbc.19
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 04:24:22 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.129.130 as permitted sender) client-ip=10.68.129.130;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.129.130 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.129.130])
        by 10.68.129.130 with SMTP id nw2mr7128448pbb.8.1330086262863 (num_hops = 1);
        Fri, 24 Feb 2012 04:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RM5rBuP4tjMmj212xd8chOoU3RP7fsHPIFMQygw51so=;
        b=v+4h2rdJr3Xj5am6BpLhsOKGynCtdQ0Y8SrfmILcTTrq4ghcsD2Mf9A9CODWBIMN72
         xhSqCw6h/3NcADtYQCd0Ckg5vvDsKQGnFCi9hMVKlofssP4iWTZNRPOrgsr/JIrzj/In
         9ukQqNgSTTZ24Rz9KOdzNxbWH9QiyiNNZdCU4=
Received: by 10.68.129.130 with SMTP id nw2mr5956812pbb.8.1330086262817;
        Fri, 24 Feb 2012 04:24:22 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.53.120])
        by mx.google.com with ESMTPS id j3sm4257108pbb.29.2012.02.24.04.24.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 04:24:21 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Feb 2012 19:23:31 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330086201-13916-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191431>

This command unpacks every non-delta objects in order to:

1. calculate sha-1
2. do byte-to-byte sha-1 collision test if we happen to have objects
   with the same sha-1
3. validate object content in strict mode

All this requires the entire object to stay in memory, a bad news for
giant blobs. This patch lowers memory consumption by not saving the
object in memory whenever possible, calculating SHA-1 while unpacking
the object.

This patch assumes that the collision test is rarely needed. The
collision test will be done later in second pass if necessary, which
puts the entire object back to memory again (We could even do the
collision test without putting the entire object back in memory, by
comparing as we unpack it).

In strict mode, it always keeps non-blob objects in memory for
validation (blobs do not need data validation). "--strict --verify"
also keeps blobs in memory.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Does anybody do "git index-pack --stdin < .git/objects/pack/something"=
?

 builtin/index-pack.c |   74 +++++++++++++++++++++++++++++++++++++++++-=
--------
 1 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index cee83b9..0c1f915 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -277,30 +277,60 @@ static void unlink_base_data(struct base_data *c)
 	free_base_data(c);
 }
=20
-static void *unpack_entry_data(unsigned long offset, unsigned long siz=
e)
+static void *unpack_entry_data(unsigned long offset, unsigned long siz=
e,
+			       enum object_type type, unsigned char *sha1)
 {
+	static char fixed_buf[8192];
 	int status;
 	git_zstream stream;
-	void *buf =3D xmalloc(size);
+	void *buf;
+	git_SHA_CTX c;
+
+	if (sha1) {		/* do hash_sha1_file internally */
+		char hdr[32];
+		int hdrlen =3D sprintf(hdr, "%s %lu", typename(type), size)+1;
+		git_SHA1_Init(&c);
+		git_SHA1_Update(&c, hdr, hdrlen);
+
+		buf =3D fixed_buf;
+	} else {
+		buf =3D xmalloc(size);
+	}
=20
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init(&stream);
 	stream.next_out =3D buf;
-	stream.avail_out =3D size;
+	stream.avail_out =3D buf =3D=3D fixed_buf ? sizeof(fixed_buf) : size;
=20
 	do {
 		stream.next_in =3D fill(1);
 		stream.avail_in =3D input_len;
 		status =3D git_inflate(&stream, 0);
 		use(input_len - stream.avail_in);
+		if (sha1) {
+			git_SHA1_Update(&c, buf, stream.next_out - (unsigned char *)buf);
+			stream.next_out =3D buf;
+			stream.avail_out =3D sizeof(fixed_buf);
+		}
 	} while (status =3D=3D Z_OK);
 	if (stream.total_out !=3D size || status !=3D Z_STREAM_END)
 		bad_object(offset, "inflate returned %d", status);
 	git_inflate_end(&stream);
+	if (sha1) {
+		git_SHA1_Final(sha1, &c);
+		buf =3D NULL;
+	}
 	return buf;
 }
=20
-static void *unpack_raw_entry(struct object_entry *obj, union delta_ba=
se *delta_base)
+static int is_delta_type(enum object_type type)
+{
+	return (type =3D=3D OBJ_REF_DELTA || type =3D=3D OBJ_OFS_DELTA);
+}
+
+static void *unpack_raw_entry(struct object_entry *obj,
+			      union delta_base *delta_base,
+			      unsigned char *sha1)
 {
 	unsigned char *p;
 	unsigned long size, c;
@@ -360,7 +390,17 @@ static void *unpack_raw_entry(struct object_entry =
*obj, union delta_base *delta_
 	}
 	obj->hdr_size =3D consumed_bytes - obj->idx.offset;
=20
-	data =3D unpack_entry_data(obj->idx.offset, obj->size);
+	/*
+	 * --verify --strict: sha1_object() does all collision test
+	 *          --strict: sha1_object() does all except blobs,
+	 *                    blobs tested in second pass
+	 * --verify         : no collision test
+	 *                  : all in second pass
+	 */
+	if (is_delta_type(obj->type) ||
+	    (strict && (verify || obj->type !=3D OBJ_BLOB)))
+		sha1 =3D NULL;	/* save unpacked object */
+	data =3D unpack_entry_data(obj->idx.offset, obj->size, obj->type, sha=
1);
 	obj->idx.crc32 =3D input_crc32;
 	return data;
 }
@@ -461,8 +501,9 @@ static void find_delta_children(const union delta_b=
ase *base,
 static void sha1_object(const void *data, unsigned long size,
 			enum object_type type, unsigned char *sha1)
 {
-	hash_sha1_file(data, size, typename(type), sha1);
-	if ((strict || !verify) && has_sha1_file(sha1)) {
+	if (data)
+		hash_sha1_file(data, size, typename(type), sha1);
+	if (data && has_sha1_file(sha1)) {
 		void *has_data;
 		enum object_type has_type;
 		unsigned long has_size;
@@ -511,11 +552,6 @@ static void sha1_object(const void *data, unsigned=
 long size,
 	}
 }
=20
-static int is_delta_type(enum object_type type)
-{
-	return (type =3D=3D OBJ_REF_DELTA || type =3D=3D OBJ_OFS_DELTA);
-}
-
 /*
  * This function is part of find_unresolved_deltas(). There are two
  * walkers going in the opposite ways.
@@ -702,7 +738,7 @@ static void parse_pack_objects(unsigned char *sha1)
 				nr_objects);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
-		void *data =3D unpack_raw_entry(obj, &delta->base);
+		void *data =3D unpack_raw_entry(obj, &delta->base, obj->idx.sha1);
 		obj->real_type =3D obj->type;
 		if (is_delta_type(obj->type)) {
 			nr_deltas++;
@@ -744,6 +780,9 @@ static void parse_pack_objects(unsigned char *sha1)
 	 * - if used as a base, uncompress the object and apply all deltas,
 	 *   recursively checking if the resulting object is used as a base
 	 *   for some more deltas.
+	 * - if the same object exists in repository and we're not in strict
+	 *   mode, we skipped the sha-1 collision test in the first pass.
+	 *   Do it now.
 	 */
 	if (verbose)
 		progress =3D start_progress("Resolving deltas", nr_deltas);
@@ -753,6 +792,15 @@ static void parse_pack_objects(unsigned char *sha1=
)
=20
 		if (is_delta_type(obj->type))
 			continue;
+
+		if (((!strict && !verify) ||
+		     (strict && !verify && obj->type =3D=3D OBJ_BLOB)) &&
+		    has_sha1_file(obj->idx.sha1)) {
+			void *data =3D get_data_from_pack(obj);
+			sha1_object(data, obj->size, obj->type, obj->idx.sha1);
+			free(data);
+		}
+
 		base_obj->obj =3D obj;
 		base_obj->data =3D NULL;
 		find_unresolved_deltas(base_obj);
--=20
1.7.8.36.g69ee2
