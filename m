From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v2 1/2] Fix multi-glob assertion in git-svn
Date: Thu,  7 Aug 2008 11:34:01 -0400
Message-ID: <1218123242-26260-2-git-send-email-marcus@griep.us>
References: <20080807090008.GA9161@untitled>
 <1218123242-26260-1-git-send-email-marcus@griep.us>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 17:46:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR7h7-0007v2-37
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 17:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbYHGPp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 11:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352AbYHGPp0
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 11:45:26 -0400
Received: from boohaunt.net ([209.40.206.144]:46971 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108AbYHGPpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 11:45:24 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 2126C1878CF3; Thu,  7 Aug 2008 11:34:02 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.4.g39f8
In-Reply-To: <1218123242-26260-1-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91587>

Fixes bad regex match check for multiple globs (would always return
one glob regardless of actual number).

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 git-svn.perl            |    5 +++--
 t/t9108-git-svn-glob.sh |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index df0ed90..5974a06 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4912,14 +4912,15 @@ sub new {
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
index f6f71d0..ef6d88e 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -83,4 +83,23 @@ test_expect_success 'test left-hand-side only globbing' '
 	cmp expect.two output.two
 	'
 
+echo "Only one '*' wildcard expansion is supported (got 2): 'branches/*/*'" > expect.three
+echo "" >> expect.three
+
+test_expect_success 'test disallow multi-globs' '
+	git config --add svn-remote.three.url "$svnrepo" &&
+	git config --add svn-remote.three.fetch trunk:refs/remotes/three/trunk &&
+	git config --add svn-remote.three.branches \
+	                 "branches/*/*:refs/remotes/three/branches/*" &&
+	git config --add svn-remote.three.tags \
+	                 "tags/*/*:refs/remotes/three/tags/*" &&
+	cd tmp &&
+		echo "try try" >> tags/end/src/b/readme &&
+		poke tags/end/src/b/readme &&
+		svn commit -m "try to try"
+		cd .. &&
+	test_must_fail git-svn fetch three &> stderr.three &&
+	cmp expect.three stderr.three
+	'
+
 test_done
-- 
1.6.0.rc2.4.g39f8
