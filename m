From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v7 3/3] submodule add: If --branch is given,
 record it in .gitmodules
Date: Tue, 11 Dec 2012 13:58:17 -0500
Message-ID: <0b2b49bb7337459502d46b814e350ec857cedfaa.1355251862.git.wking@tremily.us>
References: <20121204001717.GA17375@odin.tremily.us>
 <cover.1355251862.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:59:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiV2s-00061S-UJ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 19:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623Ab2LKS6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 13:58:47 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:10822 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754Ab2LKS6p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 13:58:45 -0500
Received: from odin.tremily.us ([unknown] [72.68.110.234])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEV00H8XRDAM870@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 11 Dec 2012 12:58:36 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 9C7FD71B43B; Tue,
 11 Dec 2012 13:58:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1355252302; bh=9T37Sk1BCjK08fHGdvxgcWExM2sxBTBk8W4Rw9SgcCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=jOWDdhIixPb489izTk44wTCuZRXkRWNPpnkzko1pPhLjsMah26E6nXnUjrTV2wxNP
 wgFkoB4L7UcM+Gu285Qf83Tq2EU4UKJbsDRSeJ0ASNME0y51xAv61jeBwf6TxaW8Jj
 +yoSS6TCQzMqAHPsI5h+GbBk3VOngA1EehHtm/mQ=
X-Mailer: git-send-email 1.7.8.6
In-reply-to: <cover.1355251862.git.wking@tremily.us>
In-reply-to: <cover.1355251862.git.wking@tremily.us>
References: <cover.1355251862.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211294>

From: "W. Trevor King" <wking@tremily.us>

This allows you to easily record a submodule.<name>.branch option in
.gitmodules when you add a new submodule.  With this patch,

  $ git submodule add -b <branch> <repository> [<path>]
  $ git config -f .gitmodules submodule.<path>.branch <branch>

reduces to

  $ git submodule add -b <branch> <repository> [<path>]

This means that future calls to

  $ git submodule update --remote ...

will get updates from the same branch that you used to initialize the
submodule, which is usually what you want.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-submodule.txt | 2 ++
 git-submodule.sh                | 4 ++++
 t/t7400-submodule-basic.sh      | 1 +
 3 files changed, 7 insertions(+)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 72dd52f..988bba9 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -208,6 +208,8 @@ OPTIONS
 -b::
 --branch::
 	Branch of repository to add as submodule.
+	The name of the branch is recorded as `submodule.<path>.branch` in
+	`.gitmodules` for `update --remote`.
 
 -f::
 --force::
diff --git a/git-submodule.sh b/git-submodule.sh
index 1395079..9f3f437 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -394,6 +394,10 @@ Use -f if you really want to add it." >&2
 
 	git config -f .gitmodules submodule."$sm_path".path "$sm_path" &&
 	git config -f .gitmodules submodule."$sm_path".url "$repo" &&
+	if test -n "$branch"
+	then
+		git config -f .gitmodules submodule."$sm_path".branch "$branch"
+	fi &&
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5397037..90e2915 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -133,6 +133,7 @@ test_expect_success 'submodule add --branch' '
 	(
 		cd addtest &&
 		git submodule add -b initial "$submodurl" submod-branch &&
+		test "initial" = "$(git config -f .gitmodules submodule.submod-branch.branch)" &&
 		git submodule init
 	) &&
 
-- 
1.8.0
