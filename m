From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v5 2/2] submodule add: If --branch is given,
 record it in .gitmodules
Date: Wed, 28 Nov 2012 14:30:29 -0500
Message-ID: <572f6aee10162597c4544522330262e877e74992.1354130656.git.wking@tremily.us>
References: <20121128165334.GA20483@odin.tremily.us>
 <cover.1354130656.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:31:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdnLh-0004qU-8S
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 20:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990Ab2K1Tau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 14:30:50 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:40648 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab2K1Tas (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 14:30:48 -0500
Received: from odin.tremily.us ([unknown] [72.68.95.13])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME700IOHQ72N840@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Nov 2012 13:30:39 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 727EC6E19F3; Wed,
 28 Nov 2012 14:30:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354131038; bh=bdMFz4JeoMApNqHTQuIut9mxr21I9UefNcnQhGQeoRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=i8GzTwN5jCcDYx+4iYXMX8Sfc4ig5kVlV4nM7hhtCdWvLeEBZbJPjTpW0OQ+gX6e+
 ZVNyrQIqvmrYikXb8ZtZx/7Fk0mLh7lrJqtIfWRU6G83zWp0+ONTlXfL0gJnK88iMh
 uK6/XxW8Zdqnmo3DEguCQE//YXVug4Aimki/6oYg=
X-Mailer: git-send-email 1.7.8.6
In-reply-to: <cover.1354130656.git.wking@tremily.us>
In-reply-to: <cover.1354130656.git.wking@tremily.us>
References: <cover.1354130656.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210763>

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
index 39aa02d..43e5b4b 100644
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
index b63d869..1f76893 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -368,6 +368,10 @@ Use -f if you really want to add it." >&2
 
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
1.8.0.2.gad10246.dirty
