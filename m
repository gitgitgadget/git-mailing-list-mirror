From: Max Kirillov <max@max630.net>
Subject: [PATCH 1/4] checkout: do not fail if target is an empty directory
Date: Sun, 12 Oct 2014 08:13:08 +0300
Message-ID: <1413090791-14428-2-git-send-email-max@max630.net>
References: <1413090791-14428-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 12 07:14:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdBTj-0006tY-LG
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 07:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbaJLFNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2014 01:13:55 -0400
Received: from p3plsmtpa09-01.prod.phx3.secureserver.net ([173.201.193.230]:40290
	"EHLO p3plsmtpa09-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750828AbaJLFNy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Oct 2014 01:13:54 -0400
Received: from wheezy.pp.htv.fi ([82.181.81.240])
	by p3plsmtpa09-01.prod.phx3.secureserver.net with 
	id 25Dj1p00F5B68XE015DrUl; Sat, 11 Oct 2014 22:13:53 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
In-Reply-To: <1413090791-14428-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Non-recursive checkout creates empty directpries in place of submodules.
If then I try to "checkout --to" submodules there, it refuses to do so,
because directory already exists.

Fix by allowing checking out to empty directory. Add test and modify the
existing one so that it uses non-empty directory.

Signed-off-by: Max Kirillov <max@max630.net>
---
 builtin/checkout.c     | 2 +-
 t/t2025-checkout-to.sh | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 01d0f2f..74eabe7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -865,7 +865,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 
 	if (!new->commit)
 		die(_("no branch specified"));
-	if (file_exists(path))
+	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
 
 	len = strlen(path);
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index eddd325..915b506 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -13,10 +13,15 @@ test_expect_success 'checkout --to not updating paths' '
 '
 
 test_expect_success 'checkout --to an existing worktree' '
-	mkdir existing &&
+	mkdir -p existing/subtree &&
 	test_must_fail git checkout --detach --to existing master
 '
 
+test_expect_success 'checkout --to an existing empty worktree' '
+	mkdir existing_empty &&
+	git checkout --detach --to existing_empty master
+'
+
 test_expect_success 'checkout --to refuses to checkout locked branch' '
 	test_must_fail git checkout --to zere master &&
 	! test -d zere &&
-- 
2.0.1.1697.g73c6810
