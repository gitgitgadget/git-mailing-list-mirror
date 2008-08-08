From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/3] Fix multi-glob assertion in git-svn
Date: Fri,  8 Aug 2008 01:41:56 -0700
Message-ID: <1218184918-9135-1-git-send-email-normalperson@yhbt.net>
References: <20080808084025.GA8718@untitled>
Cc: git@vger.kernel.org, Marcus Griep <marcus@griep.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 10:43:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRNZB-0001Rm-IQ
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 10:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342AbYHHImA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 04:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbYHHImA
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 04:42:00 -0400
Received: from hand.yhbt.net ([66.150.188.102]:56517 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214AbYHHIl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 04:41:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BD19E2DC01B;
	Fri,  8 Aug 2008 01:41:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.4.g0643f
In-Reply-To: <20080808084025.GA8718@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91636>

From: Marcus Griep <marcus@griep.us>

Fixes bad regex match check for multiple globs (would always return
one glob regardless of actual number).

[ew: fixed a bashism in the test and some minor line-wrapping]

Signed-off-by: Marcus Griep <marcus@griep.us>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl            |    5 +++--
 t/t9108-git-svn-glob.sh |   21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 06a82c8..503a7c9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4915,14 +4915,15 @@ sub new {
 	my ($class, $glob) = @_;
 	my $re = $glob;
 	$re =~ s!/+$!!g; # no need for trailing slashes
-	my $nr = ($re =~ s!^(.*)\*(.*)$!\(\[^/\]+\)!g);
-	my ($left, $right) = ($1, $2);
+	my $nr = $re =~ tr/*/*/;
 	if ($nr > 1) {
 		die "Only one '*' wildcard expansion ",
 		    "is supported (got $nr): '$glob'\n";
 	} elsif ($nr == 0) {
 		die "One '*' is needed for glob: '$glob'\n";
 	}
+	$re =~ s!^(.*)\*(.*)$!\(\[^/\]+\)!g;
+	my ($left, $right) = ($1, $2);
 	$re = quotemeta($left) . $re . quotemeta($right);
 	if (length $left && !($left =~ s!/+$!!g)) {
 		die "Missing trailing '/' on left side of: '$glob' ($left)\n";
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index f6f71d0..a6f88bd 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -83,4 +83,25 @@ test_expect_success 'test left-hand-side only globbing' '
 	cmp expect.two output.two
 	'
 
+echo "Only one '*' wildcard expansion is supported (got 2): 'branches/*/*'" \
+     > expect.three
+echo "" >> expect.three
+
+test_expect_success 'test disallow multi-globs' '
+	git config --add svn-remote.three.url "$svnrepo" &&
+	git config --add svn-remote.three.fetch \
+	                 trunk:refs/remotes/three/trunk &&
+	git config --add svn-remote.three.branches \
+	                 "branches/*/*:refs/remotes/three/branches/*" &&
+	git config --add svn-remote.three.tags \
+	                 "tags/*/*:refs/remotes/three/tags/*" &&
+	cd tmp &&
+		echo "try try" >> tags/end/src/b/readme &&
+		poke tags/end/src/b/readme &&
+		svn commit -m "try to try"
+		cd .. &&
+	test_must_fail git-svn fetch three 2> stderr.three &&
+	cmp expect.three stderr.three
+	'
+
 test_done
-- 
1.6.0.rc2.4.g0643f
