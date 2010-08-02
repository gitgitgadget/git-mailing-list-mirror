From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH] Fix git svn dcommit to work with touched files
Date: Mon,  2 Aug 2010 12:58:19 -0700
Message-ID: <1280779099-29742-1-git-send-email-ddkilzer@kilzer.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	"David D. Kilzer" <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 02 21:58:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og19h-0005bv-Cu
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 21:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab0HBT6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 15:58:35 -0400
Received: from mail-out.apple.com ([17.254.13.22]:59786 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab0HBT6c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 15:58:32 -0400
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out3.apple.com (Postfix) with ESMTP id EFE4DA12191A;
	Mon,  2 Aug 2010 12:58:31 -0700 (PDT)
X-AuditID: 11807130-b7ca5ae000007de4-85-4c5723674d7f
Received: from ddkilzer.apple.com (ddkilzer.apple.com [17.202.32.26])
	by relay11.apple.com (Apple SCV relay) with SMTP id 43.94.32228.763275C4; Mon,  2 Aug 2010 12:58:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.9.g74fb9
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152446>

The dcommit command fails if an otherwise unmodified file has
been touched in the working directory:

    Cannot dcommit with a dirty index.  Commit your changes
    first, or stash them with `git stash'.

This happens because "git diff-index" reports a difference
between the index and the filesystem:

    :100644 100644 d00491...... 000000...... M      file

The fix is to run "git update-index --refresh" before
"git diff-index" as is done in git-rebase and
git-rebase--interactive before "git diff-files".

This changes dcommit to display a list of modified files before
exiting.

Also add a similar test case for "git svn rebase".

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---
 git-svn.perl             |    1 +
 t/t9100-git-svn-basic.sh |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index c416358..b8a98d4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -494,6 +494,7 @@ sub cmd_set_tree {
 
 sub cmd_dcommit {
 	my $head = shift;
+	command_noisy(qw/update-index --refresh/);
 	git_cmd_try { command_oneline(qw/diff-index --quiet HEAD/) }
 		'Cannot dcommit with a dirty index.  Commit your changes first, '
 		. "or stash them with `git stash'.\n";
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 13766ab..d5adae6 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -271,6 +271,17 @@ test_expect_success 'able to dcommit to a subdirectory' "
 	test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\"
 	"
 
+test_expect_success 'dcommit should not fail with a touched file' '
+	test_commit "commit-new-file-foo2" foo2 &&
+	test-chmtime =-60 foo &&
+	git svn dcommit
+'
+
+test_expect_success 'rebase should not fail with a touched file' '
+	test-chmtime =-60 foo &&
+	git svn rebase
+'
+
 test_expect_success 'able to set-tree to a subdirectory' "
 	echo cba > d &&
 	git update-index d &&
-- 
1.7.2.1.9.g74fb9
