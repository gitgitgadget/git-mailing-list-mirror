From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: allow rebuild to work on non-linear remote heads
Date: Mon, 20 Mar 2006 20:51:16 -0800
Message-ID: <20060321045116.GA20162@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Mar 21 05:51:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLYq0-0005Xu-QA
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 05:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWCUEvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 23:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWCUEvR
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 23:51:17 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34754 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030301AbWCUEvR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 23:51:17 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 76FCA2DC033; Mon, 20 Mar 2006 20:51:16 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17775>

Because committing back to an SVN repository from different
machines can result in different lineages, two different
repositories running git-svn can result in different commit
SHA1s (but of the same tree).  Sometimes trees that are tracked
independently are merged together (usually via children),
resulting in non-unique git-svn-id: lines in rev-list.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

85bed4cd937921844574fe66da95977fdeece993
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index cf233ef..f3fc3ec 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -850,11 +850,23 @@ sub assert_revision_unknown {
 	}
 }
 
+sub trees_eq {
+	my ($x, $y) = @_;
+	my @x = safe_qx('git-cat-file','commit',$x);
+	my @y = safe_qx('git-cat-file','commit',$y);
+	if (($y[0] ne $x[0]) || $x[0] !~ /^tree $sha1\n$/
+				|| $y[0] !~ /^tree $sha1\n$/) {
+		print STDERR "Trees not equal: $y[0] != $x[0]\n";
+		return 0
+	}
+	return 1;
+}
+
 sub assert_revision_eq_or_unknown {
 	my ($revno, $commit) = @_;
 	if (-f "$REV_DIR/$revno") {
 		my $current = file_to_s("$REV_DIR/$revno");
-		if ($commit ne $current) {
+		if (($commit ne $current) && !trees_eq($commit, $current)) {
 			croak "$REV_DIR/$revno already exists!\n",
 				"current: $current\nexpected: $commit\n";
 		}
-- 
1.2.4.gb622a
