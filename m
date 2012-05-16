From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] index-pack: use streaming interface on large blobs (most of the time)
Date: Wed, 16 May 2012 19:50:30 +0700
Message-ID: <1337172630-23679-2-git-send-email-pclouds@gmail.com>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 14:55:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUdla-0007wD-0w
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 14:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933430Ab2EPMz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 08:55:26 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65500 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933426Ab2EPMzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 08:55:24 -0400
Received: by pbbrp8 with SMTP id rp8so1070297pbb.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=caCVi9xO7UcSTj+90XMkFOayHyimCiy3hbh/17eV5EA=;
        b=N0cuqZqeJS1AOFvZwS0Ckdti5T6A9X5tJyf+erJoWU1paxOCx409RNJH9k1bBeL3g5
         hv1Vi1/qYx3co36N6e6x/zCami+8uxV31kTufU4nkxqBr6DPqivpnSwkAJwtWN1V8gF1
         yvhnJ6f6mhWm5HSjNlrbBbu1jiTz4bTTjgFtMmmitZxLYBYHXVnk+pnmskPFeo3Wezrj
         T++FwNYkp6Jv19mIi70UThvRvuRKAVFcNUYA1lB4mrQfVq9Y8jMUzHnqns9Icjs4wS9G
         +3+7wcDGqujgPNu1By8WBZDOWNbPGJVzYDgEs17ihQWHVEf+E1nKgzbY6wmOuaf0uWP6
         oHTw==
Received: by 10.68.242.67 with SMTP id wo3mr10744864pbc.91.1337172871688;
        Wed, 16 May 2012 05:54:31 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.61.104])
        by mx.google.com with ESMTPS id os7sm5377863pbb.67.2012.05.16.05.54.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 05:54:30 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 May 2012 19:50:41 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197880>

unpack_raw_entry() will not allocate and return decompressed blobs if
they are larger than core.bigFileThreshold.

The blob content is needed by sha1_object() in some cases. When we do
need the blob content, we put it back in core with
get_data_from_pack(). However we rarely need that in pratice.

The first case is when we find an in-repo blob with the same SHA-1. We
need to do collision test, byte-on-byte. Normally (e.g. in
fetch/pull/clone) this does not happen because git avoid to send
objects that client already has.

The other case is when --strict is specified and the object in
question is not a blob, which can't happen in reality becase we deal
with large _blobs_ here.

Note: --verify (or git-verify-pack) a pack from current repository
will trigger collision test on every object in the pack, which
effectively disables this patch. This could be easily worked around by
setting GIT_DIR to an imaginary place with no packs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |   52 ++++++++++++++++++++++++++++++++++++++++++=
-------
 t/t1050-large.sh     |    5 ++++
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ccb0214..1b790df 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -392,9 +392,10 @@ static int is_delta_type(enum object_type type)
 static void *unpack_entry_data(unsigned long offset, unsigned long siz=
e,
 			       enum object_type type, unsigned char *sha1)
 {
+	static char fixed_buf[8192];
 	int status;
 	git_zstream stream;
-	void *buf =3D xmalloc(size);
+	void *buf;
 	git_SHA_CTX c;
 	char hdr[32];
 	int hdrlen;
@@ -406,11 +407,15 @@ static void *unpack_entry_data(unsigned long offs=
et, unsigned long size,
 		git_SHA1_Update(&c, hdr, hdrlen);
 	} else
 		sha1 =3D NULL;
+	if (type =3D=3D OBJ_BLOB && size > big_file_threshold)
+		buf =3D fixed_buf;
+	else
+		buf =3D xmalloc(size);
=20
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init(&stream);
 	stream.next_out =3D buf;
-	stream.avail_out =3D size;
+	stream.avail_out =3D buf =3D=3D fixed_buf ? sizeof(fixed_buf) : size;
 	last_out =3D buf;
=20
 	do {
@@ -420,6 +425,10 @@ static void *unpack_entry_data(unsigned long offse=
t, unsigned long size,
 		use(input_len - stream.avail_in);
 		if (sha1)
 			git_SHA1_Update(&c, last_out, stream.next_out - last_out);
+		if (buf =3D=3D fixed_buf) {
+			stream.next_out =3D buf;
+			stream.avail_out =3D sizeof(fixed_buf);
+		}
 		last_out =3D stream.next_out;
 	} while (status =3D=3D Z_OK);
 	if (stream.total_out !=3D size || status !=3D Z_STREAM_END)
@@ -427,7 +436,7 @@ static void *unpack_entry_data(unsigned long offset=
, unsigned long size,
 	git_inflate_end(&stream);
 	if (sha1)
 		git_SHA1_Final(sha1, &c);
-	return buf;
+	return buf =3D=3D fixed_buf ? NULL : buf;
 }
=20
 static void *unpack_raw_entry(struct object_entry *obj,
@@ -593,14 +602,21 @@ static void find_delta_children(const union delta=
_base *base,
 	*last_index =3D last;
 }
=20
-static void sha1_object(const void *data, unsigned long size,
-			enum object_type type, const unsigned char *sha1)
+static void sha1_object(const void *data, struct object_entry *obj_ent=
ry,
+			unsigned long size, enum object_type type,
+			const unsigned char *sha1)
 {
+	void *new_data =3D NULL;
+
+	assert(data || obj_entry);
+
 	read_lock();
 	if (has_sha1_file(sha1)) {
 		void *has_data;
 		enum object_type has_type;
 		unsigned long has_size;
+		if (!data)
+			data =3D new_data =3D get_data_from_pack(obj_entry);
 		has_data =3D read_sha1_file(sha1, &has_type, &has_size);
 		read_unlock();
 		if (!has_data)
@@ -625,6 +641,9 @@ static void sha1_object(const void *data, unsigned =
long size,
 			int eaten;
 			void *buf =3D (void *) data;
=20
+			if (!buf)
+				buf =3D new_data =3D get_data_from_pack(obj_entry);
+
 			/*
 			 * we do not need to free the memory here, as the
 			 * buf is deleted by the caller.
@@ -649,6 +668,8 @@ static void sha1_object(const void *data, unsigned =
long size,
 		}
 		read_unlock();
 	}
+
+	free(new_data);
 }
=20
 /*
@@ -732,7 +753,7 @@ static void resolve_delta(struct object_entry *delt=
a_obj,
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	hash_sha1_file(result->data, result->size,
 		       typename(delta_obj->real_type), delta_obj->idx.sha1);
-	sha1_object(result->data, result->size, delta_obj->real_type,
+	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
 		    delta_obj->idx.sha1);
 	counter_lock();
 	nr_resolved_deltas++;
@@ -862,7 +883,7 @@ static void *threaded_second_pass(void *data)
  */
 static void parse_pack_objects(unsigned char *sha1)
 {
-	int i;
+	int i, nr_delays =3D 0;
 	struct delta_entry *delta =3D deltas;
 	struct stat st;
=20
@@ -878,8 +899,12 @@ static void parse_pack_objects(unsigned char *sha1=
)
 			nr_deltas++;
 			delta->obj_no =3D i;
 			delta++;
+		} else if (!data) {
+			/* large blobs, check later */
+			obj->real_type =3D OBJ_BAD;
+			nr_delays++;
 		} else
-			sha1_object(data, obj->size, obj->type, obj->idx.sha1);
+			sha1_object(data, NULL, obj->size, obj->type, obj->idx.sha1);
 		free(data);
 		display_progress(progress, i+1);
 	}
@@ -899,6 +924,17 @@ static void parse_pack_objects(unsigned char *sha1=
)
 	if (S_ISREG(st.st_mode) &&
 			lseek(input_fd, 0, SEEK_CUR) - input_len !=3D st.st_size)
 		die(_("pack has junk at the end"));
+
+	for (i =3D 0; i < nr_objects; i++) {
+		struct object_entry *obj =3D &objects[i];
+		if (obj->real_type !=3D OBJ_BAD)
+			continue;
+		obj->real_type =3D obj->type;
+		sha1_object(NULL, obj, obj->size, obj->type, obj->idx.sha1);
+		nr_delays--;
+	}
+	if (nr_delays)
+		die(_("confusion beyond insanity in parse_pack_objects()"));
 }
=20
 /*
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 55ed955..3f80688 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -130,6 +130,11 @@ test_expect_success 'git-show a large file' '
=20
 '
=20
+test_expect_success 'index-pack' '
+	git clone file://"`pwd`"/.git foo &&
+	GIT_DIR=3Dnon-existent git index-pack --strict --verify foo/.git/obje=
cts/pack/*.pack
+'
+
 test_expect_success 'repack' '
 	git repack -ad
 '
--=20
1.7.8.36.g69ee2
