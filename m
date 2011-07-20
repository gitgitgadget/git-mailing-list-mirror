From: Ray Chen <rchen@cs.umd.edu>
Subject: [RFC/PATCH v3] git-svn: New flag to emulate empty directories
Date: Wed, 20 Jul 2011 18:37:26 -0400
Message-ID: <1311201446-26895-1-git-send-email-rchen@cs.umd.edu>
Cc: Eric Wong <normalperson@yhbt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ray Chen <rchen@cs.umd.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 21 00:37:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjfOr-0004D7-G6
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 00:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab1GTWhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 18:37:48 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34629 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab1GTWhq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 18:37:46 -0400
Received: by qwk3 with SMTP id 3so366465qwk.19
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 15:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=vKEPoY+6Y1hBr4tBEYumeIt6ifJgF1SWq+gkFT1mFWo=;
        b=U26vzxvzLY54GGgHpOzK+PMc9MZZylrJApBS8iJd6D7nqDRomHsjXM91N+fF9E12Ra
         /1nSKHwgxdwvuy66BhUWFg7MMPgACFZGdm+vXUW8dUFYsEEjrrlbtMbJOM2hsmZErwdk
         6ze2HUncBG1EBMi4DZNxZv1bFq4I7P8cNUSUM=
Received: by 10.229.90.132 with SMTP id i4mr7672677qcm.33.1311201465730;
        Wed, 20 Jul 2011 15:37:45 -0700 (PDT)
Received: from localhost.localdomain (c-76-21-241-143.hsd1.md.comcast.net [76.21.241.143])
        by mx.google.com with ESMTPS id d12sm442317qcd.14.2011.07.20.15.37.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jul 2011 15:37:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177558>

Adds a --preserve-empty-dirs flag to the clone operation that will detect
empty directories in the remote Subversion repository and create placeholder
files in the corresponding local Git directories.  This allows "empty"
directories to exist in the history of a Git repository.

Also adds the --placeholder-file flag to control the name of any placeholder
files created.  Default value is ".gitignore".

Signed-off-by: Ray Chen <rchen@cs.umd.edu>
---

This version of the patch allows --preserve-empty-dirs and --placeholder-file
to be specified for the clone operation.

These options are now "sticky," in that they store their values in the repo's
config file.  This allows proper operation of subsequent git-svn fetch and/or
rebase operations, effectively enabling read-only long-term tracking.  Any
placeholder files introduced by these flags are tracked and removed if/when
they become unnecessary.

Note that write operations to Subversion repositories with empty directories
remains problematic.  I believe the issue fundamentally stems from Git's lack
of empty directory support.

This patch applies cleanly to "master," and does not introduce any unexpected
failures in the testsuite.

Is anybody else willing to review this patch?  I'd feel better if we had more
than two sets of eyes look this over.

 Documentation/git-svn.txt              |   11 +++
 git-svn.perl                           |  148 ++++++++++++++++++++++++++++++-
 t/t9160-git-svn-preserve-empty-dirs.sh |  153 ++++++++++++++++++++++++++++++++
 3 files changed, 308 insertions(+), 4 deletions(-)
 create mode 100755 t/t9160-git-svn-preserve-empty-dirs.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 713e523..21822d1 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -156,6 +156,17 @@ Skip "branches" and "tags" of first level directories;;
 	affecting the working tree; and the 'rebase' command will be
 	able to update the working tree with the latest changes.
 
+--preserve-empty-dirs;;
+	Create a placeholder file in the local Git repository for each
+	empty directory fetched from Subversion.  This includes directories
+	that become empty by removing all entries in the Subversion
+	repository (but not the directory itself).  The placeholder files
+	are also tracked and removed when no longer necessary.
+
+--placeholder-filename=<filename>;;
+	Set the name of placeholder files created by --preserve-empty-dirs.
+	Default: ".gitignore"
+
 'rebase'::
 	This fetches revisions from the SVN parent of the current HEAD
 	and rebases the current (uncommitted to SVN) work against it.
diff --git a/git-svn.perl b/git-svn.perl
index 89f83fd..96f373f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -89,6 +89,7 @@ my ($_stdin, $_help, $_edit,
 	$_prefix, $_no_checkout, $_url, $_verbose,
 	$_git_format, $_commit_url, $_tag, $_merge_info);
 $Git::SVN::_follow_parent = 1;
+$SVN::Git::Fetcher::_placeholder_filename = ".gitignore";
 $_q ||= 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -139,6 +140,10 @@ my %cmd = (
 			   %fc_opts } ],
 	clone => [ \&cmd_clone, "Initialize and fetch revisions",
 			{ 'revision|r=s' => \$_revision,
+			  'preserve-empty-dirs' =>
+				\$SVN::Git::Fetcher::_preserve_empty_dirs,
+			  'placeholder-filename=s' =>
+				\$SVN::Git::Fetcher::_placeholder_filename,
 			   %fc_opts, %init_opts } ],
 	init => [ \&cmd_init, "Initialize a repo for tracking" .
 			  " (requires URL argument)",
@@ -386,6 +391,12 @@ sub do_git_init_db {
 	my $ignore_regex = \$SVN::Git::Fetcher::_ignore_regex;
 	command_noisy('config', "$pfx.ignore-paths", $$ignore_regex)
 		if defined $$ignore_regex;
+
+	if (defined $SVN::Git::Fetcher::_preserve_empty_dirs) {
+		my $fname = \$SVN::Git::Fetcher::_placeholder_filename;
+		command_noisy('config', "$pfx.preserve-empty-dirs", 'true');
+		command_noisy('config', "$pfx.placeholder-filename", $$fname);
+	}
 }
 
 sub init_subdir {
@@ -4080,12 +4091,13 @@ sub _read_password {
 }
 
 package SVN::Git::Fetcher;
-use vars qw/@ISA/;
+use vars qw/@ISA $_ignore_regex $_preserve_empty_dirs $_placeholder_filename
+            @deleted_gpath %added_placeholder $repo_id/;
 use strict;
 use warnings;
 use Carp qw/croak/;
+use File::Basename qw/dirname/;
 use IO::File qw//;
-use vars qw/$_ignore_regex/;
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
 sub new {
@@ -4097,8 +4109,34 @@ sub new {
 		$self->{empty_symlinks} =
 		                  _mark_empty_symlinks($git_svn, $switch_path);
 	}
-	$self->{ignore_regex} = eval { command_oneline('config', '--get',
-			     "svn-remote.$git_svn->{repo_id}.ignore-paths") };
+
+	# some options are read globally, but can be overridden locally
+	# per [svn-remote "..."] section.  Command-line options will *NOT*
+	# override options set in an [svn-remote "..."] section
+	$repo_id = $git_svn->{repo_id};
+	my $k = "svn-remote.$repo_id.ignore-paths";
+	my $v = eval { command_oneline('config', '--get', $k) };
+	$self->{ignore_regex} = $v;
+
+	$k = "svn-remote.$repo_id.preserve-empty-dirs";
+	$v = eval { command_oneline('config', '--get', '--bool', $k) };
+	if ($v && $v eq 'true') {
+		$_preserve_empty_dirs = 1;
+		$k = "svn-remote.$repo_id.placeholder-filename";
+		$v = eval { command_oneline('config', '--get', $k) };
+		$_placeholder_filename = $v;
+	}
+
+	# Load the list of placeholder files added during previous invocations.
+	$k = "svn-remote.$repo_id.added-placeholder";
+	$v = eval { command_oneline('config', '--get-all', $k) };
+	if ($_preserve_empty_dirs && $v) {
+		# command() prints errors to stderr, so we only call it if
+		# command_oneline() succeeded.
+		my @v = command('config', '--get-all', $k);
+		$added_placeholder{ dirname($_) } = $_ foreach @v;
+	}
+
 	$self->{empty} = {};
 	$self->{dir_prop} = {};
 	$self->{file_prop} = {};
@@ -4227,6 +4265,8 @@ sub delete_entry {
 		$self->{gii}->remove($gpath);
 		print "\tD\t$gpath\n" unless $::_q;
 	}
+	# Don't add to @deleted_gpath if we're deleting a placeholder file.
+	push @deleted_gpath, $gpath unless $added_placeholder{dirname($path)};
 	$self->{empty}->{$path} = 0;
 	undef;
 }
@@ -4259,7 +4299,15 @@ sub add_file {
 		my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
 		delete $self->{empty}->{$dir};
 		$mode = '100644';
+
+		if ($added_placeholder{$dir}) {
+			# Remove our placeholder file, if we created one.
+			delete_entry($self, $added_placeholder{$dir})
+				unless $path eq $added_placeholder{$dir};
+			delete $added_placeholder{$dir}
+		}
 	}
+
 	{ path => $path, mode_a => $mode, mode_b => $mode,
 	  pool => SVN::Pool->new, action => 'A' };
 }
@@ -4277,6 +4325,7 @@ sub add_directory {
 			chomp;
 			$self->{gii}->remove($_);
 			print "\tD\t$_\n" unless $::_q;
+			push @deleted_gpath, $gpath;
 		}
 		command_close_pipe($ls, $ctx);
 		$self->{empty}->{$path} = 0;
@@ -4284,6 +4333,13 @@ sub add_directory {
 	my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
 	delete $self->{empty}->{$dir};
 	$self->{empty}->{$path} = 1;
+
+	if ($added_placeholder{$dir}) {
+		# Remove our placeholder file, if we created one.
+		delete_entry($self, $added_placeholder{$dir});
+		delete $added_placeholder{$dir}
+	}
+
 out:
 	{ path => $path };
 }
@@ -4447,12 +4503,96 @@ sub abort_edit {
 
 sub close_edit {
 	my $self = shift;
+
+	if ($_preserve_empty_dirs) {
+		my @empty_dirs;
+
+		# Any entry flagged as empty that also has an associated
+		# dir_prop represents a newly created empty directory.
+		foreach my $i (keys %{$self->{empty}}) {
+			push @empty_dirs, $i if exists $self->{dir_prop}->{$i};
+		}
+
+		# Search for directories that have become empty due subsequent
+		# file deletes.
+		push @empty_dirs, $self->find_empty_directories();
+
+		# Finally, add a placeholder file to each empty directory.
+		$self->add_placeholder_file($_) foreach (@empty_dirs);
+
+		$self->stash_placeholder_list();
+	}
+
 	$self->{git_commit_ok} = 1;
 	$self->{nr} = $self->{gii}->{nr};
 	delete $self->{gii};
 	$self->SUPER::close_edit(@_);
 }
 
+sub find_empty_directories {
+	my ($self) = @_;
+	my @empty_dirs;
+	my %dirs = map { dirname($_) => 1 } @deleted_gpath;
+
+	foreach my $dir (sort keys %dirs) {
+		next if $dir eq ".";
+
+		# If there have been any additions to this directory, there is
+		# no reason to check if it is empty.
+		my $skip_added = 0;
+		foreach my $t (qw/dir_prop file_prop/) {
+			foreach my $path (keys %{ $self->{$t} }) {
+				if (exists $self->{$t}->{dirname($path)}) {
+					$skip_added = 1;
+					last;
+				}
+			}
+			last if $skip_added;
+		}
+		next if $skip_added;
+
+		# Use `git ls-tree` to get the filenames of this directory
+		# that existed prior to this particular commit.
+		my $ls = command('ls-tree', '-z', '--name-only',
+				 $self->{c}, "$dir/");
+		my %files = map { $_ => 1 } split(/\0/, $ls);
+
+		# Remove the filenames that were deleted during this commit.
+		delete $files{$_} foreach (@deleted_gpath);
+
+		# Report the directory if there are no filenames left.
+		push @empty_dirs, $dir unless (scalar %files);
+	}
+	@empty_dirs;
+}
+
+sub add_placeholder_file {
+	my ($self, $dir) = @_;
+	my $path = "$dir/$_placeholder_filename";
+	my $gpath = $self->git_path($path);
+
+	my $fh = $::_repository->temp_acquire($gpath);
+	my $hash = $::_repository->hash_and_insert_object(Git::temp_path($fh));
+	Git::temp_release($fh, 1);
+	$self->{gii}->update('100644', $hash, $gpath) or croak $!;
+
+	# The directory should no longer be considered empty.
+	delete $self->{empty}->{$dir} if exists $self->{empty}->{$dir};
+
+	# Keep track of any placeholder files we create.
+	$added_placeholder{$dir} = $path;
+}
+
+sub stash_placeholder_list {
+	my ($self) = @_;
+	my $k = "svn-remote.$repo_id.added-placeholder";
+	my $v = eval { command_oneline('config', '--get-all', $k) };
+	command_noisy('config', '--unset-all', $k) if $v;
+	foreach (values %added_placeholder) {
+		command_noisy('config', '--add', $k, $_);
+	}
+}
+
 package SVN::Git::Editor;
 use vars qw/@ISA $_rmdir $_cp_similarity $_find_copies_harder $_rename_limit/;
 use strict;
diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
new file mode 100755
index 0000000..b4a4434
--- /dev/null
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -0,0 +1,153 @@
+#!/bin/sh
+#
+# Copyright (c) 2011 Ray Chen
+#
+
+test_description='git svn test (option --preserve-empty-dirs)
+
+This test uses git to clone a Subversion repository that contains empty
+directories, and checks that corresponding directories are created in the
+local Git repository with placeholder files.'
+
+. ./lib-git-svn.sh
+
+say 'define NO_SVN_TESTS to skip git svn tests'
+GIT_REPO=git-svn-repo
+
+test_expect_success 'initialize source svn repo containing empty dirs' '
+	svn_cmd mkdir -m x "$svnrepo"/trunk &&
+	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
+	(
+		cd "$SVN_TREE" &&
+		mkdir -p 1 2 3/a 3/b 4 5 6 &&
+		echo "First non-empty file"  > 2/file1.txt &&
+		echo "Second non-empty file" > 2/file2.txt &&
+		echo "Third non-empty file"  > 3/a/file1.txt &&
+		echo "Fourth non-empty file" > 3/b/file1.txt &&
+		svn_cmd add 1 2 3 4 5 6 &&
+		svn_cmd commit -m "initial commit" &&
+
+		mkdir 4/a &&
+		svn_cmd add 4/a &&
+		svn_cmd commit -m "nested empty directory" &&
+		mkdir 4/a/b &&
+		svn_cmd add 4/a/b &&
+		svn_cmd commit -m "deeply nested empty directory" &&
+		mkdir 4/a/b/c &&
+		svn_cmd add 4/a/b/c &&
+		svn_cmd commit -m "really deeply nested empty directory" &&
+		echo "Kill the placeholder file" > 4/a/b/c/foo &&
+		svn_cmd add 4/a/b/c/foo &&
+		svn_cmd commit -m "Regular file to remove placeholder" &&
+
+		svn_cmd del 2/file2.txt &&
+		svn_cmd del 3/b &&
+		svn_cmd commit -m "delete non-last entry in directory" &&
+
+		svn_cmd del 2/file1.txt &&
+		svn_cmd del 3/a &&
+		svn_cmd commit -m "delete last entry in directory" &&
+
+		echo "Conflict file" > 5/.placeholder &&
+		mkdir 6/.placeholder &&
+		svn_cmd add 5/.placeholder 6/.placeholder &&
+		svn_cmd commit -m "Placeholder Namespace conflict"
+	) &&
+	rm -rf "$SVN_TREE"
+'
+
+test_expect_success 'clone svn repo with --preserve-empty-dirs' '
+	git svn clone "$svnrepo"/trunk --preserve-empty-dirs "$GIT_REPO"
+'
+
+# "$GIT_REPO"/1 should only contain the placeholder file.
+test_expect_success 'directory empty from inception' '
+	test -f "$GIT_REPO"/1/.gitignore &&
+	test $(find "$GIT_REPO"/1 -type f | wc -l) = "1"
+'
+
+# "$GIT_REPO"/2 and "$GIT_REPO"/3 should only contain the placeholder file.
+test_expect_success 'directory empty from subsequent svn commit' '
+	test -f "$GIT_REPO"/2/.gitignore &&
+	test $(find "$GIT_REPO"/2 -type f | wc -l) = "1" &&
+	test -f "$GIT_REPO"/3/.gitignore &&
+	test $(find "$GIT_REPO"/3 -type f | wc -l) = "1"
+'
+
+# No placeholder files should exist in "$GIT_REPO"/4, even though one was
+# generated for every sub-directory at some point in the repo's history.
+test_expect_success 'add entry to previously empty directory' '
+	test $(find "$GIT_REPO"/4 -type f | wc -l) = "1" &&
+	test -f "$GIT_REPO"/4/a/b/c/foo
+'
+
+# The HEAD~2 commit should not have introduced .gitignore placeholder files.
+test_expect_success 'remove non-last entry from directory' '
+	(
+		cd "$GIT_REPO" &&
+		git checkout HEAD~2
+	) &&
+	test_must_fail test -f "$GIT_REPO"/2/.gitignore &&
+	test_must_fail test -f "$GIT_REPO"/3/.gitignore
+'
+
+# After re-cloning the repository with --placeholder-file specified, there
+# should be 5 files named ".placeholder" in the local Git repo.
+test_expect_success 'clone svn repo with --placeholder-file specified' '
+	rm -rf "$GIT_REPO" &&
+	git svn clone "$svnrepo"/trunk --preserve-empty-dirs \
+		--placeholder-file=.placeholder "$GIT_REPO" &&
+	find "$GIT_REPO" -type f -name ".placeholder" &&
+	test $(find "$GIT_REPO" -type f -name ".placeholder" | wc -l) = "5"
+'
+
+# "$GIT_REPO"/5/.placeholder should be a file, and non-empty.
+test_expect_success 'placeholder namespace conflict with file' '
+	test -s "$GIT_REPO"/5/.placeholder
+'
+
+# "$GIT_REPO"/6/.placeholder should be a directory, and the "$GIT_REPO"/6 tree
+# should only contain one file: the placeholder.
+test_expect_success 'placeholder namespace conflict with directory' '
+	test -d "$GIT_REPO"/6/.placeholder &&
+	test -f "$GIT_REPO"/6/.placeholder/.placeholder &&
+	test $(find "$GIT_REPO"/6 -type f | wc -l) = "1"
+'
+
+# Prepare a second set of svn commits to test persistence during rebase.
+test_expect_success 'second set of svn commits and rebase' '
+	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
+	(
+		cd "$SVN_TREE" &&
+		mkdir -p 7 &&
+		echo "This should remove placeholder" > 1/file1.txt &&
+		echo "This should not remove placeholder" > 5/file1.txt &&
+		svn_cmd add 7 1/file1.txt 5/file1.txt &&
+		svn_cmd commit -m "subsequent svn commit for persistence tests"
+	) &&
+	rm -rf "$SVN_TREE" &&
+	(
+		cd "$GIT_REPO" &&
+		git svn rebase
+	)
+'
+
+# Check that --preserve-empty-dirs and --placeholder-file flag state
+# stays persistent over multiple invocations.
+test_expect_success 'flag persistence during subsqeuent rebase' '
+	test -f "$GIT_REPO"/7/.placeholder &&
+	test $(find "$GIT_REPO"/7 -type f | wc -l) = "1"
+'
+
+# Check that placeholder files are properly removed when unnecessary,
+# even across multiple invocations.
+test_expect_success 'placeholder list persistence during subsqeuent rebase' '
+	test -f "$GIT_REPO"/1/file1.txt &&
+	test $(find "$GIT_REPO"/1 -type f | wc -l) = "1" &&
+
+	test -f "$GIT_REPO"/5/file1.txt &&
+	test -f "$GIT_REPO"/5/.placeholder &&
+	test $(find "$GIT_REPO"/5 -type f | wc -l) = "2"
+'
+
+test_done
-- 
1.7.5.1
