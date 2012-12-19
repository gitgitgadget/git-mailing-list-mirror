From: wking@tremily.us
Subject: [PATCH v8 3/3] submodule add: If --branch is given,
 record it in .gitmodules
Date: Wed, 19 Dec 2012 11:03:33 -0500
Message-ID: <2c8df95b9f4cc9ceb9d6d96d5deac22320541dd9.1355932282.git.wking@tremily.us>
References: <20121212230217.GB7729@odin.tremily.us>
 <cover.1355932282.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 17:04:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlM89-0003YL-7P
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 17:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614Ab2LSQEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 11:04:00 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:31143 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610Ab2LSQDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 11:03:55 -0500
Received: from odin.tremily.us ([unknown] [72.68.92.119])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MFA00HYCCLUXL40@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 19 Dec 2012 10:03:33 -0600 (CST)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with SMTP id 28F07737709; Wed,
 19 Dec 2012 11:03:29 -0500 (EST)
Received: by mjolnir (sSMTP sendmail emulation); Wed, 19 Dec 2012 11:03:42 -0500
X-Mailer: git-send-email 1.8.0
In-reply-to: <cover.1355932282.git.wking@tremily.us>
In-reply-to: <cover.1355932282.git.wking@tremily.us>
References: <cover.1355932282.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211832>

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
index 8bf173a..b1996f1 100644
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
index 6ae51c6..22ec5b6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -417,6 +417,10 @@ Use -f if you really want to add it." >&2
 
 	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
 	git config -f .gitmodules submodule."$sm_name".url "$repo" &&
+	if test -n "$branch"
+	then
+		git config -f .gitmodules submodule."$sm_name".branch "$branch"
+	fi &&
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index de7d453..2683cba 100755
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
