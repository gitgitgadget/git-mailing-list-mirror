From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] index-pack: hash non-delta objects while reading from stream
Date: Wed, 16 May 2012 19:50:29 +0700
Message-ID: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 14:54:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUdkL-0006a0-Gq
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 14:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759122Ab2EPMyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 08:54:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57217 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab2EPMyX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 08:54:23 -0400
Received: by pbbrp8 with SMTP id rp8so1069602pbb.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=58bHCbHgL0wFqzwyhqA+AvD9ZCrrtLZwk16C6qfjq2c=;
        b=Jw0vJGQy3feRc0AeV1PGx6Kym4K6sfYbRij31/SeEhTEFDhIdnZ+jPihYC/qRbcP3w
         w/Gp3MS3xBv2Ldz1/37fy2GQWF3qdNWRdosSzAo43ASH8Dv+I9bulSxs3PngI2dXBslu
         SyJQGeAwvAtefDgI2Q+HySod/r3ulzkchocRaINybjh7Whf754cLl4b0Aror8lQIP18O
         PDxq4LqFPEYvhxigPDpanqEFdAu19WerLZofmsIRnyg5DC1X0Pvi8cRMyAhHQ9AfoWSN
         JcrW8xGNk7TJfWtrTB+srzsUnMgTTk5QzlicGWdUkP2OjSGNfqI6kCvgOPgxolI83eZO
         d1ww==
Received: by 10.68.193.226 with SMTP id hr2mr16087907pbc.155.1337172862464;
        Wed, 16 May 2012 05:54:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.61.104])
        by mx.google.com with ESMTPS id ou5sm5384516pbb.54.2012.05.16.05.54.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 05:54:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 May 2012 19:50:31 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197879>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Preparatory step for large blob support.

 builtin/index-pack.c |   43 ++++++++++++++++++++++++++++++++----------=
-
 1 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dc2cfe6..ccb0214 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -384,30 +384,55 @@ static void unlink_base_data(struct base_data *c)
 	free_base_data(c);
 }
=20
-static void *unpack_entry_data(unsigned long offset, unsigned long siz=
e)
+static int is_delta_type(enum object_type type)
+{
+	return (type =3D=3D OBJ_REF_DELTA || type =3D=3D OBJ_OFS_DELTA);
+}
+
+static void *unpack_entry_data(unsigned long offset, unsigned long siz=
e,
+			       enum object_type type, unsigned char *sha1)
 {
 	int status;
 	git_zstream stream;
 	void *buf =3D xmalloc(size);
+	git_SHA_CTX c;
+	char hdr[32];
+	int hdrlen;
+	unsigned char *last_out;
+
+	if (!is_delta_type(type)) {
+		hdrlen =3D sprintf(hdr, "%s %lu", typename(type), size)+1;
+		git_SHA1_Init(&c);
+		git_SHA1_Update(&c, hdr, hdrlen);
+	} else
+		sha1 =3D NULL;
=20
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init(&stream);
 	stream.next_out =3D buf;
 	stream.avail_out =3D size;
+	last_out =3D buf;
=20
 	do {
 		stream.next_in =3D fill(1);
 		stream.avail_in =3D input_len;
 		status =3D git_inflate(&stream, 0);
 		use(input_len - stream.avail_in);
+		if (sha1)
+			git_SHA1_Update(&c, last_out, stream.next_out - last_out);
+		last_out =3D stream.next_out;
 	} while (status =3D=3D Z_OK);
 	if (stream.total_out !=3D size || status !=3D Z_STREAM_END)
 		bad_object(offset, _("inflate returned %d"), status);
 	git_inflate_end(&stream);
+	if (sha1)
+		git_SHA1_Final(sha1, &c);
 	return buf;
 }
=20
-static void *unpack_raw_entry(struct object_entry *obj, union delta_ba=
se *delta_base)
+static void *unpack_raw_entry(struct object_entry *obj,
+			      union delta_base *delta_base,
+			      unsigned char *sha1)
 {
 	unsigned char *p;
 	unsigned long size, c;
@@ -467,7 +492,7 @@ static void *unpack_raw_entry(struct object_entry *=
obj, union delta_base *delta_
 	}
 	obj->hdr_size =3D consumed_bytes - obj->idx.offset;
=20
-	data =3D unpack_entry_data(obj->idx.offset, obj->size);
+	data =3D unpack_entry_data(obj->idx.offset, obj->size, obj->type, sha=
1);
 	obj->idx.crc32 =3D input_crc32;
 	return data;
 }
@@ -569,9 +594,8 @@ static void find_delta_children(const union delta_b=
ase *base,
 }
=20
 static void sha1_object(const void *data, unsigned long size,
-			enum object_type type, unsigned char *sha1)
+			enum object_type type, const unsigned char *sha1)
 {
-	hash_sha1_file(data, size, typename(type), sha1);
 	read_lock();
 	if (has_sha1_file(sha1)) {
 		void *has_data;
@@ -627,11 +651,6 @@ static void sha1_object(const void *data, unsigned=
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
@@ -711,6 +730,8 @@ static void resolve_delta(struct object_entry *delt=
a_obj,
 	free(delta_data);
 	if (!result->data)
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
+	hash_sha1_file(result->data, result->size,
+		       typename(delta_obj->real_type), delta_obj->idx.sha1);
 	sha1_object(result->data, result->size, delta_obj->real_type,
 		    delta_obj->idx.sha1);
 	counter_lock();
@@ -851,7 +872,7 @@ static void parse_pack_objects(unsigned char *sha1)
 				nr_objects);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
-		void *data =3D unpack_raw_entry(obj, &delta->base);
+		void *data =3D unpack_raw_entry(obj, &delta->base, obj->idx.sha1);
 		obj->real_type =3D obj->type;
 		if (is_delta_type(obj->type)) {
 			nr_deltas++;
--=20
1.7.8.36.g69ee2
