From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 9/9 v7] difftool: print list of valid tools with '--tool-help'
Date: Mon, 26 Mar 2012 12:23:35 -0400
Message-ID: <1332779015-22882-1-git-send-email-tim.henigan@gmail.com>
References: <7vzkb7rtd0.fsf@alter.siamese.dyndns.org>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Mon Mar 26 18:24:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCCiK-0003dO-Oa
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 18:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934Ab2CZQYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 12:24:07 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:60148 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932919Ab2CZQYG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 12:24:06 -0400
Received: by qadc11 with SMTP id c11so2253798qad.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eNBls5TyaVxABY7y/SAU223c6laFGvaUpOV4sfWUZHQ=;
        b=DMgIJr7emBaHIHhmQiMKRBR+oFQ+XsLP3EL8v2LsgTgyu/pCMWjMtgsZTjoxmPUoDr
         eGy3jsk5S6Abs+M5Yw/F80z0tw/S53z3tWDQOG6qx8dp0yb387rWtY/XM6Z+cqaLrJ0S
         rHTXu8LBX/GAraGBPRClYGcUiyzXsefeBq11QSuoaISgfSzCuUDPgthqI5PRJ8W8FW0C
         grYw47S6p09getUWWYL98O2V8DLLZ9H1wvUShlE8zNnk5CzQ9edQpC9an6y4FZ/6WlZR
         YHtwRyZ8g+3qsUVogHnFt12YRi0v8KN1SKjyxnWIa66mdWRyjHPpj4HKqKfUIHpYXbk7
         1W5A==
Received: by 10.224.58.205 with SMTP id i13mr28008448qah.97.1332779045538;
        Mon, 26 Mar 2012 09:24:05 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id dv7sm30659777qab.15.2012.03.26.09.23.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 09:24:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.36.gdd92a
In-Reply-To: <7vzkb7rtd0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193925>

Since bc7a96a (mergetool--lib: Refactor tools into separate files,
2011-08-18), it is possible to add a new diff tool by creating a simple
script in the '$(git --exec-path)/mergetools' directory.  Updating the
difftool help text is still a manual process, and the documentation can
easily go out of sync.

Teach the command to read the list of valid tools from the 'mergetools'
directory, determine which of them are actually installed and then print
them for the user when the '--tool-help' option is given.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This replaces 9/9 in the previous version the series.

Changes in v7:

  - The list of possible tools is now tested to find out which are
    actually installed and available to run.
  - The user is informed that tools that require a windowed session will
    fail if they are running a terminal-only session.

This change is based on a suggestion given by Junio Hamano on the Git
developer list [1].

[1]: http://permalink.gmane.org/gmane.comp.version-control.git/193237


 Documentation/git-difftool.txt |   11 ++++++-----
 git-difftool.perl              |   40 +++++++++++++++++++++++++++++++++++++---
 t/t7800-difftool.sh            |    5 +++++
 3 files changed, 48 insertions(+), 8 deletions(-)

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
index 0fa131c..35370b8 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -14,7 +14,7 @@
 use 5.008;
 use strict;
 use warnings;
-use File::Basename qw(dirname);
+use File::Basename qw(dirname basename);
 use File::Copy;
 use File::stat;
 use File::Path qw(mkpath);
@@ -28,7 +28,7 @@ sub usage
 {
 	my $exitcode = shift;
 	print << 'USAGE';
-usage: git difftool [-t|--tool=<tool>]
+usage: git difftool [-t|--tool=<tool>] [--tool-help]
                     [-x|--extcmd=<cmd>]
                     [-g|--gui] [--no-gui]
                     [--prompt] [-y|--no-prompt]
@@ -38,6 +38,36 @@ USAGE
 	exit($exitcode);
 }
 
+sub print_tool_help
+{
+	my ($cmd, @found, @notfound);
+	my $gitpath = Git::exec_path();
+
+	for (glob "$gitpath/mergetools/*") {
+		my $tool = basename($_);
+		next if ($tool eq "defaults");
+
+		$cmd  = '. "$(git --exec-path)/git-mergetool--lib"';
+		$cmd .= " && get_merge_tool_path $tool >/dev/null 2>&1";
+		if (system('sh', '-c', $cmd) == 0) {
+			push(@found, $tool);
+		} else {
+			push(@notfound, $tool);
+		}
+	}
+
+	print "'git difftool --tool=<tool>' may be set to one of the following:\n";
+	print "\t$_\n" for (@found);
+
+	print "\nThe following tools are valid, but not currently available:\n";
+	print "\t$_\n" for (@notfound);
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
@@ -132,18 +162,22 @@ sub setup_dir_diff
 
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
1.7.10.rc1.36.gdd92a
