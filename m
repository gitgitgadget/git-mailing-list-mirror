From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 2/4] git-submodule init: Record submodule.<name>.branch in
 repository config.
Date: Mon, 26 Nov 2012 16:00:17 -0500
Message-ID: <6734714e90064b3932126565e3027d7edcf45d51.1353962698.git.wking@tremily.us>
References: <20121123175402.GH2806@odin.tremily.us>
 <cover.1353962698.git.wking@tremily.us>
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:02:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5oU-00058l-Qc
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 22:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756449Ab2KZVB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 16:01:29 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:62412 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab2KZVB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 16:01:27 -0500
Received: from odin.tremily.us ([unknown] [72.68.108.240])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME40092A51QTR40@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 26 Nov 2012 15:01:08 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id 1EEB46DEFCA; Mon,
 26 Nov 2012 16:01:02 -0500 (EST)
X-Mailer: git-send-email 1.8.0.3.g95edff1.dirty
In-reply-to: <cover.1353962698.git.wking@tremily.us>
In-reply-to: <cover.1353962698.git.wking@tremily.us>
References: <cover.1353962698.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210492>

From: "W. Trevor King" <wking@tremily.us>

This allows users to override the .gitmodules value with a
per-repository value.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/config.txt   |  9 +++++----
 git-submodule.sh           |  7 +++++++
 t/t7400-submodule-basic.sh | 18 ++++++++++++++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 11f320b..1304499 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1994,10 +1994,11 @@ status.submodulesummary::
 submodule.<name>.path::
 submodule.<name>.url::
 submodule.<name>.update::
-	The path within this project, URL, and the updating strategy
-	for a submodule.  These variables are initially populated
-	by 'git submodule init'; edit them to override the
-	URL and other values found in the `.gitmodules` file.  See
+submodule.<name>.branch::
+	The path within this project, URL, the updating strategy, and the
+	local branch name for a submodule.  These variables are initially
+	populated by 'git submodule init'; edit them to override the URL and
+	other values found in the `.gitmodules` file.  See
 	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
 
 submodule.<name>.fetchRecurseSubmodules::
diff --git a/git-submodule.sh b/git-submodule.sh
index 6eed008..c51b6ae 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -505,6 +505,13 @@ cmd_init()
 		test -n "$(git config submodule."$name".update)" ||
 		git config submodule."$name".update "$upd" ||
 		die "$(eval_gettext "Failed to register update mode for submodule path '\$sm_path'")"
+
+		# Copy "branch" setting when it is not set yet
+		branch="$(git config -f .gitmodules submodule."$name".branch)"
+		test -z "$branch" ||
+		test -n "$(git config submodule."$name".branch)" ||
+		git config submodule."$name".branch "$branch" ||
+		die "$(eval_gettext "Failed to register branch for submodule path '\$sm_path'")"
 	done
 }
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fc08647..3dc8237 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -236,6 +236,24 @@ test_expect_success 'submodule add --local-branch=<name> --branch' '
 	)
 '
 
+test_expect_success 'init should register submodule branch in .git/config' '
+	(
+		cd addtest &&
+		git submodule init &&
+		test "$(git config submodule.submod-follow.branch)" = "final"
+	)
+'
+
+test_expect_success 'local config should override .gitmodules branch' '
+	(
+		cd addtest &&
+		rm -fr submod-follow &&
+		git config submodule.submod-follow.branch initial
+		git submodule init &&
+		test "$(git config submodule.submod-follow.branch)" = "initial"
+	)
+'
+
 test_expect_success 'setup - add an example entry to .gitmodules' '
 	GIT_CONFIG=.gitmodules \
 	git config submodule.example.url git://example.com/init.git
-- 
1.8.0.3.g95edff1.dirty
