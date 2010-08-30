From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Reduce zlib deflate code duplication
Date: Mon, 30 Aug 2010 11:46:55 +1000
Message-ID: <1283132815-3277-1-git-send-email-pclouds@gmail.com>
References: <1282856164-5126-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Aug 30 03:47:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OptSm-0001z6-7Y
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 03:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393Ab0H3BrB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 21:47:01 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63324 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226Ab0H3BrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 21:47:00 -0400
Received: by pwi7 with SMTP id 7so2011563pwi.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 18:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=DiaDZnNm2qVlHhNpUso9bsOxeMXA5xIstKygzDv+CUk=;
        b=rRQgYyChqk2z8BVQyLRCwOzfALQf/5kJouR7GL+YJAVpdcdmN0umxdqYuODKQ0AZBv
         yIkN2bM0tiHAUz5sLJ9CtuyFsr5wwRfQX4dtrzg7fCfpHDp9FYY+u4kDjPa58st5WHN1
         GllSOzI7cXxAnlwAtat5yF1ugBKI5Lu+e/BDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sNaph7550Btbffx/fUUH+6fPM7RFovgCpLokjQ+6GHS0USLarsuEWg4lg2IpPB8n8U
         e9f75boBlM0WNofr4qfrSP8y6gaKlLj71v50HgJvMOsNuZ7XKq7aqw9NNruaXdyF+2HK
         /4B1PfntfCzh1nsfrV4StxjRTg1le6ykHfQC8=
Received: by 10.114.160.2 with SMTP id i2mr4350526wae.110.1283132819742;
        Sun, 29 Aug 2010 18:46:59 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id o17sm6929199wal.21.2010.08.29.18.46.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 18:46:58 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 30 Aug 2010 11:47:05 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282856164-5126-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154742>

This patch make a common deflate routine and reuse that routine as
much as possible.

Most of deflation code is simply "given this buffer, just deflate
it". Exceptions include index-pack, http-push, fast-import,
write_sha1_file and remote-curl, which either make multiple zlib
streams, or compress and calculate sha1/checksum in parallel, or
create gzip stream.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 remote-curl is now excluded from the patch.
=20
 git_deflate() returns zlib error code and will be used to print
 something out. I'm not sure if it should die() inside diff.c.
 It error() onlys for now.

 archive-zip.c          |   37 ++-----------------------------------
 builtin/pack-objects.c |   27 ++++++---------------------
 cache.h                |    1 +
 diff.c                 |   41 +++++++++++++++-------------------------=
-
 fast-import.c          |   45 +++++++++++++++++-----------------------=
-----
 wrapper.c              |   31 +++++++++++++++++++++++++++++++
 6 files changed, 72 insertions(+), 110 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index cf28504..ed176ca 100644
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
_level, NULL);
 		if (deflated && compressed_size - 6 < size) {
 			/* ZLIB --> raw compressed data (see RFC 1950) */
 			/* CMF and FLG ... */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0e81673..9e78e88 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -130,28 +130,13 @@ static void *get_delta(struct object_entry *entry=
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
+	int zlib_error;
+	void *out =3D git_deflate(*pptr, &size, pack_compression_level, &zlib=
_error);
+	if (!out)
+		die("failed to compress, zlib error %d", zlib_error);
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
index eb77e1d..afca130 100644
--- a/cache.h
+++ b/cache.h
@@ -22,6 +22,7 @@
 void git_inflate_init(z_streamp strm);
 void git_inflate_end(z_streamp strm);
 int git_inflate(z_streamp strm, int flush);
+void *git_deflate(void *buf, unsigned long *size, int compression_leve=
l, int *error);
=20
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
diff --git a/diff.c b/diff.c
index 6fb97d4..56ef7a0 100644
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
@@ -1708,12 +1684,19 @@ static void emit_binary_diff_body(FILE *file, m=
mfile_t *one, mmfile_t *two, char
 	unsigned long delta_size;
 	unsigned long deflate_size;
 	unsigned long data_size;
+	int zlib_error;
=20
 	/* We could do deflated delta, or we could do just deflated two,
 	 * whichever is smaller.
 	 */
 	delta =3D NULL;
-	deflated =3D deflate_it(two->ptr, two->size, &deflate_size);
+	deflate_size =3D two->size;
+	deflated =3D git_deflate(two->ptr, &deflate_size, zlib_compression_le=
vel, &zlib_error);
+	if (!deflated) {
+		error("failed to compress for binary diff prefix %s, zlib error %d",
+		      prefix, zlib_error);
+		return;
+	}
 	if (one->size && two->size) {
 		delta =3D diff_delta(one->ptr, one->size,
 				   two->ptr, two->size,
@@ -1721,8 +1704,14 @@ static void emit_binary_diff_body(FILE *file, mm=
file_t *one, mmfile_t *two, char
 		if (delta) {
 			void *to_free =3D delta;
 			orig_size =3D delta_size;
-			delta =3D deflate_it(delta, delta_size, &delta_size);
+			delta =3D git_deflate(delta, &delta_size, zlib_compression_level, N=
ULL);
 			free(to_free);
+			if (!delta) {
+				free(deflated);
+				error("failed to compress for delta prefix %s, zlib error %d",
+				      prefix, zlib_error);
+				return;
+			}
 		}
 	}
=20
diff --git a/fast-import.c b/fast-import.c
index dd51ac4..cbdab25 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -993,7 +993,8 @@ static int store_object(
 	unsigned char sha1[20];
 	unsigned long hdrlen, deltalen;
 	git_SHA_CTX c;
-	z_stream s;
+	unsigned long compressed_size;
+	int zlib_error;
=20
 	hdrlen =3D sprintf((char *)hdr,"%s %lu", typename(type),
 		(unsigned long)dat->len) + 1;
@@ -1025,24 +1026,15 @@ static int store_object(
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
+			  pack_compression_level, &zlib_error);
+	if (!out)
+		die("failed to compress, zlib error %d", zlib_error);
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
@@ -1053,15 +1045,12 @@ static int store_object(
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
+					  pack_compression_level, &zlib_error);
+			if (!out)
+				die("failed to compress, zlib error %d", zlib_error);
 		}
 	}
=20
@@ -1096,8 +1085,8 @@ static int store_object(
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
diff --git a/wrapper.c b/wrapper.c
index fd8ead3..d0d3de9 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -289,6 +289,37 @@ int git_inflate(z_streamp strm, int flush)
 	return ret;
 }
=20
+void *git_deflate(void *in, unsigned long *size, int compression_level=
, int *error)
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
+	if (result !=3D Z_STREAM_END ||
+	    (result =3D deflateEnd(&stream)) !=3D Z_OK) {
+		if (error)
+			*error =3D result;
+		*size =3D 0;
+		free(out);
+		return NULL;
+	}
+	*size =3D stream.total_out;
+	return out;
+}
+
 int odb_mkstemp(char *template, size_t limit, const char *pattern)
 {
 	int fd;
--=20
1.7.1.rc1.69.g24c2f7
