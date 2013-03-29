From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/5] difftool: don't overwrite modified files
Date: Fri, 29 Mar 2013 11:28:33 +0000
Message-ID: <8028ebdca0a219b44123a813d6bd8b95d076f2e9.1364555970.git.john@keeping.me.uk>
References: <cover.1364555970.git.john@keeping.me.uk>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 29 12:29:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULXVE-0008RQ-1n
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 12:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab3C2L3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 07:29:21 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:49857 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548Ab3C2L3U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 07:29:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3DD30606500;
	Fri, 29 Mar 2013 11:29:20 +0000 (GMT)
X-Quarantine-ID: <U9Bap7jfvlGz>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U9Bap7jfvlGz; Fri, 29 Mar 2013 11:29:19 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 3CD8B6064FF;
	Fri, 29 Mar 2013 11:29:06 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.411.g65a544e
In-Reply-To: <cover.1364555970.git.john@keeping.me.uk>
In-Reply-To: <cover.1364555970.git.john@keeping.me.uk>
References: <cover.1364555970.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219491>

After running the user's diff tool, git-difftool will copy any files
that differ between the working tree and the temporary tree.  This is
useful when the user edits the file in their diff tool but is wrong if
they edit the working tree file while examining the diff.

Instead of copying unconditionally when the files differ, create and
index from the working tree files and only copy the temporary file back
if it was modified and the working tree file was not.  If both files
have been modified, print a warning and exit with an error.

Note that we cannot use an existing index in git-difftool since those
contain the modified files that need to be checked out but here we are
looking at those files which are copied from the working tree and not
checked out.  These are precisely the files which are not in the
existing indices.

Signed-off-by: John Keeping <john@keeping.me.uk>

---
Changes since v2:
- Set TMPDIR to $TRASH_DIRECTORY in the test where difftool fails

 git-difftool.perl   | 73 +++++++++++++++++++++++++++++++++++++++++++----------
 t/t7800-difftool.sh | 30 ++++++++++++++++++++++
 2 files changed, 89 insertions(+), 14 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 663640d..844f619 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -13,9 +13,9 @@
 use 5.008;
 use strict;
 use warnings;
+use Error qw(:try);
 use File::Basename qw(dirname);
 use File::Copy;
-use File::Compare;
 use File::Find;
 use File::stat;
 use File::Path qw(mkpath rmtree);
@@ -88,14 +88,45 @@ sub use_wt_file
 	my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
 	my $null_sha1 = '0' x 40;
 
-	if ($sha1 eq $null_sha1) {
-		return 1;
-	} elsif (not $symlinks) {
+	if ($sha1 ne $null_sha1 and not $symlinks) {
 		return 0;
 	}
 
 	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
-	return $sha1 eq $wt_sha1;
+	my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
+	return ($use, $wt_sha1);
+}
+
+sub changed_files
+{
+	my ($repo_path, $index, $worktree) = @_;
+	$ENV{GIT_INDEX_FILE} = $index;
+	$ENV{GIT_WORK_TREE} = $worktree;
+	my $must_unset_git_dir = 0;
+	if (not defined($ENV{GIT_DIR})) {
+		$must_unset_git_dir = 1;
+		$ENV{GIT_DIR} = $repo_path;
+	}
+
+	my @refreshargs = qw/update-index --really-refresh -q --unmerged/;
+	my @gitargs = qw/diff-files --name-only -z/;
+	try {
+		Git::command_oneline(@refreshargs);
+	} catch Git::Error::Command with {};
+
+	my $line = Git::command_oneline(@gitargs);
+	my @files;
+	if (defined $line) {
+		@files = split('\0', $line);
+	} else {
+		@files = ();
+	}
+
+	delete($ENV{GIT_INDEX_FILE});
+	delete($ENV{GIT_WORK_TREE});
+	delete($ENV{GIT_DIR}) if ($must_unset_git_dir);
+
+	return map { $_ => 1 } @files;
 }
 
 sub setup_dir_diff
@@ -121,6 +152,7 @@ sub setup_dir_diff
 	my $null_sha1 = '0' x 40;
 	my $lindex = '';
 	my $rindex = '';
+	my $wtindex = '';
 	my %submodule;
 	my %symlink;
 	my @working_tree = ();
@@ -174,8 +206,12 @@ EOF
 		}
 
 		if ($rmode ne $null_mode) {
-			if (use_wt_file($repo, $workdir, $dst_path, $rsha1, $symlinks)) {
-				push(@working_tree, $dst_path);
+			my ($use, $wt_sha1) = use_wt_file($repo, $workdir,
+							  $dst_path, $rsha1,
+							  $symlinks);
+			if ($use) {
+				push @working_tree, $dst_path;
+				$wtindex .= "$rmode $wt_sha1\t$dst_path\0";
 			} else {
 				$rindex .= "$rmode $rsha1\t$dst_path\0";
 			}
@@ -218,6 +254,12 @@ EOF
 	$rc = system('git', 'checkout-index', '--all', "--prefix=$rdir/");
 	exit_cleanup($tmpdir, $rc) if $rc != 0;
 
+	$ENV{GIT_INDEX_FILE} = "$tmpdir/wtindex";
+	($inpipe, $ctx) =
+		$repo->command_input_pipe(qw(update-index --info-only -z --index-info));
+	print($inpipe $wtindex);
+	$repo->command_close_pipe($inpipe, $ctx);
+
 	# If $GIT_DIR was explicitly set just for the update/checkout
 	# commands, then it should be unset before continuing.
 	delete($ENV{GIT_DIR}) if ($must_unset_git_dir);
@@ -390,19 +432,22 @@ sub dir_diff
 	# should be copied back to the working tree.
 	# Do not copy back files when symlinks are used and the
 	# external tool did not replace the original link with a file.
+	my %wt_modified = changed_files($repo->repo_path(),
+		"$tmpdir/wtindex", "$workdir");
+	my %tmp_modified = changed_files($repo->repo_path(),
+		"$tmpdir/wtindex", "$b");
 	for my $file (@worktree) {
 		next if $symlinks && -l "$b/$file";
 		next if ! -f "$b/$file";
 
-		my $diff = compare("$b/$file", "$workdir/$file");
-		if ($diff == 0) {
-			next;
-		} elsif ($diff == -1) {
-			my $errmsg = "warning: Could not compare ";
-			$errmsg += "'$b/$file' with '$workdir/$file'\n";
+		if (exists $wt_modified{$file} and exists $tmp_modified{$file}) {
+			my $errmsg = "warning: Both files modified: ";
+			$errmsg .= "'$workdir/$file' and '$b/$file'.\n";
+			$errmsg .= "warning: Working tree file has been left.\n";
+			$errmsg .= "warning:\n";
 			warn $errmsg;
 			$error = 1;
-		} elsif ($diff == 1) {
+		} elsif ($tmp_modified{$file}) {
 			my $mode = stat("$b/$file")->mode;
 			copy("$b/$file", "$workdir/$file") or
 			exit_cleanup($tmpdir, 1);
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index e6a16cd..017f55a 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -377,4 +377,34 @@ test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstage
 	test_cmp actual expect
 '
 
+write_script modify-file <<\EOF
+echo "new content" >file
+EOF
+
+test_expect_success PERL 'difftool --no-symlinks does not overwrite working tree file ' '
+	echo "orig content" >file &&
+	git difftool --dir-diff --no-symlinks --extcmd "$(pwd)/modify-file" branch &&
+	echo "new content" >expect &&
+	test_cmp expect file
+'
+
+write_script modify-both-files <<\EOF
+echo "wt content" >file &&
+echo "tmp content" >"$2/file" &&
+echo "$2" >tmpdir
+EOF
+
+test_expect_success PERL 'difftool --no-symlinks detects conflict ' '
+	(
+		TMPDIR=$TRASH_DIRECTORY &&
+		export TMPDIR &&
+		echo "orig content" >file &&
+		test_must_fail git difftool --dir-diff --no-symlinks --extcmd "$(pwd)/modify-both-files" branch &&
+		echo "wt content" >expect &&
+		test_cmp expect file &&
+		echo "tmp content" >expect &&
+		test_cmp expect "$(cat tmpdir)/file"
+	)
+'
+
 test_done
-- 
1.8.2.411.g65a544e
