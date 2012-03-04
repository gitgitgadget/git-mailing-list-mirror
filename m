From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/10] cat-file: use streaming interface to print blobs
Date: Sun,  4 Mar 2012 19:59:49 +0700
Message-ID: <1330865996-2069-4-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 14:02:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4B5L-0003U1-Uw
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 14:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884Ab2CDNCl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 08:02:41 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:42943 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab2CDNCa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 08:02:30 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so3847615dad.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 05:02:30 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.202.135 as permitted sender) client-ip=10.68.202.135;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.202.135 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.202.135])
        by 10.68.202.135 with SMTP id ki7mr31163021pbc.158.1330866150453 (num_hops = 1);
        Sun, 04 Mar 2012 05:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=L15thuWPE4jZ9G9+bJU5LP8oJsAQMYaoZm0FnCk/Odk=;
        b=cSwZk+xScwvL26CbMmcGpqr6i3tqT71OaIT8bkp0MBYdcnXY1LkqzZJtrvFiox+B/c
         iYldSR78KU8Yzi7duyzxo20c9Z33urnK7jfhXxcO0u75lVnQcBsx947yXK38ScD5ZCco
         q0zD5hKs0qei03kTO/vSMZ+wFnBUn4/gpCwXnXH5SrdKG+wXIo3CEjGgG60O7XVtMuSw
         07dx1ae6rKvyaSgutsLduNGsZTeAe7dElg5XBMewySU2QbFpJTVDm12b5U+7gtOBClFw
         zKW7ipfXrP/52/iQ/p9IpCOAzU03ceisGhXviiR4ZehOQWV+b1j0fzcpWvxODTsMa9fF
         jYag==
Received: by 10.68.202.135 with SMTP id ki7mr26754532pbc.158.1330866150360;
        Sun, 04 Mar 2012 05:02:30 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.34.94])
        by mx.google.com with ESMTPS id m7sm10448276pba.30.2012.03.04.05.02.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 05:02:29 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 04 Mar 2012 20:00:23 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192153>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/cat-file.c |   23 +++++++++++++++++++++++
 t/t1050-large.sh   |    2 +-
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8ed501f..bc6cc9f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -11,6 +11,7 @@
 #include "parse-options.h"
 #include "diff.h"
 #include "userdiff.h"
+#include "streaming.h"
=20
 #define BATCH 1
 #define BATCH_CHECK 2
@@ -82,6 +83,24 @@ static void pprint_tag(const unsigned char *sha1, co=
nst char *buf, unsigned long
 		write_or_die(1, cp, endp - cp);
 }
=20
+static int write_blob(const unsigned char *sha1)
+{
+	unsigned char new_sha1[20];
+
+	if (sha1_object_info(sha1, NULL) =3D=3D OBJ_TAG) {
+		enum object_type type;
+		unsigned long size;
+		char *buffer =3D read_sha1_file(sha1, &type, &size);
+		if (memcmp(buffer, "object ", 7) ||
+		    get_sha1_hex(buffer + 7, new_sha1))
+			die("%s not a valid tag", sha1_to_hex(sha1));
+		sha1 =3D new_sha1;
+		free(buffer);
+	}
+
+	return stream_blob_to_fd(1, sha1, NULL, 0);
+}
+
 static int cat_one_file(int opt, const char *exp_type, const char *obj=
_name)
 {
 	unsigned char sha1[20];
@@ -127,6 +146,8 @@ static int cat_one_file(int opt, const char *exp_ty=
pe, const char *obj_name)
 			return cmd_ls_tree(2, ls_args, NULL);
 		}
=20
+		if (type =3D=3D OBJ_BLOB)
+			return write_blob(sha1);
 		buf =3D read_sha1_file(sha1, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
@@ -149,6 +170,8 @@ static int cat_one_file(int opt, const char *exp_ty=
pe, const char *obj_name)
 		break;
=20
 	case 0:
+		if (type_from_string(exp_type) =3D=3D OBJ_BLOB)
+			return write_blob(sha1);
 		buf =3D read_object_with_reference(sha1, exp_type, &size, NULL);
 		break;
=20
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index f245e59..39a3e77 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -114,7 +114,7 @@ test_expect_success 'hash-object' '
 	git hash-object large1
 '
=20
-test_expect_failure 'cat-file a large file' '
+test_expect_success 'cat-file a large file' '
 	git cat-file blob :large1 >/dev/null
 '
=20
--=20
1.7.8.36.g69ee2
