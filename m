From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Fix git reset --abort not restoring the right commit under some conditions
Date: Sat,  1 Mar 2008 11:32:14 +0100
Message-ID: <1204367534-28204-1-git-send-email-mh@glandium.org>
References: <7vod9y4xcn.fsf@gitster.siamese.dyndns.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 01 11:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVOyA-0004PV-R1
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 11:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbYCAK2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 05:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbYCAK2y
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 05:28:54 -0500
Received: from vuizook.err.no ([194.24.252.247]:49954 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753383AbYCAK2x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 05:28:53 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVOxM-00063I-Na; Sat, 01 Mar 2008 11:28:47 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVP0o-0007LV-Hg; Sat, 01 Mar 2008 11:32:14 +0100
X-Mailer: git-send-email 1.5.4.3.343.gb141c.dirty
In-Reply-To: <7vod9y4xcn.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75651>

Previously, --abort would end by git resetting to ORIG_HEAD, but some
commands, such as git reset --hard (which happened in git rebase --skip,
but could just as well be typed by the user), modify ORIG_HEAD.

Just use the orig-head we store in $dotest instead.
---

 > > ... and I'm even the one to blame
 > > fb6e4e1f3f048898677f3cf177bfcaf60123bd5c is first bad commit
 >
 > Heh, didn't you say you don't have enough knowledge in git-rebase? ;-)

 I'm relieved, I'm not exactly to blame ;) I just exposed the bug that was
 actually already here.

 git-rebase.sh           |    5 ++---
 t/t3407-rebase-abort.sh |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index bdcea0e..6b9af96 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -208,16 +208,15 @@ do
 		if test -d "$dotest"
 		then
 			move_to_original_branch
-			rm -r "$dotest"
 		elif test -d .dotest
 		then
 			dotest=.dotest
 			move_to_original_branch
-			rm -r .dotest
 		else
 			die "No rebase in progress?"
 		fi
-		git reset --hard ORIG_HEAD
+		git reset --hard $(cat $dotest/orig-head)
+		rm -r "$dotest"
 		exit
 		;;
 	--onto)
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 94bdd72..3417138 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -29,7 +29,7 @@ test_expect_success 'rebase --abort' '
 	test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase)
 '
 
-test_expect_failure 'rebase --abort after --skip' '
+test_expect_success 'rebase --abort after --skip' '
 	# Clean up the state from the previous one
 	git reset --hard pre-rebase
 	rm -rf .dotest
-- 
1.5.4.3.343.gb141c.dirty

