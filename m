From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: fix svn compat and fetch args
Date: Thu, 9 Mar 2006 03:48:47 -0800
Message-ID: <20060309114846.GA11934@localdomain>
References: <20060307220837.GB27397@nowhere.earth> <20060308014207.GA31137@localdomain> <20060308015730.GA28056@localdomain> <7vacc07wwp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 12:49:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHJeH-0001DW-92
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 12:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWCILti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 06:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWCILti
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 06:49:38 -0500
Received: from hand.yhbt.net ([66.150.188.102]:194 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751859AbWCILth (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 06:49:37 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 56C0E7DC005;
	Thu,  9 Mar 2006 03:49:35 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu,  9 Mar 2006 03:48:47 -0800
To: Junio C Hamano <junkio@cox.net>, Yann Dirson <ydirson@altern.org>
Content-Disposition: inline
In-Reply-To: <7vacc07wwp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17410>

'svn info' doesn't work with URLs in svn <= 1.1.  Now we
only run svn info in local directories.

As a side effect, this should also work better for 'init' off
directories that are no longer in the latest revision of the
repository.

svn checkout -r<revision> arguments are fixed.
Newer versions of svn (1.2.x) seem to need URL@REV as well as
-rREV to checkout a particular revision...

Add an example in the manpage of how to track directory that has
been moved since its initial revision.

A huge thanks to Yann Dirson for the bug reporting and testing
my original patch.  Thanks also to Junio C Hamano for suggesting
a safer way to use git-rev-parse.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

  Junio C Hamano <junkio@cox.net> wrote:
  > Eric Wong <normalperson@yhbt.net> writes:
  > 
  > > Junio: please don't apply this patch to git.git just yet.  It seems fine
  > > to me, but I haven't tested it heavily yet (Yann can help me, I hope :)
  > > I hardly slept the past few days and I may have broken something badly
  > > (it pasts all the tests, though).
  > 
  > I won't be applying it then.

  You can apply this one :)

  > I think this part is wrong.

  Cool, thanks for the example.

 contrib/git-svn/git-svn.perl |   63 ++++++++++++++++++++++++++++++------------
 contrib/git-svn/git-svn.txt  |   32 ++++++++++++++++++++-
 2 files changed, 75 insertions(+), 20 deletions(-)

1e07c915bbc3ff06967a85a71c0cbad82fa40cf6
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 3c860e4..dca4e5c 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -30,6 +30,7 @@ my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_find_copies_harder, $_l, $_version, $_upgrade, $_authors);
 my (@_branch_from, %tree_map, %users);
+my $_svn_co_url_revs;
 
 my %fc_opts = ( 'no-ignore-externals' => \$_no_ignore_ext,
 		'branch|b=s' => \@_branch_from,
@@ -77,7 +78,7 @@ usage(0) if $_help;
 version() if $_version;
 usage(1) unless defined $cmd;
 load_authors() if $_authors;
-svn_check_ignore_externals();
+svn_compat_check();
 $cmd{$cmd}->[0]->(@ARGV);
 exit 0;
 
@@ -162,7 +163,8 @@ sub rebuild {
 				croak "SVN repository location required: $url\n";
 			}
 			$SVN_URL ||= $url;
-			$SVN_UUID ||= setup_git_svn();
+			$SVN_UUID ||= $uuid;
+			setup_git_svn();
 			$latest = $rev;
 		}
 		assert_revision_eq_or_unknown($rev, $c);
@@ -171,9 +173,7 @@ sub rebuild {
 	}
 	close $rev_list or croak $?;
 	if (!chdir $SVN_WC) {
-		my @svn_co = ('svn','co',"-r$latest");
-		push @svn_co, '--ignore-externals' unless $_no_ignore_ext;
-		sys(@svn_co, $SVN_URL, $SVN_WC);
+		svn_cmd_checkout($SVN_URL, $latest, $SVN_WC);
 		chdir $SVN_WC or croak $!;
 	}
 
@@ -222,14 +222,14 @@ sub fetch {
 	my $base = shift @$svn_log or croak "No base revision!\n";
 	my $last_commit = undef;
 	unless (-d $SVN_WC) {
-		my @svn_co = ('svn','co',"-r$base->{revision}");
-		push @svn_co,'--ignore-externals' unless $_no_ignore_ext;
-		sys(@svn_co, $SVN_URL, $SVN_WC);
+		svn_cmd_checkout($SVN_URL,$base->{revision},$SVN_WC);
 		chdir $SVN_WC or croak $!;
+		read_uuid();
 		$last_commit = git_commit($base, @parents);
 		assert_svn_wc_clean($base->{revision}, $last_commit);
 	} else {
 		chdir $SVN_WC or croak $!;
+		read_uuid();
 		$last_commit = file_to_s("$REV_DIR/$base->{revision}");
 	}
 	my @svn_up = qw(svn up);
@@ -275,7 +275,9 @@ sub commit {
 
 	fetch();
 	chdir $SVN_WC or croak $!;
-	my $svn_current_rev =  svn_info('.')->{'Last Changed Rev'};
+	my $info = svn_info('.');
+	read_uuid($info);
+	my $svn_current_rev =  $info->{'Last Changed Rev'};
 	foreach my $c (@revs) {
 		my $mods = svn_checkout_tree($svn_current_rev, $c);
 		if (scalar @$mods == 0) {
@@ -314,6 +316,14 @@ sub show_ignore {
 
 ########################### utility functions #########################
 
+sub read_uuid {
+	return if $SVN_UUID;
+	my $info = shift || svn_info('.');
+	$SVN_UUID = $info->{'Repository UUID'} or
+					croak "Repository UUID unreadable\n";
+	s_to_file($SVN_UUID,"$GIT_DIR/$GIT_SVN/info/uuid");
+}
+
 sub setup_git_svn {
 	defined $SVN_URL or croak "SVN repository location required\n";
 	unless (-d $GIT_DIR) {
@@ -323,14 +333,10 @@ sub setup_git_svn {
 	mkpath(["$GIT_DIR/$GIT_SVN/info"]);
 	mkpath([$REV_DIR]);
 	s_to_file($SVN_URL,"$GIT_DIR/$GIT_SVN/info/url");
-	$SVN_UUID = svn_info($SVN_URL)->{'Repository UUID'} or
-					croak "Repository UUID unreadable\n";
-	s_to_file($SVN_UUID,"$GIT_DIR/$GIT_SVN/info/uuid");
 
 	open my $fd, '>>', "$GIT_DIR/$GIT_SVN/info/exclude" or croak $!;
 	print $fd '.svn',"\n";
 	close $fd or croak $!;
-	return $SVN_UUID;
 }
 
 sub assert_svn_wc_clean {
@@ -860,7 +866,6 @@ sub git_commit {
 	my ($log_msg, @parents) = @_;
 	assert_revision_unknown($log_msg->{revision});
 	my $out_fh = IO::File->new_tmpfile or croak $!;
-	$SVN_UUID ||= svn_info('.')->{'Repository UUID'};
 
 	map_tree_joins() if (@_branch_from && !%tree_map);
 
@@ -922,7 +927,16 @@ sub git_commit {
 	}
 	my @update_ref = ('git-update-ref',"refs/remotes/$GIT_SVN",$commit);
 	if (my $primary_parent = shift @exec_parents) {
-		push @update_ref, $primary_parent;
+		$pid = fork;
+		defined $pid or croak $!;
+		if (!$pid) {
+			close STDERR;
+			close STDOUT;
+			exec 'git-rev-parse','--verify',
+						"refs/remotes/$GIT_SVN^0";
+		}
+		waitpid $pid, 0;
+		push @update_ref, $primary_parent unless $?;
 	}
 	sys(@update_ref);
 	sys('git-update-ref',"$GIT_SVN/revs/$log_msg->{revision}",$commit);
@@ -995,13 +1009,26 @@ sub safe_qx {
 	return wantarray ? @ret : join('',@ret);
 }
 
-sub svn_check_ignore_externals {
-	return if $_no_ignore_ext;
-	unless (grep /ignore-externals/,(safe_qx(qw(svn co -h)))) {
+sub svn_compat_check {
+	my @co_help = safe_qx(qw(svn co -h));
+	unless (grep /ignore-externals/,@co_help) {
 		print STDERR "W: Installed svn version does not support ",
 				"--ignore-externals\n";
 		$_no_ignore_ext = 1;
 	}
+	if (grep /usage: checkout URL\[\@REV\]/,@co_help) {
+		$_svn_co_url_revs = 1;
+	}
+}
+
+# *sigh*, new versions of svn won't honor -r<rev> without URL@<rev>,
+# (and they won't honor URL@<rev> without -r<rev>, too!)
+sub svn_cmd_checkout {
+	my ($url, $rev, $dir) = @_;
+	my @cmd = ('svn','co', "-r$rev");
+	push @cmd, '--ignore-externals' unless $_no_ignore_ext;
+	$url .= "\@$rev" if $_svn_co_url_revs;
+	sys(@cmd, $url, $dir);
 }
 
 sub check_upgrade_needed {
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index 8e9a971..5fb5b7c 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -175,8 +175,8 @@ COMPATIBILITY OPTIONS
 	Do not use this flag unless you know exactly what you're getting
 	yourself into.  You have been warned.
 
-Examples
-~~~~~~~~
+Basic Examples
+~~~~~~~~~~~~~~
 
 Tracking and contributing to an Subversion managed-project:
 
@@ -234,6 +234,34 @@ This allows you to tie unfetched SVN rev
 
 	git-svn fetch 375=$(git-rev-parse HEAD)
 
+Advanced Example: Tracking a Reorganized Repository
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+If you're tracking a directory that has moved, or otherwise been
+branched or tagged off of another directory in the repository and you
+care about the full history of the project, then you can read this
+section.
+
+This is how Yann Dirson tracked the trunk of the ufoai directory when
+the /trunk directory of his repository was moved to /ufoai/trunk and
+he needed to continue tracking /ufoai/trunk where /trunk left off.
+
+	# This log message shows when the repository was reorganized::
+	r166 | ydirson | 2006-03-02 01:36:55 +0100 (Thu, 02 Mar 2006) | 1 line
+	Changed paths:
+	   D /trunk
+	   A /ufoai/trunk (from /trunk:165)
+
+	# First we start tracking the old revisions::
+	GIT_SVN_ID=git-oldsvn git-svn init \
+	      https://svn.sourceforge.net/svnroot/ufoai/trunk
+	GIT_SVN_ID=git-oldsvn git-svn fetch -r1:165
+
+	# And now, we continue tracking the new revisions::
+	GIT_SVN_ID=git-newsvn git-svn init \
+	      https://svn.sourceforge.net/svnroot/ufoai/ufoai/trunk
+	GIT_SVN_ID=git-newsvn git-svn fetch \
+	      166=`git-rev-parse refs/remotes/git-oldsvn`
+
 BUGS
 ----
 If somebody commits a conflicting changeset to SVN at a bad moment
-- 
1.2.4.ga2910
