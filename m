From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/4] pack-objects: use streaming interface for reading large loose blobs
Date: Wed, 16 May 2012 19:02:11 +0700
Message-ID: <1337169731-23416-4-git-send-email-pclouds@gmail.com>
References: <1336818375-16895-1-git-send-email-pclouds@gmail.com>
 <1337169731-23416-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 14:06:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUd02-0000gi-EF
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 14:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758663Ab2EPMGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 08:06:33 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38428 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756377Ab2EPMGc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 08:06:32 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so898350dad.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 05:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mLer4h1hoITMp0/iHsO7aOnWg3eQBOPPqlIjXjrdZCM=;
        b=Pz4FHEIWjcP1ldlh+u3+D25DgmfJD0K6eBt+LgMIkJwF4crGetsezpXy3hPENRxUdG
         vXfZzvNoKTR1WpjWbFD2D4c0Wcv4OHjeXawKIHXPNPgIHlbEwur94eji00NQpPlurtd2
         iPPdKDwWB5GuXZGswfq21qcXnI+Y3Oq5gDGSDr7tolzrOLS7jpucARY9WUxflybpu6Mh
         qc25iTcNUVP0akQ97qi1BA6191bH6K8QQjqCw9cpBoOpy/u2YIm6fa5dH0g3THXkZX5l
         kZBY0bD8dnTivEIzmBLBnMwQKJjw22ty+9ur9YU8NHSQAW3+cZaLUivPwZNoYpi48Mc1
         SPeA==
Received: by 10.68.223.37 with SMTP id qr5mr16088223pbc.159.1337169992621;
        Wed, 16 May 2012 05:06:32 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.61.104])
        by mx.google.com with ESMTPS id sy3sm4200165pbc.0.2012.05.16.05.06.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 05:06:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 May 2012 19:02:41 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1337169731-23416-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197872>

git usually streams large blobs directly to packs. But there are cases
where git can create large loose blobs (unpack-objects or hash-object
over pipe). Or they can come from other git implementations.
core.bigfilethreshold can also be lowered down and introduce a new
wave of large loose blobs.

Use streaming interface to read/compress/write these blobs in one go.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Changes since the first version:

  - use "struct git_istream *" as streaming indicator, instead of "buf
    !=3D NULL"
  - fall back to read_sha1_file() if open_istream() fails
  - write_object() returns correct written number of bytes (previously
    datalen was miscalculated, leading to wrong pack size calculation)

 builtin/pack-objects.c |   63 ++++++++++++++++++++++++++++++++++++++++=
++++---
 t/t1050-large.sh       |   12 +++++++++
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ccfcbad..b2679cb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -16,6 +16,7 @@
 #include "list-objects.h"
 #include "progress.h"
 #include "refs.h"
+#include "streaming.h"
 #include "thread-utils.h"
=20
 static const char *pack_usage[] =3D {
@@ -150,6 +151,46 @@ static unsigned long do_compress(void **pptr, unsi=
gned long size)
 	return stream.total_out;
 }
=20
+static unsigned long write_large_blob_data(struct git_istream *st, str=
uct sha1file *f,
+					   const unsigned char *sha1)
+{
+	git_zstream stream;
+	unsigned char ibuf[1024 * 16];
+	unsigned char obuf[1024 * 16];
+	unsigned long olen =3D 0;
+
+	memset(&stream, 0, sizeof(stream));
+	git_deflate_init(&stream, pack_compression_level);
+
+	for (;;) {
+		ssize_t readlen;
+		int zret =3D Z_OK;
+		readlen =3D read_istream(st, ibuf, sizeof(ibuf));
+		if (readlen =3D=3D -1)
+			die(_("unable to read %s"), sha1_to_hex(sha1));
+
+		stream.next_in =3D ibuf;
+		stream.avail_in =3D readlen;
+		while ((stream.avail_in || readlen =3D=3D 0) &&
+		       (zret =3D=3D Z_OK || zret =3D=3D Z_BUF_ERROR)) {
+			stream.next_out =3D obuf;
+			stream.avail_out =3D sizeof(obuf);
+			zret =3D git_deflate(&stream, readlen ? 0 : Z_FINISH);
+			sha1write(f, obuf, stream.next_out - obuf);
+			olen +=3D stream.next_out - obuf;
+		}
+		if (stream.avail_in)
+			die(_("deflate error (%d)"), zret);
+		if (readlen =3D=3D 0) {
+			if (zret !=3D Z_STREAM_END)
+				die(_("deflate error (%d)"), zret);
+			break;
+		}
+	}
+	git_deflate_end(&stream);
+	return olen;
+}
+
 /*
  * we are going to reuse the existing object data as is.  make
  * sure it is not corrupt.
@@ -208,11 +249,18 @@ static unsigned long write_no_reuse_object(struct=
 sha1file *f, struct object_ent
 	unsigned hdrlen;
 	enum object_type type;
 	void *buf;
+	struct git_istream *st =3D NULL;
=20
 	if (!usable_delta) {
-		buf =3D read_sha1_file(entry->idx.sha1, &type, &size);
-		if (!buf)
-			die("unable to read %s", sha1_to_hex(entry->idx.sha1));
+		if (entry->type =3D=3D OBJ_BLOB &&
+		    entry->size > big_file_threshold &&
+		    (st =3D open_istream(entry->idx.sha1, &type, &size, NULL)) !=3D =
NULL)
+			buf =3D NULL;
+		else {
+			buf =3D read_sha1_file(entry->idx.sha1, &type, &size);
+			if (!buf)
+				die(_("unable to read %s"), sha1_to_hex(entry->idx.sha1));
+		}
 		/*
 		 * make sure no cached delta data remains from a
 		 * previous attempt before a pack split occurred.
@@ -235,6 +283,9 @@ static unsigned long write_no_reuse_object(struct s=
ha1file *f, struct object_ent
=20
 	if (entry->z_delta_size)
 		datalen =3D entry->z_delta_size;
+	else if (st)
+		/* large blob case, just assume we don't compress well */
+		datalen =3D size;
 	else
 		datalen =3D do_compress(&buf, size);
=20
@@ -281,7 +332,11 @@ static unsigned long write_no_reuse_object(struct =
sha1file *f, struct object_ent
 		}
 		sha1write(f, header, hdrlen);
 	}
-	sha1write(f, buf, datalen);
+	if (st)
+		datalen =3D write_large_blob_data(st, f, entry->idx.sha1);
+	else
+		sha1write(f, buf, datalen);
+	close_istream(st);
 	free(buf);
=20
 	return hdrlen + datalen;
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 55ed955..313889b 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -134,6 +134,18 @@ test_expect_success 'repack' '
 	git repack -ad
 '
=20
+test_expect_success 'pack-objects with large loose object' '
+	SHA1=3D`git hash-object huge` &&
+	test_create_repo loose &&
+	echo $SHA1 | git pack-objects --stdout |
+		GIT_ALLOC_LIMIT=3D0 GIT_DIR=3Dloose/.git git unpack-objects &&
+	echo $SHA1 | GIT_DIR=3Dloose/.git git pack-objects pack &&
+	test_create_repo packed &&
+	mv pack-* packed/.git/objects/pack &&
+	GIT_DIR=3Dpacked/.git git cat-file blob $SHA1 >actual &&
+	cmp huge actual
+'
+
 test_expect_success 'tar achiving' '
 	git archive --format=3Dtar HEAD >/dev/null
 '
--=20
1.7.8.36.g69ee2
