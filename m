From: =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>
Subject: [PATCH] Improve tests for detached worktree in git-submodule
Date: Mon, 30 Jul 2012 13:10:10 -0300
Message-ID: <1343664610-479-1-git-send-email-dangra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:11:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvsZ3-0002xp-2v
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 18:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab2G3QLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 12:11:20 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34986 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab2G3QLT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 12:11:19 -0400
Received: by gglu4 with SMTP id u4so4974371ggl.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=9Uo6+ajAxZLqOVKDhrIQzHywhNIbzcWz+fhm7dwrV4A=;
        b=E1TNIq3YcYy6Urr/ZQHGp82oI8rmEsNhrIPpL4CRYo8beMmwu9jROao7gmDEq0Rnqo
         +xs12B3MGCxS/lfT/swh3FGBEz+4oyw8rp2OcK6DdB1wvQp40C8cGWVhgZ4uZ4LSzMKg
         hXjYCETorsero8XwRUIxEPb5AJnvEvwLKze1ZzRxw3H7LgzhvquTvHkVeTS9FrmWadMi
         9Y5JofULnsUncmVS0y9ol+FDO4IoayEQQAivo4+sCsyJ8n4lThDqjCdLADneH+4FgmI0
         jVA7UgDqm9qC6AaPcVVfGX731LWdrAAWkmr+VDNRhKLOokm912e7Vtd+BKJ89/f6bd7U
         cuHw==
Received: by 10.236.149.162 with SMTP id x22mr10661457yhj.92.1343664678709;
        Mon, 30 Jul 2012 09:11:18 -0700 (PDT)
Received: from localhost.localdomain (r190-135-175-126.dialup.adsl.anteldata.net.uy. [190.135.175.126])
        by mx.google.com with ESMTPS id y10sm20180241yhd.6.2012.07.30.09.11.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 09:11:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202571>


Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
---
 t/t7409-submodule-detached-worktree.sh |   31 ++++++++++++++++++++++++=
-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/t/t7409-submodule-detached-worktree.sh b/t/t7409-submodule=
-detached-worktree.sh
index db75642..d88f400 100755
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
+		git rev-list --max-count=3D1 HEAD > "$TRASH_DIRECTORY/expect"
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
+			git rev-list --max-count=3D1 HEAD > actual &&
+			test_cmp actual "$TRASH_DIRECTORY/expect"
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
+			git rev-list --max-count=3D1 HEAD > actual &&
+			test_cmp actual "$TRASH_DIRECTORY/expect"
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
