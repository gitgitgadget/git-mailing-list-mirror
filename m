From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Document and test the new % shotcut for the tracked branch
Date: Fri, 20 Mar 2009 11:04:31 +0100
Message-ID: <1237543471-27248-1-git-send-email-git@drmicha.warpmail.net>
References: <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:08:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkbeT-0001Ec-Lz
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 11:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759645AbZCTKEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 06:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759707AbZCTKEt
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 06:04:49 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56648 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759647AbZCTKEs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 06:04:48 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 2DD5B2F7B51;
	Fri, 20 Mar 2009 06:04:46 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 20 Mar 2009 06:04:46 -0400
X-Sasl-enc: sstc4PxhhUXrGUNNGohw7L6j/GKY1YNyCCG2KH7u0Mf8 1237543485
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5EA4F2ACE8;
	Fri, 20 Mar 2009 06:04:45 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.149.g6462
In-Reply-To: <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113931>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Johannes Schindelin venit, vidit, dixit 20.03.2009 10:29:
> 
> Often, it is quite interesting to inspect the branch tracked by a given
> branch.  This patch introduces a nice notation to get at the tracked
> branch: 'BEL<branch>' can be used to access that tracked branch.
> 
> A special shortcut 'BEL' refers to the branch tracked by the current branch.
> 
> Suggested by Pasky and Shawn.
> 
> This patch extends the function introduced to handle the nth-last branch
> (via the {-<n>} notation); therefore that function name was renamed to
> something more general.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

I guess you beat me to it then, which is fine.

But haven't you seen my note about the failing test either? The code below
tests with branches which track local branches. merge and remote is set
for the branch in question ("tracking"), it's just that remote is ".".
It seems that the remote.c code does not set up merge info for these
branches.

<Goes to figure out how to enter BEL...>

 Documentation/git-rev-parse.txt |    3 ++
 t/t1506-rev-parse-track.sh      |   60 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100755 t/t1506-rev-parse-track.sh

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 5ed2bc8..dafcfe8 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -215,6 +215,9 @@ when you run 'git-merge'.
 * The special construct '@\{-<n>\}' means the <n>th branch checked out
   before the current one.
 
+* A prefix '%', optionally followed by a branchname '<branch>', means the
+  branch tracked by '<branch>'. '<branch>' defaults to the current branch.
+
 * A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   'rev{caret}'
diff --git a/t/t1506-rev-parse-track.sh b/t/t1506-rev-parse-track.sh
new file mode 100755
index 0000000..1ca1dd6
--- /dev/null
+++ b/t/t1506-rev-parse-track.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='test % syntax'
+
+. ./test-lib.sh
+
+
+make_commit () {
+	echo "$1" > "$1" &&
+	git add "$1" &&
+	git commit -m "$1"
+}
+
+
+test_expect_success 'setup' '
+
+	make_commit 1 &&
+	git branch tracked &&
+	make_commit 2 &&
+	git checkout tracked &&
+	make_commit 3 &&
+	git checkout --track -b tracking tracked
+	make_commit 4 &&
+	git checkout master
+
+'
+
+# tracking tracks tracked
+# master does not track anything
+# all three point at different commits
+
+test_rev_equivalent () {
+
+	git rev-parse "$1" > expect &&
+	git rev-parse "$2" > output &&
+	test_cmp expect output
+
+}
+
+test_expect_success '%trackingbranch works' '
+	test_rev_equivalent tracked %tracking
+'
+
+test_expect_success '% works in tracking branch' '
+	git checkout tracking &&
+	test_rev_equivalent tracked %
+'
+
+test_expect_success '%nontrackingbranch fails' '
+	test_must_fail git rev-parse %tracked
+'
+
+test_expect_success '% fails in non-tracking branch' '
+	git checkout tracked &&
+	test_must_fail git rev-parse %
+'
+
+test_done
+
+
-- 
1.6.2.149.g6462
