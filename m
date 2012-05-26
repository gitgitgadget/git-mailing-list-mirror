From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] pack-objects: use streaming interface for reading large loose blobs
Date: Sat, 26 May 2012 17:28:01 +0700
Message-ID: <1338028081-22638-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 12:32:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYEIG-0003Vd-9p
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 12:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469Ab2EZKcP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 06:32:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46556 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422Ab2EZKcO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 06:32:14 -0400
Received: by dady13 with SMTP id y13so2242483dad.19
        for <git@vger.kernel.org>; Sat, 26 May 2012 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=+0OvD/+CKRl5ptz7IEcNfrUEli7MGXbi13dpFjugEfg=;
        b=MT66RT9vWZc0mQTf01dHdkKiqLUZIDsylTAS8fS57BI3lhPQtHCwzemByrXFZvsyFh
         nQtjECKZt0negN5+nSuOvJgKm772sOZZ0ZcDUoqxZFYDa5bzXrq/H4myIVIxPyaPfw2n
         HkKDq68wwsqc4RTqlEQnXJ813L/ldwGmsq6JSyoy7V/MOkQqHjfOPirCPjkj8EGoB4vK
         ik1CQ3IjxfXLIt4Cv0VTqRaYu7ln9RcSyf7VaSmOMHSi2zpYXhCkT3RC5I+o/Nwd7eSf
         gSTjT0Xd8aPHKpRXVbj3nPXxIeZ/js3/QcQyWJj8hTjfGakq1MfP+9o1qLD8goIcqMov
         JtAA==
Received: by 10.68.236.129 with SMTP id uu1mr6340554pbc.77.1338028333625;
        Sat, 26 May 2012 03:32:13 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.50.33])
        by mx.google.com with ESMTPS id ix5sm12157625pbc.18.2012.05.26.03.32.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 May 2012 03:32:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 26 May 2012 17:28:12 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198550>

git usually streams large blobs directly to packs. But there are cases
where git can create large loose blobs (unpack-objects or hash-object
over pipe). Or they can come from other git implementations.
core.bigfilethreshold can also be lowered down and introduce a new
wave of large loose blobs.

Use streaming interface to read/compress/write these blobs in one
go. Fall back to normal way if somehow streaming interface cannot be
used.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On top of ng/pack-objects-cleanup. Changes since the last version is
 we do not rely on close_istream(NULL); any more.

 builtin/pack-objects.c | 73 ++++++++++++++++++++++++++++++++++++++++++=
+++-----
 t/t1050-large.sh       | 12 +++++++++
 2 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ccfcbad..f334820 100644
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
@@ -233,7 +281,9 @@ static unsigned long write_no_reuse_object(struct s=
ha1file *f, struct object_ent
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	}
=20
-	if (entry->z_delta_size)
+	if (st)	/* large blob case, just assume we don't compress well */
+		datalen =3D size;
+	else if (entry->z_delta_size)
 		datalen =3D entry->z_delta_size;
 	else
 		datalen =3D do_compress(&buf, size);
@@ -256,6 +306,8 @@ static unsigned long write_no_reuse_object(struct s=
ha1file *f, struct object_ent
 		while (ofs >>=3D 7)
 			dheader[--pos] =3D 128 | (--ofs & 127);
 		if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >=3D limi=
t) {
+			if (st)
+				close_istream(st);
 			free(buf);
 			return 0;
 		}
@@ -268,6 +320,8 @@ static unsigned long write_no_reuse_object(struct s=
ha1file *f, struct object_ent
 		 * an additional 20 bytes for the base sha1.
 		 */
 		if (limit && hdrlen + 20 + datalen + 20 >=3D limit) {
+			if (st)
+				close_istream(st);
 			free(buf);
 			return 0;
 		}
@@ -276,13 +330,20 @@ static unsigned long write_no_reuse_object(struct=
 sha1file *f, struct object_ent
 		hdrlen +=3D 20;
 	} else {
 		if (limit && hdrlen + datalen + 20 >=3D limit) {
+			if (st)
+				close_istream(st);
 			free(buf);
 			return 0;
 		}
 		sha1write(f, header, hdrlen);
 	}
-	sha1write(f, buf, datalen);
-	free(buf);
+	if (st) {
+		datalen =3D write_large_blob_data(st, f, entry->idx.sha1);
+		close_istream(st);
+	} else {
+		sha1write(f, buf, datalen);
+		free(buf);
+	}
=20
 	return hdrlen + datalen;
 }
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
1.7.10.2.549.g9354186
