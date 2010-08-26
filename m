From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Reduce zlib deflate code duplication
Date: Fri, 27 Aug 2010 06:56:04 +1000
Message-ID: <1282856164-5126-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 00:15:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OokjM-0004k4-E8
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 00:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671Ab0HZWP1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Aug 2010 18:15:27 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55977 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab0HZWP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 18:15:26 -0400
Received: by pzk9 with SMTP id 9so796361pzk.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=nUGCbL5gYa3gLJq8xIaC9lmjxYLyY/vfL4ClwZmQpeE=;
        b=C6cSstPK73QZoh6b77+kI7tsuEWG61KhfCsFI88u9wLVgQelAs5fqhMqxLP29ZPCRx
         6ae8iJcs29g/3blt5JRrHQVji8HZwJlvJaJMKnFPOqKXPbJEwkfGztkHYIzONFJwO7y8
         Wy2n5lMxz4ih010s5i3NuPkQntUm0czYZGKcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=u+XhB3nm/OtIs7VrtdI9Yh4zN/cYV0jlqclQQlCoDbPTbcbnqPitku5SDYPPvHJKPi
         n8VoeeewkJfujTAX8uARaD96nM7zd3Uvr3KODd/r/dElY20/kG0aoxwo4R6sJSSmK32v
         7KaxveKlSz40Q/KhYSkhadQBOEhndSPDZi2zw=
Received: by 10.142.172.6 with SMTP id u6mr520319wfe.52.1282860925476;
        Thu, 26 Aug 2010 15:15:25 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id v38sm3498655wfh.0.2010.08.26.15.15.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 15:15:24 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Fri, 27 Aug 2010 06:56:06 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154566>

Most of deflation code is simply "given this buffer, just deflate
it". Make a common routine and reuse it instead.=20

Exceptions include index-pack, http-push, fast-import,
write_sha1_file, which either make multiple zlib streams, or compress
and calculate sha1/checksum in parallel.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 There is possibly a regression here. remote-curl.c/post_rpc()
 specifies more compression options, although I doubt it affects
 performance. It also reveals places where deflation is expected
 to be always successful.

 archive-zip.c          |   37 ++-----------------------------------
 builtin/pack-objects.c |   24 +++---------------------
 cache.h                |    1 +
 diff.c                 |   29 +++--------------------------
 fast-import.c          |   40 ++++++++++++----------------------------
 remote-curl.c          |   31 ++++---------------------------
 wrapper.c              |   30 ++++++++++++++++++++++++++++++
 7 files changed, 55 insertions(+), 137 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index cf28504..64ec465 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -87,39 +87,6 @@ static void copy_le32(unsigned char *dest, unsigned =
int n)
 	dest[3] =3D 0xff & (n >> 030);
 }
=20
-static void *zlib_deflate(void *data, unsigned long size,
-		int compression_level, unsigned long *compressed_size)
-{
-	z_stream stream;
-	unsigned long maxsize;
-	void *buffer;
-	int result;
-
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, compression_level);
-	maxsize =3D deflateBound(&stream, size);
-	buffer =3D xmalloc(maxsize);
-
-	stream.next_in =3D data;
-	stream.avail_in =3D size;
-	stream.next_out =3D buffer;
-	stream.avail_out =3D maxsize;
-
-	do {
-		result =3D deflate(&stream, Z_FINISH);
-	} while (result =3D=3D Z_OK);
-
-	if (result !=3D Z_STREAM_END) {
-		free(buffer);
-		return NULL;
-	}
-
-	deflateEnd(&stream);
-	*compressed_size =3D stream.total_out;
-
-	return buffer;
-}
-
 static int write_zip_entry(struct archiver_args *args,
 		const unsigned char *sha1, const char *path, size_t pathlen,
 		unsigned int mode, void *buffer, unsigned long size)
@@ -164,8 +131,8 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	}
=20
 	if (method =3D=3D 8) {
-		deflated =3D zlib_deflate(buffer, size, args->compression_level,
-				&compressed_size);
+		compressed_size =3D size;
+		deflated =3D git_deflate(buffer, &compressed_size, args->compression=
_level);
 		if (deflated && compressed_size - 6 < size) {
 			/* ZLIB --> raw compressed data (see RFC 1950) */
 			/* CMF and FLG ... */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0e81673..20e2b6e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -130,28 +130,10 @@ static void *get_delta(struct object_entry *entry=
)
=20
 static unsigned long do_compress(void **pptr, unsigned long size)
 {
-	z_stream stream;
-	void *in, *out;
-	unsigned long maxsize;
-
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, pack_compression_level);
-	maxsize =3D deflateBound(&stream, size);
-
-	in =3D *pptr;
-	out =3D xmalloc(maxsize);
+	void *out =3D git_deflate(*pptr, &size, pack_compression_level);
+	free(*pptr);
 	*pptr =3D out;
-
-	stream.next_in =3D in;
-	stream.avail_in =3D size;
-	stream.next_out =3D out;
-	stream.avail_out =3D maxsize;
-	while (deflate(&stream, Z_FINISH) =3D=3D Z_OK)
-		; /* nothing */
-	deflateEnd(&stream);
-
-	free(in);
-	return stream.total_out;
+	return size;
 }
=20
 /*
diff --git a/cache.h b/cache.h
index eb77e1d..c8ab52d 100644
--- a/cache.h
+++ b/cache.h
@@ -22,6 +22,7 @@
 void git_inflate_init(z_streamp strm);
 void git_inflate_end(z_streamp strm);
 int git_inflate(z_streamp strm, int flush);
+void *git_deflate(void *buf, unsigned long *size, int compression_leve=
l);
=20
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
diff --git a/diff.c b/diff.c
index 6fb97d4..18f2f55 100644
--- a/diff.c
+++ b/diff.c
@@ -1674,30 +1674,6 @@ static void checkdiff_consume(void *priv, char *=
line, unsigned long len)
 	}
 }
=20
-static unsigned char *deflate_it(char *data,
-				 unsigned long size,
-				 unsigned long *result_size)
-{
-	int bound;
-	unsigned char *deflated;
-	z_stream stream;
-
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
-	bound =3D deflateBound(&stream, size);
-	deflated =3D xmalloc(bound);
-	stream.next_out =3D deflated;
-	stream.avail_out =3D bound;
-
-	stream.next_in =3D (unsigned char *)data;
-	stream.avail_in =3D size;
-	while (deflate(&stream, Z_FINISH) =3D=3D Z_OK)
-		; /* nothing */
-	deflateEnd(&stream);
-	*result_size =3D stream.total_out;
-	return deflated;
-}
-
 static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t =
*two, char *prefix)
 {
 	void *cp;
@@ -1713,7 +1689,8 @@ static void emit_binary_diff_body(FILE *file, mmf=
ile_t *one, mmfile_t *two, char
 	 * whichever is smaller.
 	 */
 	delta =3D NULL;
-	deflated =3D deflate_it(two->ptr, two->size, &deflate_size);
+	deflate_size =3D two->size;
+	deflated =3D git_deflate(two->ptr, &deflate_size, zlib_compression_le=
vel);
 	if (one->size && two->size) {
 		delta =3D diff_delta(one->ptr, one->size,
 				   two->ptr, two->size,
@@ -1721,7 +1698,7 @@ static void emit_binary_diff_body(FILE *file, mmf=
ile_t *one, mmfile_t *two, char
 		if (delta) {
 			void *to_free =3D delta;
 			orig_size =3D delta_size;
-			delta =3D deflate_it(delta, delta_size, &delta_size);
+			delta =3D git_deflate(delta, &delta_size, zlib_compression_level);
 			free(to_free);
 		}
 	}
diff --git a/fast-import.c b/fast-import.c
index dd51ac4..28bac18 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -993,7 +993,7 @@ static int store_object(
 	unsigned char sha1[20];
 	unsigned long hdrlen, deltalen;
 	git_SHA_CTX c;
-	z_stream s;
+	unsigned long compressed_size;
=20
 	hdrlen =3D sprintf((char *)hdr,"%s %lu", typename(type),
 		(unsigned long)dat->len) + 1;
@@ -1025,24 +1025,13 @@ static int store_object(
 	} else
 		delta =3D NULL;
=20
-	memset(&s, 0, sizeof(s));
-	deflateInit(&s, pack_compression_level);
-	if (delta) {
-		s.next_in =3D delta;
-		s.avail_in =3D deltalen;
-	} else {
-		s.next_in =3D (void *)dat->buf;
-		s.avail_in =3D dat->len;
-	}
-	s.avail_out =3D deflateBound(&s, s.avail_in);
-	s.next_out =3D out =3D xmalloc(s.avail_out);
-	while (deflate(&s, Z_FINISH) =3D=3D Z_OK)
-		/* nothing */;
-	deflateEnd(&s);
+	compressed_size =3D delta ? deltalen : dat->len;
+	out =3D git_deflate(delta ? delta : dat->buf, &compressed_size,
+			  pack_compression_level);
=20
 	/* Determine if we should auto-checkpoint. */
-	if ((max_packsize && (pack_size + 60 + s.total_out) > max_packsize)
-		|| (pack_size + 60 + s.total_out) < pack_size) {
+	if ((max_packsize && (pack_size + 60 + compressed_size) > max_packsiz=
e)
+		|| (pack_size + 60 + compressed_size) < pack_size) {
=20
 		/* This new object needs to *not* have the current pack_id. */
 		e->pack_id =3D pack_id + 1;
@@ -1053,15 +1042,10 @@ static int store_object(
 			free(delta);
 			delta =3D NULL;
=20
-			memset(&s, 0, sizeof(s));
-			deflateInit(&s, pack_compression_level);
-			s.next_in =3D (void *)dat->buf;
-			s.avail_in =3D dat->len;
-			s.avail_out =3D deflateBound(&s, s.avail_in);
-			s.next_out =3D out =3D xrealloc(out, s.avail_out);
-			while (deflate(&s, Z_FINISH) =3D=3D Z_OK)
-				/* nothing */;
-			deflateEnd(&s);
+			free(out);
+			compressed_size =3D dat->len;
+			out =3D git_deflate(dat->buf, &compressed_size,
+					  pack_compression_level);
 		}
 	}
=20
@@ -1096,8 +1080,8 @@ static int store_object(
 		pack_size +=3D hdrlen;
 	}
=20
-	sha1write(pack_file, out, s.total_out);
-	pack_size +=3D s.total_out;
+	sha1write(pack_file, out, compressed_size);
+	pack_size +=3D compressed_size;
=20
 	e->idx.crc32 =3D crc32_end(pack_file);
=20
diff --git a/remote-curl.c b/remote-curl.c
index 04d4813..e0d07fc 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -420,33 +420,10 @@ static int post_rpc(struct rpc_state *rpc)
 		 * we can try to deflate it ourselves, this may save on.
 		 * the transfer time.
 		 */
-		size_t size;
-		z_stream stream;
-		int ret;
-
-		memset(&stream, 0, sizeof(stream));
-		ret =3D deflateInit2(&stream, Z_BEST_COMPRESSION,
-				Z_DEFLATED, (15 + 16),
-				8, Z_DEFAULT_STRATEGY);
-		if (ret !=3D Z_OK)
-			die("cannot deflate request; zlib init error %d", ret);
-		size =3D deflateBound(&stream, rpc->len);
-		gzip_body =3D xmalloc(size);
-
-		stream.next_in =3D (unsigned char *)rpc->buf;
-		stream.avail_in =3D rpc->len;
-		stream.next_out =3D (unsigned char *)gzip_body;
-		stream.avail_out =3D size;
-
-		ret =3D deflate(&stream, Z_FINISH);
-		if (ret !=3D Z_STREAM_END)
-			die("cannot deflate request; zlib deflate error %d", ret);
-
-		ret =3D deflateEnd(&stream);
-		if (ret !=3D Z_OK)
-			die("cannot deflate request; zlib end error %d", ret);
-
-		size =3D stream.total_out;
+		unsigned long size =3D rpc->len;
+		gzip_body =3D git_deflate(rpc->buf, &size, Z_BEST_COMPRESSION);
+		if (!gzip_body)
+			die("cannot deflate request; zlib deflate error");
=20
 		headers =3D curl_slist_append(headers, "Content-Encoding: gzip");
 		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, gzip_body);
diff --git a/wrapper.c b/wrapper.c
index fd8ead3..fda7279 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -289,6 +289,36 @@ int git_inflate(z_streamp strm, int flush)
 	return ret;
 }
=20
+void *git_deflate(void *in, unsigned long *size, int compression_level=
)
+{
+	z_stream stream;
+	void *out;
+	unsigned long maxsize;
+	int result;
+
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, compression_level);
+	maxsize =3D deflateBound(&stream, *size);
+
+	out =3D xmalloc(maxsize);
+	stream.next_in =3D in;
+	stream.avail_in =3D *size;
+	stream.next_out =3D out;
+	stream.avail_out =3D maxsize;
+	while ((result =3D deflate(&stream, Z_FINISH)) =3D=3D Z_OK)
+		; /* nothing */
+
+	if (result !=3D Z_STREAM_END) {
+		*size =3D 0;
+		free(out);
+		return NULL;
+	}
+
+	deflateEnd(&stream);
+	*size =3D stream.total_out;
+	return out;
+}
+
 int odb_mkstemp(char *template, size_t limit, const char *pattern)
 {
 	int fd;
--=20
1.7.1.rc1.69.g24c2f7
