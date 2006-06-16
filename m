From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/4] git-svn: rebuild convenience and bugfixes
Date: Fri, 16 Jun 2006 10:57:26 -0700
Message-ID: <11504806511326-git-send-email-normalperson@yhbt.net>
References: <11504049343825-git-send-email-normalperson@yhbt.net> <11504806463470-git-send-email-normalperson@yhbt.net> <11504806472857-git-send-email-normalperson@yhbt.net> <11504806481800-git-send-email-normalperson@yhbt.net> <11504806492195-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 16 19:57:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrIZi-0006lH-Th
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 19:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWFPR5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 13:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWFPR5e
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 13:57:34 -0400
Received: from hand.yhbt.net ([66.150.188.102]:13028 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751205AbWFPR5c (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 13:57:32 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 656B17DC020;
	Fri, 16 Jun 2006 10:57:31 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 16 Jun 2006 10:57:31 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11504806492195-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21957>

We will now automatically fetch the refs/remotes/git-svn ref
from origin and store a Pull: line for it.

--remote=<origin> may be passed if your remote is named something
other than 'origin'

Also, remember to make GIT_SVN_DIR whenever we need to create
.rev_db

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index ab1d065..da0ff9a 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -42,7 +42,7 @@ my $_optimize_commits = 1 unless $ENV{GI
 my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
-	$_find_copies_harder, $_l, $_cp_similarity,
+	$_find_copies_harder, $_l, $_cp_similarity, $_cp_remote,
 	$_repack, $_repack_nr, $_repack_flags,
 	$_template, $_shared, $_no_default_regex, $_no_graft_copy,
 	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
@@ -86,6 +86,7 @@ my %cmd = (
 			{ 'revision|r=i' => \$_revision } ],
 	rebuild => [ \&rebuild, "Rebuild git-svn metadata (after git clone)",
 			{ 'no-ignore-externals' => \$_no_ignore_ext,
+			  'copy-remote|remote=s' => \$_cp_remote,
 			  'upgrade' => \$_upgrade } ],
 	'graft-branches' => [ \&graft_branches,
 			'Detect merges/branches from already imported history',
@@ -134,7 +135,7 @@ init_vars();
 load_authors() if $_authors;
 load_all_refs() if $_branch_all_refs;
 svn_compat_check();
-migration_check() unless $cmd =~ /^(?:init|multi-init)$/;
+migration_check() unless $cmd =~ /^(?:init|rebuild|multi-init)$/;
 $cmd{$cmd}->[0]->(@ARGV);
 exit 0;
 
@@ -174,6 +175,9 @@ sub version {
 }
 
 sub rebuild {
+	if (quiet_run(qw/git-rev-parse --verify/,"refs/remotes/$GIT_SVN^0")) {
+		copy_remote_ref();
+	}
 	$SVN_URL = shift or undef;
 	my $newest_rev = 0;
 	if ($_upgrade) {
@@ -1940,6 +1944,7 @@ sub svn_cmd_checkout {
 
 sub check_upgrade_needed {
 	if (!-r $REVDB) {
+		-d $GIT_SVN_DIR or mkpath([$GIT_SVN_DIR]);
 		open my $fh, '>>',$REVDB or croak $!;
 		close $fh;
 	}
@@ -2052,6 +2057,7 @@ sub migrate_revdb {
 			init_vars();
 			exit 0 if -r $REVDB;
 			print "Upgrading svn => git mapping...\n";
+			-d $GIT_SVN_DIR or mkpath([$GIT_SVN_DIR]);
 			open my $fh, '>>',$REVDB or croak $!;
 			close $fh;
 			rebuild();
@@ -2763,6 +2769,17 @@ sub revdb_get {
 	return $ret;
 }
 
+sub copy_remote_ref {
+	my $origin = $_cp_remote ? $_cp_remote : 'origin';
+	my $ref = "refs/remotes/$GIT_SVN";
+	if (safe_qx('git-ls-remote', $origin, $ref)) {
+		sys(qw/git fetch/, $origin, "$ref:$ref");
+	} else {
+		die "Unable to find remote reference: ",
+				"refs/remotes/$GIT_SVN on $origin\n";
+	}
+}
+
 package SVN::Git::Editor;
 use vars qw/@ISA/;
 use strict;
-- 
1.4.0
