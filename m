From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/7] cat-file: use streaming API to print blobs
Date: Wed,  7 Mar 2012 17:54:17 +0700
Message-ID: <1331117661-19378-4-git-send-email-pclouds@gmail.com>
References: <7vty21twqc.fsf@alter.siamese.dyndns.org>
 <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 11:54:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5EVQ-0003ls-No
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 11:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330Ab2CGKxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 05:53:19 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:64743 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2CGKxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 05:53:18 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so7761663dad.11
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 02:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6zBm0bbDJiSPRrnTaXdz6c7Hmr8LLfM0aejOprtt3+w=;
        b=LdabuHvDdHyFc/Kriss1Yr/jbEk4uTGn6yIr4alIrcqZiYY5zECYOIxyVNkk8AT8xZ
         gRm6qYd6YfqJl0C8Gz29K4SAd9ukLnkdQywLwCenINfiKks1FYAMdL03yZNF2hfQp/Pw
         46u0ptwkudARwhbH+gJYRJcWf7FSnxnAanQo60M/wX50CK7AdbOYEF9zhELB29vvvwdo
         wiAkYojHJzT2sj/jNEb3MQyqWQT8QAIYq7uTiwdfkBDDskBcmuAujUMBOM3xpw7ARB2e
         ejqgtKxpnx5GxUP98HxANsoN8B4B/GmMEAyFaA4cfh/+AxtE/V8TlrRnq/OhcK/Lf1nN
         C5jw==
Received: by 10.68.216.4 with SMTP id om4mr3134623pbc.19.1331117594534;
        Wed, 07 Mar 2012 02:53:14 -0800 (PST)
Received: from tre ([115.74.59.10])
        by mx.google.com with ESMTPS id 3sm571070pbx.66.2012.03.07.02.53.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 02:53:13 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 07 Mar 2012 17:54:44 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192443>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/cat-file.c |   25 +++++++++++++++++++++++++
 t/t1050-large.sh   |    4 ++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8ed501f..36a9104 100644
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
@@ -149,6 +152,28 @@ static int cat_one_file(int opt, const char *exp_t=
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
+			/*
+			 * we attempted to dereference a tag to a blob
+			 * and failed; there may be new dereference
+			 * mechanisms this code is not aware of.
+			 * fall-back to the usual case.
+			 */
+		}
 		buf =3D read_object_with_reference(sha1, exp_type, &size, NULL);
 		break;
=20
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index ded66b3..f662fef 100755
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
1.7.8.36.g69ee2
