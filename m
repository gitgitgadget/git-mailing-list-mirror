From: =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>
Subject: [PATCH] Improve tests for detached worktree in git-submodule
Date: Mon, 30 Jul 2012 14:43:32 -0300
Message-ID: <1343670212-2992-1-git-send-email-dangra@gmail.com>
References: <7v6295rxmb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:44:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svu13-0007RH-NN
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab2G3RoB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 13:44:01 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:32974 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab2G3Rn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 13:43:59 -0400
Received: by yenl2 with SMTP id l2so5096028yen.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Dd06uw+7oE8Nhfgfw80hK8XmNOJTEtV1kT0QyHMu/Qo=;
        b=ziJat9yIGAz4g4jDomiaq9kjWPfyfkc9Ze6XNT0nuyl62t1RHC/OAR05KsRUodthiI
         efCfYgHDYUomV1HRPsp+By5G0avTEDSkrybsZNJbSQsUMuh2KfjkYEKzHbVj/AuoWI8H
         kn8GCRamuPq/88oVODYUaSFoROpc7+riIRsy27bGLHdE7r9CQh3fIqwQ/JAUEi+6Q6b4
         UV0DQteoHjh6Sq9C1hkBQbZ9wPDmHQZ37XKOQCGP7mjYOqvT1isN1Ei69a9H8v0hXm2M
         ZwSmlX8m5AvCvWaKb3Rj8yhIk0hhyvwsfi1rWF+oCbA1EpMOtdLBcHJzG4V6vQLspvJ2
         wTaQ==
Received: by 10.236.182.228 with SMTP id o64mr10720497yhm.85.1343670238878;
        Mon, 30 Jul 2012 10:43:58 -0700 (PDT)
Received: from localhost.localdomain (r190-135-175-126.dialup.adsl.anteldata.net.uy. [190.135.175.126])
        by mx.google.com with ESMTPS id r25sm20553339yhi.13.2012.07.30.10.43.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 10:43:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <7v6295rxmb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202592>

* Check submodule is correctly initialized and updated after cloning .d=
otfiles

Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
---

Remove $TRASH_DIRECTORY and "git rev-parse --verify HEAD" as suggested =
by Junio

 t/t7409-submodule-detached-worktree.sh |   31 ++++++++++++++++++++++++=
-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/t/t7409-submodule-detached-worktree.sh b/t/t7409-submodule=
-detached-worktree.sh
index db75642..1d5a4c5 100755
--- a/t/t7409-submodule-detached-worktree.sh
+++ b/t/t7409-submodule-detached-worktree.sh
@@ -15,7 +15,11 @@ TEST_NO_CREATE_REPO=3D1
 test_expect_success 'submodule on detached working tree' '
 	git init --bare remote &&
 	test_create_repo bundle1 &&
-	(cd bundle1 && test_commit "shoot") &&
+	(
+		cd bundle1 &&
+		test_commit "shoot" &&
+		git rev-parse --verify HEAD > ../expect
+	) &&
 	mkdir home &&
 	(
 		cd home &&
@@ -23,14 +27,27 @@ test_expect_success 'submodule on detached working =
tree' '
 		git clone --bare ../remote .dotfiles &&
 		git submodule add ../bundle1 .vim/bundle/sogood &&
 		test_commit "sogood" &&
+		(
+			unset GIT_WORK_TREE GIT_DIR &&
+			cd .vim/bundle/sogood &&
+			git rev-parse --verify HEAD > actual &&
+			test_cmp ../../../../expect actual
+		) &&
 		git push origin master
-	) &&
+	)
 	mkdir home2 &&
 	(
 		cd home2 &&
-		export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dotfiles" &&
 		git clone --bare ../remote .dotfiles &&
-		git submodule update --init
+		export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		git checkout master &&
+		git submodule update --init &&
+		(
+			unset GIT_WORK_TREE GIT_DIR &&
+			cd .vim/bundle/sogood &&
+			git rev-parse --verify HEAD > actual &&
+			test_cmp ../../../../expect actual
+		)
 	)
 '
=20
@@ -42,6 +59,7 @@ test_expect_success 'submodule on detached working po=
inted by core.worktree' '
 		git clone --bare ../remote "$GIT_DIR" &&
 		git config core.bare false &&
 		git config core.worktree .. &&
+		git checkout master &&
 		git submodule add ../bundle1 .vim/bundle/dupe &&
 		test_commit "dupe" &&
 		git push origin master
@@ -52,9 +70,8 @@ test_expect_success 'submodule on detached working po=
inted by core.worktree' '
 		git config core.bare false &&
 		git config core.worktree .. &&
 		git pull &&
-		git submodule update &&
-		git submodule status &&
-		test -d .vim/bundle/dupe
+		git submodule update --init &&
+		test -e .vim/bundle/dupe/shoot.t
 	)
 '
=20
--=20
1.7.5.4
