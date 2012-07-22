From: =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>
Subject: [PATCH] Solve git-submodule issues with detached work trees
Date: Sun, 22 Jul 2012 11:49:44 -0300
Message-ID: <CAHCkQtNfz8Kbn810LgXEQ_rkyk4qn5amGgHQsv2uR6H38sTSrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 16:49:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsxTi-0008WU-RZ
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 16:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089Ab2GVOtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jul 2012 10:49:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58658 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab2GVOtp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2012 10:49:45 -0400
Received: by pbbrp8 with SMTP id rp8so9309208pbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=n+guLdBOuhMFKYZ47NveqNYS98+YW/M7YRTEfvhc9do=;
        b=VGIvV+uwineANVrd23OIJoBj/PYQeWZHdivl1BYJiyIPDYxTNwAdmKQ5CkibaN/tTY
         PSkt37GcrMd1kFECt3iisIteSHWAcfofo0uvf3JDZzOCgg7R2PCRnBBUcNjR1SVUVFiv
         B4Z+T7rt/4GIXSFuidy351ZFUOZY5se6n6mj+UyCI9o+TIi2g1C22z/fuGX4A3+kd9R2
         ij8kh/hLcL5AFGySFRJMN/rqOv59HWnjbYykhHNGvHNV+HfGt4dD7nM4BNl3Rt2s4Bq5
         I/0Si9k6QMFmvUt64Z2sUtS6KWu1Y72VRlA+NGGsWp76/WyEZBdVcGCpzNGs7nVtTR25
         dUsA==
Received: by 10.66.83.65 with SMTP id o1mr24582633pay.17.1342968584951; Sun,
 22 Jul 2012 07:49:44 -0700 (PDT)
Received: by 10.68.48.100 with HTTP; Sun, 22 Jul 2012 07:49:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201851>

A common way to track dotfiles with git is using GIT_DIR and
GIT_WORK_TREE to move repository out of ~/.git with something like:

    git init --bare ~/.dotfiles
    alias dotfiles=3D"GIT_DIR=3D~/.dotfiles GIT_WORK_TREE=3D~ git"

    dotfiles add ~/.bashrc
    dotfiles commit -a -m "add my bashrc"
    ...

but git-submodule complains when trying to add submodules:

    dotfiles submodule add http://path.to/submodule
    fatal: working tree '/home/user' already exists.

    git --git-dir ~/.dotfiles submodule add http://path.to/submodule
    fatal: /usr/lib/git-core/git-submodule cannot be used without a
working tree.

Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
---
 git-submodule.sh                       |    7 +++-
 t/t7409-submodule-detached-worktree.sh |   61 ++++++++++++++++++++++++=
++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100755 t/t7409-submodule-detached-worktree.sh

diff --git a/git-submodule.sh b/git-submodule.sh
index 5629d87..88ee4ea 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -181,8 +181,11 @@ module_clone()
 		rm -f "$gitdir/index"
 	else
 		mkdir -p "$gitdir_base"
-		git clone $quiet -n ${reference:+"$reference"} \
-			--separate-git-dir "$gitdir" "$url" "$sm_path" ||
+		(
+			clear_local_git_env
+			git clone $quiet -n ${reference:+"$reference"} \
+				--separate-git-dir "$gitdir" "$url" "$sm_path"
+		) ||
 		die "$(eval_gettext "Clone of '\$url' into submodule path
'\$sm_path' failed")"
 	fi

diff --git a/t/t7409-submodule-detached-worktree.sh
b/t/t7409-submodule-detached-worktree.sh
new file mode 100755
index 0000000..db75642
--- /dev/null
+++ b/t/t7409-submodule-detached-worktree.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Daniel Gra=C3=B1a
+#
+
+test_description=3D'Test submodules on detached working tree
+
+This test verifies that "git submodule" initialization, update and
addition works
+on detahced working trees
+'
+
+TEST_NO_CREATE_REPO=3D1
+. ./test-lib.sh
+
+test_expect_success 'submodule on detached working tree' '
+	git init --bare remote &&
+	test_create_repo bundle1 &&
+	(cd bundle1 && test_commit "shoot") &&
+	mkdir home &&
+	(
+		cd home &&
+		export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		git clone --bare ../remote .dotfiles &&
+		git submodule add ../bundle1 .vim/bundle/sogood &&
+		test_commit "sogood" &&
+		git push origin master
+	) &&
+	mkdir home2 &&
+	(
+		cd home2 &&
+		export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		git clone --bare ../remote .dotfiles &&
+		git submodule update --init
+	)
+'
+
+test_expect_success 'submodule on detached working pointed by core.wor=
ktree' '
+	mkdir home3 &&
+	(
+		cd home3 &&
+		export GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		git clone --bare ../remote "$GIT_DIR" &&
+		git config core.bare false &&
+		git config core.worktree .. &&
+		git submodule add ../bundle1 .vim/bundle/dupe &&
+		test_commit "dupe" &&
+		git push origin master
+	) &&
+	(
+		cd home &&
+		export GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		git config core.bare false &&
+		git config core.worktree .. &&
+		git pull &&
+		git submodule update &&
+		git submodule status &&
+		test -d .vim/bundle/dupe
+	)
+'
+
+test_done
--=20
1.7.5.4
