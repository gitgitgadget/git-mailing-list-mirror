From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] pack-objects: use streaming interface for reading large loose blobs
Date: Sat, 12 May 2012 17:26:15 +0700
Message-ID: <1336818375-16895-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 12:30:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ST9af-0003nz-C6
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 12:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab2ELKaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 06:30:14 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63398 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209Ab2ELKaM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 06:30:12 -0400
Received: by obbtb18 with SMTP id tb18so4502074obb.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 03:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Qf5W3tl7hobRl9VmFtY1kTyBTKnVflCtwP3YqNAvAuc=;
        b=hKh6QqSGkl1f42we3f7z29XRTTX7BOCq/qeOST3hsW3cPgmvPhRg5bbFdiAV5khsd9
         3LHTnUERaf4gIMzEaWTDCb/9T/bXpVOdC9o8/bJXNFHnGstOjCfvODyfnpYgV7FS+DFV
         tEo7wLTYvHvPb6THK7gH5ho2SqoMM982Yd6cqSzdAQE8a7k+JEVm4Ck4UKixZj/XPOSo
         aCbWVSCKfIPifCTJz5wlk/d4UKvCQtWVYRvgsr5ACHXXwXZx5hzz25eWcIWJRk2Fwji8
         Nmc25wGt1MrifQfrQJ6eAujeZ2UcPstczO/rSiBbW0D+EoV1zzTMYQqlb42bKq0n37u4
         U2gQ==
Received: by 10.182.119.33 with SMTP id kr1mr1556410obb.60.1336818611821;
        Sat, 12 May 2012 03:30:11 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.131])
        by mx.google.com with ESMTPS id js6sm6315864obb.2.2012.05.12.03.30.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 May 2012 03:30:11 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 12 May 2012 17:26:27 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197719>

git usually streams large blobs directly to packs. But there are cases
where git can create large loose blobs (unpack-objects or hash-object
over pipe). Or they can come from other git implementations.
core.bigfilethreshold can also be lowered down and introduce a new
wave of large loose blobs.

Use streaming interface to read these blobs and compress/write at the
same time.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 index-pack's streaming support is on the way. unpack-objects is
 another story because I'm thinking of merging it back to index-pack
 first, which may take more than one release cycle.

 builtin/pack-objects.c |   73 ++++++++++++++++++++++++++++++++++++++++=
++++----
 t/t1050-large.sh       |   16 ++++++++++
 2 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1861093..98b51c1 100644
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
@@ -150,6 +151,55 @@ static unsigned long do_compress(void **pptr, unsi=
gned long size)
 	return stream.total_out;
 }
=20
+static void write_large_blob_data(struct sha1file *f, const unsigned c=
har *sha1)
+{
+	git_zstream stream;
+	unsigned char ibuf[1024 * 16];
+	unsigned char obuf[1024 * 16];
+	int zret;
+
+	struct git_istream *st;
+	enum object_type type;
+	unsigned long sz;
+
+	st =3D open_istream(sha1, &type, &sz, NULL);
+	if (!st)
+		die(_("failed to read %s"), sha1_to_hex(sha1));
+
+	memset(&stream, 0, sizeof(stream));
+	git_deflate_init(&stream, pack_compression_level);
+
+	if (type !=3D OBJ_BLOB)
+		die("BUG: %s is not a blob", sha1_to_hex(sha1));
+
+	for (;;) {
+		ssize_t readlen;
+		readlen =3D read_istream(st, ibuf, sizeof(ibuf));
+		if (readlen =3D=3D -1)
+			die(_("failed to read %s"), sha1_to_hex(sha1));
+
+		stream.next_in =3D ibuf;
+		stream.avail_in =3D readlen;
+		zret =3D Z_OK;
+		while ((stream.avail_in || readlen =3D=3D 0) &&
+		       (zret =3D=3D Z_OK || zret =3D=3D Z_BUF_ERROR)) {
+			stream.next_out =3D obuf;
+			stream.avail_out =3D sizeof(obuf);
+			zret =3D git_deflate(&stream, readlen ? 0 : Z_FINISH);
+			sha1write(f, obuf, stream.next_out - obuf);
+		}
+		if (stream.avail_in)
+			die(_("deflate error (%d)"), zret);
+		if (readlen =3D=3D 0) {
+			if (zret !=3D Z_STREAM_END)
+				die(_("deflate error (%d)"), zret);
+			break;
+		}
+	}
+	close_istream(st);
+	git_deflate_end(&stream);
+}
+
 /*
  * we are going to reuse the existing object data as is.  make
  * sure it is not corrupt.
@@ -259,9 +309,14 @@ static unsigned long write_object(struct sha1file =
*f,
 	if (!to_reuse) {
 		no_reuse:
 		if (!usable_delta) {
-			buf =3D read_sha1_file(entry->idx.sha1, &type, &size);
-			if (!buf)
-				die("unable to read %s", sha1_to_hex(entry->idx.sha1));
+			type =3D sha1_object_info(entry->idx.sha1, &size);
+			if (type =3D=3D OBJ_BLOB && size > big_file_threshold)
+				buf =3D NULL;
+			else {
+				buf =3D read_sha1_file(entry->idx.sha1, &type, &size);
+				if (!buf)
+					die("unable to read %s", sha1_to_hex(entry->idx.sha1));
+			}
 			/*
 			 * make sure no cached delta data remains from a
 			 * previous attempt before a pack split occurred.
@@ -284,8 +339,11 @@ static unsigned long write_object(struct sha1file =
*f,
=20
 		if (entry->z_delta_size)
 			datalen =3D entry->z_delta_size;
-		else
+		else if (buf)
 			datalen =3D do_compress(&buf, size);
+		else
+			/* large blob case, just assume we don't compress well */
+			datalen =3D size;
=20
 		/*
 		 * The object header is a byte of 'type' followed by zero or
@@ -330,8 +388,11 @@ static unsigned long write_object(struct sha1file =
*f,
 			}
 			sha1write(f, header, hdrlen);
 		}
-		sha1write(f, buf, datalen);
-		free(buf);
+		if (buf) {
+			sha1write(f, buf, datalen);
+			free(buf);
+		} else
+			write_large_blob_data(f, entry->idx.sha1);
 	}
 	else {
 		struct packed_git *p =3D entry->in_pack;
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 55ed955..7fbd2e1 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -134,6 +134,22 @@ test_expect_success 'repack' '
 	git repack -ad
 '
=20
+test_expect_success 'pack-objects with large loose object' '
+	echo Z | dd of=3Dlarge4 bs=3D1k seek=3D2000 &&
+	OBJ=3D9f36d94e145816ec642592c09cc8e601d83af157 &&
+	P=3D.git/objects/9f/36d94e145816ec642592c09cc8e601d83af157 &&
+	(
+	unset GIT_ALLOC_LIMIT &&
+	cat large4 | git hash-object -w --stdin &&
+	git cat-file blob $OBJ >actual &&
+	cmp large4 actual
+	) &&
+	echo $OBJ | git pack-objects .git/objects/pack/pack &&
+	rm $P &&
+	git cat-file blob $OBJ >actual &&
+	cmp large4 actual
+'
+
 test_expect_success 'tar achiving' '
 	git archive --format=3Dtar HEAD >/dev/null
 '
--=20
1.7.8.36.g69ee2
