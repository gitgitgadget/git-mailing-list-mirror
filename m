From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] archive-zip: stream large blobs into zip file
Date: Mon, 30 Apr 2012 11:57:17 +0700
Message-ID: <1335761837-12482-6-git-send-email-pclouds@gmail.com>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 07:01:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOijv-0000Nu-5s
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 07:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab2D3FBa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 01:01:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57671 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab2D3FB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 01:01:29 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so2872602pbb.19
        for <git@vger.kernel.org>; Sun, 29 Apr 2012 22:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FdG0MtUwBTYUSxApZ54XupXHRkAee4GanFWMqrMGIzQ=;
        b=S5kc0a902Bz8HgNZ1nj9oGnEkJyAUdDBTWhMngOmaOPGN0YdxUp+gVkiLO9AInpTGi
         8iUztzMWlw509UGhNQDEjuZ420Jui2vWCbh7CGZv73mcd24lvF/R2hpHwya51ym/etQY
         9vPP3oeiK61rzlu9R461uJMTD3AQ6GXoivLVwMLyS+DF0TbhQYt8W8CkPoG+TCqUQ4sO
         L+CVLleWELBDGx1BDxdO7rFVObk9Oue+ZLhOWV08y6LqSUeRmuSlMAuakQDXrgQV8sdN
         QuZ/nbE2pvBP730EMmQOvKpokP96ZBA81TyXj+dPfOxb3UGmgTHR+pEmDUtoU/kRrtd6
         T+9w==
Received: by 10.68.212.7 with SMTP id ng7mr4351014pbc.71.1335762089763;
        Sun, 29 Apr 2012 22:01:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id pi10sm13910049pbc.9.2012.04.29.22.01.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Apr 2012 22:01:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 30 Apr 2012 11:58:04 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196540>

A large blob will be read twice. One for calculating crc32, one for
actual writing. Large blobs are written uncompressed for simplicity.

Writing compressed large blobs is possible. But a naive implementation
would need to decompress/compress the blob twice: one to calculate
compressed size, one for actual writing, assuming compressed blobs are
still over large file limit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I think we could extract compressed size from pack index, then stream
 the compressed blob directly from pack to zip file. But that makes
 git-archive sensitive to pack format. And to be honest I don't care
 that much about large file support to do it. This patch is good
 enough for me.

 Documentation/git-archive.txt |    3 ++
 archive-zip.c                 |   42 +++++++++++++++++++++++++++++++++=
+++++++-
 t/t1050-large.sh              |    4 +++
 3 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index ac7006e..6df85a6 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -120,6 +120,9 @@ tar.<format>.remote::
 	user-defined formats, but true for the "tar.gz" and "tgz"
 	formats.
=20
+core.bigFileThreshold::
+	Files larger than this size are stored uncompressed in zip format.
+
 ATTRIBUTES
 ----------
=20
diff --git a/archive-zip.c b/archive-zip.c
index f8039ba..ee58bda 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "archive.h"
+#include "streaming.h"
=20
 static int zip_date;
 static int zip_time;
@@ -120,6 +121,29 @@ static void *zlib_deflate(void *data, unsigned lon=
g size,
 	return buffer;
 }
=20
+static int crc32_stream(const unsigned char *sha1, unsigned long *crc)
+{
+	struct git_istream *st;
+	enum object_type type;
+	unsigned long sz;
+
+	st =3D open_istream(sha1, &type, &sz, NULL);
+	if (!st)
+		return error("cannot stream blob %s", sha1_to_hex(sha1));
+	for (;;) {
+		char buf[1024];
+		ssize_t readlen;
+
+		readlen =3D read_istream(st, buf, sizeof(buf));
+
+		if (readlen <=3D 0)
+			return readlen;
+		*crc =3D crc32(*crc, (unsigned char*)buf, readlen);
+	}
+	close_istream(st);
+	return 0;
+}
+
 static int write_zip_entry(struct archiver_args *args,
 			   const unsigned char *sha1,
 			   const char *path, size_t pathlen,
@@ -153,6 +177,19 @@ static int write_zip_entry(struct archiver_args *a=
rgs,
 		compressed_size =3D 0;
 		buffer =3D NULL;
 		size =3D 0;
+	} else if (!args->convert && S_ISREG(mode) &&
+		      sha1_object_info(sha1, &size) =3D=3D OBJ_BLOB &&
+		      size > big_file_threshold) {
+		buffer =3D NULL;
+		method =3D 0;
+		attr2 =3D S_ISLNK(mode) ? ((mode | 0777) << 16) :
+			(mode & 0111) ? ((mode) << 16) : 0;
+		if (crc32_stream(sha1, &crc) < 0)
+			return error("failed to calculate crc32 from blob %s, SHA1 %s",
+				     path, sha1_to_hex(sha1));
+		out =3D buffer;
+		uncompressed_size =3D size;
+		compressed_size =3D size;
 	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
 		enum object_type type;
 		buffer =3D sha1_file_to_archive(args, path, sha1, mode, &type, &size=
);
@@ -234,7 +271,10 @@ static int write_zip_entry(struct archiver_args *a=
rgs,
 	write_or_die(1, path, pathlen);
 	zip_offset +=3D pathlen;
 	if (compressed_size > 0) {
-		write_or_die(1, out, compressed_size);
+		if (out)
+			write_or_die(1, out, compressed_size);
+		else
+			stream_blob_to_fd(1, sha1, NULL, 0);
 		zip_offset +=3D compressed_size;
 	}
=20
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index fe47554..458fdde 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -138,4 +138,8 @@ test_expect_success 'tar achiving' '
 	git archive --format=3Dtar HEAD >/dev/null
 '
=20
+test_expect_success 'zip achiving' '
+	git archive --format=3Dzip HEAD >/dev/null
+'
+
 test_done
--=20
1.7.8.36.g69ee2
