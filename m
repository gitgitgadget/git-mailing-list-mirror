From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 5/5] reset: disallow "reset --keep" outside a work tree
Date: Sat, 02 Jan 2010 06:39:33 +0100
Message-ID: <20100102053934.30066.20988.chriscool@tuxfamily.org>
References: <20100102053303.30066.26391.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 06:40:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQwio-00023x-Ax
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 06:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685Ab0ABFkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 00:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468Ab0ABFkG
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 00:40:06 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:54017 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab0ABFkA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 00:40:00 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id ECA6281801B;
	Sat,  2 Jan 2010 06:39:50 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1C50081806A;
	Sat,  2 Jan 2010 06:39:40 +0100 (CET)
X-git-sha1: f12f4bbf36fd16ac55e2cf4460e1f8b66e6b6ef3 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100102053303.30066.26391.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136021>

It is safer and consistent with "--merge" and "--hard" resets to disallow
"git reset --keep" outside a work tree.

So let's just do that and add some tests while at it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-reset.c       |    2 +-
 t/t7103-reset-bare.sh |   25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index da61f20..52584af 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -319,7 +319,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
-	if (reset_type == HARD || reset_type == MERGE)
+	if (reset_type != SOFT && reset_type != MIXED)
 		setup_work_tree();
 
 	if (reset_type == MIXED && is_bare_repository())
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index afb55b3..1eef93c 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -11,21 +11,26 @@ test_expect_success 'setup non-bare' '
 	git commit -a -m two
 '
 
-test_expect_success 'hard reset requires a worktree' '
+test_expect_success '"hard" reset requires a worktree' '
 	(cd .git &&
 	 test_must_fail git reset --hard)
 '
 
-test_expect_success 'merge reset requires a worktree' '
+test_expect_success '"merge" reset requires a worktree' '
 	(cd .git &&
 	 test_must_fail git reset --merge)
 '
 
-test_expect_success 'mixed reset is ok' '
+test_expect_success '"keep" reset requires a worktree' '
+	(cd .git &&
+	 test_must_fail git reset --keep)
+'
+
+test_expect_success '"mixed" reset is ok' '
 	(cd .git && git reset)
 '
 
-test_expect_success 'soft reset is ok' '
+test_expect_success '"soft" reset is ok' '
 	(cd .git && git reset --soft)
 '
 
@@ -40,19 +45,23 @@ test_expect_success 'setup bare' '
 	cd bare.git
 '
 
-test_expect_success 'hard reset is not allowed in bare' '
+test_expect_success '"hard" reset is not allowed in bare' '
 	test_must_fail git reset --hard HEAD^
 '
 
-test_expect_success 'merge reset is not allowed in bare' '
+test_expect_success '"merge" reset is not allowed in bare' '
 	test_must_fail git reset --merge HEAD^
 '
 
-test_expect_success 'mixed reset is not allowed in bare' '
+test_expect_success '"keep" reset is not allowed in bare' '
+	test_must_fail git reset --keep HEAD^
+'
+
+test_expect_success '"mixed" reset is not allowed in bare' '
 	test_must_fail git reset --mixed HEAD^
 '
 
-test_expect_success 'soft reset is allowed in bare' '
+test_expect_success '"soft" reset is allowed in bare' '
 	git reset --soft HEAD^ &&
 	test "`git show --pretty=format:%s | head -n 1`" = "one"
 '
-- 
1.6.6.rc2.5.g49666
