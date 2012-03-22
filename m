From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 1/9 v6] difftool: parse options using Getopt::Long
Date: Thu, 22 Mar 2012 15:52:16 -0400
Message-ID: <1332445944-10944-2-git-send-email-tim.henigan@gmail.com>
References: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 20:53:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAo4I-00051K-IM
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548Ab2CVTxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:53:00 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:35234 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab2CVTxA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:53:00 -0400
Received: by qadc11 with SMTP id c11so523561qad.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KmLneL/JSSkVYb2LUzOWDZTl+Yk4KqKS/kt/5o8RhPc=;
        b=cWmszTyGAcmurfSPikRnVpK/4OwqkPFp2WBWPZ3pchGVa8VYA8XsqI0yFN+VxL5F9U
         CXShehCGUiVgUJ9QWkzs94+vPlW0DRhrZ6RTYO+3MR1W7YKnPFz24ddJr1td03qyKiAR
         08Rha3yLkvUmBSY+Ja1W2LTpY1vGMG3QO+bI6Xl1swyDqKpicogNvkLPRN3JM3sTL9aS
         rbzOk0srZlU8gsywnkh5SPjoAXYeJOIFdU+zTF5/jQJ/BedRXx9hHm2TlmJVvtZakBj3
         ev9pMmTMUxvg4EgIdfp9EqHduYp0Vna+fBEkfuSZfCVHg2/xt9jIAlMbyM1KgJCtseVl
         S+Jw==
Received: by 10.229.137.6 with SMTP id u6mr3614809qct.112.1332445979416;
        Thu, 22 Mar 2012 12:52:59 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id 1sm10020084qac.3.2012.03.22.12.52.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:52:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.36.g15e879
In-Reply-To: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193700>

Replace custom option/argument parser with standard Getopt::Long
module.  This shortens the code and makes it easier to understand.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Changes in v6:
  - Patch 10/9 from the previous version of the series (difftool: fix
    regression in '--prompt' options) has been squashed into this commit.
    Now the '--[no-]prompt' options are properly handled from the start.


 git-difftool.perl |  111 ++++++++++++++++++++++-------------------------------
 1 file changed, 46 insertions(+), 65 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 09b65f1..f4e28a6 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -15,17 +15,15 @@ use strict;
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
 	print << 'USAGE';
-usage: git difftool [-t|--tool=<tool>] [-x|--extcmd=<cmd>]
-                    [-y|--no-prompt]   [-g|--gui]
+usage: git difftool [-t|--tool=<tool>]
+                    [-x|--extcmd=<cmd>] [-g|--gui]
+                    [--prompt] [-y|--no-prompt]
                     ['git diff' options]
 USAGE
 	exit 1;
@@ -33,6 +31,7 @@ USAGE
 
 sub setup_environment
 {
+	my $DIR = abs_path(dirname($0));
 	$ENV{PATH} = "$DIR:$ENV{PATH}";
 	$ENV{GIT_PAGER} = '';
 	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
@@ -47,75 +46,57 @@ sub exe
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
+my ($difftool_cmd, $extcmd, $gui, $help, $prompt);
+GetOptions('g|gui' => \$gui,
+	'h' => \$help,
+	'prompt!' => \$prompt,
+	'y' => sub { $prompt = 0; },
+	't|tool:s' => \$difftool_cmd,
+	'x|extcmd:s' => \$extcmd);
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
+	}
+}
+if (defined($prompt)) {
+	if ($prompt) {
 		$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
-	} elsif ($prompt eq 'no') {
+	} else {
 		$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
 	}
-	return @command
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
1.7.10.rc1.36.g15e879
