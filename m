From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 2/2] difftool: Handle compare() returning -1
Date: Thu, 26 Jul 2012 12:36:19 -0700
Message-ID: <1343331379-99746-2-git-send-email-davvid@gmail.com>
References: <1343331379-99746-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 21:37:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuTrl-0004q4-Hz
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 21:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab2GZTg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 15:36:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48489 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab2GZTgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 15:36:24 -0400
Received: by pbbrp8 with SMTP id rp8so3678283pbb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vNR5mIP2nnomnIh/5X3wU45ZcGRJgucRxwsIfBiLAXE=;
        b=pOTBIZ24SzEQZdGSUM482moPdycUxSM4gW6HGEMUHwxCetWv3NwCpMk3qGWuhxn180
         rhMfwARHi76GJlqBMupG9lwPQxNuxDSBNfBoAsgQ1UYJiQeGVf4hAAozAYi8U49hGbg0
         8+lCAOxUrs3lS4+BvNaeCiGMSKIQOJtxsAgiZBxkXnK3a7PGZjg/yzbGLa6avuvLlWqE
         BNBkRqO7iEvjm1AWBhi9scvmCLJhPclEIkqBM/Ow9PtrCp+N6hQUlwThyuj54swwDnSg
         R11DOAS+1629Dtt6nOQYSqCIGeSIN1i71hZk2bwyZsuWch/BtPZmLk7WzrawgmY+x4LJ
         jgeA==
Received: by 10.68.221.227 with SMTP id qh3mr7812300pbc.115.1343331384007;
        Thu, 26 Jul 2012 12:36:24 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id oa5sm284084pbb.14.2012.07.26.12.36.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 12:36:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.11.g8d9a67a
In-Reply-To: <1343331379-99746-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202297>

Keep the temporary directory around when compare()
cannot read its input files, which is indicated by -1.

Defer tempdir creation to allow an early exit in setup_dir_diff().
Wrap the rest of the entry points in an exit_cleanup() function
to handle removing temporary files and error reporting.

Print the temporary files' location so that the user can
recover them.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Differences since v1:

Store errno before calling rmtree() so that we are not affected
when rmtree() clobbers errno.

 git-difftool.perl | 101 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 32 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 8e51238..e4277f5 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -18,7 +18,7 @@ use File::Copy;
 use File::Compare;
 use File::Find;
 use File::stat;
-use File::Path qw(mkpath);
+use File::Path qw(mkpath rmtree);
 use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
@@ -112,6 +112,18 @@ EOF
 	exit(0);
 }
 
+sub exit_cleanup
+{
+	my ($tmpdir, $status) = @_;
+	my $errno = $!;
+	rmtree($tmpdir);
+	if ($status and $errno) {
+		my ($package, $file, $line) = caller();
+		warn "$file line $line: $errno\n";
+	}
+	exit($status | ($status >> 8));
+}
+
 sub setup_dir_diff
 {
 	my ($repo, $workdir, $symlinks) = @_;
@@ -128,13 +140,6 @@ sub setup_dir_diff
 	my $diffrtn = $diffrepo->command_oneline(@gitargs);
 	exit(0) if (length($diffrtn) == 0);
 
-	# Setup temp directories
-	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 1, TMPDIR => 1);
-	my $ldir = "$tmpdir/left";
-	my $rdir = "$tmpdir/right";
-	mkpath($ldir) or die $!;
-	mkpath($rdir) or die $!;
-
 	# Build index info for left and right sides of the diff
 	my $submodule_mode = '160000';
 	my $symlink_mode = '120000';
@@ -203,6 +208,13 @@ EOF
 		}
 	}
 
+	# Setup temp directories
+	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 0, TMPDIR => 1);
+	my $ldir = "$tmpdir/left";
+	my $rdir = "$tmpdir/right";
+	mkpath($ldir) or exit_cleanup($tmpdir, 1);
+	mkpath($rdir) or exit_cleanup($tmpdir, 1);
+
 	# If $GIT_DIR is not set prior to calling 'git update-index' and
 	# 'git checkout-index', then those commands will fail if difftool
 	# is called from a directory other than the repo root.
@@ -219,16 +231,18 @@ EOF
 		$repo->command_input_pipe(qw(update-index -z --index-info));
 	print($inpipe $lindex);
 	$repo->command_close_pipe($inpipe, $ctx);
+
 	my $rc = system('git', 'checkout-index', '--all', "--prefix=$ldir/");
-	exit($rc | ($rc >> 8)) if ($rc != 0);
+	exit_cleanup($tmpdir, $rc) if $rc != 0;
 
 	$ENV{GIT_INDEX_FILE} = "$tmpdir/rindex";
 	($inpipe, $ctx) =
 		$repo->command_input_pipe(qw(update-index -z --index-info));
 	print($inpipe $rindex);
 	$repo->command_close_pipe($inpipe, $ctx);
+
 	$rc = system('git', 'checkout-index', '--all', "--prefix=$rdir/");
-	exit($rc | ($rc >> 8)) if ($rc != 0);
+	exit_cleanup($tmpdir, $rc) if $rc != 0;
 
 	# If $GIT_DIR was explicitly set just for the update/checkout
 	# commands, then it should be unset before continuing.
@@ -240,14 +254,19 @@ EOF
 	for my $file (@working_tree) {
 		my $dir = dirname($file);
 		unless (-d "$rdir/$dir") {
-			mkpath("$rdir/$dir") or die $!;
+			mkpath("$rdir/$dir") or
+			exit_cleanup($tmpdir, 1);
 		}
 		if ($symlinks) {
-			symlink("$workdir/$file", "$rdir/$file") or die $!;
+			symlink("$workdir/$file", "$rdir/$file") or
+			exit_cleanup($tmpdir, 1);
 		} else {
-			copy("$workdir/$file", "$rdir/$file") or die $!;
+			copy("$workdir/$file", "$rdir/$file") or
+			exit_cleanup($tmpdir, 1);
+
 			my $mode = stat("$workdir/$file")->mode;
-			chmod($mode, "$rdir/$file") or die $!;
+			chmod($mode, "$rdir/$file") or
+			exit_cleanup($tmpdir, 1);
 		}
 	}
 
@@ -255,27 +274,35 @@ EOF
 	# temporary file to both the left and right directories to show the
 	# change in the recorded SHA1 for the submodule.
 	for my $path (keys %submodule) {
+		my $ok;
 		if (defined($submodule{$path}{left})) {
-			write_to_file("$ldir/$path", "Subproject commit $submodule{$path}{left}");
+			$ok = write_to_file("$ldir/$path",
+				"Subproject commit $submodule{$path}{left}");
 		}
 		if (defined($submodule{$path}{right})) {
-			write_to_file("$rdir/$path", "Subproject commit $submodule{$path}{right}");
+			$ok = write_to_file("$rdir/$path",
+				"Subproject commit $submodule{$path}{right}");
 		}
+		exit_cleanup($tmpdir, 1) if not $ok;
 	}
 
 	# Symbolic links require special treatment. The standard "git diff"
 	# shows only the link itself, not the contents of the link target.
 	# This loop replicates that behavior.
 	for my $path (keys %symlink) {
+		my $ok;
 		if (defined($symlink{$path}{left})) {
-			write_to_file("$ldir/$path", $symlink{$path}{left});
+			$ok = write_to_file("$ldir/$path",
+					$symlink{$path}{left});
 		}
 		if (defined($symlink{$path}{right})) {
-			write_to_file("$rdir/$path", $symlink{$path}{right});
+			$ok = write_to_file("$rdir/$path",
+					$symlink{$path}{right});
 		}
+		exit_cleanup($tmpdir, 1) if not $ok;
 	}
 
-	return ($ldir, $rdir, @working_tree);
+	return ($ldir, $rdir, $tmpdir, @working_tree);
 }
 
 sub write_to_file
@@ -286,16 +313,18 @@ sub write_to_file
 	# Make sure the path to the file exists
 	my $dir = dirname($path);
 	unless (-d "$dir") {
-		mkpath("$dir") or die $!;
+		mkpath("$dir") or return 0;
 	}
 
 	# If the file already exists in that location, delete it.  This
 	# is required in the case of symbolic links.
-	unlink("$path");
+	unlink($path);
 
-	open(my $fh, '>', "$path") or die $!;
+	open(my $fh, '>', $path) or return 0;
 	print($fh $value);
 	close($fh);
+
+	return 1;
 }
 
 sub main
@@ -367,21 +396,19 @@ sub main
 sub dir_diff
 {
 	my ($extcmd, $symlinks) = @_;
-
 	my $rc;
+	my $error = 0;
 	my $repo = Git->repository();
-
 	my $workdir = find_worktree($repo);
-	my ($a, $b, @worktree) = setup_dir_diff($repo, $workdir, $symlinks);
+	my ($a, $b, $tmpdir, @worktree) =
+		setup_dir_diff($repo, $workdir, $symlinks);
+
 	if (defined($extcmd)) {
 		$rc = system($extcmd, $a, $b);
 	} else {
 		$ENV{GIT_DIFFTOOL_DIRDIFF} = 'true';
 		$rc = system('git', 'difftool--helper', $a, $b);
 	}
-
-	exit($rc | ($rc >> 8)) if ($rc != 0);
-
 	# If the diff including working copy files and those
 	# files were modified during the diff, then the changes
 	# should be copied back to the working tree.
@@ -395,16 +422,26 @@ sub dir_diff
 		if ($diff == 0) {
 			next;
 		} elsif ($diff == -1 ) {
-			my $errmsg = "warning: could not compare ";
+			my $errmsg = "warning: Could not compare ";
 			$errmsg += "'$b/$file' with '$workdir/$file'\n";
 			warn $errmsg;
+			$error = 1;
 		} elsif ($diff == 1) {
-			copy("$b/$file", "$workdir/$file") or die $!;
 			my $mode = stat("$b/$file")->mode;
-			chmod($mode, "$workdir/$file") or die $!;
+			copy("$b/$file", "$workdir/$file") or
+			exit_cleanup($tmpdir, 1);
+
+			chmod($mode, "$workdir/$file") or
+			exit_cleanup($tmpdir, 1);
 		}
 	}
-	exit(0);
+	if ($error) {
+		warn "warning: Temporary files exist in '$tmpdir'.\n";
+		warn "warning: You may want to cleanup or recover these.\n";
+		exit(1);
+	} else {
+		exit_cleanup($tmpdir, $rc);
+	}
 }
 
 sub file_diff
-- 
1.7.11.11.g8d9a67a
