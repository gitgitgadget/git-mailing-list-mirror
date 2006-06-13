From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/13] git-svn: --branch-all-refs / -B support
Date: Tue, 13 Jun 2006 11:02:04 -0700
Message-ID: <11502217381866-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:02:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDDb-0004ny-1W
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWFMSCU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWFMSCU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:20 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44229 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751108AbWFMSCT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:19 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 915417DC021;
	Tue, 13 Jun 2006 11:02:18 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:18 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21790>

This should make life easier for all those who type:

	`git-rev-parse --symbolic --all | xargs -n1 echo -b`

every time they run git-svn fetch.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 089d597..c91160d 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -34,12 +34,13 @@ my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_find_copies_harder, $_l, $_cp_similarity,
-	$_version, $_upgrade, $_authors);
+	$_version, $_upgrade, $_authors, $_branch_all_refs);
 my (@_branch_from, %tree_map, %users);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
 
 my %fc_opts = ( 'no-ignore-externals' => \$_no_ignore_ext,
 		'branch|b=s' => \@_branch_from,
+		'branch-all-refs|B' => \$_branch_all_refs,
 		'authors-file|A=s' => \$_authors );
 
 # yes, 'native' sets "\n".  Patches to fix this for non-*nix systems welcome:
@@ -108,6 +109,7 @@ usage(0) if $_help;
 version() if $_version;
 usage(1) unless defined $cmd;
 load_authors() if $_authors;
+load_all_refs() if $_branch_all_refs;
 svn_compat_check();
 $cmd{$cmd}->[0]->(@ARGV);
 exit 0;
@@ -1238,6 +1240,17 @@ sub map_tree_joins {
 	}
 }
 
+sub load_all_refs {
+	if (@_branch_from) {
+		print STDERR '--branch|-b parameters are ignored when ',
+			"--branch-all-refs|-B is passed\n";
+	}
+
+	# don't worry about rev-list on non-commit objects/tags,
+	# it shouldn't blow up if a ref is a blob or tree...
+	chomp(@_branch_from = `git-rev-parse --symbolic --all`);
+}
+
 # '<svn username> = real-name <email address>' mapping based on git-svnimport:
 sub load_authors {
 	open my $authors, '<', $_authors or die "Can't open $_authors $!\n";
-- 
1.4.0
