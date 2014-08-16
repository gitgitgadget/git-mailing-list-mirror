From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 4/5] diff --stat: mark any file larger than core.bigfilethreshold binary
Date: Sat, 16 Aug 2014 10:08:05 +0700
Message-ID: <1408158486-7328-5-git-send-email-pclouds@gmail.com>
References: <1407927454-9268-1-git-send-email-pclouds@gmail.com>
 <1408158486-7328-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 05:08:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIUMA-00011W-9L
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 05:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbaHPDIe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2014 23:08:34 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:45508 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaHPDId (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 23:08:33 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so4453387pac.4
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3jGWOZXqTqOGwMLOPmrHXumTU71BRL99XZlhWLRCzg4=;
        b=PtSs+gytQGwDlWU6a7n8hYMZhhuCSjIjfka1k/njmkCqp05E4HcLc6Pb060YXTFj2g
         lJV9CxPZ79hEjwhuHNI0kiAm6pCAc2+5T0zEkLmTrF4VY/uez8MExsk4d7NT40mhRtCP
         ohAbb35OZKsFSuwjdqT8whKpKmHQDmeY/mYGW5tDbCNqyOmwqT7cZ6nXJelbTdeek+QS
         xGTnGD3gJ4q3o6HhtjO1xoOc3usFDOjgZThnHCaSIig1e98b4Jfb+u95LGhIaagdglBE
         AG2graF3OQPsE2DHEQo2cJ/REZl8yY2orpjqcR3DSxegpLYFNveLcPNS5qRhlIlVkb5g
         mzdg==
X-Received: by 10.66.225.141 with SMTP id rk13mr1681573pac.112.1408158513007;
        Fri, 15 Aug 2014 20:08:33 -0700 (PDT)
Received: from lanh ([115.73.215.192])
        by mx.google.com with ESMTPSA id a5sm14205473pdp.38.2014.08.15.20.08.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Aug 2014 20:08:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Aug 2014 10:08:31 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1408158486-7328-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255317>

Too large files may lead to failure to allocate memory. If it happens
here, it could impact quite a few commands that involve
diff. Moreover, too large files are inefficient to compare anyway (and
most likely non-text), so mark them binary and skip looking at their
content.

Noticed-by: Dale R. Worley <worley@alum.mit.edu>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt        |  3 ++-
 Documentation/gitattributes.txt |  4 ++--
 diff.c                          | 26 ++++++++++++++++++--------
 diffcore.h                      |  1 +
 t/t1050-large.sh                |  4 ++++
 5 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c55c22a..3b5b24a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -499,7 +499,8 @@ core.bigFileThreshold::
 	Files larger than this size are stored deflated, without
 	attempting delta compression.  Storing large files without
 	delta compression avoids excessive memory usage, at the
-	slight expense of increased disk usage.
+	slight expense of increased disk usage. Additionally files
+	larger than this size are always treated as binary.
 +
 Default is 512 MiB on all platforms.  This should be reasonable
 for most projects as source code and other text files can still
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 643c1ba..9b45bda 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -440,8 +440,8 @@ Unspecified::
=20
 	A path to which the `diff` attribute is unspecified
 	first gets its contents inspected, and if it looks like
-	text, it is treated as text.  Otherwise it would
-	generate `Binary files differ`.
+	text and is smaller than core.bigFileThreshold, it is treated
+	as text. Otherwise it would generate `Binary files differ`.
=20
 String::
=20
diff --git a/diff.c b/diff.c
index f4b7421..d381a6f 100644
--- a/diff.c
+++ b/diff.c
@@ -2188,8 +2188,8 @@ int diff_filespec_is_binary(struct diff_filespec =
*one)
 			one->is_binary =3D one->driver->binary;
 		else {
 			if (!one->data && DIFF_FILE_VALID(one))
-				diff_populate_filespec(one, 0);
-			if (one->data)
+				diff_populate_filespec(one, CHECK_BINARY);
+			if (one->is_binary =3D=3D -1 && one->data)
 				one->is_binary =3D buffer_is_binary(one->data,
 						one->size);
 			if (one->is_binary =3D=3D -1)
@@ -2725,6 +2725,11 @@ int diff_populate_filespec(struct diff_filespec =
*s, unsigned int flags)
 		}
 		if (size_only)
 			return 0;
+		if ((flags & CHECK_BINARY) &&
+		    s->size > big_file_threshold && s->is_binary =3D=3D -1) {
+			s->is_binary =3D 1;
+			return 0;
+		}
 		fd =3D open(s->path, O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
@@ -2746,16 +2751,21 @@ int diff_populate_filespec(struct diff_filespec=
 *s, unsigned int flags)
 	}
 	else {
 		enum object_type type;
-		if (size_only) {
+		if (size_only || (flags & CHECK_BINARY)) {
 			type =3D sha1_object_info(s->sha1, &s->size);
 			if (type < 0)
 				die("unable to read %s", sha1_to_hex(s->sha1));
-		} else {
-			s->data =3D read_sha1_file(s->sha1, &type, &s->size);
-			if (!s->data)
-				die("unable to read %s", sha1_to_hex(s->sha1));
-			s->should_free =3D 1;
+			if (size_only)
+				return 0;
+			if (s->size > big_file_threshold && s->is_binary =3D=3D -1) {
+				s->is_binary =3D 1;
+				return 0;
+			}
 		}
+		s->data =3D read_sha1_file(s->sha1, &type, &s->size);
+		if (!s->data)
+			die("unable to read %s", sha1_to_hex(s->sha1));
+		s->should_free =3D 1;
 	}
 	return 0;
 }
diff --git a/diffcore.h b/diffcore.h
index c80df18..33ea2de 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -56,6 +56,7 @@ extern void fill_filespec(struct diff_filespec *, con=
st unsigned char *,
 			  int, unsigned short);
=20
 #define CHECK_SIZE_ONLY 1
+#define CHECK_BINARY    2
 extern int diff_populate_filespec(struct diff_filespec *, unsigned int=
);
 extern void diff_free_filespec_data(struct diff_filespec *);
 extern void diff_free_filespec_blob(struct diff_filespec *);
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 5642f84..00d2f33 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -112,6 +112,10 @@ test_expect_success 'diff --raw' '
 	git diff --raw HEAD^
 '
=20
+test_expect_success 'diff --stat' '
+	git diff --stat HEAD^ HEAD
+'
+
 test_expect_success 'hash-object' '
 	git hash-object large1
 '
--=20
2.1.0.rc0.78.gc0d8480
