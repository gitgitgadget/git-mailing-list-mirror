From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 1/9 v2] difftool: parse options using Getopt::Long
Date: Sat, 17 Mar 2012 21:55:26 -0400
Message-ID: <1332035734-5443-2-git-send-email-tim.henigan@gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
 <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 02:57:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S95Ml-0004Sq-V5
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 02:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254Ab2CRB4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 21:56:31 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55335 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883Ab2CRB4A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 21:56:00 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so7559135iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 18:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fMc0NAui6Fee1ce5Ds6wgBAiZBdKHiZhgHzspUnYCu4=;
        b=rZ8vybxE6roam/ecQw19PdcNJJTSOgiYksgYsdctI9yDEGrpXqed99B/hdTJxCbCob
         4VCkAUuwMRdG62+WyzyAr55Fm81NWnpc/9gErOnX+JobdsrO12bv9411y9WPMgJ+hdOm
         V5lN+bWPZja90GoFxr4WMPZXY3O2kFkywmss02NgL02tv7CgvGd9W6YyJntfmh9gctcK
         rXEsuSfwlRzN1pknNcsQfGX2zMNrFxMVR3Ponm9OnCMMgtP0gJT+ppyz3HjROLVex0FS
         mz6mCa61Pdy+4/5wIP6TCB4me6EWJ2GRvL1D6sO8VEoLowtxHBfq1BF0pugc7bF1zWvb
         fbzA==
Received: by 10.50.159.228 with SMTP id xf4mr2959527igb.0.1332035760487;
        Sat, 17 Mar 2012 18:56:00 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id uy10sm2950959igc.15.2012.03.17.18.55.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 18:55:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
In-Reply-To: <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193364>

Replace custom option/argument parser with standard Getopt::Long
module.  This shortens the code and makes it easier to understand.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl |  109 +++++++++++++++++++++--------------------------------
 1 file changed, 44 insertions(+), 65 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 09b65f1..e365727 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -15,11 +15,8 @@ use strict;
 use warnings;
 use Cwd qw(abs_path);
 use File::Basename qw(dirname);
-
-require Git;
-
-my $DIR = abs_path(dirname($0));
-
+use Getopt::Long qw(:config pass_through);
+use Git;
 
 sub usage
 {
@@ -33,6 +30,7 @@ USAGE
 
 sub setup_environment
 {
+	my $DIR = abs_path(dirname($0));
 	$ENV{PATH} = "$DIR:$ENV{PATH}";
 	$ENV{GIT_PAGER} = '';
 	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
@@ -47,75 +45,56 @@ sub exe
 	return $exe;
 }
 
-sub generate_command
-{
-	my @command = (exe('git'), 'diff');
-	my $skip_next = 0;
-	my $idx = -1;
-	my $prompt = '';
-	for my $arg (@ARGV) {
-		$idx++;
-		if ($skip_next) {
-			$skip_next = 0;
-			next;
-		}
-		if ($arg eq '-t' || $arg eq '--tool') {
-			usage() if $#ARGV <= $idx;
-			$ENV{GIT_DIFF_TOOL} = $ARGV[$idx + 1];
-			$skip_next = 1;
-			next;
-		}
-		if ($arg =~ /^--tool=/) {
-			$ENV{GIT_DIFF_TOOL} = substr($arg, 7);
-			next;
-		}
-		if ($arg eq '-x' || $arg eq '--extcmd') {
-			usage() if $#ARGV <= $idx;
-			$ENV{GIT_DIFFTOOL_EXTCMD} = $ARGV[$idx + 1];
-			$skip_next = 1;
-			next;
-		}
-		if ($arg =~ /^--extcmd=/) {
-			$ENV{GIT_DIFFTOOL_EXTCMD} = substr($arg, 9);
-			next;
-		}
-		if ($arg eq '-g' || $arg eq '--gui') {
-			eval {
-				my $tool = Git::command_oneline('config',
-				                                'diff.guitool');
-				if (length($tool)) {
-					$ENV{GIT_DIFF_TOOL} = $tool;
-				}
-			};
-			next;
-		}
-		if ($arg eq '-y' || $arg eq '--no-prompt') {
-			$prompt = 'no';
-			next;
-		}
-		if ($arg eq '--prompt') {
-			$prompt = 'yes';
-			next;
-		}
-		if ($arg eq '-h') {
-			usage();
-		}
-		push @command, $arg;
+# parse command-line options. all unrecognized options and arguments
+# are passed through to the 'git diff' command.
+my ($difftool_cmd, $extcmd, $gui, $help, $no_prompt, $prompt);
+GetOptions('g|gui' => \$gui,
+	'h' => \$help,
+	'prompt' => \$prompt,
+	't|tool:s' => \$difftool_cmd,
+	'x|extcmd:s' => \$extcmd,
+	'y|no-prompt' => \$no_prompt);
+
+if (defined($help)) {
+	usage();
+} 
+if (defined($difftool_cmd)) {
+	if (length($difftool_cmd) > 0) {
+		$ENV{GIT_DIFF_TOOL} = $difftool_cmd;
+	} else {
+		print "No <tool> given for --tool=<tool>\n";
+		usage();
 	}
-	if ($prompt eq 'yes') {
-		$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
-	} elsif ($prompt eq 'no') {
-		$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+}
+if (defined($extcmd)) {
+	if (length($extcmd) > 0) {
+		$ENV{GIT_DIFFTOOL_EXTCMD} = $extcmd;
+	} else {
+		print "No <cmd> given for --extcmd=<cmd>\n";
+		usage();
+	}
+}
+if (defined($gui)) {
+	my $guitool = "";
+	$guitool = Git::config('diff.guitool');
+	if (length($guitool) > 0) {
+		$ENV{GIT_DIFF_TOOL} = $guitool;
 	}
-	return @command
+}
+if (defined($prompt)) {
+	$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
+}
+elsif (defined($no_prompt)) {
+	$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
 }
 
 setup_environment();
+my @command = (exe('git'), 'diff', @ARGV);
 
 # ActiveState Perl for Win32 does not implement POSIX semantics of
 # exec* system call. It just spawns the given executable and finishes
 # the starting program, exiting with code 0.
 # system will at least catch the errors returned by git diff,
 # allowing the caller of git difftool better handling of failures.
-my $rc = system(generate_command());
+my $rc = system(@command);
 exit($rc | ($rc >> 8));
-- 
1.7.9.1.290.gbd444
