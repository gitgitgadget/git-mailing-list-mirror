From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 03/11] t5403: avoid doing "git add foo/bar" where foo/.git exists
Date: Mon, 24 Oct 2011 17:36:08 +1100
Message-ID: <1319438176-7304-4-git-send-email-pclouds@gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:38:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIEBE-0000fG-6y
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab1JXGig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 02:38:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59080 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1JXGif (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:38:35 -0400
Received: by mail-yw0-f46.google.com with SMTP id 3so1171021ywm.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 23:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LJo09oZ6+5UZK6I/M6EUDIHCZmkXegs2EYDo6EtmAls=;
        b=Jyp30ayJoJB0sMvUe3QEMH4XShoHLq6zuNvJ5P4dhPu9DNVEhJeHa+ly5vtydVKYt5
         sO0M5a0AOo1JSB5vfsc6bRUXtNCjLdVPqRdudvUk3yxqj08XGe1pgxlLREhyoHjb/1UG
         iKUnp1YCnY+yFVOJdcL1eX7bx/jqfnsMtnYr4=
Received: by 10.236.115.226 with SMTP id e62mr8152291yhh.44.1319438314929;
        Sun, 23 Oct 2011 23:38:34 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id c8sm31176142yhm.14.2011.10.23.23.38.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 23:38:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 17:36:52 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184156>

In this case, "foo" is considered a submodule and bar, if added,
belongs to foo/.git. "git add" should only allow "git add foo" in this
case, but it passes somehow.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5403-post-checkout-hook.sh |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook=
=2Esh
index 1753ef2..3b3e2c1 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -16,10 +16,13 @@ test_expect_success setup '
 	git update-ref refs/heads/master $commit0 &&
 	git clone ./. clone1 &&
 	git clone ./. clone2 &&
-	GIT_DIR=3Dclone2/.git git branch new2 &&
-	echo Data for commit1. >clone2/b &&
-	GIT_DIR=3Dclone2/.git git add clone2/b &&
-	GIT_DIR=3Dclone2/.git git commit -m new2
+	(
+		cd clone2 &&
+		git branch new2 &&
+		echo Data for commit1. >b &&
+		git add b &&
+		git commit -m new2
+	)
 '
=20
 for clone in 1 2; do
@@ -48,7 +51,7 @@ test_expect_success 'post-checkout runs as expected '=
 '
 '
=20
 test_expect_success 'post-checkout args are correct with git checkout =
-b ' '
-	GIT_DIR=3Dclone1/.git git checkout -b new1 &&
+	( cd clone1 && git checkout -b new1 ) &&
 	old=3D$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
 	new=3D$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
 	flag=3D$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
@@ -56,7 +59,7 @@ test_expect_success 'post-checkout args are correct w=
ith git checkout -b ' '
 '
=20
 test_expect_success 'post-checkout receives the right args with HEAD c=
hanged ' '
-	GIT_DIR=3Dclone2/.git git checkout new2 &&
+	( cd clone2 && git checkout new2 ) &&
 	old=3D$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
 	new=3D$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
 	flag=3D$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
@@ -64,7 +67,7 @@ test_expect_success 'post-checkout receives the right=
 args with HEAD changed ' '
 '
=20
 test_expect_success 'post-checkout receives the right args when not sw=
itching branches ' '
-	GIT_DIR=3Dclone2/.git git checkout master b &&
+	( cd clone2 && git checkout master b ) &&
 	old=3D$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
 	new=3D$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
 	flag=3D$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
--=20
1.7.3.1.256.g2539c.dirty
