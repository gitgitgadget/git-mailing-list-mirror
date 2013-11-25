From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 27/28] clone: use git protocol for cloning shallow repo locally
Date: Mon, 25 Nov 2013 10:55:53 +0700
Message-ID: <1385351754-9954-28-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:54:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknFV-0002Ps-VH
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775Ab3KYDyK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:54:10 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:60006 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab3KYDyI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:54:08 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so4838387pbb.28
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jv3vB/3sOrtJsp4+W45lsr/l8/d9DaSEFsq0z3dEHGw=;
        b=x8LfdPuzKHlBmAvDSl3xWaLgszmby3ymA1dHtKABXzMzZn4zuOZ6tK+nQeHBskCKlr
         PwnNM3uvgZ9HjOuqkJ4i0e23TMy/JDY4V+Psw4PtzJATw3bFjwMZmidsQ2KoJxA7PHCc
         YW25gJ7AYhOtL7RV3c6MMU9k/YKXALPRCZEg5WRlhK8IGUixFDGKtC5wh1tLH6Un2Rgv
         iRuGpMrqL6Z2pH7zDV7sOnwIuwI75kC7o7rdto/wqCRjsOKJPkYyP5iG2sPjcQ7+uim7
         AWz5Y39MpjlcO7oPpZp0o+Bto7P3Zm+P8VGl5IwXn5vRDy6Iciklb67VbSL03tfxnxDl
         sL1Q==
X-Received: by 10.66.65.108 with SMTP id w12mr21380956pas.84.1385351647641;
        Sun, 24 Nov 2013 19:54:07 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id ki1sm69739788pbd.1.2013.11.24.19.54.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:54:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:58:40 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238296>

clone_local() does not handle $SRC/shallow. It could be made so, but
it's simpler to use fetch-pack/upload-pack instead.

This used by be caught by the check in upload-pack, which is triggered
by transport_get_remote_refs(), even in local clone case. The check is
now gone and check_everything_connected() should catch the result
incomplete repo. But check_everything_connected() will soon be skipped
in local clone case, opening a door to corrupt repo. This patch should
close that door.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c  | 11 +++++++++--
 t/t5601-clone.sh |  7 +++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0b182ce..71ee68b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -797,8 +797,15 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	else
 		repo =3D repo_name;
 	is_local =3D option_local !=3D 0 && path && !is_bundle;
-	if (is_local && option_depth)
-		warning(_("--depth is ignored in local clones; use file:// instead."=
));
+	if (is_local) {
+		if (option_depth)
+			warning(_("--depth is ignored in local clones; use file:// instead.=
"));
+		if (!access(mkpath("%s/shallow", path), F_OK)) {
+			if (option_local > 0)
+				warning(_("source repository is shallow, ignoring --local"));
+			is_local =3D 0;
+		}
+	}
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
=20
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 1d1c875..c226cff 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -340,4 +340,11 @@ test_expect_success 'clone from a repository with =
two identical branches' '
=20
 '
=20
+test_expect_success 'shallow clone locally' '
+	git clone --depth=3D1 --no-local src ssrrcc &&
+	git clone ssrrcc ddsstt &&
+	test_cmp ssrrcc/.git/shallow ddsstt/.git/shallow &&
+	( cd ddsstt && git fsck )
+'
+
 test_done
--=20
1.8.2.83.gc99314b
