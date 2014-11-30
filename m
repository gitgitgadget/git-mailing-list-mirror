From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 34/34] git-common-dir: make "modules/" per-working-directory directory
Date: Sun, 30 Nov 2014 15:24:59 +0700
Message-ID: <1417335899-27307-35-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:30:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuzu5-0000qz-HF
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbaK3Iap convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:30:45 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:58523 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbaK3Iap (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:30:45 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so9015111pde.10
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gM9AELUbDxtEN6Lj3fxekHLLrRf+Nrxm/ANAKIVE1yU=;
        b=LU2JqZT4oQWlu0mrd6UIv3w/v8B5O43HGJgLAmZKRrSdQzu7o1e6zqtj8IcGaHqnvY
         mFHCYb22QlhdPIJp7Xki3/JmlJhj42LKEJvJ009oOLFf3olmzmZBrmDp2KanHTwIWFnC
         C4uYuqiRlbopsTtcD4Spu3EMCeO8COW7MJuRhySDFH5fKHFDh4Gx4eV10n5+B1fywbB5
         CJcTwvx//2OKrR2ExioYSVdLe6+oEN/7tlZVKAlgHB89uiPN3Il56e/35x5dcApLrpIv
         U9VFHteOywpY+me9go1zqURDdOlKFXM4vfGZFqcd3SFAJBJ1dp8lTmpJBfe2tleDmmSR
         CHfQ==
X-Received: by 10.70.125.164 with SMTP id mr4mr89181826pdb.36.1417336244819;
        Sun, 30 Nov 2014 00:30:44 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id gz10sm14396916pac.23.2014.11.30.00.30.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:30:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:30:43 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260421>

=46rom: Max Kirillov <max@max630.net>

Each working directory of main repository has its own working directory
of submodule, and in most cases they should be checked out to different
revisions. So they should be separated.

It looks logical to make submodule instances in different working
directories to reuse the submodule directory in the common dir of
the main repository, and probably this is how "checkout --to" should
initialize them called on the main repository, but they also should wor=
k
fine being completely separated clones.

Testfile t7410-submodule-checkout-to.sh demostrates the behavior.

Signed-off-by: Max Kirillov <max@max630.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitrepository-layout.txt    |  4 +--
 path.c                                    |  2 +-
 t/t7410-submodule-checkout-to.sh (new +x) | 50 +++++++++++++++++++++++=
++++++++
 3 files changed, 52 insertions(+), 4 deletions(-)
 create mode 100755 t/t7410-submodule-checkout-to.sh

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 2b30a92..7173b38 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -248,9 +248,7 @@ commondir::
 	incomplete without the repository pointed by "commondir".
=20
 modules::
-	Contains the git-repositories of the submodules. This
-	directory is ignored if $GIT_COMMON_DIR is set and
-	"$GIT_COMMON_DIR/modules" will be used instead.
+	Contains the git-repositories of the submodules.
=20
 worktrees::
 	Contains worktree specific information of linked
diff --git a/path.c b/path.c
index 35d498e..a5c51a3 100644
--- a/path.c
+++ b/path.c
@@ -92,7 +92,7 @@ static void replace_dir(struct strbuf *buf, int len, =
const char *newdir)
 }
=20
 static const char *common_list[] =3D {
-	"/branches", "/hooks", "/info", "!/logs", "/lost-found", "/modules",
+	"/branches", "/hooks", "/info", "!/logs", "/lost-found",
 	"/objects", "/refs", "/remotes", "/worktrees", "/rr-cache", "/svn",
 	"config", "!gc.pid", "packed-refs", "shallow",
 	NULL
diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-check=
out-to.sh
new file mode 100755
index 0000000..8f30aed
--- /dev/null
+++ b/t/t7410-submodule-checkout-to.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description=3D'Combination of submodules and multiple workdirs'
+
+. ./test-lib.sh
+
+base_path=3D$(pwd -P)
+
+test_expect_success 'setup: make origin' \
+    'mkdir -p origin/sub && ( cd origin/sub && git init &&
+	echo file1 >file1 &&
+	git add file1 &&
+	git commit -m file1 ) &&
+    mkdir -p origin/main && ( cd origin/main && git init &&
+	git submodule add ../sub &&
+	git commit -m "add sub" ) &&
+    ( cd origin/sub &&
+	echo file1updated >file1 &&
+	git add file1 &&
+	git commit -m "file1 updated" ) &&
+    ( cd origin/main/sub && git pull ) &&
+    ( cd origin/main &&
+	git add sub &&
+	git commit -m "sub updated" )'
+
+test_expect_success 'setup: clone' \
+    'mkdir clone && ( cd clone &&
+	git clone --recursive "$base_path/origin/main")'
+
+rev1_hash_main=3D$(git --git-dir=3Dorigin/main/.git show --pretty=3Dfo=
rmat:%h -q "HEAD~1")
+rev1_hash_sub=3D$(git --git-dir=3Dorigin/sub/.git show --pretty=3Dform=
at:%h -q "HEAD~1")
+
+test_expect_success 'checkout main' \
+    'mkdir default_checkout &&
+    (cd clone/main &&
+	git checkout --to "$base_path/default_checkout/main" "$rev1_hash_main=
")'
+
+test_expect_failure 'can see submodule diffs just after checkout' \
+    '(cd default_checkout/main && git diff --submodule master"^!" | gr=
ep "file1 updated")'
+
+test_expect_success 'checkout main and initialize independed clones' \
+    'mkdir fully_cloned_submodule &&
+    (cd clone/main &&
+	git checkout --to "$base_path/fully_cloned_submodule/main" "$rev1_has=
h_main") &&
+    (cd fully_cloned_submodule/main && git submodule update)'
+
+test_expect_success 'can see submodule diffs after independed cloning'=
 \
+    '(cd fully_cloned_submodule/main && git diff --submodule master"^!=
" | grep "file1 updated")'
+
+test_done
--=20
2.1.0.rc0.78.gc0d8480
