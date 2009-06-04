From: Ben Jackson <ben@ben.com>
Subject: [PATCHv2 2/2] Add 'git svn reset' to unwind 'git svn fetch'
Date: Wed,  3 Jun 2009 20:45:52 -0700
Message-ID: <1244087152-17002-2-git-send-email-ben@ben.com>
References: <1244087152-17002-1-git-send-email-ben@ben.com>
Cc: gitster@pobox.com, normalperson@yhbt.net, Ben Jackson <ben@ben.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 05:46:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC3ua-0003TW-7H
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 05:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbZFDDqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 23:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbZFDDqX
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 23:46:23 -0400
Received: from kronos.home.ben.com ([71.117.242.19]:62732 "EHLO
	kronos.home.ben.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbZFDDqV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 23:46:21 -0400
Received: from kronos.home.ben.com (localhost [127.0.0.1])
	by kronos.home.ben.com (8.14.3/8.14.3) with ESMTP id n543kLcE017078;
	Wed, 3 Jun 2009 20:46:21 -0700 (PDT)
Received: (from bjj@localhost)
	by kronos.home.ben.com (8.14.3/8.14.3/Submit) id n543kLv9017077;
	Wed, 3 Jun 2009 20:46:21 -0700 (PDT)
	(envelope-from bjj)
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1244087152-17002-1-git-send-email-ben@ben.com>
X-Virus-Scanned: ClamAV 0.93.3/9418/Wed Jun  3 05:18:15 2009 on kronos.home.ben.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120677>

Add a command to unwind the effects of fetch by moving the rev_map
and refs/remotes/git-svn back to an old SVN revision.  This allows
revisions to be re-fetched.  Ideally SVN revs would be immutable,
but permissions changes in the SVN repository or indiscriminate use
of '--ignore-paths' can create situations where fetch cannot make
progress.

Signed-off-by: Ben Jackson <ben@ben.com>
---

Update ensures revision input is numeric.

On Wed, Jun 03, 2009 at 05:24:06PM -0700, Eric Wong wrote:
> Ben Jackson <ben@ben.com> wrote:
> > 3.  Without --parent it should probably fail for a nonexistent rev rather
> > than automatically find_rev_before..
>
> Probably best to ignore the --parent flag and just pass 1 as the second
> argument to find_rev_before.  That's how SVN operations work when a
> non-exact revision is specified..

That is how '-r' works.  Passing '1' to find_rev_before *skips* the
input rev.  The theory is that you may know that r1000 is "bad" and
so you use 'git svn reset -r1000 --parent' to discard r1000 (while
'reset -r1000' *keeps* r1000, analagous to 'git reset SHA').  You could
get the same effect with 'git svn reset -r999' (and internally that's
identical).  I looked for a SVN syntax to copy, eg '-r1000^' if it were
like GIT, but I didn't see one.  I know I am overloading --parent which
means something else for other git-svn commands, so I'm happy to remove
that if you don't like it.


 Documentation/git-svn.txt |   59 +++++++++++++++++++++++++++++++++++++++-
 git-svn.perl              |   45 +++++++++++++++++++++++++++---
 t/t9139-git-svn-reset.sh  |   66 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+), 6 deletions(-)
 create mode 100755 t/t9139-git-svn-reset.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ca3fc3d..e209145 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -215,7 +215,7 @@ config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
 The following features from `svn log' are supported:
 +
 --
---revision=<n>[:<n>];;
+-r/--revision=<n>[:<n>];;
 	is supported, non-numeric args are not:
 	HEAD, NEXT, BASE, PREV, etc ...
 -v/--verbose;;
@@ -313,6 +313,63 @@ Any other arguments are passed directly to 'git-log'
 	Shows the Subversion externals.  Use -r/--revision to specify a
 	specific revision.
 
+'reset'::
+	Undoes the effects of 'fetch' back to the specified revision.
+	This allows you to re-'fetch' an SVN revision.  Normally the
+	contents of an SVN revision should never change and 'reset'
+	should not be necessary.  However, if SVN permissions change,
+	or if you alter your --ignore-paths option, a 'fetch' may fail
+	with "not found in commit" (file not previously visible) or
+	"checksum mismatch" (missed a modification).  If the problem
+	file cannot be ignored forever (with --ignore-paths) the only
+	way to repair the repo is to use 'reset'.
+
+Only the rev_map and refs/remotes/git-svn are changed.  Follow 'reset'
+with a 'fetch' and then 'git-reset' or 'git-rebase' to move local
+branches onto the new tree.
+
+-r/--revision=<n>;;
+	Specify the most recent revision to keep.  All later revisions
+	are discarded.
+-p/--parent;;
+	Discard the specified revision as well, keeping the nearest
+	parent instead.
+Example:;;
+Assume you have local changes in "master", but you need to refetch "r2".
+
+------------
+    r1---r2---r3 remotes/git-svn
+                \
+                 A---B master
+------------
+
+Fix the ignore-paths or SVN permissions problem that caused "r2" to
+be incomplete in the first place.  Then:
+
+[verse]
+git svn reset -r2 -p
+git svn fetch
+
+------------
+    r1---r2'--r3' remotes/git-svn
+      \
+       r2---r3---A---B master
+------------
+
+Then fixup "master" with 'git-rebase'.
+Do NOT use 'git-merge' or your history will not be compatible with a
+future 'dcommit'!
+
+[verse]
+git rebase --onto remotes/git-svn A^ master
+
+------------
+    r1---r2'--r3' remotes/git-svn
+                \
+                 A'--B' master
+------------
+
+
 --
 
 OPTIONS
diff --git a/git-svn.perl b/git-svn.perl
index b77710c..dcbf397 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -211,6 +211,10 @@ my %cmd = (
 	'blame' => [ \&Git::SVN::Log::cmd_blame,
 	            "Show what revision and author last modified each line of a file",
 		    { 'git-format' => \$_git_format } ],
+	'reset' => [ \&cmd_reset,
+		     "Undo fetches back to the specified SVN revision",
+		     { 'revision|r=s' => \$_revision,
+		       'parent|p' => \$_fetch_parent } ],
 );
 
 my $cmd;
@@ -1024,6 +1028,20 @@ sub cmd_info {
 	print $result, "\n";
 }
 
+sub cmd_reset {
+	my $target = shift || $_revision or die "SVN revision required\n";
+	$target = $1 if $target =~ /^r(\d+)$/;
+	$target =~ /^\d+$/ or die "Numeric SVN revision expected\n";
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	unless ($gs) {
+		die "Unable to determine upstream SVN information from ".
+		    "history\n";
+	}
+	my ($r, $c) = $gs->find_rev_before($target, not $_fetch_parent);
+	$gs->rev_map_set($r, $c, 'reset', $uuid);
+	print "r$r = $c ($gs->{ref_id})\n";
+}
+
 ########################### utility functions #########################
 
 sub rebase_cmd {
@@ -2982,6 +3000,14 @@ sub _rev_map_set {
 	  croak "write: $!";
 }
 
+sub _rev_map_reset {
+	my ($fh, $rev, $commit) = @_;
+	my $c = _rev_map_get($fh, $rev);
+	$c eq $commit or die "_rev_map_reset(@_) commit $c does not match!\n";
+	my $offset = sysseek($fh, 0, SEEK_CUR) or croak "seek: $!";
+	truncate $fh, $offset or croak "truncate: $!";
+}
+
 sub mkfile {
 	my ($path) = @_;
 	unless (-e $path) {
@@ -2998,6 +3024,7 @@ sub rev_map_set {
 	my $db = $self->map_path($uuid);
 	my $db_lock = "$db.lock";
 	my $sig;
+	$update_ref ||= 0;
 	if ($update_ref) {
 		$SIG{INT} = $SIG{HUP} = $SIG{TERM} = $SIG{ALRM} = $SIG{PIPE} =
 		            $SIG{USR1} = $SIG{USR2} = sub { $sig = $_[0] };
@@ -3021,7 +3048,8 @@ sub rev_map_set {
 
 	sysopen(my $fh, $db_lock, O_RDWR | O_CREAT)
 	     or croak "Couldn't open $db_lock: $!\n";
-	_rev_map_set($fh, $rev, $commit);
+	$update_ref eq 'reset' ? _rev_map_reset($fh, $rev, $commit) :
+				 _rev_map_set($fh, $rev, $commit);
 	if ($sync) {
 		$fh->flush or die "Couldn't flush $db_lock: $!\n";
 		$fh->sync or die "Couldn't sync $db_lock: $!\n";
@@ -3029,7 +3057,9 @@ sub rev_map_set {
 	close $fh or croak $!;
 	if ($update_ref) {
 		$_head = $self;
-		command_noisy('update-ref', '-m', "r$rev",
+		my $note = "";
+		$note = " ($update_ref)" if ($update_ref !~ /^\d*$/);
+		command_noisy('update-ref', '-m', "r$rev$note",
 		              $self->refname, $commit);
 	}
 	rename $db_lock, $db or die "rev_map_set(@_): ", "Failed to rename: ",
@@ -3091,12 +3121,19 @@ sub rev_map_get {
 	return undef unless -e $map_path;
 
 	sysopen(my $fh, $map_path, O_RDONLY) or croak "open: $!";
+	my $c = _rev_map_get($fh, $rev);
+	close($fh) or croak "close: $!";
+	$c
+}
+
+sub _rev_map_get {
+	my ($fh, $rev) = @_;
+
 	binmode $fh or croak "binmode: $!";
 	my $size = (stat($fh))[7];
 	($size % 24) == 0 or croak "inconsistent size: $size";
 
 	if ($size == 0) {
-		close $fh or croak "close: $fh";
 		return undef;
 	}
 
@@ -3114,11 +3151,9 @@ sub rev_map_get {
 		} elsif ($r > $rev) {
 			$u = $i - 24;
 		} else { # $r == $rev
-			close($fh) or croak "close: $!";
 			return $c eq ('0' x 40) ? undef : $c;
 		}
 	}
-	close($fh) or croak "close: $!";
 	undef;
 }
 
diff --git a/t/t9139-git-svn-reset.sh b/t/t9139-git-svn-reset.sh
new file mode 100755
index 0000000..0735526
--- /dev/null
+++ b/t/t9139-git-svn-reset.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Ben Jackson
+#
+
+test_description='git svn reset'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup test repository' '
+	svn_cmd co "$svnrepo" s &&
+	(
+		cd s &&
+		mkdir vis &&
+		echo always visible > vis/vis.txt &&
+		svn_cmd add vis &&
+		svn_cmd commit -m "create visible files" &&
+		mkdir hid &&
+		echo initially hidden > hid/hid.txt &&
+		svn_cmd add hid &&
+		svn_cmd commit -m "create initially hidden files" &&
+		svn_cmd up &&
+		echo mod >> vis/vis.txt &&
+		svn_cmd commit -m "modify vis" &&
+		svn_cmd up
+	)
+'
+
+test_expect_success 'clone SVN repository with hidden directory' '
+	git svn init "$svnrepo" g &&
+	( cd g && git svn fetch --ignore-paths="^hid" )
+'
+
+test_expect_success 'modify hidden file in SVN repo' '
+	( cd s &&
+	  echo mod hidden >> hid/hid.txt &&
+	  svn_cmd commit -m "modify hid" &&
+	  svn_cmd up
+	)
+'
+
+test_expect_success 'fetch fails on modified hidden file' '
+	( cd g &&
+	  git svn find-rev refs/remotes/git-svn > ../expect &&
+	  ! git svn fetch 2> ../errors &&
+	  git svn find-rev refs/remotes/git-svn > ../expect2 ) &&
+	fgrep "not found in commit" errors &&
+	test_cmp expect expect2
+'
+
+test_expect_success 'reset unwinds back to r1' '
+	( cd g &&
+	  git svn reset -r1 &&
+	  git svn find-rev refs/remotes/git-svn > ../expect2 ) &&
+	echo 1 >expect &&
+	test_cmp expect expect2
+'
+
+test_expect_success 'refetch succeeds not ignoring any files' '
+	( cd g &&
+	  git svn fetch &&
+	  git svn rebase &&
+	  fgrep "mod hidden" hid/hid.txt
+	)
+'
+
+test_done
-- 
1.6.3.GIT
