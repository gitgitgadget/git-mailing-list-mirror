From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/6] index-pack: hash non-delta objects while reading from stream
Date: Wed, 23 May 2012 21:09:46 +0700
Message-ID: <1337782191-10091-1-git-send-email-pclouds@gmail.com>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 16:13:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXCK6-000095-8T
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 16:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760093Ab2EWONx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 10:13:53 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48459 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab2EWONw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 10:13:52 -0400
Received: by pbbrp8 with SMTP id rp8so9944677pbb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=f/j/l1BblfCALC1HIFKN7CoNainfW57/D2h2jzzf24k=;
        b=lYfFD7MGsTZ8K+rHh3zrAn822waeS/XQrvk06bnAMgOCsUKxBiURKgpAhx47UnkCkH
         N1EaE2a5e3+Dx4DzVBzUE77JKpsLhlv7bLRyv2NJvyqip7Gq1PyuiHlgx38etDZOPLdR
         XMlS3w84uaIvedQwiTvOVEsofsJQoZFW/UWKSwRYA49FKHVdab7ygVHSIDQwj3QJJ5k5
         uVcg7Oh3/wklI24SVPpjaXmKYbb22BF5mlsVjGfh6lZuUKmIsUfbno1D1fs+Tm7T+Ich
         3So9pZhC4kqYFU8JOsAaaZLbA5T0e2sdq7JKDK8D9/Le7NHE4un3QUSHoo6pYI6yUThF
         26rw==
Received: by 10.68.202.8 with SMTP id ke8mr10735496pbc.94.1337782432113;
        Wed, 23 May 2012 07:13:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.52.77])
        by mx.google.com with ESMTPS id tx9sm1995864pbc.10.2012.05.23.07.13.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 07:13:50 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 May 2012 21:09:52 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198286>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fix spaces around "+ 1" operator in unpack_entry_data and last_out's s=
cope.

 builtin/index-pack.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dc2cfe6..a744856 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -384,11 +384,27 @@ static void unlink_base_data(struct base_data *c)
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
+
+	if (!is_delta_type(type)) {
+		hdrlen =3D sprintf(hdr, "%s %lu", typename(type), size) + 1;
+		git_SHA1_Init(&c);
+		git_SHA1_Update(&c, hdr, hdrlen);
+	} else
+		sha1 =3D NULL;
=20
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init(&stream);
@@ -396,18 +412,25 @@ static void *unpack_entry_data(unsigned long offs=
et, unsigned long size)
 	stream.avail_out =3D size;
=20
 	do {
+		unsigned char *last_out =3D stream.next_out;
 		stream.next_in =3D fill(1);
 		stream.avail_in =3D input_len;
 		status =3D git_inflate(&stream, 0);
 		use(input_len - stream.avail_in);
+		if (sha1)
+			git_SHA1_Update(&c, last_out, stream.next_out - last_out);
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
@@ -467,7 +490,7 @@ static void *unpack_raw_entry(struct object_entry *=
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
@@ -569,9 +592,8 @@ static void find_delta_children(const union delta_b=
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
@@ -627,11 +649,6 @@ static void sha1_object(const void *data, unsigned=
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
@@ -711,6 +728,8 @@ static void resolve_delta(struct object_entry *delt=
a_obj,
 	free(delta_data);
 	if (!result->data)
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
+	hash_sha1_file(result->data, result->size,
+		       typename(delta_obj->real_type), delta_obj->idx.sha1);
 	sha1_object(result->data, result->size, delta_obj->real_type,
 		    delta_obj->idx.sha1);
 	counter_lock();
@@ -851,7 +870,7 @@ static void parse_pack_objects(unsigned char *sha1)
 				nr_objects);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
-		void *data =3D unpack_raw_entry(obj, &delta->base);
+		void *data =3D unpack_raw_entry(obj, &delta->base, obj->idx.sha1);
 		obj->real_type =3D obj->type;
 		if (is_delta_type(obj->type)) {
 			nr_deltas++;
--=20
1.7.10.2.549.g9354186
