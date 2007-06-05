From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-svn: allow to specify svn branch for commands
Date: Tue, 05 Jun 2007 16:23:34 +1200
Message-ID: <4664E546.5060304@vilain.net>
References: <1181014957993-git-send-email-sam.vilain@catalyst.net.nz> <20070605041446.GA4266@untitled>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Git Central <git@vger.kernel.org>, stephen@touset.org,
	Jonathan Rockway <jon@jrock.us>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 06:28:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvQer-0001pz-Nz
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 06:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbXFEE2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 00:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbXFEE2a
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 00:28:30 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:54851 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbXFEE23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 00:28:29 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1HvQed-0000ty-Tw; Tue, 05 Jun 2007 16:28:23 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id D515ECB9E8; Tue,  5 Jun 2007 16:28:23 +1200 (NZST)
In-Reply-To: <20070605041446.GA4266@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49156>

Eric Wong wrote:
> Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
>> "git-svn dcommit" ends up making an arbitrary decision when pushing
>> back merges.  Allow the user to specify which one is used, albeit in a
>> rather hack-ish way.
> 
> Frightening...  Perhaps we should echo the final URL out
> to the user and prompt them for confirmation.

Actually in between sending this to the list, I figured that it should
be possible to detect when this is happening, at the expense of an extra
"git-log" command.  Basically, take the first revision you found a
commitlog entry in, and then do a log from the indicated head excluding
that commit.  If you find more valid tips then the user is merging in
gitspace.

Of course ideally you want to make sure that merge commits posted back
are shipped with all of the necessary tokens for the various SVN-land
tools out there.  eg, svk:merge, svnmerge, and whatever kooky system the
SVN dev team come up with.  But that's a separate issue.

The original patch had a fairly dire bug, so here's a version that at
least doesn't break the test suite.

Subject: [PATCH] git-svn: allow to specify svn branch for commands

"git-svn dcommit" ends up making an arbitrary decision when pushing
back merges.  Allow the user to specify which one is used, albeit in a
rather hack-ish way.
---

 Documentation/git-svn.txt |   11 +++++++++++
 git-svn.perl              |   17 ++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index c0d7d95..3e64522 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -69,6 +69,17 @@ COMMANDS
 	argument if that is what you want.  This is useful if
 	you wish to track multiple projects that share a common
 	repository.
+-B<svn_branch>;;
+--branch=<svn_branch>;;
+	Normally, git-svn is capable of figuring out which branch you
+	are working on.  However, if you are doing merges between svn
+	branches using git then the decision about which branch to
+	dcommit to will end up being made based on which of the
+	branches you are merging has the newest upstream commit.  This
+	option enables a global filter that tells git-svn what to look
+	for in the git-svn-id: line - specify a repository UUID or a
+	branch name here.  So, it may be used with "git-svn log",
+	"git-svn dcommit", etc.
 
 'fetch'::
 	Fetch unfetched revisions from the Subversion remote we are
diff --git a/git-svn.perl b/git-svn.perl
index e350061..906aa4b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -54,7 +54,7 @@ $sha1 = qr/[a-f\d]{40}/;
 $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_stdin, $_help, $_edit,
 	$_message, $_file,
-	$_template, $_shared,
+	$_template, $_shared, $_branch,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_verbose);
@@ -69,6 +69,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'useSvmProps' => \$Git::SVN::_use_svm_props,
 		'useSvnsyncProps' => \$Git::SVN::_use_svnsync_props,
 		'log-window-size=i' => \$Git::SVN::Ra::_log_window_size,
+		'branch|B=s' => \$_branch,
 		'no-checkout' => \$_no_checkout,
 		'quiet|q' => \$_q,
 		'repack-flags|repack-args|repack-opts=s' =>
@@ -367,7 +368,7 @@ sub cmd_dcommit {
 	my $head = shift;
 	$head ||= 'HEAD';
 	my @refs;
-	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
+	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs, $_branch);
 	unless ($gs) {
 		die "Unable to determine upstream SVN information from ",
 		    "$head history\n";
@@ -441,7 +442,7 @@ sub cmd_find_rev {
 		my $head = shift;
 		$head ||= 'HEAD';
 		my @refs;
-		my (undef, undef, undef, $gs) = working_head_info($head, \@refs);
+		my (undef, undef, undef, $gs) = working_head_info($head, \@refs, $_branch);
 		unless ($gs) {
 			die "Unable to determine upstream SVN information from ",
 			    "$head history\n";
@@ -457,7 +458,7 @@ sub cmd_find_rev {
 
 sub cmd_rebase {
 	command_noisy(qw/update-index --refresh/);
-	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD', undef, $_branch);
 	unless ($gs) {
 		die "Unable to determine upstream SVN information from ",
 		    "working tree history\n";
@@ -474,7 +475,7 @@ sub cmd_rebase {
 }
 
 sub cmd_show_ignore {
-	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD', undef, $_branch);
 	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
 	$gs->traverse_ignore(\*STDOUT, $gs->{path}, $r);
@@ -801,12 +802,14 @@ sub cmt_metadata {
 }
 
 sub working_head_info {
-	my ($head, $refs) = @_;
+	my ($head, $refs, $grep) = @_;
 	my ($fh, $ctx) = command_output_pipe('rev-list', $head);
 	while (my $hash = <$fh>) {
 		chomp($hash);
 		my ($url, $rev, $uuid) = cmt_metadata($hash);
 		if (defined $url && defined $rev) {
+			next unless (!$grep or
+				$url =~ m{$grep} or $uuid =~ m{$grep});
 			if (my $gs = Git::SVN->find_by_url($url)) {
 				my $c = $gs->rev_db_get($rev);
 				if ($c && $c eq $hash) {
@@ -3394,7 +3397,7 @@ sub git_svn_log_cmd {
 		last;
 	}
 
-	my ($url, $rev, $uuid, $gs) = ::working_head_info($head);
+	my ($url, $rev, $uuid, $gs) = ::working_head_info($head, undef, $_branch);
 	$gs ||= Git::SVN->_new;
 	my @cmd = (qw/log --abbrev-commit --pretty=raw --default/,
 	           $gs->refname);
-- 
1.5.2.0.45.gfea6d-dirty
