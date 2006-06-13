From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 7/13] git-svn: add --repack and --repack-flags= options
Date: Tue, 13 Jun 2006 11:02:09 -0700
Message-ID: <1150221745225-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:03:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDEA-0004t6-K2
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWFMSCe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWFMSCd
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:33 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52165 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932150AbWFMSCb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:31 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3E8AB7DC022;
	Tue, 13 Jun 2006 11:02:25 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:25 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21800>

This should help keep disk usage sane for large imports.

--repack takes an optional argument for the interval, it
defaults to 1000 if no argument is specified.

Arguments to --repack-flags are passed directly to git-repack.
No arguments are passed by default.

Idea stolen from git-cvsimport :)

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index a243060..a04cf1d 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -34,6 +34,7 @@ my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_find_copies_harder, $_l, $_cp_similarity,
+	$_repack, $_repack_nr, $_repack_flags,
 	$_version, $_upgrade, $_authors, $_branch_all_refs);
 my (@_branch_from, %tree_map, %users);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
@@ -42,7 +43,9 @@ my @repo_path_split_cache;
 my %fc_opts = ( 'no-ignore-externals' => \$_no_ignore_ext,
 		'branch|b=s' => \@_branch_from,
 		'branch-all-refs|B' => \$_branch_all_refs,
-		'authors-file|A=s' => \$_authors );
+		'authors-file|A=s' => \$_authors,
+		'repack:i' => \$_repack,
+		'repack-flags|repack-args|repack-opts=s' => \$_repack_flags);
 
 # yes, 'native' sets "\n".  Patches to fix this for non-*nix systems welcome:
 my %EOL = ( CR => "\015", LF => "\012", CRLF => "\015\012", native => "\012" );
@@ -82,6 +85,7 @@ GetOptions(%opts, 'help|H|h' => \$_help,
 		'version|V' => \$_version,
 		'id|i=s' => \$GIT_SVN) or exit 1;
 
+set_default_vals();
 usage(0) if $_help;
 version() if $_version;
 usage(1) unless defined $cmd;
@@ -1120,6 +1124,10 @@ sub git_commit {
 	sys(@update_ref);
 	sys('git-update-ref',"svn/$GIT_SVN/revs/$log_msg->{revision}",$commit);
 	print "r$log_msg->{revision} = $commit\n";
+	if ($_repack && (--$_repack_nr == 0)) {
+		$_repack_nr = $_repack;
+		sys("git repack $_repack_flags");
+	}
 	return $commit;
 }
 
@@ -1362,6 +1370,14 @@ sub read_repo_config {
 	}
 }
 
+sub set_default_vals {
+	if (defined $_repack) {
+		$_repack = 1000 if ($_repack <= 0);
+		$_repack_nr = $_repack;
+		$_repack_flags ||= '';
+	}
+}
+
 __END__
 
 Data structures:
-- 
1.4.0
