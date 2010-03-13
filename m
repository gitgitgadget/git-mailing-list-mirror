From: Dave Olszewski <cxreg@pobox.com>
Subject: [PATCH] stash: dont save during a conflicted merge
Date: Fri, 12 Mar 2010 19:40:33 -0800
Message-ID: <1268451633-30046-1-git-send-email-cxreg@pobox.com>
Cc: Dave Olszewski <cxreg@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 04:47:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqIKT-0005fI-7G
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 04:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757348Ab0CMDrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 22:47:47 -0500
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:41530 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757337Ab0CMDrq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Mar 2010 22:47:46 -0500
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Mar 2010 22:47:46 EST
X-Envelope-From: count@genericorp.net
Received: from bokonon.genericorp.net (c-76-104-180-27.hsd1.wa.comcast.net [76.104.180.27])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o2D3ejvk027877
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Fri, 12 Mar 2010 21:40:51 -0600
Received: from count by bokonon.genericorp.net with local (Exim 4.71)
	(envelope-from <count@bokonon.genericorp.net>)
	id 1NqIDQ-0007p5-Dw; Fri, 12 Mar 2010 19:40:40 -0800
X-Mailer: git-send-email 1.7.0.2.200.ga611.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142072>

Similar to commit c8c562a, if a user is resolving conflicts, they may
think it wise to stash their current work tree and git pull to see if
there are additional changes on the remote.

The stash will fail to save if the index contains unmerged entries, but
if the conflicts are resolved, the stash will succeed, and both
MERGE_HEAD and MERGE_MSG will be removed.  This is probably a mistake,
and we should warn the user and refuse to stash.

Signed-off-by: Dave Olszewski <cxreg@pobox.com>
---
 git-stash.sh     |    5 +++++
 t/t3903-stash.sh |   19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index aa47e54..1a70f8d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -172,6 +172,11 @@ save_stash () {
 	test -f "$GIT_DIR/logs/$ref_stash" ||
 		clear_stash || die "Cannot initialize stash"
 
+	if test -f "$GIT_DIR/MERGE_HEAD"
+	then
+		die "You have not concluded your merge. (MERGE_HEAD exists)";
+	fi
+
 	create_stash "$stash_msg"
 
 	# Make sure the reflog for stash is kept.
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 476e5ec..9915f4f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -228,4 +228,23 @@ test_expect_success 'stash --invalid-option' '
 	test bar,bar2 = $(cat file),$(cat file2)
 '
 
+test_expect_success 'stash during merge' '
+	git branch other &&
+	git checkout master &&
+	echo conflict > conflict &&
+	git add conflict &&
+	git commit -m "conflict" &&
+	git checkout other &&
+	echo other content > conflict &&
+	git add conflict &&
+	git commit -m "other branch conflict" &&
+	git checkout master &&
+	test_must_fail git merge other &&
+	test_must_fail git stash &&
+	git add . &&
+	git status &&
+	test_must_fail git stash &&
+	git reset --hard
+'
+
 test_done
-- 
1.7.0.2.200.ga611.dirty
