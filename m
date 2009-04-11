From: Ben Jackson <ben@ben.com>
Subject: [PATCH v2 1/2] Add per-svn-remote ignore-paths config
Date: Sat, 11 Apr 2009 10:46:17 -0700
Message-ID: <1239471978-45479-1-git-send-email-ben@ben.com>
Cc: normalperson@yhbt.net, gitster@pobox.com, ben@ben.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 19:48:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LshJC-0008VR-7P
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 19:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758110AbZDKRq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 13:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758060AbZDKRqZ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 13:46:25 -0400
Received: from kronos.home.ben.com ([71.117.242.19]:51951 "EHLO
	kronos.home.ben.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757692AbZDKRqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 13:46:24 -0400
Received: from kronos.home.ben.com (localhost [127.0.0.1])
	by kronos.home.ben.com (8.14.3/8.14.3) with ESMTP id n3BHkJHF045508;
	Sat, 11 Apr 2009 10:46:19 -0700 (PDT)
Received: (from bjj@localhost)
	by kronos.home.ben.com (8.14.3/8.14.3/Submit) id n3BHkIcp045507;
	Sat, 11 Apr 2009 10:46:18 -0700 (PDT)
	(envelope-from bjj)
X-Mailer: git-send-email 1.6.0.1
X-Virus-Scanned: ClamAV 0.93.3/9224/Fri Apr 10 14:49:29 2009 on kronos.home.ben.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116305>

The --ignore-paths option to fetch is very useful for working on a subset
of a SVN repository.  For proper operation, every command that causes a
fetch (explicit or implied) must include a matching --ignore-paths option.

This patch adds a persistent svn-remote.$repo_id.ignore-paths config by
promoting Fetcher::is_path_ignored to a member function and initializing
$self->{ignore_regex} in Fetcher::new.  Command line --ignore-paths is
still recognized and acts in addition to the config value.

Signed-off-by: Ben Jackson <ben@ben.com>
---

This version fixes a bug found by Eric Wong (inappropriate cut'n'paste
use of perl m//o) and extends the test cases to include independent
tests for command-line and config ignore-paths.

 Documentation/git-svn.txt       |   22 ++++++++++-----
 git-svn.perl                    |   26 ++++++++++--------
 t/t9134-git-svn-ignore-paths.sh |   55 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 82 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b7b1af8..af2d6c2 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -104,17 +104,25 @@ repository, either don't use this option or you should both use it in
 the same local timezone.
 
 --ignore-paths=<regex>;;
-	This allows one to specify Perl regular expression that will
+	This allows one to specify a Perl regular expression that will
 	cause skipping of all matching paths from checkout from SVN.
-	Examples:
+	The '--ignore-paths' option should match for every 'fetch'
+	(including automatic fetches due to 'clone', 'dcommit',
+	'rebase', etc) on a given repository.
 
-	--ignore-paths="^doc" - skip "doc*" directory for every fetch.
+config key: svn-remote.<name>.ignore-paths
 
-	--ignore-paths="^[^/]+/(?:branches|tags)" - skip "branches"
-	    and "tags" of first level directories.
+	If the ignore-paths config key is set and the command
+	line option is also given, both regular expressions
+	will be used.
 
-	Regular expression is not persistent, you should specify
-	it every time when fetching.
+Examples:
+
+	--ignore-paths="^doc" - skip "doc*" directory for every
+	    fetch.
+
+	--ignore-paths="^[^/]+/(?:branches|tags)" - skip
+	    "branches" and "tags" of first level directories.
 
 'clone'::
 	Runs 'init' and 'fetch'.  It will automatically create a
diff --git a/git-svn.perl b/git-svn.perl
index d919798..8e195ed 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3286,6 +3286,8 @@ sub new {
 		$self->{empty_symlinks} =
 		                  _mark_empty_symlinks($git_svn, $switch_path);
 	}
+	$self->{ignore_regex} = eval { command_oneline('config', '--get',
+			     "svn-remote.$git_svn->{repo_id}.ignore-paths") };
 	$self->{empty} = {};
 	$self->{dir_prop} = {};
 	$self->{file_prop} = {};
@@ -3350,8 +3352,10 @@ sub in_dot_git {
 
 # return value: 0 -- don't ignore, 1 -- ignore
 sub is_path_ignored {
-	my ($path) = @_;
+	my ($self, $path) = @_;
 	return 1 if in_dot_git($path);
+	return 1 if defined($self->{ignore_regex}) &&
+	            $path =~ m!$self->{ignore_regex}!;
 	return 0 unless defined($_ignore_regex);
 	return 1 if $path =~ m!$_ignore_regex!o;
 	return 0;
@@ -3382,7 +3386,7 @@ sub git_path {
 
 sub delete_entry {
 	my ($self, $path, $rev, $pb) = @_;
-	return undef if is_path_ignored($path);
+	return undef if $self->is_path_ignored($path);
 
 	my $gpath = $self->git_path($path);
 	return undef if ($gpath eq '');
@@ -3415,7 +3419,7 @@ sub open_file {
 	my ($self, $path, $pb, $rev) = @_;
 	my ($mode, $blob);
 
-	goto out if is_path_ignored($path);
+	goto out if $self->is_path_ignored($path);
 
 	my $gpath = $self->git_path($path);
 	($mode, $blob) = (command('ls-tree', '-z', $self->{c}, "./$gpath")
@@ -3435,7 +3439,7 @@ sub add_file {
 	my ($self, $path, $pb, $cp_path, $cp_rev) = @_;
 	my $mode;
 
-	if (!is_path_ignored($path)) {
+	if (!$self->is_path_ignored($path)) {
 		my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
 		delete $self->{empty}->{$dir};
 		$mode = '100644';
@@ -3446,7 +3450,7 @@ sub add_file {
 
 sub add_directory {
 	my ($self, $path, $cp_path, $cp_rev) = @_;
-	goto out if is_path_ignored($path);
+	goto out if $self->is_path_ignored($path);
 	my $gpath = $self->git_path($path);
 	if ($gpath eq '') {
 		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
@@ -3470,7 +3474,7 @@ out:
 
 sub change_dir_prop {
 	my ($self, $db, $prop, $value) = @_;
-	return undef if is_path_ignored($db->{path});
+	return undef if $self->is_path_ignored($db->{path});
 	$self->{dir_prop}->{$db->{path}} ||= {};
 	$self->{dir_prop}->{$db->{path}}->{$prop} = $value;
 	undef;
@@ -3478,7 +3482,7 @@ sub change_dir_prop {
 
 sub absent_directory {
 	my ($self, $path, $pb) = @_;
-	return undef if is_path_ignored($path);
+	return undef if $self->is_path_ignored($path);
 	$self->{absent_dir}->{$pb->{path}} ||= [];
 	push @{$self->{absent_dir}->{$pb->{path}}}, $path;
 	undef;
@@ -3486,7 +3490,7 @@ sub absent_directory {
 
 sub absent_file {
 	my ($self, $path, $pb) = @_;
-	return undef if is_path_ignored($path);
+	return undef if $self->is_path_ignored($path);
 	$self->{absent_file}->{$pb->{path}} ||= [];
 	push @{$self->{absent_file}->{$pb->{path}}}, $path;
 	undef;
@@ -3494,7 +3498,7 @@ sub absent_file {
 
 sub change_file_prop {
 	my ($self, $fb, $prop, $value) = @_;
-	return undef if is_path_ignored($fb->{path});
+	return undef if $self->is_path_ignored($fb->{path});
 	if ($prop eq 'svn:executable') {
 		if ($fb->{mode_b} != 120000) {
 			$fb->{mode_b} = defined $value ? 100755 : 100644;
@@ -3510,7 +3514,7 @@ sub change_file_prop {
 
 sub apply_textdelta {
 	my ($self, $fb, $exp) = @_;
-	return undef if is_path_ignored($fb->{path});
+	return undef if $self->is_path_ignored($fb->{path});
 	my $fh = $::_repository->temp_acquire('svn_delta');
 	# $fh gets auto-closed() by SVN::TxDelta::apply(),
 	# (but $base does not,) so dup() it for reading in close_file
@@ -3557,7 +3561,7 @@ sub apply_textdelta {
 
 sub close_file {
 	my ($self, $fb, $exp) = @_;
-	return undef if is_path_ignored($fb->{path});
+	return undef if $self->is_path_ignored($fb->{path});
 
 	my $hash;
 	my $path = $self->git_path($fb->{path});
diff --git a/t/t9134-git-svn-ignore-paths.sh b/t/t9134-git-svn-ignore-paths.sh
index c4b5b8b..b9a1597 100755
--- a/t/t9134-git-svn-ignore-paths.sh
+++ b/t/t9134-git-svn-ignore-paths.sh
@@ -31,6 +31,22 @@ test_expect_success 'clone an SVN repository with ignored www directory' '
 	test_cmp expect expect2
 '
 
+test_expect_success 'init+fetch an SVN repository with ignored www directory' '
+	git svn init "$svnrepo" c &&
+	( cd c && git svn fetch --ignore-paths="^www" ) &&
+	rm expect2 &&
+	echo test_qqq > expect &&
+	for i in c/*/*.txt; do cat $i >> expect2; done &&
+	test_cmp expect expect2
+'
+
+test_expect_success 'set persistent ignore-paths config' '
+	(
+	    cd g &&
+	    git config svn-remote.svn.ignore-paths "^www"
+	)
+'
+
 test_expect_success 'SVN-side change outside of www' '
 	(
 		cd s &&
@@ -41,9 +57,20 @@ test_expect_success 'SVN-side change outside of www' '
 	)
 '
 
-test_expect_success 'update git svn-cloned repo' '
+test_expect_success 'update git svn-cloned repo (config ignore)' '
 	(
 		cd g &&
+		git svn rebase &&
+		printf "test_qqq\nb\n" > expect &&
+		for i in */*.txt; do cat $i >> expect2; done &&
+		test_cmp expect2 expect &&
+		rm expect expect2
+	)
+'
+
+test_expect_success 'update git svn-cloned repo (option ignore)' '
+	(
+		cd c &&
 		git svn rebase --ignore-paths="^www" &&
 		printf "test_qqq\nb\n" > expect &&
 		for i in */*.txt; do cat $i >> expect2; done &&
@@ -62,9 +89,20 @@ test_expect_success 'SVN-side change inside of ignored www' '
 	)
 '
 
-test_expect_success 'update git svn-cloned repo' '
+test_expect_success 'update git svn-cloned repo (config ignore)' '
 	(
 		cd g &&
+		git svn rebase &&
+		printf "test_qqq\nb\n" > expect &&
+		for i in */*.txt; do cat $i >> expect2; done &&
+		test_cmp expect2 expect &&
+		rm expect expect2
+	)
+'
+
+test_expect_success 'update git svn-cloned repo (option ignore)' '
+	(
+		cd c &&
 		git svn rebase --ignore-paths="^www" &&
 		printf "test_qqq\nb\n" > expect &&
 		for i in */*.txt; do cat $i >> expect2; done &&
@@ -84,9 +122,20 @@ test_expect_success 'SVN-side change in and out of ignored www' '
 	)
 '
 
-test_expect_success 'update git svn-cloned repo again' '
+test_expect_success 'update git svn-cloned repo again (config ignore)' '
 	(
 		cd g &&
+		git svn rebase &&
+		printf "test_qqq\nb\nygg\n" > expect &&
+		for i in */*.txt; do cat $i >> expect2; done &&
+		test_cmp expect2 expect &&
+		rm expect expect2
+	)
+'
+
+test_expect_success 'update git svn-cloned repo again (option ignore)' '
+	(
+		cd c &&
 		git svn rebase --ignore-paths="^www" &&
 		printf "test_qqq\nb\nygg\n" > expect &&
 		for i in */*.txt; do cat $i >> expect2; done &&
-- 
1.6.2.2.487.gd6486
