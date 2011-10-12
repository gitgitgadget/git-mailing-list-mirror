From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] t5403: do not use access repos with GIT_DIR when worktree is involved
Date: Wed, 12 Oct 2011 20:35:05 +1100
Message-ID: <1318412105-13595-3-git-send-email-pclouds@gmail.com>
References: <1318412105-13595-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 11:35:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDvE8-0007yu-Os
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 11:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab1JLJfs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 05:35:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62085 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1JLJfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 05:35:47 -0400
Received: by gyb13 with SMTP id 13so487007gyb.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=quKYJdku4hRJUYaEXSxo2UDTDOenNzvYP0vKE1gRc48=;
        b=jRMc4ctjCJn7xuzAE5gH3bBS4POEZl6knC1pY/JZNbWjhPN9/5gOX+9FXIs4yZC+Hy
         6QL3d3lpZc2LyB3KOA0WWxiO5pBF3aUKxG7YCfI4mHYL54MwPo3Z2i7fRuCh3wjklkvL
         Dv8Y97Ukaj4GwDE1VxHaplo/RmpOvD1nG778s=
Received: by 10.236.76.195 with SMTP id b43mr35227519yhe.18.1318412147190;
        Wed, 12 Oct 2011 02:35:47 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id p54sm2133022yhh.1.2011.10.12.02.35.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Oct 2011 02:35:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 12 Oct 2011 20:35:35 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1318412105-13595-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183365>

Setting GIT_DIR alone means worktree is current directory for legacy
reasons. Avoid using that, instead go to the worktree and execute
commands there.

The troublesome command is "GIT_DIR=3Dclone2/.git git add clone2/b". Th=
e
real worktree is clone2, but that command tells git worktree is $(pwd).
What does user expect to add then? Should the new entry in index be "b"
or "clone2/b"?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5403-post-checkout-hook.sh |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook=
=2Esh
index 6643f32..3459539 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -13,10 +13,13 @@ test_expect_success setup '
 	git commit -m setup &&
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
@@ -45,7 +48,7 @@ test_expect_success 'post-checkout runs as expected '=
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
@@ -53,7 +56,7 @@ test_expect_success 'post-checkout args are correct w=
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
@@ -61,7 +64,7 @@ test_expect_success 'post-checkout receives the right=
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
