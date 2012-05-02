From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/10] archive-tar: stream large blobs to tar file
Date: Wed,  2 May 2012 20:25:18 +0700
Message-ID: <1335965122-17458-7-git-send-email-pclouds@gmail.com>
References: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 15:30:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZd2-0000ye-5R
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab2EBN3z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:29:55 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63602 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab2EBN3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:29:55 -0400
Received: by ghrr11 with SMTP id r11so666760ghr.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AMO7NdAe9HhkA4dJU/hL8n2UCBFM5XLKnA2S0T7g0YI=;
        b=KZ/yspRkCi8gUtfmrcPFjy0KdMQWpBr8gnEmG6o3lwpRaEscOArJGlUQTtXFhmluWK
         QT3eFXstqtTA76Rmkja6QXE4M44/23yuYBVtAIVPleuxmLyxoNi8n5eYCXOKZviVw8ps
         ZF//PhUM0/7pwX7EhhesBFiXgsWAe1O3h2qd+dAGll7t7L9PDUVP/Pq5py8XvOGh4fMs
         UFhO5pomcyqAETZz9znxeVzI+uj0tG9e1mWre15M1VyWz+G7UjMqA0i6O9NEklVX5nnk
         vIYktE8Pli662A6Ij3ew7FMCgsM44Cca70c/ECnc6cNTYT+5YYn75CSYABP0bM4S3kew
         5t7Q==
Received: by 10.68.204.103 with SMTP id kx7mr48436053pbc.147.1335965394437;
        Wed, 02 May 2012 06:29:54 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id pz3sm1996484pbc.16.2012.05.02.06.29.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 06:29:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 20:26:24 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196809>

t5000 makes sure it produces correct output while t1050 is about not
going over memory limit (i.e. respect core.bigfilethreshold from the
beginning to the end)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-tar.c       |   44 +++++++++++++++++++++++++++++++++++++++++--=
-
 t/t1050-large.sh    |    4 ++++
 t/t5000-tar-tree.sh |    7 +++++++
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 9060f9a..759e2bf 100644
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
@@ -80,6 +81,35 @@ static void write_trailer(void)
 }
=20
 /*
+ * queues up writes, so that all our write(2) calls write exactly one
+ * full block; pads writes to RECORDSIZE
+ */
+static int stream_blocked(const unsigned char *sha1)
+{
+	struct git_istream *st;
+	enum object_type type;
+	unsigned long sz;
+	char buf[BLOCKSIZE];
+	ssize_t readlen;
+
+	st =3D open_istream(sha1, &type, &sz, NULL);
+	if (!st)
+		return error("cannot stream blob %s", sha1_to_hex(sha1));
+	for (;;) {
+		readlen =3D read_istream(st, buf, sizeof(buf));
+		if (readlen <=3D 0)
+			break;
+		write_blocked(buf, readlen, 1);
+	}
+	close_istream(st);
+
+	/* pad the remaining (if any) to full 512-byte blocks */
+	if (!readlen)
+		write_blocked(NULL, 0, 0);
+	return readlen;
+}
+
+/*
  * pax extended header records have the format "%u %s=3D%s\n".  %u con=
tains
  * the size of the whole string (including the %u), the first %s is th=
e
  * keyword, the second one is the value.  This function constructs suc=
h a
@@ -205,7 +235,11 @@ static int write_tar_entry(struct archiver_args *a=
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
@@ -237,8 +271,12 @@ static int write_tar_entry(struct archiver_args *a=
rgs,
 	}
 	strbuf_release(&ext_header);
 	write_blocked(&header, sizeof(header), 0);
-	if (S_ISREG(mode) && buffer && size > 0)
-		write_blocked(buffer, size, 0);
+	if (S_ISREG(mode) && size > 0) {
+		if (buffer)
+			write_blocked(buffer, size, 0);
+		else
+			err =3D stream_blocked(sha1);
+	}
 	free(buffer);
 	return err;
 }
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
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 527c9e7..421c356 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -84,6 +84,13 @@ test_expect_success \
     'git archive vs. git tar-tree' \
     'test_cmp b.tar b2.tar'
=20
+test_expect_success 'git archive on large files' '
+    git config core.bigfilethreshold 1 &&
+    git archive HEAD >b3.tar &&
+    git config --unset core.bigfilethreshold &&
+    test_cmp b.tar b3.tar
+'
+
 test_expect_success \
     'git archive in a bare repo' \
     '(cd bare.git && git archive HEAD) >b3.tar'
--=20
1.7.8.36.g69ee2
