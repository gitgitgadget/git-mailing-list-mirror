From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] unpack-trees: do not abort when overwriting an existing file with the same content
Date: Mon, 21 Jan 2013 18:40:33 +0700
Message-ID: <1358768433-26096-1-git-send-email-pclouds@gmail.com>
References: <1358594648-26851-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 12:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxFjx-0006yl-4u
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 12:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135Ab3AULkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 06:40:13 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:38974 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab3AULkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 06:40:12 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so3339077pad.22
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 03:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Bgz8rtN0iXp46OOy3+cB8P3H8sInrpieYp/lqpESySI=;
        b=F9jCMkAUKm8b0FnN3hr+uJaKzYvE3TUFnudtm4pqCeh506vRBaf0nroBEJyiR+3IGc
         S1shOycKExLRZPQJ4DMG1LytTgCAn0E1vBh33fkvxySgTSvllpPuZ+n/U/sjfzm8doyg
         Mwr0GKbUMG6zKH620Sc6N598uHsPMaDNgVQ/5iz4Dqh8EQlKQGLWtzF45B1qxVDTR70f
         59+U8NmHqsZt6EvlWN47o0hXY1NwSjBXi11qII+Xg0blfr8vtxezycutccw8jUgez3jL
         UIbAd3TN8w8T7Vr4G5nSR6TGDn9e5lZpukxrg78pJiE2ks3lZGREuwdRQyRytUoklbNm
         SEFQ==
X-Received: by 10.68.130.161 with SMTP id of1mr48801067pbb.32.1358768411966;
        Mon, 21 Jan 2013 03:40:11 -0800 (PST)
Received: from lanh ([115.74.55.178])
        by mx.google.com with ESMTPS id f5sm9145595pav.22.2013.01.21.03.40.08
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 03:40:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 21 Jan 2013 18:40:34 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358594648-26851-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214111>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Changes: do not lose worktree's executable permission.

 t/t1011-read-tree-sparse-checkout.sh |  3 ++-
 t/t2021-checkout-overwrite.sh        | 18 ++++++++++++++++++
 unpack-trees.c                       | 31 ++++++++++++++++++++++++++++=
+++
 3 files changed, 51 insertions(+), 1 deletion(-)

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
index 5da63e9..bb1696d 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -47,4 +47,22 @@ test_expect_success SYMLINKS 'checkout commit with d=
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
+test_expect_success POSIXPERM 'do abort on an existing file, same cont=
ent but different permission' '
+	git checkout -f HEAD^ &&
+	echo abc >bar &&
+	git add bar &&
+	git commit -m "new file" &&
+	git reset HEAD^ &&
+	chmod a+x bar &&
+	test_must_fail git checkout HEAD@{1}
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 0e1a196..ea204ae 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -9,6 +9,8 @@
 #include "refs.h"
 #include "attr.h"
=20
+#define SAME_CONTENT_SIZE_LIMIT (1024 * 1024)
+
 /*
  * Error messages expected by scripts out of plumbing commands such as
  * read-tree.  Non-scripted Porcelain is not required to use these mes=
sages
@@ -1363,6 +1365,7 @@ static int check_ok_to_remove(const char *name, i=
nt len, int dtype,
 			      struct unpack_trees_options *o)
 {
 	struct cache_entry *result;
+	unsigned long ce_size;
=20
 	/*
 	 * It may be that the 'lstat()' succeeded even though
@@ -1405,6 +1408,34 @@ static int check_ok_to_remove(const char *name, =
int len, int dtype,
 			return 0;
 	}
=20
+	/*
+	 * If it has the same content that we are going to overwrite,
+	 * there's no point in complaining. We still overwrite it in
+	 * the end though.
+	 */
+	if (ce &&
+	    S_ISREG(st->st_mode) && S_ISREG(ce->ce_mode) &&
+	    (!trust_executable_bit ||
+	     (0100 & (ce->ce_mode ^ st->st_mode)) =3D=3D 0) &&
+	    st->st_size < SAME_CONTENT_SIZE_LIMIT &&
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
