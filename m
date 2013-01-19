From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] unpack-trees: do not abort when overwriting an existing file with the same content
Date: Sat, 19 Jan 2013 18:24:08 +0700
Message-ID: <1358594648-26851-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 12:29:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwWcR-0002qT-8l
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 12:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab3ASLXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 06:23:50 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:33983 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab3ASLXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 06:23:49 -0500
Received: by mail-pb0-f43.google.com with SMTP id jt11so1131467pbb.2
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 03:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=sYDsnGsuhsIC+JeTHF17VPw3VcV4G34ytiEOwDd93HA=;
        b=bdUVA1zvjqAu0VA2b7Z+O7jCelbPXQrVyLXdPZSgQOk9jPmhXAxz7mRmQ8nGqwUfA/
         9loBFuA3ncBgpkCTldbcDUHYmJdCenHx6ehE7tG02AfGNImsziUMiQ1VfNmn/SOwe9sK
         UgkwVls/EAqWuiGlyJb6PIYr+j5t1pQbk4Qz+9n6FG6VtPcbUpT5F07onaFrMc8iDcct
         yANmLs1P+tva4Ckd+bFx7e5akB5jkc93RD2y8WSyORYNm/xt+YJMIWidAk2JllvIaFVg
         xNOcmcZMzFV5kpSnEveVtlv+gzLoXt+baTGiY4KghNw8GgtAyvJfQ0OLHJAzM8+IYNNy
         yJvg==
X-Received: by 10.66.73.165 with SMTP id m5mr31623455pav.78.1358594628785;
        Sat, 19 Jan 2013 03:23:48 -0800 (PST)
Received: from lanh ([115.74.55.178])
        by mx.google.com with ESMTPS id kl3sm4871750pbc.15.2013.01.19.03.23.45
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jan 2013 03:23:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 19 Jan 2013 18:24:09 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213971>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The "git reset" as illustrated in the test case is one case people
 may be hit by this. We can also do the same for "uptodate" check, but
 I'm not sure how that could happen.

 t/t1011-read-tree-sparse-checkout.sh |  3 ++-
 t/t2021-checkout-overwrite.sh        |  8 ++++++++
 unpack-trees.c                       | 27 +++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 5c0053a..38f9899 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -238,7 +238,8 @@ test_expect_success 'print errors when failed to up=
date worktree' '
 	echo sub >.git/info/sparse-checkout &&
 	git checkout -f init &&
 	mkdir sub &&
-	touch sub/added sub/addedtoo &&
+	echo modified >sub/added &&
+	echo modified >sub/addedtoo &&
 	test_must_fail git checkout top 2>actual &&
 	cat >expected <<\EOF &&
 error: The following untracked working tree files would be overwritten=
 by checkout:
diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite=
=2Esh
index 5da63e9..4163449 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -47,4 +47,12 @@ test_expect_success SYMLINKS 'checkout commit with d=
ir must not remove untracked
 	test -h a/b
 '
=20
+test_expect_success 'do not abort on overwriting an existing file with=
 the same content' '
+	echo abc >bar &&
+	git add bar &&
+	git commit -m "new file" &&
+	git reset HEAD^ &&
+	git checkout HEAD@{1}
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 0e1a196..16adc03 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1363,6 +1363,7 @@ static int check_ok_to_remove(const char *name, i=
nt len, int dtype,
 			      struct unpack_trees_options *o)
 {
 	struct cache_entry *result;
+	unsigned long ce_size;
=20
 	/*
 	 * It may be that the 'lstat()' succeeded even though
@@ -1405,6 +1406,32 @@ static int check_ok_to_remove(const char *name, =
int len, int dtype,
 			return 0;
 	}
=20
+	/*
+	 * If it has the same content that we are going to write down,
+	 * there's no point in complaining. We still overwrite it in the
+	 * end though. Permission is not checked so it may be lost.
+	 */
+	if (ce &&
+	    S_ISREG(st->st_mode) && S_ISREG(ce->ce_mode) &&
+	    st->st_size < 1024 * 1024 && /* should be configurable */
+	    sha1_object_info(ce->sha1, &ce_size) =3D=3D OBJ_BLOB &&
+	    ce_size =3D=3D st->st_size) {
+		void *buffer =3D NULL;
+		unsigned long size;
+		enum object_type type;
+		struct strbuf sb =3D STRBUF_INIT;
+		int matched =3D
+			strbuf_read_file(&sb, ce->name, ce_size) =3D=3D ce_size &&
+			(buffer =3D read_sha1_file(ce->sha1, &type, &size)) !=3D NULL &&
+			type =3D=3D OBJ_BLOB &&
+			size =3D=3D ce_size &&
+			!memcmp(buffer, sb.buf, size);
+		free(buffer);
+		strbuf_release(&sb);
+		if (matched)
+			return 0;
+	}
+
 	return o->gently ? -1 :
 		add_rejected_path(o, error_type, name);
 }
--=20
1.8.0.rc2.23.g1fb49df
