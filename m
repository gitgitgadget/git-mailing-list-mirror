From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: File was not found in commit
Date: Sun, 18 Jan 2009 18:41:30 -0800
Message-ID: <20090119024130.GA23823@dcvr.yhbt.net>
References: <49678705.4040506@mog.se> <20090111215526.GA15533@atjola.homenet> <496A890C.8080208@mog.se> <20090112023211.GA21462@dcvr.yhbt.net> <20090112051409.GB14992@dcvr.yhbt.net> <496B497F.30109@mog.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Morgan Christiansson <git@mog.se>
X-From: git-owner@vger.kernel.org Mon Jan 19 03:43:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOk6O-0004cN-Ed
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 03:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757210AbZASCld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 21:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757184AbZASClc
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 21:41:32 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:44227 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756748AbZASClb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 21:41:31 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF68D1F5D0;
	Mon, 19 Jan 2009 02:41:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <496B497F.30109@mog.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106306>

Morgan Christiansson <git@mog.se> wrote:
> Eric Wong wrote:
>> Eric Wong <normalperson@yhbt.net> wrote:
>>   
>>> Morgan Christiansson <git@mog.se> wrote:
>>>     
>>>> The "Ignoring path" message appears to be coming from git which is  
>>>> refusing to commit the .git directory. Which leads to git-svn being 
>>>>  unaware of the files being ignored and giving an error when it 
>>>> can't  find them.
>>>>       I'm personally fine with these files being ignored by git, 
>>>> but git-svn  needs to be aware that they are not added to the 
>>>> repository.
>>>>       
>>> Hi Morgan,
>>> Can you try the following rough patch and see it it fixes things
>>> for you?  Thanks!
>>>     
>>
>> Actually, I think this patch is broken (my quickly put together test
>> case was insufficient)...
>>   
>
> Yes it was. apply_textdelta() is never called for my repo so it has no  
> effect.
>
> I've attached an updated and simplified version of the testcase you sent  
> that correctly triggers the bug i reported.
>
> I'm not a native perl coder though so I don't think I would be able to  
> provide a clean fix for this. But I've traced through enough of the  
> program to see that the .git directories should be filtered out as early  
> as possible to mimick the behaviour of git.

Hi Morgan, the following patch should fix your problem.

>From b03a71a660d15d76b63d7d3c5205b896f89f34b5 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sun, 11 Jan 2009 18:23:38 -0800
Subject: [PATCH] git-svn: avoid importing nested git repos

Some SVN repositories contain git repositories within them
(hopefully accidentally checked in).  Since git refuses to track
nested ".git" repositories, this can be a problem when fetching
updates from SVN.

Thanks to Morgan Christiansson for the report and testing.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl                       |   34 +++++++++++--
 t/t9133-git-svn-nested-git-repo.sh |  101 ++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 4 deletions(-)
 create mode 100755 t/t9133-git-svn-nested-git-repo.sh

diff --git a/git-svn.perl b/git-svn.perl
index 71b8ef4..55c4dfb 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3291,6 +3291,11 @@ sub _mark_empty_symlinks {
 	\%ret;
 }
 
+# returns true if a given path is inside a ".git" directory
+sub in_dot_git {
+	$_[0] =~ m{(?:^|/)\.git(?:/|$)};
+}
+
 sub set_path_strip {
 	my ($self, $path) = @_;
 	$self->{path_strip} = qr/^\Q$path\E(\/|$)/ if length $path;
@@ -3316,6 +3321,7 @@ sub git_path {
 
 sub delete_entry {
 	my ($self, $path, $rev, $pb) = @_;
+	return undef if in_dot_git($path);
 
 	my $gpath = $self->git_path($path);
 	return undef if ($gpath eq '');
@@ -3343,8 +3349,12 @@ sub delete_entry {
 
 sub open_file {
 	my ($self, $path, $pb, $rev) = @_;
+	my ($mode, $blob);
+
+	goto out if in_dot_git($path);
+
 	my $gpath = $self->git_path($path);
-	my ($mode, $blob) = (command('ls-tree', $self->{c}, '--', $gpath)
+	($mode, $blob) = (command('ls-tree', $self->{c}, '--', $gpath)
 	                     =~ /^(\d{6}) blob ([a-f\d]{40})\t/);
 	unless (defined $mode && defined $blob) {
 		die "$path was not found in commit $self->{c} (r$rev)\n";
@@ -3352,20 +3362,27 @@ sub open_file {
 	if ($mode eq '100644' && $self->{empty_symlinks}->{$path}) {
 		$mode = '120000';
 	}
+out:
 	{ path => $path, mode_a => $mode, mode_b => $mode, blob => $blob,
 	  pool => SVN::Pool->new, action => 'M' };
 }
 
 sub add_file {
 	my ($self, $path, $pb, $cp_path, $cp_rev) = @_;
-	my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
-	delete $self->{empty}->{$dir};
-	{ path => $path, mode_a => 100644, mode_b => 100644,
+	my $mode;
+
+	if (!in_dot_git($path)) {
+		my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
+		delete $self->{empty}->{$dir};
+		$mode = '100644';
+	}
+	{ path => $path, mode_a => $mode, mode_b => $mode,
 	  pool => SVN::Pool->new, action => 'A' };
 }
 
 sub add_directory {
 	my ($self, $path, $cp_path, $cp_rev) = @_;
+	goto out if in_dot_git($path);
 	my $gpath = $self->git_path($path);
 	if ($gpath eq '') {
 		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
@@ -3383,11 +3400,13 @@ sub add_directory {
 	my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
 	delete $self->{empty}->{$dir};
 	$self->{empty}->{$path} = 1;
+out:
 	{ path => $path };
 }
 
 sub change_dir_prop {
 	my ($self, $db, $prop, $value) = @_;
+	return undef if in_dot_git($db->{path});
 	$self->{dir_prop}->{$db->{path}} ||= {};
 	$self->{dir_prop}->{$db->{path}}->{$prop} = $value;
 	undef;
@@ -3395,6 +3414,7 @@ sub change_dir_prop {
 
 sub absent_directory {
 	my ($self, $path, $pb) = @_;
+	return undef if in_dot_git($pb->{path});
 	$self->{absent_dir}->{$pb->{path}} ||= [];
 	push @{$self->{absent_dir}->{$pb->{path}}}, $path;
 	undef;
@@ -3402,6 +3422,7 @@ sub absent_directory {
 
 sub absent_file {
 	my ($self, $path, $pb) = @_;
+	return undef if in_dot_git($pb->{path});
 	$self->{absent_file}->{$pb->{path}} ||= [];
 	push @{$self->{absent_file}->{$pb->{path}}}, $path;
 	undef;
@@ -3409,6 +3430,7 @@ sub absent_file {
 
 sub change_file_prop {
 	my ($self, $fb, $prop, $value) = @_;
+	return undef if in_dot_git($fb->{path});
 	if ($prop eq 'svn:executable') {
 		if ($fb->{mode_b} != 120000) {
 			$fb->{mode_b} = defined $value ? 100755 : 100644;
@@ -3424,11 +3446,13 @@ sub change_file_prop {
 
 sub apply_textdelta {
 	my ($self, $fb, $exp) = @_;
+	return undef if (in_dot_git($fb->{path}));
 	my $fh = $::_repository->temp_acquire('svn_delta');
 	# $fh gets auto-closed() by SVN::TxDelta::apply(),
 	# (but $base does not,) so dup() it for reading in close_file
 	open my $dup, '<&', $fh or croak $!;
 	my $base = $::_repository->temp_acquire('git_blob');
+
 	if ($fb->{blob}) {
 		my ($base_is_link, $size);
 
@@ -3469,6 +3493,8 @@ sub apply_textdelta {
 
 sub close_file {
 	my ($self, $fb, $exp) = @_;
+	return undef if (in_dot_git($fb->{path}));
+
 	my $hash;
 	my $path = $self->git_path($fb->{path});
 	if (my $fh = $fb->{fh}) {
diff --git a/t/t9133-git-svn-nested-git-repo.sh b/t/t9133-git-svn-nested-git-repo.sh
new file mode 100755
index 0000000..893f57e
--- /dev/null
+++ b/t/t9133-git-svn-nested-git-repo.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Eric Wong
+#
+
+test_description='git svn property tests'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup repo with a git repo inside it' '
+	svn co "$svnrepo" s &&
+	(
+		cd s &&
+		git init &&
+		test -f .git/HEAD &&
+		> .git/a &&
+		echo a > a &&
+		svn add .git a &&
+		svn commit -m "create a nested git repo" &&
+		svn up &&
+		echo hi >> .git/a &&
+		svn commit -m "modify .git/a" &&
+		svn up
+	)
+'
+
+test_expect_success 'clone an SVN repo containing a git repo' '
+	git svn clone "$svnrepo" g &&
+	echo a > expect &&
+	test_cmp expect g/a
+'
+
+test_expect_success 'SVN-side change outside of .git' '
+	(
+		cd s &&
+		echo b >> a &&
+		svn commit -m "SVN-side change outside of .git" &&
+		svn up &&
+		svn log -v | fgrep "SVN-side change outside of .git"
+	)
+'
+
+test_expect_success 'update git svn-cloned repo' '
+	(
+		cd g &&
+		git svn rebase &&
+		echo a > expect &&
+		echo b >> expect &&
+		test_cmp a expect &&
+		rm expect
+	)
+'
+
+test_expect_success 'SVN-side change inside of .git' '
+	(
+		cd s &&
+		git add a &&
+		git commit -m "add a inside an SVN repo" &&
+		git log &&
+		svn add --force .git &&
+		svn commit -m "SVN-side change inside of .git" &&
+		svn up &&
+		svn log -v | fgrep "SVN-side change inside of .git"
+	)
+'
+
+test_expect_success 'update git svn-cloned repo' '
+	(
+		cd g &&
+		git svn rebase &&
+		echo a > expect &&
+		echo b >> expect &&
+		test_cmp a expect &&
+		rm expect
+	)
+'
+
+test_expect_success 'SVN-side change in and out of .git' '
+	(
+		cd s &&
+		echo c >> a &&
+		git add a &&
+		git commit -m "add a inside an SVN repo" &&
+		svn commit -m "SVN-side change in and out of .git" &&
+		svn up &&
+		svn log -v | fgrep "SVN-side change in and out of .git"
+	)
+'
+
+test_expect_success 'update git svn-cloned repo again' '
+	(
+		cd g &&
+		git svn rebase &&
+		echo a > expect &&
+		echo b >> expect &&
+		echo c >> expect &&
+		test_cmp a expect &&
+		rm expect
+	)
+'
+
+test_done
-- 
Eric Wong
