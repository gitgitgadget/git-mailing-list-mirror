From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] archive-tar: stream large blobs to tar file
Date: Mon, 30 Apr 2012 11:57:16 +0700
Message-ID: <1335761837-12482-5-git-send-email-pclouds@gmail.com>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 07:01:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOijo-0000Ih-1q
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 07:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab2D3FBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 01:01:23 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57671 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab2D3FBW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 01:01:22 -0400
Received: by pbbrp8 with SMTP id rp8so2872602pbb.19
        for <git@vger.kernel.org>; Sun, 29 Apr 2012 22:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dtA/rFuMm/wHQEZA3r9gXcJcVWPdpZ3mg3EDC6ocjn4=;
        b=N3u9ZO00+i8yrXtsVEpPS3104ovEn7Q5rWeFrzUR8Ep7hNHy/Jyd/mpbccCk/+HnoZ
         +hvCF44kdkQjeY26AI/VO+AofRrORA1f0gwp0LNsFsWNgUw0xs2MINeutxejQgr4lDV7
         WWh/BwKQS+sjw4taAx1LrPmqWjdllu4r9IFPuFLflFPEO6PZFLtKIjSnnH9sa1MulIgn
         Byu/d/JNb/wwpIS2zl9c0X1bvpZ1mz1DfGkYDu6+sWBxXq69VSx7TpOGFyJxB31fr+PL
         KfIiGMQwgBeTzR4y4X5AYUSYf1XYa+5YP6qn0fxjzdwTOD+auAo1R2OLgpfK37gzMQlx
         u+2w==
Received: by 10.68.240.135 with SMTP id wa7mr44827146pbc.7.1335762082420;
        Sun, 29 Apr 2012 22:01:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id tx9sm4286675pbc.10.2012.04.29.22.01.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Apr 2012 22:01:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 30 Apr 2012 11:57:57 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196539>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-tar.c    |   38 +++++++++++++++++++++++++++++++++++---
 t/t1050-large.sh |    4 ++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 61821f4..865ef6d 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "tar.h"
 #include "archive.h"
+#include "streaming.h"
 #include "run-command.h"
=20
 #define RECORDSIZE	(512)
@@ -62,6 +63,29 @@ static void write_blocked(const void *data, unsigned=
 long size)
 	write_if_needed();
 }
=20
+static int stream_blob_to_file(const unsigned char *sha1)
+{
+	struct git_istream *st;
+	enum object_type type;
+	unsigned long sz;
+
+	st =3D open_istream(sha1, &type, &sz, NULL);
+	if (!st)
+		return error("cannot stream blob %s", sha1_to_hex(sha1));
+	for (;;) {
+		char buf[BLOCKSIZE];
+		ssize_t readlen;
+
+		readlen =3D read_istream(st, buf, sizeof(buf));
+
+		if (readlen <=3D 0)
+			return readlen;
+		write_blocked(buf, readlen);
+	}
+	close_istream(st);
+	return 0;
+}
+
 /*
  * The end of tar archives is marked by 2*512 nul bytes and after that
  * follows the rest of the block (if any).
@@ -203,7 +227,11 @@ static int write_tar_entry(struct archiver_args *a=
rgs,
 	} else
 		memcpy(header.name, path, pathlen);
=20
-	if (S_ISLNK(mode) || S_ISREG(mode)) {
+	if (S_ISREG(mode) && !args->convert &&
+	    sha1_object_info(sha1, &size) =3D=3D OBJ_BLOB &&
+	    size > big_file_threshold)
+		buffer =3D NULL;
+	else if (S_ISLNK(mode) || S_ISREG(mode)) {
 		enum object_type type;
 		buffer =3D sha1_file_to_archive(args, path, sha1, old_mode, &type, &=
size);
 		if (!buffer)
@@ -233,8 +261,12 @@ static int write_tar_entry(struct archiver_args *a=
rgs,
 	}
 	strbuf_release(&ext_header);
 	write_blocked(&header, sizeof(header));
-	if (S_ISREG(mode) && buffer && size > 0)
-		write_blocked(buffer, size);
+	if (S_ISREG(mode) && size > 0) {
+		if (buffer)
+			write_blocked(buffer, size);
+		else
+			err =3D stream_blob_to_file(sha1);
+	}
 	return err;
 }
=20
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 4d127f1..fe47554 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -134,4 +134,8 @@ test_expect_success 'repack' '
 	git repack -ad
 '
=20
+test_expect_success 'tar achiving' '
+	git archive --format=3Dtar HEAD >/dev/null
+'
+
 test_done
--=20
1.7.8.36.g69ee2
