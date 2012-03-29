From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 9/9 v9] difftool: print list of valid tools with '--tool-help'
Date: Thu, 29 Mar 2012 09:39:18 -0400
Message-ID: <1333028358-12917-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 29 15:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDFZx-0004yY-HY
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 15:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758716Ab2C2Njt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 09:39:49 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:41780 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758338Ab2C2Njr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 09:39:47 -0400
Received: by qadc11 with SMTP id c11so76966qad.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Jwrvk9LADVVzsVeic3vZOND9J92Z0iJKlqzR2g2W9uk=;
        b=VimBWmpVKB8HxiP3u9FICL693rCtbsWiQ6WIAYmuDFQZwPkyJ6PLiaPCOiGl0RrzR9
         E400PE83BMXuZLyaz5XbXiKeB67yAjaPp4f+jpMYHrI3TxUQPCzSdi4o/oqS7bO4+Utp
         vgIaPKPBC+TR2fulnrHEYdpcDgJiLK/obIZmEIX8ytt0kSZN88drPvQzXNGeMLxKnvzO
         M8kBSg1TUNiywURtB+2eTJii7jqZ8Jk730EF8l/VifZSP10aj0SBiMfXZCqzL6QzptSZ
         LduIPVsDF+3KhzMvEPnSqTS1eFWc7WYiMzfB9s/tTwNZIIWckM6wXJt9v7//4fCaaUNg
         XB1g==
Received: by 10.224.106.66 with SMTP id w2mr286351qao.1.1333028386416;
        Thu, 29 Mar 2012 06:39:46 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id f12sm12473979qan.1.2012.03.29.06.39.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 06:39:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc2.21.gc9e51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194252>

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

Changes in v9:
  - File::Find now ignores sub-directories of '$(git --exec-path)/mergetools'.
  - Moved all tool script filter logic into a separate function.
  - Filter now rejects anything other than simple files found in 'mergetools'.

Please note that the tool script files are not 'chmod +x', so we cannot test
for it.

These changes were suggested during review of the previous version by
Junio Hamano on the Git developers list [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/194158/focus=194181


 Documentation/git-difftool.txt |   11 ++++----
 git-difftool.perl              |   55 ++++++++++++++++++++++++++++++++++++++--
 t/t7800-difftool.sh            |    5 ++++
 3 files changed, 64 insertions(+), 7 deletions(-)

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
index 0fa131c..f83e226 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -16,19 +16,21 @@ use strict;
 use warnings;
 use File::Basename qw(dirname);
 use File::Copy;
+use File::Find;
 use File::stat;
 use File::Path qw(mkpath);
 use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
 
+my @tools;
 my @working_tree;
 
 sub usage
 {
 	my $exitcode = shift;
 	print << 'USAGE';
-usage: git difftool [-t|--tool=<tool>]
+usage: git difftool [-t|--tool=<tool>] [--tool-help]
                     [-x|--extcmd=<cmd>]
                     [-g|--gui] [--no-gui]
                     [--prompt] [-y|--no-prompt]
@@ -38,6 +40,51 @@ USAGE
 	exit($exitcode);
 }
 
+sub filter_tool_scripts
+{
+	if (-d $_) {
+		if ($_ ne ".") {
+			# Ignore files in subdirectories
+			$File::Find::prune = 1;
+		}
+	} else {
+		if ((-f $_) && ($_ ne "defaults")) {
+			push(@tools, $_);
+		}
+	}
+}
+
+sub print_tool_help
+{
+	my ($cmd, @found, @notfound);
+	my $gitpath = Git::exec_path();
+
+	find(\&filter_tool_scripts, "$gitpath/mergetools");
+
+	foreach my $tool (@tools) {
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
@@ -132,18 +179,22 @@ sub setup_dir_diff
 
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
1.7.10.rc2.21.g42bdb
