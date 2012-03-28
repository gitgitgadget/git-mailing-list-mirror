From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 9/9 v8] difftool: print list of valid tools with '--tool-help'
Date: Wed, 28 Mar 2012 14:34:44 -0400
Message-ID: <1332959684-2231-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 28 20:35:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCxiG-0005O5-Pl
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 20:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723Ab2C1SfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 14:35:09 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:63229 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397Ab2C1SfH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 14:35:07 -0400
Received: by qadc11 with SMTP id c11so1012678qad.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 11:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ofnNSom6ep/enuWc3939A/DtsLE/iBLFDYaSgx4355c=;
        b=pa7In8hyDymQqrNmWlaZ3lzZ286TP1N5b/4ym9hQbuqhYA671Q/YhQGbYEyWFdWT+z
         UZkRzu2JEonOrrePkZRWPuePt+uSw3voveoUuU0cBbHCaz0bRSBcro++PLgfV8tM3iOJ
         YTN3vwV5zINe9YCQImw0C6o445qnfHZzmGvvz07ePtKlqJZQaVSMvsC/FyjuwrsBdE/Y
         C2vQqgkifyvfmmCUZIWKdkJZpzi8KHMmHed/xV9liAapoYQMRuvlsxWx8Emmu2C/u96I
         L8S+q2fUjL4wlZUEtaRmeNk84xJtZoWYx20So6ELlmY1uFoLjLzJ8cDjf6eSeBQNG7XK
         ROtg==
Received: by 10.224.180.206 with SMTP id bv14mr3912130qab.56.1332959705953;
        Wed, 28 Mar 2012 11:35:05 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id cv8sm7855777qab.12.2012.03.28.11.35.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 11:35:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc2.21.g8cb1a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194158>

Since bc7a96a (mergetool--lib: Refactor tools into separate files,
2011-08-18), it is possible to add a new diff tool by creating a simple
script in the '$(git --exec-path)/mergetools' directory.  Updating the
difftool help text is still a manual process, and the documentation can
easily go out of sync.

This commit teaches difftool the '--tool-help' option, which:
  - Reads the list of valid tools from 'mergetools/*'
  - Determines which of them are actually installed
  - Determines which are capable of diffing (i.e. not just a merge tool)
  - Prints the resulting list for the user

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This replaces 9/9 in the previous version of the series.

Changes in v8:
  - Replaced 'glob' with 'File::Find'. Glob will fail if file paths include
    spaces.  Using File::Find overcomes that limitation.
  - Added 'TOOL_MODE=DIFF' prior to calling 'git-mergetool--lib.sh'. This
    insures that the shell script executes as designed.
  - difftool now calls 'can_diff' from 'git-mergetool--lib.sh' to insure that
    only tools that are capable of diffing are shown as valid options. For
    example, 'tortoisemerge' cannot be used as a diff viewer.
  - The list of tools shown to the user is now sorted.


 Documentation/git-difftool.txt |   11 +++++-----
 git-difftool.perl              |   43 ++++++++++++++++++++++++++++++++++++++--
 t/t7800-difftool.sh            |    5 +++++
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index aba5e76..31fc2e3 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -36,11 +36,9 @@ OPTIONS
 
 -t <tool>::
 --tool=<tool>::
-	Use the diff tool specified by <tool>.
-	Valid diff tools are:
-	araxis, bc3, deltawalker, diffuse, emerge, ecmerge, gvimdiff,
-	kdiff3,	kompare, meld, opendiff, p4merge, tkdiff, vimdiff and
-	xxdiff.
+	Use the diff tool specified by <tool>.  Valid values include
+	emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
+	for the list of valid <tool> settings.
 +
 If a diff tool is not specified, 'git difftool'
 will use the configuration variable `diff.tool`.  If the
@@ -68,6 +66,9 @@ of the diff post-image.  `$MERGED` is the name of the file which is
 being compared. `$BASE` is provided for compatibility
 with custom merge tool commands and has the same value as `$MERGED`.
 
+--tool-help::
+	Print a list of diff tools that may be used with `--tool`.
+
 -x <command>::
 --extcmd=<command>::
 	Specify a custom command for viewing diffs.
diff --git a/git-difftool.perl b/git-difftool.perl
index 0fa131c..15fd572 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -16,6 +16,7 @@ use strict;
 use warnings;
 use File::Basename qw(dirname);
 use File::Copy;
+use File::Find;
 use File::stat;
 use File::Path qw(mkpath);
 use File::Temp qw(tempdir);
@@ -28,7 +29,7 @@ sub usage
 {
 	my $exitcode = shift;
 	print << 'USAGE';
-usage: git difftool [-t|--tool=<tool>]
+usage: git difftool [-t|--tool=<tool>] [--tool-help]
                     [-x|--extcmd=<cmd>]
                     [-g|--gui] [--no-gui]
                     [--prompt] [-y|--no-prompt]
@@ -38,6 +39,40 @@ USAGE
 	exit($exitcode);
 }
 
+sub print_tool_help
+{
+	my ($cmd, @found, @notfound, @tools);
+	my $gitpath = Git::exec_path();
+
+	find(sub { push(@tools, $_) unless (-d $_) }, "$gitpath/mergetools");
+
+	for (@tools) {
+		my $tool = $_;
+		next if ($tool eq "defaults");
+
+		$cmd  = "TOOL_MODE=diff";
+		$cmd .= ' && . "$(git --exec-path)/git-mergetool--lib"';
+		$cmd .= " && get_merge_tool_path $tool >/dev/null 2>&1";
+		$cmd .= " && can_diff >/dev/null 2>&1";
+		if (system('sh', '-c', $cmd) == 0) {
+			push(@found, $tool);
+		} else {
+			push(@notfound, $tool);
+		}
+	}
+
+	print "'git difftool --tool=<tool>' may be set to one of the following:\n";
+	print "\t$_\n" for (sort(@found));
+
+	print "\nThe following tools are valid, but not currently available:\n";
+	print "\t$_\n" for (sort(@notfound));
+
+	print "\nNOTE: Some of the tools listed above only work in a windowed\n";
+	print "environment. If run in a terminal-only session, they will fail.\n";
+
+	exit(0);
+}
+
 sub setup_dir_diff
 {
 	# Run the diff; exit immediately if no diff found
@@ -132,18 +167,22 @@ sub setup_dir_diff
 
 # parse command-line options. all unrecognized options and arguments
 # are passed through to the 'git diff' command.
-my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $prompt);
+my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $prompt, $tool_help);
 GetOptions('g|gui!' => \$gui,
 	'd|dir-diff' => \$dirdiff,
 	'h' => \$help,
 	'prompt!' => \$prompt,
 	'y' => sub { $prompt = 0; },
 	't|tool:s' => \$difftool_cmd,
+	'tool-help' => \$tool_help,
 	'x|extcmd:s' => \$extcmd);
 
 if (defined($help)) {
 	usage(0);
 } 
+if (defined($tool_help)) {
+	print_tool_help();
+}
 if (defined($difftool_cmd)) {
 	if (length($difftool_cmd) > 0) {
 		$ENV{GIT_DIFF_TOOL} = $difftool_cmd;
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 478c1be..bbe71e5 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -319,6 +319,11 @@ test_expect_success PERL 'say no to the second file' '
 	echo "$diff" | stdin_doesnot_contain br2
 '
 
+test_expect_success PERL 'difftool --tool-help' '
+	tool_help=$(git difftool --tool-help) &&
+	echo "$tool_help" | stdin_contains tool
+'
+
 test_expect_success PERL 'setup change in subdirectory' '
 	git checkout master &&
 	mkdir sub &&
-- 
1.7.10.rc2.21.g8cb1a
