From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/10] index-pack: reduce memory usage when the pack has large blobs
Date: Sun,  4 Mar 2012 19:59:53 +0700
Message-ID: <1330865996-2069-8-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 14:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4B5j-0003eK-Pu
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 14:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab2CDNDG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 08:03:06 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40475 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab2CDNDE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 08:03:04 -0500
Received: by pbcun15 with SMTP id un15so1801665pbc.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 05:03:04 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.234.131 as permitted sender) client-ip=10.68.234.131;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.234.131 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.234.131])
        by 10.68.234.131 with SMTP id ue3mr10270780pbc.5.1330866184151 (num_hops = 1);
        Sun, 04 Mar 2012 05:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vgtY13p71SRKWce68xp8OHD+R1fM7ae+LwhUJPxVfGI=;
        b=tg6MFkMZ3evetimQDCR3/V3OLx/Da6UveY5IM1xsYpxn6MSimAKCnzrhnUDTrNbWJA
         9TCzwahIysr17FljVk7BPuO5YAzSDBK8RXfg+NPy8nh9zobR+w7BtzHoAl6K5ouDDvlH
         E68g13m8Z0eFoWKTIbxolOuvecIobdqdCWRB8pzBHy+jYZzndPplqLNB1BvVapZWDlo4
         1daetwNTBYLY0KBCVcKnOFRbbFs0QG6xCsEniFAgu7tdu6s4AYhzg5hsy0sTX9OZlNCH
         yjjmY6VgwI+kNCJ04wN+GpmTYOovLlWLHCEEGRjQDAyA8xQvH9ENjVOQt2oH53w+yAiG
         +VuQ==
Received: by 10.68.234.131 with SMTP id ue3mr9054476pbc.5.1330866184109;
        Sun, 04 Mar 2012 05:03:04 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.34.94])
        by mx.google.com with ESMTPS id y7sm10447870pbp.25.2012.03.04.05.02.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 05:03:03 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 04 Mar 2012 20:00:56 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192158>

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
validation (blobs do not need data validation).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |   64 +++++++++++++++++++++++++++++++++++++++---=
-------
 t/t1050-large.sh     |    4 +-
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 918684f..db27133 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -276,30 +276,60 @@ static void unlink_base_data(struct base_data *c)
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
@@ -359,7 +389,9 @@ static void *unpack_raw_entry(struct object_entry *=
obj, union delta_base *delta_
 	}
 	obj->hdr_size =3D consumed_bytes - obj->idx.offset;
=20
-	data =3D unpack_entry_data(obj->idx.offset, obj->size);
+	if (is_delta_type(obj->type) || strict)
+		sha1 =3D NULL;	/* save unpacked object */
+	data =3D unpack_entry_data(obj->idx.offset, obj->size, obj->type, sha=
1);
 	obj->idx.crc32 =3D input_crc32;
 	return data;
 }
@@ -460,8 +492,9 @@ static void find_delta_children(const union delta_b=
ase *base,
 static void sha1_object(const void *data, unsigned long size,
 			enum object_type type, unsigned char *sha1)
 {
-	hash_sha1_file(data, size, typename(type), sha1);
-	if (has_sha1_file(sha1)) {
+	if (data)
+		hash_sha1_file(data, size, typename(type), sha1);
+	if (data && has_sha1_file(sha1)) {
 		void *has_data;
 		enum object_type has_type;
 		unsigned long has_size;
@@ -510,11 +543,6 @@ static void sha1_object(const void *data, unsigned=
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
@@ -689,10 +717,20 @@ static int compare_delta_entry(const void *a, con=
st void *b)
  * - if used as a base, uncompress the object and apply all deltas,
  *   recursively checking if the resulting object is used as a base
  *   for some more deltas.
+ * - if the same object exists in repository and we're not in strict
+ *   mode, we skipped the sha-1 collision test in the first pass.
+ *   Do it now.
  */
 static void second_pass(struct object_entry *obj)
 {
 	struct base_data *base_obj =3D alloc_base_data();
+
+	if (!strict && has_sha1_file(obj->idx.sha1)) {
+		void *data =3D get_data_from_pack(obj);
+		sha1_object(data, obj->size, obj->type, obj->idx.sha1);
+		free(data);
+	}
+
 	base_obj->obj =3D obj;
 	base_obj->data =3D NULL;
 	find_unresolved_deltas(base_obj);
@@ -718,7 +756,7 @@ static void parse_pack_objects(unsigned char *sha1)
 				nr_objects);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
-		void *data =3D unpack_raw_entry(obj, &delta->base);
+		void *data =3D unpack_raw_entry(obj, &delta->base, obj->idx.sha1);
 		obj->real_type =3D obj->type;
 		if (is_delta_type(obj->type)) {
 			nr_deltas++;
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 66acb3b..7e78c72 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -123,7 +123,7 @@ test_expect_success 'git-show a large file' '
=20
 '
=20
-test_expect_failure 'clone' '
+test_expect_success 'clone' '
 	git clone -n file://"$PWD"/.git new &&
 	(
 	cd new &&
@@ -132,7 +132,7 @@ test_expect_failure 'clone' '
 	)
 '
=20
-test_expect_failure 'fetch updates' '
+test_expect_success 'fetch updates' '
 	echo modified >> large1 &&
 	git commit -q -a -m updated &&
 	(
--=20
1.7.8.36.g69ee2
