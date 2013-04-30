From: Ilya Basin <basinilya@gmail.com>
Subject: [PATCH 5/5] git-svn: fix empty dir tracking in branches
Date: Tue, 30 Apr 2013 21:38:14 +0400
Message-ID: <51800471.6905700a.65c8.00b9@mx.google.com>
Cc: Ray Chen <rchen@cs.umd.edu>, Eric Wong <normalperson@yhbt.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEhf-0004K2-My
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760881Ab3D3Ruu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:50:50 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:60117 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760855Ab3D3Ruo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:50:44 -0400
Received: by mail-la0-f45.google.com with SMTP id el20so676138lab.4
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:from:date:subject:to:cc;
        bh=5waD+QJrYE6w8c3ebfee0jbfNIyccLsUskfaLlws4IQ=;
        b=hVpoG0W3Nl0JsRPWtyq953WNQAriXxI7E+YDGgmrLn4zXL+d0hbs3UYMTW1YdfS/+M
         5INAVv6Nh/SMd4QcfZTyxBG7GVNgFYQW8KrHiG88wS4TFN/Sz5jIhPIHHg/WToeTUNt9
         pCss45/qt6RG1Q0JU6PCQm573VA0icuVTWtk7+6zaMWtrL07fMYkxcUtXjYXoOnJcbHe
         WlOS/+VhC0CrRouIpK5VDY7ckDxNATY8vExLhAb22lW6VSTWqdcI/nsbb/68bIBHsRog
         s6ekHgn8QhxPhKLD7DkH5qdoGxy7Aqm1Us3jYbyy1HMmIOKlXmZqtQNjZdWGbHG69LSt
         0BBQ==
X-Received: by 10.112.135.166 with SMTP id pt6mr10983624lbb.127.1367344242643;
        Tue, 30 Apr 2013 10:50:42 -0700 (PDT)
Received: from [192.168.0.78] ([178.71.111.32])
        by mx.google.com with ESMTPSA id r9sm18577lbr.3.2013.04.30.10.50.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 10:50:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222970>

  - When creating a tag or branch from a subdir, a disjoint branch is
    created. Then git-svn re-imports the commits using this dir as strip
    path.

    During this re-import the variable %added_placeholder is not up to
    date. Because the branch is disjoint, this variable should be empty
    in the beginning, but it's not. Because of that git-svn tries to
    delete non-existent .gitignore files and dies.

  - When creating a tag or branch from a subdir, the strip path is e.g.
    "trunk/module", but change_dir_prop() can be called with just
    "trunk". This breaks tracking of placeholder files, because it
    relise on the hash {dir_prop}, filled in change_dir_prop().

  - When creating a normal tag or branch, git-svn creates a normal
    branch without reimport, but the placeholder files in the new
    branch are not added to %added_placeholder.

This patch does 3 things:

  - It makes git-svn store paths in %added_placeholder already
    translated from "trunk/subdir/" to "tags/subdir_1.0/" during
    reimport.

  - When strip path is "trunk/subdir", don't add "trunk" to {dir_prop}
    in change_dir_prop().

  - When a normal branch is created, it takes entries in
    %added_placeholder belonging to the source branch, translates them
    to target branch and adds them to %added_placeholder.
---
 perl/Git/SVN.pm                        |  2 +
 perl/Git/SVN/Fetcher.pm                | 72 ++++++++++++++++++++++++++++++----
 t/t9160-git-svn-preserve-empty-dirs.sh | 51 ++++++++++++++++++++++--
 3 files changed, 114 insertions(+), 11 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 5273ee8..660921d 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1143,6 +1143,7 @@ sub find_parent_branch {
 		($r0, $parent) = $gs->find_rev_before($r, 1);
 	}
 	if (defined $r0 && defined $parent) {
+		Git::SVN::Fetcher::_end_reimport($self, $branch_from, $self->path);
 		print STDERR "Found branch parent: ($self->{ref_id}) $parent\n"
 		             unless $::_q > 1;
 		my $ed;
@@ -1395,6 +1396,7 @@ sub other_gs {
 			last if ($url eq $gs->metadata_url);
 			$ref_id .= '-';
 		}
+		Git::SVN::Fetcher::_begin_reimport($self->path);
 		print STDERR "Initializing parent: $ref_id\n" unless $::_q > 1;
 	}
 	$gs
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index a5ad4cd..aaf5d9a 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -1,6 +1,7 @@
 package Git::SVN::Fetcher;
 use vars qw/@ISA $_ignore_regex $_preserve_empty_dirs $_placeholder_filename
             $_package_inited
+            $_reimportpath
             @deleted_gpath %added_placeholder $repo_id/;
 use strict;
 use warnings;
@@ -162,13 +163,59 @@ sub git_path {
 		require Encode;
 		Encode::from_to($path, 'UTF-8', $enc);
 	}
-	if ($self->{path_strip}) {
-		$path =~ s!$self->{path_strip}!! or
-		  die "Failed to strip path '$path' ($self->{path_strip})\n";
+	_strip_path($path, $self->{path_strip})
+}
+
+sub _strip_path {
+	my ($path, $re_strip) = @_;
+	if ($re_strip) {
+		$path =~ s!$re_strip!! or
+		  die "Failed to strip path '$path' ($re_strip)\n";
 	}
 	$path;
 }
 
+sub _begin_reimport {
+	( $_reimportpath ) = @_;
+	undef
+}
+
+sub _end_reimport {
+	my ( $git_svn, $branch_from, $branch_to ) = @_;
+	_try_init_package($git_svn);
+	if (defined $_reimportpath) {
+		$_reimportpath = undef;
+	} else {
+		my $re_strip = qr/^\Q$branch_from\E(\/|$)/ if length $branch_from;
+		foreach (values %added_placeholder) {
+			my $path = $_;
+			if ( (!length $branch_from) || $path =~ s!$re_strip!! ) {
+				$path = $branch_to . (length $branch_to && length $path ? "/" : "") . $path;
+				$added_placeholder{ dirname($path) } = $path;
+			}
+		}
+	}
+	undef
+}
+
+sub svn2ph_path {
+	my ($self, $path) = @_;
+	if (defined $_reimportpath && defined $path) {
+		$path = _strip_path($path, $self->{path_strip});
+		$path = $_reimportpath . (length $_reimportpath && length $path ? "/" : "") . $path;
+	}
+	$path
+}
+
+sub ph2svn_path {
+	my ($self, $path) = @_;
+	if (defined $_reimportpath && defined $path) {
+		$path = _strip_path($path, qr/^\Q$_reimportpath\E(\/|$)/ ) if length $_reimportpath;
+		$path = $self->{pathprefix_strip} . $path; # if not empty, pathprefix_strip already ends with slash
+	}
+	$path
+}
+
 sub delete_entry {
 	my ($self, $path, $rev, $pb) = @_;
 	return undef if $self->is_path_ignored($path);
@@ -197,7 +244,8 @@ sub delete_entry {
 		print "\tD\t$gpath\n" unless $::_q;
 	}
 	# Don't add to @deleted_gpath if we're deleting a placeholder file.
-	push @deleted_gpath, $gpath unless $added_placeholder{dirname($path)};
+	my $phkey = $self->svn2ph_path(dirname($path));
+	push @deleted_gpath, $gpath unless $added_placeholder{$phkey};
 	$self->{empty}->{$path} = 0;
 	undef;
 }
@@ -231,10 +279,12 @@ sub add_file {
 		delete $self->{empty}->{$dir};
 		$mode = '100644';
 
+		$dir = $self->svn2ph_path($dir);
 		if ($added_placeholder{$dir}) {
 			# Remove our placeholder file, if we created one.
-			delete_entry($self, $added_placeholder{$dir})
-				unless $path eq $added_placeholder{$dir};
+			my $svnph = $self->ph2svn_path($added_placeholder{$dir});
+			delete_entry($self, $svnph)
+				unless $path eq $svnph;
 			delete $added_placeholder{$dir}
 		}
 	}
@@ -265,9 +315,11 @@ sub add_directory {
 	delete $self->{empty}->{$dir};
 	$self->{empty}->{$path} = 1;
 
+	$dir = $self->svn2ph_path($dir);
 	if ($added_placeholder{$dir}) {
 		# Remove our placeholder file, if we created one.
-		delete_entry($self, $added_placeholder{$dir});
+		my $svnph = $self->ph2svn_path($added_placeholder{$dir});
+		delete_entry($self, $svnph);
 		delete $added_placeholder{$dir}
 	}
 
@@ -278,6 +330,10 @@ out:
 sub change_dir_prop {
 	my ($self, $db, $prop, $value) = @_;
 	return undef if $self->is_path_ignored($db->{path});
+	if ($self->{path_strip}) {
+		$db->{path} =~ m!$self->{path_strip}! or
+			return undef;
+	}
 	$self->{dir_prop}->{$db->{path}} ||= {};
 	$self->{dir_prop}->{$db->{path}}->{$prop} = $value;
 	undef;
@@ -514,6 +570,8 @@ sub add_placeholder_file {
 	delete $self->{empty}->{$dir} if exists $self->{empty}->{$dir};
 
 	# Keep track of any placeholder files we create.
+	$dir = $self->svn2ph_path($dir);
+	$path = $self->svn2ph_path($path);
 	$added_placeholder{$dir} = $path;
 }
 
diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index ff06a86..4b0ba75 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -15,7 +15,7 @@ say 'define NO_SVN_TESTS to skip git svn tests'
 GIT_REPO=git-svn-repo
 
 test_expect_success 'initialize source svn repo containing empty dirs' '
-	svn_cmd mkdir -m x "$svnrepo"/trunk &&
+	svn_cmd mkdir -m x "$svnrepo"/trunk "$svnrepo"/tags &&
 	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
 	(
 		cd "$SVN_TREE" &&
@@ -23,8 +23,6 @@ test_expect_success 'initialize source svn repo containing empty dirs' '
 		echo x > module/foo/file.txt &&
 		svn_cmd add module &&
 		svn_cmd commit -mx &&
-		svn_cmd mv module/foo/file.txt module/bar/file.txt &&
-		svn_cmd commit -mx &&
 		mkdir -p 1 2 3/a 3/b 4 5 6 &&
 		echo "First non-empty file"  > 2/file1.txt &&
 		echo "Second non-empty file" > 2/file2.txt &&
@@ -50,12 +48,18 @@ test_expect_success 'initialize source svn repo containing empty dirs' '
 		svn_cmd del 3/b &&
 		svn_cmd commit -m "delete non-last entry in directory" &&
 
-		svn_cmd rm -m"x" "$svnrepo"/trunk/module &&
+		svn_cmd mv module/foo/file.txt module/bar/file.txt &&
+		svn_cmd commit -mx &&
+		svn_cmd cp "$svnrepo"/trunk "$svnrepo"/tags/v1.0 -m"create standard tag" &&
+		svn_cmd cp "$svnrepo"/trunk/module "$svnrepo"/tags/module_v1.0 -m"create non-standard tag" &&
+		svn_cmd rm -m"removed dir should not be recreated" "$svnrepo"/trunk/module &&
 
 		svn_cmd del 2/file1.txt &&
 		svn_cmd del 3/a &&
 		svn_cmd commit -m "delete last entry in directory" &&
 
+		svn_cmd mkdir "$svnrepo"/tags/v1.0/module/foo/baz "$svnrepo"/tags/module_v1.0/foo/baz -m"this commit should remove known .gitignore from tags" &&
+
 		echo "Conflict file" > 5/.placeholder &&
 		mkdir 6/.placeholder &&
 		svn_cmd add 5/.placeholder 6/.placeholder &&
@@ -104,6 +108,45 @@ test_expect_success 'remove non-last entry from directory' '
 	test_must_fail test -f "$GIT_REPO"/3/.gitignore
 '
 
+branchtests() {
+	branchname=$1
+	prefix=$2
+
+	test_expect_success "$branchname: "'existing placeholders are tracked when creating a branch' '
+		(
+			cd "$GIT_REPO" &&
+			git checkout "$branchname"
+		) &&
+		test -f "$GIT_REPO"/"$prefix"foo/baz/.gitignore &&
+		test_must_fail test -f "$GIT_REPO"/"$prefix"foo/.gitignore &&
+		test_must_fail test -f "$GIT_REPO"/"$prefix"bar/.gitignore
+	'
+
+	test_expect_success "$branchname: "'remove last entry from a directory' '
+		(
+			cd "$GIT_REPO" &&
+			git checkout HEAD~1
+		) &&
+		test -f "$GIT_REPO"/"$prefix"foo/.gitignore
+	'
+
+	test_expect_success "$branchname: "'add entry to previously empty directory' '
+		test_must_fail test -f "$GIT_REPO"/"$prefix"bar/.gitignore
+	'
+
+	# Skip 2 commits, one of them is empty commit of tag creation
+	test_expect_success "$branchname: "'create empty directory' '
+		(
+			cd "$GIT_REPO" &&
+			git checkout HEAD~2
+		) &&
+		test -f "$GIT_REPO"/"$prefix"bar/.gitignore
+	'
+}
+
+branchtests "tags/v1.0"        "module/"
+branchtests "tags/module_v1.0" ""
+
 # After re-cloning the repository with --placeholder-file specified, there
 # should be 5 files named ".placeholder" in the local Git repo.
 test_expect_success 'clone svn repo with --placeholder-file specified' '
-- 
1.8.1.5
