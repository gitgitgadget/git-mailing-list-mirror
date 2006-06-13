From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/13] git-svn: support -C<num> passing to git-diff-tree
Date: Tue, 13 Jun 2006 11:02:03 -0700
Message-ID: <11502217372898-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:02:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDDa-0004ny-FN
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWFMSCT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWFMSCT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:19 -0400
Received: from hand.yhbt.net ([66.150.188.102]:43461 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751102AbWFMSCS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:18 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 4D2F87DC020;
	Tue, 13 Jun 2006 11:02:17 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:17 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21789>

The repo-config key is 'svn.copysimilarity'

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 72129de..089d597 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -33,7 +33,8 @@ use POSIX qw/strftime/;
 my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
-	$_find_copies_harder, $_l, $_version, $_upgrade, $_authors);
+	$_find_copies_harder, $_l, $_cp_similarity,
+	$_version, $_upgrade, $_authors);
 my (@_branch_from, %tree_map, %users);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
 
@@ -55,6 +56,7 @@ my %cmd = (
 				'rmdir' => \$_rmdir,
 				'find-copies-harder' => \$_find_copies_harder,
 				'l=i' => \$_l,
+				'copy-similarity|C=i'=> \$_cp_similarity,
 				%fc_opts,
 			} ],
 	'show-ignore' => [ \&show_ignore, "Show svn:ignore listings", { } ],
@@ -580,7 +582,12 @@ sub svn_checkout_tree {
 	my $pid = open my $diff_fh, '-|';
 	defined $pid or croak $!;
 	if ($pid == 0) {
-		my @diff_tree = qw(git-diff-tree -z -r -C);
+		my @diff_tree = qw(git-diff-tree -z -r);
+		if ($_cp_similarity) {
+			push @diff_tree, "-C$_cp_similarity";
+		} else {
+			push @diff_tree, '-C';
+		}
 		push @diff_tree, '--find-copies-harder' if $_find_copies_harder;
 		push @diff_tree, "-l$_l" if defined $_l;
 		exec(@diff_tree, $from, $treeish) or croak $!;
-- 
1.4.0
