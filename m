From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/10] archive-zip: streaming for deflated files
Date: Wed,  2 May 2012 20:25:22 +0700
Message-ID: <1335965122-17458-11-git-send-email-pclouds@gmail.com>
References: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 15:30:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZde-0001Pp-DA
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab2EBNad convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:30:33 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64496 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab2EBNac (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:30:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1097342pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2KeyCnd1ESSEm0KysVb2oVgIrh6IFp3ANd6L2/79m4Q=;
        b=jqhoPoWFTIceCzDH+O4hk9cGELbSFY4M9KDp9V9u10PTFzvZIAspWiEiwcXxpXD6YI
         JbrlQMuJRUir7QpEUnIKp6GbxDOoYTAVh41FJPF5yoNVZxAJBXFf2ciluyCpvNE+H5Si
         oQbYEVxej5wIAdX1+NQxfuwEdrEn03BHC+Q0gpiHjqX5b2K0E4jGMejQ/donH8L0Ywum
         9HReZxXvLnmixOiT0wlCva6zvxILDzNyRGvASpaJXiX2AAxA064dOQ10v3Z+QJbiIasS
         JJoqopvLWycoGl08g4IGVmPcQPdLVK01Xz0KL9jbkHOeID2ApIWkJWDSIpQ/l+dX8Bra
         8cUQ==
Received: by 10.68.213.234 with SMTP id nv10mr18611574pbc.36.1335965432754;
        Wed, 02 May 2012 06:30:32 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id iw1sm1994566pbc.34.2012.05.02.06.30.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 06:30:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 20:27:02 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196813>

=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>

After an entry has been streamed out, its CRC and sizes are written as
part of a data descriptor.

=46or simplicity, we make the buffer for the compressed chunks twice as
big as for the uncompressed ones, to be sure the result fit in even
if deflate makes them bigger.

t5000 verifies output. t1050 makes sure the command always respects
core.bigfilethreshold

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-zip.c       |   64 +++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 t/t1050-large.sh    |    4 +++
 t/t5000-tar-tree.sh |    8 ++++++
 3 files changed, 75 insertions(+), 1 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 1c6c39d..f5af81f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -211,7 +211,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 		compressed_size =3D size;
=20
 		if (S_ISREG(mode) && type =3D=3D OBJ_BLOB && !args->convert &&
-		    size > big_file_threshold && method =3D=3D 0) {
+		    size > big_file_threshold) {
 			stream =3D open_istream(sha1, &type, &size, NULL);
 			if (!stream)
 				return error("cannot stream blob %s",
@@ -308,6 +308,68 @@ static int write_zip_entry(struct archiver_args *a=
rgs,
 		zip_offset +=3D ZIP_DATA_DESC_SIZE;
=20
 		set_zip_dir_data_desc(&dirent, size, compressed_size, crc);
+	} else if (stream && method =3D=3D 8) {
+		unsigned char buf[STREAM_BUFFER_SIZE];
+		ssize_t readlen;
+		git_zstream zstream;
+		int result;
+		size_t out_len;
+		unsigned char compressed[STREAM_BUFFER_SIZE * 2];
+
+		memset(&zstream, 0, sizeof(zstream));
+		git_deflate_init(&zstream, args->compression_level);
+
+		compressed_size =3D 0;
+		zstream.next_out =3D compressed;
+		zstream.avail_out =3D sizeof(compressed);
+
+		for (;;) {
+			readlen =3D read_istream(stream, buf, sizeof(buf));
+			if (readlen <=3D 0)
+				break;
+			crc =3D crc32(crc, buf, readlen);
+
+			zstream.next_in =3D buf;
+			zstream.avail_in =3D readlen;
+			result =3D git_deflate(&zstream, 0);
+			if (result !=3D Z_OK)
+				die("deflate error (%d)", result);
+			out =3D compressed;
+			if (!compressed_size)
+				out +=3D 2;
+			out_len =3D zstream.next_out - out;
+
+			if (out_len > 0) {
+				write_or_die(1, out, out_len);
+				compressed_size +=3D out_len;
+				zstream.next_out =3D compressed;
+				zstream.avail_out =3D sizeof(compressed);
+			}
+
+		}
+		close_istream(stream);
+		if (readlen)
+			return readlen;
+
+		zstream.next_in =3D buf;
+		zstream.avail_in =3D 0;
+		result =3D git_deflate(&zstream, Z_FINISH);
+		if (result !=3D Z_STREAM_END)
+			die("deflate error (%d)", result);
+
+		git_deflate_end(&zstream);
+		out =3D compressed;
+		if (!compressed_size)
+			out +=3D 2;
+		out_len =3D zstream.next_out - out - 4;
+		write_or_die(1, out, out_len);
+		compressed_size +=3D out_len;
+		zip_offset +=3D compressed_size;
+
+		write_zip_data_desc(size, compressed_size, crc);
+		zip_offset +=3D ZIP_DATA_DESC_SIZE;
+
+		set_zip_dir_data_desc(&dirent, size, compressed_size, crc);
 	} else if (compressed_size > 0) {
 		write_or_die(1, out, compressed_size);
 		zip_offset +=3D compressed_size;
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 9db54b5..55ed955 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -142,4 +142,8 @@ test_expect_success 'zip achiving, store only' '
 	git archive --format=3Dzip -0 HEAD >/dev/null
 '
=20
+test_expect_success 'zip achiving, deflate' '
+	git archive --format=3Dzip HEAD >/dev/null
+'
+
 test_done
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 3cd2e51..ca83ac2 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -252,6 +252,14 @@ test_expect_success UNZIP 'git archive -0 --format=
=3Dzip on large files' '
     (mkdir large && cd large && $UNZIP ../large.zip)
 '
=20
+test_expect_success UNZIP 'git archive --format=3Dzip on large files' =
'
+    git config core.bigfilethreshold 1 &&
+    git archive --format=3Dzip HEAD >large-compressed.zip &&
+    git config --unset core.bigfilethreshold &&
+    (mkdir large-compressed && cd large-compressed && $UNZIP ../large-=
compressed.zip) &&
+    test_cmp large-compressed/a/bin/sh large/a/bin/sh
+'
+
 test_expect_success \
     'git archive --list outside of a git repo' \
     'GIT_DIR=3Dsome/non-existing/directory git archive --list'
--=20
1.7.8.36.g69ee2
