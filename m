From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/11] cat-file: use streaming interface to print blobs
Date: Mon,  5 Mar 2012 10:43:40 +0700
Message-ID: <1330919028-6611-4-git-send-email-pclouds@gmail.com>
References: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 04:44:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Oqr-0003au-S4
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 04:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab2CEDol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 22:44:41 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:52615 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab2CEDol (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 22:44:41 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so4472065dad.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 19:44:40 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.232.169 as permitted sender) client-ip=10.68.232.169;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.232.169 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.232.169])
        by 10.68.232.169 with SMTP id tp9mr9875644pbc.79.1330919077861 (num_hops = 1);
        Sun, 04 Mar 2012 19:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=p9wkDjkCS3lrnm4KdigRIXVUsL5wWm85LSL7CyGCYpM=;
        b=jiMiNcRSLaKcpym8Dhcr+ISZ87JmnpvLiwRXp0HMS3QSPapGBN0GW8zcllQuDbuaTX
         kbcLe3aS+VDTDlq0a8Qf/0inMrKEb6c4Zn1GqIbA50xrpLNkdoCm+nX703bJsm8H31vO
         WCXvytuJb6Ckrd7iVB5s8Fk8N8Ly7iHZmenADGmBUhxQIiCcl5olL9aeBX0xR+d0UgpK
         bnN/C7FPFmuklRCdoTRqETE6ZEzXpFEngoy8KINyo99BXr5NzdKSXsEtDVgw5FA+x3/y
         WdQkMN8zp0EhsLvxaTk8JFKgXBNC4QWxZuOJQ/E5nEvx+IKWQW9UqES8HnyPCZFXRqoo
         DgjA==
Received: by 10.68.232.169 with SMTP id tp9mr8688660pbc.79.1330919077754;
        Sun, 04 Mar 2012 19:44:37 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id d10sm12089041pbr.59.2012.03.04.19.44.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 19:44:36 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 05 Mar 2012 10:44:12 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192196>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/cat-file.c |   24 ++++++++++++++++++++++++
 t/t1050-large.sh   |    4 ++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8ed501f..ce68a20 100644
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
@@ -127,6 +128,8 @@ static int cat_one_file(int opt, const char *exp_ty=
pe, const char *obj_name)
 			return cmd_ls_tree(2, ls_args, NULL);
 		}
=20
+		if (type =3D=3D OBJ_BLOB)
+			return stream_blob_to_fd(1, sha1, NULL, 0);
 		buf =3D read_sha1_file(sha1, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
@@ -149,6 +152,27 @@ static int cat_one_file(int opt, const char *exp_t=
ype, const char *obj_name)
 		break;
=20
 	case 0:
+		if (type_from_string(exp_type) =3D=3D OBJ_BLOB) {
+			unsigned char blob_sha1[20];
+			if (sha1_object_info(sha1, NULL) =3D=3D OBJ_TAG) {
+				enum object_type type;
+				unsigned long size;
+				char *buffer =3D read_sha1_file(sha1, &type, &size);
+				if (memcmp(buffer, "object ", 7) ||
+				    get_sha1_hex(buffer + 7, blob_sha1))
+					die("%s not a valid tag", sha1_to_hex(sha1));
+				free(buffer);
+			} else
+				hashcpy(blob_sha1, sha1);
+
+			if (sha1_object_info(blob_sha1, NULL) =3D=3D OBJ_BLOB)
+				return stream_blob_to_fd(1, blob_sha1, NULL, 0);
+			/* we attempted to dereference a tag to a blob
+			   and failed, perhaps there are new dereference
+			   mechanisms this code is not aware of,
+			   fallthrough and let read_object_with_reference
+			   deal with it */
+		}
 		buf =3D read_object_with_reference(sha1, exp_type, &size, NULL);
 		break;
=20
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 80f157a..97ad5b3 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -116,11 +116,11 @@ test_expect_success 'hash-object' '
 	git hash-object large1
 '
=20
-test_expect_failure 'cat-file a large file' '
+test_expect_success 'cat-file a large file' '
 	git cat-file blob :large1 >/dev/null
 '
=20
-test_expect_failure 'cat-file a large file from a tag' '
+test_expect_success 'cat-file a large file from a tag' '
 	git tag -m largefile largefiletag :large1 &&
 	git cat-file blob largefiletag >/dev/null
 '
--=20
1.7.3.1.256.g2539c.dirty
