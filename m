From: =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>
Subject: [PATCH] Improve tests for detached worktree in git-submodule
Date: Mon, 30 Jul 2012 14:51:59 -0300
Message-ID: <1343670719-3635-1-git-send-email-dangra@gmail.com>
References: <7vsjc9qh33.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:55:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvuBM-0000Lx-Et
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab2G3Ry7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 13:54:59 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36388 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2G3Ry6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 13:54:58 -0400
Received: by yenl2 with SMTP id l2so5110422yen.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 10:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WtjrkzQ//eN5EB98ij/nsMRCXT3kVejhER6yo4mlDKg=;
        b=UZP0OAV0CrT16l1NgWC8K5smYcNDRWmjwHEZ+s7z/Sy5Eddnr0EpL+zoDJBhj3u0If
         5u3J5l+OMVsHGhAnCU/3DzmO1vPNS/iiMTYuLrCsxmmAUfUEbpXdT4ffCCfe984mzPU9
         cMfTuehLkUv4tsxxezv+JRP97Eiu5b1jMoZEB55+noxFY4doJWDvJlxkvXmG66XBfE6s
         a1+4+ISB/hAf2hFZQoggVbwLzdNb23rKOtqzRfprcXPDGcrdeZ35n2sIkox4C9ZB0V6d
         aQg4gbcKOiJM5zibOYvdPGIclg/RrmVRHet48O/bsN6dswqjzRA0hM5cmY4+ABnxAab9
         jF+A==
Received: by 10.236.76.198 with SMTP id b46mr10698529yhe.117.1343670898094;
        Mon, 30 Jul 2012 10:54:58 -0700 (PDT)
Received: from localhost.localdomain (r190-135-175-126.dialup.adsl.anteldata.net.uy. [190.135.175.126])
        by mx.google.com with ESMTPS id g46sm6087567yhm.19.2012.07.30.10.54.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 10:54:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <7vsjc9qh33.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202596>

* Check submodule is correctly initialized and updated after cloning .d=
otfiles

Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
---
 t/t7409-submodule-detached-worktree.sh |   31 ++++++++++++++++++++++++=
-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/t/t7409-submodule-detached-worktree.sh b/t/t7409-submodule=
-detached-worktree.sh
index db75642..f82a757 100755
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
+		git rev-parse --verify HEAD >../expect
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
+			git rev-parse --verify HEAD >actual &&
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
+			git rev-parse --verify HEAD >actual &&
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
