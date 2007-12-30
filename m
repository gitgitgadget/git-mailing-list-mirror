From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] git-filter-branch could be confused by similar names
Date: Sun, 30 Dec 2007 21:51:07 +0300
Message-ID: <1199040667-31850-1-git-send-email-dpotapov@gmail.com>
References: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 30 19:51:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J93GO-0006Hb-H5
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 19:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbXL3Svb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 13:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752977AbXL3Sva
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 13:51:30 -0500
Received: from smtp01.mtu.ru ([62.5.255.48]:52742 "EHLO smtp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969AbXL3Sva (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 13:51:30 -0500
Received: from smtp01.mtu.ru (localhost [127.0.0.1])
	by smtp01.mtu.ru (Postfix) with ESMTP id 495BDADE75D;
	Sun, 30 Dec 2007 21:51:17 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-14.pppoe.mtu-net.ru [85.141.191.14])
	by smtp01.mtu.ru (Postfix) with ESMTP id 6CDDBACC126;
	Sun, 30 Dec 2007 21:51:05 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1J93Fb-0008Hy-Qv; Sun, 30 Dec 2007 21:51:07 +0300
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de>
X-DCC-STREAM-Metrics: smtp01.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69374>

'git-filter-branch branch' could fail producing the error:
"Which ref do you want to rewrite?" if existed another branch
or tag, which name was 'branch-something' or 'something/branch'.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

I have corrected my previous patch to allow "heads" or "tags"
in the name of a branch or tag, i.e. to write it like this:
   git filter-branch heads/master

 git-filter-branch.sh     |    2 +-
 t/t7003-filter-branch.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index dbab1a9..5de8b12 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -219,7 +219,7 @@ do
 	;;
 	*)
 		ref="$(git for-each-ref --format='%(refname)' |
-			grep /"$ref")"
+			grep '^refs/\([^/]\+/\)\?'"$ref"'$')"
 	esac
 
 	git check-ref-format "$ref" && echo "$ref"
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 5f60b22..c3e5207 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -36,6 +36,16 @@ test_expect_success 'result is really identical' '
 	test $H = $(git rev-parse HEAD)
 '
 
+test_expect_success 'rewrite branch with similar names' '
+	git branch my &&
+	git tag my/orig &&
+	git tag my-orig &&
+	git tag orig/my &&
+	git tag orig-my &&
+	git-filter-branch my &&
+	test $H = $(git rev-parse HEAD)
+'
+
 test_expect_success 'rewrite, renaming a specific file' '
 	git-filter-branch -f --tree-filter "mv d doh || :" HEAD
 '
-- 
1.5.3.5
