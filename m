From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/11] pack-check: do not unpack blobs
Date: Mon, 27 Feb 2012 14:55:13 +0700
Message-ID: <1330329315-11407-10-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 08:57:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vSR-0007OY-NU
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 08:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab2B0H5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 02:57:14 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60007 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab2B0H5M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 02:57:12 -0500
Received: by mail-pw0-f46.google.com with SMTP id up15so1788846pbc.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 23:57:12 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.229.67 as permitted sender) client-ip=10.68.229.67;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.229.67 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.229.67])
        by 10.68.229.67 with SMTP id so3mr31021323pbc.163.1330329432644 (num_hops = 1);
        Sun, 26 Feb 2012 23:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xwQVasT0bjYKszjup2CunSOkUoaWOQbWgUd23qL+9gY=;
        b=I9PfyrlDxV+6np2LZhiMXyVFbC7YpZqNzqG9T5elKxZintNboEVDqnGv3gsTbQ2BfA
         jx+sDB+9HVaRNQ2qdBai1dyTnPU8zHBWJnImT0rBu6lytANKjiXQgn+fTuzH7hvnKlmn
         42glo9NU7sIY4hKxt1+MdBMaZX+qRTAGRiS4A=
Received: by 10.68.229.67 with SMTP id so3mr26494402pbc.163.1330329432571;
        Sun, 26 Feb 2012 23:57:12 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id x6sm5512856pbu.67.2012.02.26.23.57.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 23:57:11 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:56:48 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191612>

blob content is not used by verify_pack caller (currently only fsck),
we only need to make sure blob sha-1 signature matches its
content. unpack_entry() is taught to hash pack entry as it is
unpacked, eliminating the need to keep whole blob in memory.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h          |    2 +-
 fast-import.c    |    2 +-
 pack-check.c     |   21 ++++++++++++++++++++-
 sha1_file.c      |   45 +++++++++++++++++++++++++++++++++++----------
 t/t1050-large.sh |    2 +-
 5 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index 6ce691b..33bfb69 100644
--- a/cache.h
+++ b/cache.h
@@ -1065,7 +1065,7 @@ extern const unsigned char *nth_packed_object_sha=
1(struct packed_git *, uint32_t
 extern off_t nth_packed_object_offset(const struct packed_git *, uint3=
2_t);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_=
git *);
 extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct packed_git *, off_t, enum object_type=
 *, unsigned long *);
+extern void *unpack_entry(struct packed_git *, off_t, enum object_type=
 *, unsigned long *, unsigned char *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *=
buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct p=
ack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_windo=
w **, off_t *, unsigned long *);
diff --git a/fast-import.c b/fast-import.c
index 6cd19e5..5e94a64 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1303,7 +1303,7 @@ static void *gfi_unpack_entry(
 		 */
 		p->pack_size =3D pack_size + 20;
 	}
-	return unpack_entry(p, oe->idx.offset, &type, sizep);
+	return unpack_entry(p, oe->idx.offset, &type, sizep, NULL);
 }
=20
 static const char *get_mode(const char *str, uint16_t *modep)
diff --git a/pack-check.c b/pack-check.c
index 63a595c..1920bdb 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -105,6 +105,7 @@ static int verify_packfile(struct packed_git *p,
 		void *data;
 		enum object_type type;
 		unsigned long size;
+		off_t curpos =3D entries[i].offset;
=20
 		if (p->index_version > 1) {
 			off_t offset =3D entries[i].offset;
@@ -116,7 +117,25 @@ static int verify_packfile(struct packed_git *p,
 					    sha1_to_hex(entries[i].sha1),
 					    p->pack_name, (uintmax_t)offset);
 		}
-		data =3D unpack_entry(p, entries[i].offset, &type, &size);
+		type =3D unpack_object_header(p, w_curs, &curpos, &size);
+		unuse_pack(w_curs);
+		if (type =3D=3D OBJ_BLOB) {
+			unsigned char sha1[20];
+			data =3D unpack_entry(p, entries[i].offset, &type, &size, sha1);
+			if (!data) {
+				if (hashcmp(entries[i].sha1, sha1))
+					err =3D error("packed %s from %s is corrupt",
+						    sha1_to_hex(entries[i].sha1), p->pack_name);
+				else if (fn) {
+					int eaten =3D 0;
+					fn(entries[i].sha1, type, size, NULL, &eaten);
+				}
+				if (((base_count + i) & 1023) =3D=3D 0)
+					display_progress(progress, base_count + i);
+				continue;
+			}
+		}
+		data =3D unpack_entry(p, entries[i].offset, &type, &size, NULL);
 		if (!data)
 			err =3D error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    sha1_to_hex(entries[i].sha1), p->pack_name,
diff --git a/sha1_file.c b/sha1_file.c
index a77ef0a..d68a5b0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1653,28 +1653,51 @@ static int packed_object_info(struct packed_git=
 *p, off_t obj_offset,
 }
=20
 static void *unpack_compressed_entry(struct packed_git *p,
-				    struct pack_window **w_curs,
-				    off_t curpos,
-				    unsigned long size)
+				     struct pack_window **w_curs,
+				     off_t curpos,
+				     unsigned long size,
+				     enum object_type type,
+				     unsigned char *sha1)
 {
+	static unsigned char fixed_buf[8192];
 	int st;
 	git_zstream stream;
 	unsigned char *buffer, *in;
+	git_SHA_CTX c;
+
+	if (sha1) {		/* do hash_sha1_file internally */
+		char hdr[32];
+		int hdrlen =3D sprintf(hdr, "%s %lu", typename(type), size)+1;
+		git_SHA1_Init(&c);
+		git_SHA1_Update(&c, hdr, hdrlen);
+
+		buffer =3D fixed_buf;
+	} else {
+		buffer =3D xmallocz(size);
+	}
=20
-	buffer =3D xmallocz(size);
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out =3D buffer;
-	stream.avail_out =3D size + 1;
+	stream.avail_out =3D buffer =3D=3D fixed_buf ? sizeof(fixed_buf) : si=
ze + 1;
=20
 	git_inflate_init(&stream);
 	do {
 		in =3D use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in =3D in;
 		st =3D git_inflate(&stream, Z_FINISH);
-		if (!stream.avail_out)
+		if (sha1) {
+			git_SHA1_Update(&c, buffer, stream.next_out - (unsigned char *)buff=
er);
+			stream.next_out =3D buffer;
+			stream.avail_out =3D sizeof(fixed_buf);
+		}
+		else if (!stream.avail_out)
 			break; /* the payload is larger than it should be */
 		curpos +=3D stream.next_in - in;
 	} while (st =3D=3D Z_OK || st =3D=3D Z_BUF_ERROR);
+	if (sha1) {
+		git_SHA1_Final(sha1, &c);
+		buffer =3D NULL;
+	}
 	git_inflate_end(&stream);
 	if ((st !=3D Z_STREAM_END) || stream.total_out !=3D size) {
 		free(buffer);
@@ -1727,7 +1750,7 @@ static void *cache_or_unpack_entry(struct packed_=
git *p, off_t base_offset,
=20
 	ret =3D ent->data;
 	if (!ret || ent->p !=3D p || ent->base_offset !=3D base_offset)
-		return unpack_entry(p, base_offset, type, base_size);
+		return unpack_entry(p, base_offset, type, base_size, NULL);
=20
 	if (!keep_cache) {
 		ent->data =3D NULL;
@@ -1844,7 +1867,7 @@ static void *unpack_delta_entry(struct packed_git=
 *p,
 			return NULL;
 	}
=20
-	delta_data =3D unpack_compressed_entry(p, w_curs, curpos, delta_size)=
;
+	delta_data =3D unpack_compressed_entry(p, w_curs, curpos, delta_size,=
 OBJ_NONE, NULL);
 	if (!delta_data) {
 		error("failed to unpack compressed delta "
 		      "at offset %"PRIuMAX" from %s",
@@ -1883,7 +1906,8 @@ static void write_pack_access_log(struct packed_g=
it *p, off_t obj_offset)
 int do_check_packed_object_crc;
=20
 void *unpack_entry(struct packed_git *p, off_t obj_offset,
-		   enum object_type *type, unsigned long *sizep)
+		   enum object_type *type, unsigned long *sizep,
+		   unsigned char *sha1)
 {
 	struct pack_window *w_curs =3D NULL;
 	off_t curpos =3D obj_offset;
@@ -1917,7 +1941,8 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
-		data =3D unpack_compressed_entry(p, &w_curs, curpos, *sizep);
+		data =3D unpack_compressed_entry(p, &w_curs, curpos,
+					       *sizep, *type, sha1);
 		break;
 	default:
 		data =3D NULL;
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 7e78c72..c749ecb 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -141,7 +141,7 @@ test_expect_success 'fetch updates' '
 	)
 '
=20
-test_expect_failure 'fsck' '
+test_expect_success 'fsck' '
 	git fsck --full
 '
=20
--=20
1.7.3.1.256.g2539c.dirty
