From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH] git-svn: prevent dcommitting if the index is dirty.
Date: Sun, 11 Nov 2007 19:41:41 +0100
Message-ID: <1194806501-4796-1-git-send-email-tsuna@lrde.epita.fr>
Cc: normalperson@yhbt.net, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 19:42:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrHl1-0008Or-QL
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 19:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131AbXKKSlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 13:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755255AbXKKSlv
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 13:41:51 -0500
Received: from quanta.tsunanet.net ([82.229.223.213]:59597 "EHLO
	quanta.tsunanet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633AbXKKSlv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 13:41:51 -0500
Received: by quanta.tsunanet.net (Postfix, from userid 501)
	id 73A4EC94220; Sun, 11 Nov 2007 19:41:41 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.654.gdd5ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64493>

dcommit uses rebase `sync' the history with what has just been pushed to
SVN.  Trying to dcommit with a dirty index is troublesome for rebase, so now
the user will get an error message if he attempts to dcommit with a dirty
index.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
 git-svn.perl                              |    3 +++
 t/t9106-git-svn-dcommit-clobber-series.sh |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index dd93e32..a15df4f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -390,6 +390,9 @@ sub cmd_set_tree {
 
 sub cmd_dcommit {
 	my $head = shift;
+        git_cmd_try { command_oneline(qw/diff-index --quiet HEAD/) }
+          'Cannot dcommit with a dirty index.  Commit your changes first'
+          . "or stash them with `git stash'.\n";
 	$head ||= 'HEAD';
 	my @refs;
 	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
diff --git a/t/t9106-git-svn-dcommit-clobber-series.sh b/t/t9106-git-svn-dcommit-clobber-series.sh
index 7eff4cd..44fae3b 100755
--- a/t/t9106-git-svn-dcommit-clobber-series.sh
+++ b/t/t9106-git-svn-dcommit-clobber-series.sh
@@ -53,4 +53,10 @@ test_expect_success 'change file but in unrelated area' "
 		test x\"\`sed -n -e 61p < file\`\" = x6611
 	"
 
+test_expect_failure 'attempt to dcommit with a dirty index' "
+	echo foo >>file &&
+	git add file &&
+	git svn dcommit
+	"
+
 test_done
-- 
1.5.3.5.654.gdd5ec
