From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v6 3/4] submodule add: If --branch is given,
 record it in .gitmodules
Date: Sat, 01 Dec 2012 22:17:03 -0500
Message-ID: <be4777f670198aedae24c3974fddd575fc734c0c.1354417619.git.wking@tremily.us>
References: <20121130032719.GE29257@odin.tremily.us>
 <cover.1354417618.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 04:18:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf04k-00067R-D3
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 04:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab2LBDSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 22:18:15 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:44129 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab2LBDSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 22:18:13 -0500
Received: from odin.tremily.us ([unknown] [72.68.87.250])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MED00F35VTZSKC0@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 01 Dec 2012 21:18:00 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id 7298E6E403B; Sat,
 01 Dec 2012 22:17:59 -0500 (EST)
X-Mailer: git-send-email 1.8.0.4.gf74b0fc.dirty
In-reply-to: <cover.1354417618.git.wking@tremily.us>
In-reply-to: <cover.1354417618.git.wking@tremily.us>
References: <cover.1354417618.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210995>

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
index 104b5de..27b02fe 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -395,6 +395,10 @@ Use -f if you really want to add it." >&2
 
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
1.8.0.4.gf74b0fc.dirty
