From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: add ability to specify --commit-url for dcommit
Date: Thu, 7 Aug 2008 02:06:16 -0700
Message-ID: <20080807090616.GA9335@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 14:27:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR4az-00074H-N8
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 14:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbYHGMYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 08:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbYHGMYJ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 08:24:09 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55315 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbYHGMYG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 08:24:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 3B28D2DC032;
	Thu,  7 Aug 2008 02:06:16 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91571>

This allows one to use public svn:// URLs for fetch and
svn+ssh:// URLs for committing (without using the complicated
rewriteRoot option, reimporting or git-filter-branch).

Using this can also help avoid unnecessary server
authentication/encryption overhead on busy SVN servers.

Along with the new --revision option, this can also be allowed
to override the branch detection in dcommit, too.  This is
potentially dangerous and not recommended!  (And also purposely
undocumented, but the loaded gun is there in case somebody
wants to make it safe).

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |    9 +++++++++
 git-svn.perl              |    9 ++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 773ae96..1e644ca 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -138,6 +138,15 @@ and have no uncommitted changes.
 +
 --no-rebase;;
 	After committing, do not rebase or reset.
+--commit-url <URL>;;
+	Commit to this SVN URL (the full path).  This is intended to
+	allow existing git-svn repositories created with one transport
+	method (e.g. `svn://` or `http://` for anonymous read) to be
+	reused if a user is later given access to an alternate transport
+	method (e.g. `svn+ssh://` or `https://`) for commit.
+
+	Using this option for any other purpose (don't ask)
+	is very strongly discouraged.
 --
 
 'log'::
diff --git a/git-svn.perl b/git-svn.perl
index df0ed90..06a82c8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -66,7 +66,7 @@ my ($_stdin, $_help, $_edit,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_git_format);
+	$_git_format, $_commit_url);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -127,6 +127,8 @@ my %cmd = (
 			  'verbose|v' => \$_verbose,
 			  'dry-run|n' => \$_dry_run,
 			  'fetch-all|all' => \$_fetch_all,
+			  'commit-url=s' => \$_commit_url,
+			  'revision|r=i' => \$_revision,
 			  'no-rebase' => \$_no_rebase,
 			%cmt_opts, %fc_opts } ],
 	'set-tree' => [ \&cmd_set_tree,
@@ -416,6 +418,8 @@ sub cmd_dcommit {
 	$head ||= 'HEAD';
 	my @refs;
 	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
+	$url = $_commit_url if defined $_commit_url;
+	my $last_rev = $_revision if defined $_revision;
 	if ($url) {
 		print "Committing to $url ...\n";
 	}
@@ -423,7 +427,6 @@ sub cmd_dcommit {
 		die "Unable to determine upstream SVN information from ",
 		    "$head history.\nPerhaps the repository is empty.";
 	}
-	my $last_rev;
 	my ($linear_refs, $parents) = linearize_history($gs, \@refs);
 	if ($_no_rebase && scalar(@$linear_refs) > 1) {
 		warn "Attempting to commit more than one change while ",
@@ -446,7 +449,7 @@ sub cmd_dcommit {
 			my $cmt_rev;
 			my %ed_opts = ( r => $last_rev,
 			                log => get_commit_entry($d)->{log},
-			                ra => Git::SVN::Ra->new($gs->full_url),
+			                ra => Git::SVN::Ra->new($url),
 			                config => SVN::Core::config_get_config(
 			                        $Git::SVN::Ra::config_dir
 			                ),
-- 
Eric Wong
