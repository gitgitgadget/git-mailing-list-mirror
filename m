From: Dave Olszewski <cxreg@pobox.com>
Subject: [PATCH] rebase--interactive: don't enforce valid branch
Date: Sun, 14 Mar 2010 21:48:22 -0700
Message-ID: <1268628502-29696-1-git-send-email-cxreg@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 05:48:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr2EU-00073f-By
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 05:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010Ab0COEsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 00:48:43 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:39780 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754838Ab0COEsk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 00:48:40 -0400
X-Envelope-From: count@genericorp.net
Received: from bokonon.genericorp.net (c-76-104-180-27.hsd1.wa.comcast.net [76.104.180.27])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o2F4mWqj031159
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 14 Mar 2010 23:48:38 -0500
Received: from count by bokonon.genericorp.net with local (Exim 4.71)
	(envelope-from <count@bokonon.genericorp.net>)
	id 1Nr2E7-0007jT-9R
	for git@vger.kernel.org; Sun, 14 Mar 2010 21:48:27 -0700
X-Mailer: git-send-email 1.7.0.2.213.gd6898.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142168>

git rebase allows you to specify a non-branch commit-ish as the "branch"
argument, which leaves HEAD detached when it's finished.  This is
occasionally useful, and this patch brings the same functionality to git
rebase ---interactive.

Signed-off-by: Dave Olszewski <cxreg@pobox.com>
---
 git-rebase--interactive.sh    |    2 --
 t/t3404-rebase-interactive.sh |    7 +++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3e4fd14..d047dcb 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -783,8 +783,6 @@ first and then run 'git rebase --continue' again."
 
 		if test ! -z "$1"
 		then
-			output git show-ref --verify --quiet "refs/heads/$1" ||
-				die "Invalid branchname: $1"
 			output git checkout "$1" ||
 				die "Could not checkout $1"
 		fi
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4e35137..32ffa15 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -553,4 +553,11 @@ test_expect_success 'reword' '
 	git show HEAD~2 | grep "C changed"
 '
 
+test_expect_success 'rebase while detaching HEAD' '
+	grandparent=$(git rev-parse HEAD~2) &&
+	test_tick &&
+	FAKE_LINES="2 1" git rebase -i HEAD~2 HEAD^0 &&
+	test $grandparent = $(git rev-parse HEAD~2)
+'
+
 test_done
-- 
1.7.0.2.213.gd6898.dirty
