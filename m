From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix broken symlink workaround when switching
	branches
Date: Wed, 11 Feb 2009 02:12:07 -0800
Message-ID: <20090211101207.GA28840@dcvr.yhbt.net>
References: <83dfc36c0902101438p7b7fbff8ja66b1fb021942cd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Anton Gyllenberg <anton@iki.fi>
X-From: git-owner@vger.kernel.org Wed Feb 11 11:13:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXC64-00014t-LW
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 11:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbZBKKML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 05:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbZBKKMJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 05:12:09 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43346 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbZBKKMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 05:12:08 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1DC1F798;
	Wed, 11 Feb 2009 10:12:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <83dfc36c0902101438p7b7fbff8ja66b1fb021942cd8@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109398>

Thanks to Anton Gyllenberg <anton@iki.fi> for the bug report
(and testcase in the following commit):
> Commit dbc6c74d0858d77e61e092a48d467e725211f8e9 "git-svn:
> handle empty files marked as symlinks in SVN" caused a
> regression in an unusual case where a branch has been created
> in SVN, later deleted and then created again from another
> branch point and the original branch point had empty files not
> in the new branch. In some cases git svn fetch will then fail
> while trying to fetch the empty file from the wrong SVN
> revision.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Thanks Anton, I've made the following patch along with your
 testcase and pushed to git://git.bogomips.org/git-svn

 Can you let me know if it works on a real repo (or breaks anything
 else)?  It's once again way past my bed time...

 git-svn.perl |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9baf822..001a1d8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2417,7 +2417,7 @@ sub find_parent_branch {
 			# is not included with SVN 1.4.3 (the latest version
 			# at the moment), so we can't rely on it
 			$self->{last_commit} = $parent;
-			$ed = SVN::Git::Fetcher->new($self);
+			$ed = SVN::Git::Fetcher->new($self, $gs->{path});
 			$gs->ra->gs_do_switch($r0, $rev, $gs,
 					      $self->full_url, $ed)
 			  or die "SVN connection failed somewhere...\n";
@@ -3258,12 +3258,13 @@ use vars qw/$_ignore_regex/;
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
 sub new {
-	my ($class, $git_svn) = @_;
+	my ($class, $git_svn, $switch_path) = @_;
 	my $self = SVN::Delta::Editor->new;
 	bless $self, $class;
 	if (exists $git_svn->{last_commit}) {
 		$self->{c} = $git_svn->{last_commit};
-		$self->{empty_symlinks} = _mark_empty_symlinks($git_svn);
+		$self->{empty_symlinks} =
+		                  _mark_empty_symlinks($git_svn, $switch_path);
 	}
 	$self->{empty} = {};
 	$self->{dir_prop} = {};
@@ -3278,7 +3279,7 @@ sub new {
 # not inside them (when the Git::SVN::Fetcher object is passed) to
 # do_{switch,update}
 sub _mark_empty_symlinks {
-	my ($git_svn) = @_;
+	my ($git_svn, $switch_path) = @_;
 	my $bool = Git::config_bool('svn.brokenSymlinkWorkaround');
 	return {} if (defined($bool) && ! $bool);
 
@@ -3294,7 +3295,7 @@ sub _mark_empty_symlinks {
 	chomp(my $empty_blob = `git hash-object -t blob --stdin < /dev/null`);
 	my ($ls, $ctx) = command_output_pipe(qw/ls-tree -r -z/, $cmt);
 	local $/ = "\0";
-	my $pfx = $git_svn->{path};
+	my $pfx = defined($switch_path) ? $switch_path : $git_svn->{path};
 	$pfx .= '/' if length($pfx);
 	while (<$ls>) {
 		chomp;
-- 
Eric Wong
