From: Ray Chen <rchen@cs.umd.edu>
Subject: [PATCH v2] git-svn: New flag to emulate empty directories
Date: Thu, 26 May 2011 02:38:23 -0400
Message-ID: <1306391903-22092-1-git-send-email-rchen@cs.umd.edu>
Cc: Ray Chen <rchen@cs.umd.edu>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Wong <normalperson@yhbt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 18:32:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPdTd-00040z-Db
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 18:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601Ab1EZQb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 12:31:56 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51118 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab1EZQbz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 12:31:55 -0400
Received: by qyk7 with SMTP id 7so2820090qyk.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer;
        bh=QyzIPsHhw++OvyNWB+gFq+qXlbbUCf4MtEhPQEW269w=;
        b=xXb+CMq9miP5pgQ4ORz4FcANjSPm1m13Uwso4mE2Xf7dZL/aX487QHP3FsFIT/G0bf
         fZVyRbmcWhoKVX8SlfgM5MK0u17wGlz8Z8an9tInSNkQ5VuoZVi0TB53rE8OUhvWI871
         9IB9QLaGmikDW8biDIWfRdlTs1vMKUxNO5N8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=Bw6qxAkap6nLl6Tt8uR8RvHDeB4p/4lGREG+HZJmsxq238488PlGjmSKq7SYPFTb+Z
         9jqn1b/752GmLV568fOxPdW5Xjnq4FH4u7v3fqXFDaC63jDF0UzBV0X3UKbA1fjKcPfJ
         3hMt3HZHtuQYyBXzDUsFK5BfDCaM0TnO7OYUg=
Received: by 10.224.193.135 with SMTP id du7mr596701qab.213.1306427514562;
        Thu, 26 May 2011 09:31:54 -0700 (PDT)
Received: from dyninst2.cs.umd.edu (csnat-7.cs.umd.edu [128.8.127.167])
        by mx.google.com with ESMTPS id t28sm532701qcs.41.2011.05.26.09.31.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 09:31:54 -0700 (PDT)
Received: from dyninst2.cs.umd.edu (dyninst2.cs.umd.edu [127.0.0.1])
	by dyninst2.cs.umd.edu (8.14.4/8.14.4) with ESMTP id p4Q6cq4A022130;
	Thu, 26 May 2011 02:38:52 -0400
Received: (from rchen@localhost)
	by dyninst2.cs.umd.edu (8.14.4/8.14.4/Submit) id p4Q6cpKY022128;
	Thu, 26 May 2011 02:38:51 -0400
X-Mailer: git-send-email 1.7.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174545>

Adds the --preserve-empty-dirs flag to the clone operation that will
detect empty directories in the target Subversion repository and create
placeholder files in the corresponding local Git directories.  This allows
"empty" directories to exist in the history of a Git repository.

Also adds the --placeholder-file flag to control the name of any
placeholder files created.  Default value is ".gitignore".

Signed-off-by: Ray Chen <rchen@cs.umd.edu>
---

This version of the patch allows --preserve-empty-dirs and --placeholder-file
to be specified only during the clone operation.  This removes the ability to
use this feature for long-term tracking.

The main problem with the long-term tracking case occurs when all files are
deleted from a directory in a Subversion-based Git repository, and dcommitted
back to Subversion.  Currently, this causes the directory to be removed from
the local Git repo, but leaves an empty directory in the Subversion repo.

To correctly deal with this situation, dcommit would need to modify the local
commit object by re-adding a tree object that contains the placeholder file
object.  This would effectively be something like an automatic rebase/squash,
which I'm not sure is possible from the high-level git-svn.perl file.  Does
anybody know a way to do this?

(BUG REPORT: If somebody then commits a new file to the empty directory using
 Subversion, the next "git-svn fetch" will transfer the new file to the local
 Git repo, but it won't show up in the working directory.)

Additionally, placeholder files are now tracked and removed if they become
unnecessary.

Finally, this patch includes documentation and a test case.

 Documentation/git-svn.txt              |   11 +++
 git-svn.perl                           |   97 ++++++++++++++++++++++++++-
 t/t9159-git-svn-preserve-empty-dirs.sh |  117 ++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+), 2 deletions(-)
 create mode 100755 t/t9159-git-svn-preserve-empty-dirs.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 713e523..fbe4325 100644
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
+	are also removed when no longer necessary.
+
+--placeholder-filename=<filename>;;
+	Set the name of placeholder files created by --preserve-empty-dirs.
+	Default: ".gitignore"
+
 'rebase'::
 	This fetches revisions from the SVN parent of the current HEAD
 	and rebases the current (uncommitted to SVN) work against it.
diff --git a/git-svn.perl b/git-svn.perl
index 7849cfc..c658f30 100755
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
@@ -4076,12 +4081,13 @@ sub _read_password {
 }
 
 package SVN::Git::Fetcher;
-use vars qw/@ISA/;
+use vars qw/@ISA $_ignore_regex $_preserve_empty_dirs $_placeholder_filename
+            @deleted_gpath %added_placeholder/;
 use strict;
 use warnings;
 use Carp qw/croak/;
+use File::Basename qw/dirname/;
 use IO::File qw//;
-use vars qw/$_ignore_regex/;
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
 sub new {
@@ -4223,6 +4229,7 @@ sub delete_entry {
 		$self->{gii}->remove($gpath);
 		print "\tD\t$gpath\n" unless $::_q;
 	}
+	push @deleted_gpath, $gpath unless $added_placeholder{$gpath};
 	$self->{empty}->{$path} = 0;
 	undef;
 }
@@ -4255,7 +4262,14 @@ sub add_file {
 		my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
 		delete $self->{empty}->{$dir};
 		$mode = '100644';
+
+		if ($added_placeholder{$dir}) {
+			my $fn = "$dir/$_placeholder_filename";
+			delete_entry($self, $fn) unless $path eq $fn;
+			delete $added_placeholder{$dir}
+		}
 	}
+
 	{ path => $path, mode_a => $mode, mode_b => $mode,
 	  pool => SVN::Pool->new, action => 'A' };
 }
@@ -4273,6 +4287,7 @@ sub add_directory {
 			chomp;
 			$self->{gii}->remove($_);
 			print "\tD\t$_\n" unless $::_q;
+			push @deleted_gpath, $gpath;
 		}
 		command_close_pipe($ls, $ctx);
 		$self->{empty}->{$path} = 0;
@@ -4280,6 +4295,12 @@ sub add_directory {
 	my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
 	delete $self->{empty}->{$dir};
 	$self->{empty}->{$path} = 1;
+
+	if ($added_placeholder{$dir}) {
+		delete_entry($self, "$dir/$_placeholder_filename");
+		delete $added_placeholder{$dir}
+	}
+
 out:
 	{ path => $path };
 }
@@ -4443,12 +4464,84 @@ sub abort_edit {
 
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
+	$added_placeholder{$dir} = 1;
+}
+
 package SVN::Git::Editor;
 use vars qw/@ISA $_rmdir $_cp_similarity $_find_copies_harder $_rename_limit/;
 use strict;
diff --git a/t/t9159-git-svn-preserve-empty-dirs.sh b/t/t9159-git-svn-preserve-empty-dirs.sh
new file mode 100755
index 0000000..50cbf51
--- /dev/null
+++ b/t/t9159-git-svn-preserve-empty-dirs.sh
@@ -0,0 +1,117 @@
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
+	test `find "$GIT_REPO"/1 -type f | wc -l` = "1"
+'
+
+# "$GIT_REPO"/2 and "$GIT_REPO"/3 should only contain the placeholder file.
+test_expect_success 'directory empty from subsequent commit' '
+	test -f "$GIT_REPO"/2/.gitignore &&
+	test `find "$GIT_REPO"/2 -type f | wc -l` = "1" &&
+	test -f "$GIT_REPO"/3/.gitignore &&
+	test `find "$GIT_REPO"/3 -type f | wc -l` = "1"
+'
+
+# No placeholder files should exist in "$GIT_REPO"/4, even though one was
+# generated for every sub-directory at some point in the repo's history.
+test_expect_success 'add entry to previously empty directory' '
+	test `find "$GIT_REPO"/4 -type f | wc -l` = "1" &&
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
+	test `find "$GIT_REPO" -type f -name ".placeholder" | wc -l` = "5"
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
+	test `find "$GIT_REPO"/6 -type f | wc -l` = "1"
+'
+
+test_done
-- 
1.7.4.4
