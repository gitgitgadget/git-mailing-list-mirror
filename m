From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/11] cat-file: use streaming interface to print blobs
Date: Mon, 27 Feb 2012 14:55:07 +0700
Message-ID: <1330329315-11407-4-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 08:56:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vRS-0006zS-Cy
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 08:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab2B0H4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 02:56:13 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56349 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab2B0H4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 02:56:12 -0500
Received: by daed14 with SMTP id d14so834292dae.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 23:56:11 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.223.68 as permitted sender) client-ip=10.68.223.68;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.223.68 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.223.68])
        by 10.68.223.68 with SMTP id qs4mr37037940pbc.112.1330329371848 (num_hops = 1);
        Sun, 26 Feb 2012 23:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OXsCJbPONK683UcyUNHOZxrNu78ZlfIS+sG9G4JvdW4=;
        b=vLZ39ZEjEhui4GA/c65JF1cy61Kry3R2WuTjzHxSslfa97+3t3P7FFz4l5qqxpKA+N
         K8ECdB+U3jCgsrKSdWgYBi6YJ9K6LgejkxFGT9k2VLNawEHDXySFMXZP3YDrgashPo9N
         mkNzFF/8TbWlkwOhxNclTNc9te/tq2k7FDS7s=
Received: by 10.68.223.68 with SMTP id qs4mr31530750pbc.112.1330329371812;
        Sun, 26 Feb 2012 23:56:11 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id q8sm12045872pbn.20.2012.02.26.23.56.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 23:56:10 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:55:48 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191608>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/cat-file.c |   22 ++++++++++++++++++++++
 t/t1050-large.sh   |    2 +-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8ed501f..3f3b558 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -82,6 +82,24 @@ static void pprint_tag(const unsigned char *sha1, co=
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
+	return streaming_write_sha1(1, 0, sha1, OBJ_BLOB, NULL);
+}
+
 static int cat_one_file(int opt, const char *exp_type, const char *obj=
_name)
 {
 	unsigned char sha1[20];
@@ -127,6 +145,8 @@ static int cat_one_file(int opt, const char *exp_ty=
pe, const char *obj_name)
 			return cmd_ls_tree(2, ls_args, NULL);
 		}
=20
+		if (type =3D=3D OBJ_BLOB)
+			return write_blob(sha1);
 		buf =3D read_sha1_file(sha1, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
@@ -149,6 +169,8 @@ static int cat_one_file(int opt, const char *exp_ty=
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
1.7.3.1.256.g2539c.dirty
