From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 9/9] difftool: print list of valid tools with '--tool-help'
Date: Fri, 16 Mar 2012 22:00:13 -0400
Message-ID: <1331949613-15284-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 03:00:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8iwT-0007H7-00
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 03:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946122Ab2CQCAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 22:00:19 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61404 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945895Ab2CQCAR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 22:00:17 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so6234576iag.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 19:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=G2PchGUO3fxkP7PH1+94WmqOCxUU4JSxgqN+aibym38=;
        b=ujjB/VEfm0iYIEz75y4IFGKsEMrU4p+yD70UnB6BuSrNmJyyUa0Y9Q86P48GedNUnw
         FMxT7KQFbM8CyGKz2Kwsuhw5Qaeugovj8jaHc2P5ZO4Drd3fDXIPYlGZ3akTCdjHIXbG
         c1aT33HxlB9r9kW2lbgLQVFP70/8crgKnOTVDDK9UBf69VDhRWuMR/RAFwrXOBA1XJ1V
         iAru9LA4w+oBIgPdUfT5sovlUMF/8ITEdjEVrSbl3xYD3knzgH/Oz897ScMvhNZyN7Hh
         KCxkLYRWnTolmlyvce+yQB0zXNvajD5C4MfNlXNICMOpSqynhn9Q/DRqcOTh0bS1ouVV
         OFkw==
Received: by 10.50.57.133 with SMTP id i5mr1045879igq.14.1331949616920;
        Fri, 16 Mar 2012 19:00:16 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id k8sm1248867igz.4.2012.03.16.19.00.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 19:00:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193298>

Since bc7a96a (mergetool--lib: Refactor tools into separate files,
2011-08-18), it is possible to add a new diff tool by creating a simple
script in the '$(git --exec-path)/mergetools' directory.  Updating the
difftool help text is still a manual process, and the documentation can
easily go out of sync.

Teach the command to read the list of valid tools from the 'mergetools'
directory and print them for the user when the '--tool-help' option is
given.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>

Conflicts:

	git-difftool.perl
---
 Documentation/git-difftool.txt |   11 ++++++-----
 git-difftool.perl              |   17 ++++++++++++++---
 2 files changed, 20 insertions(+), 8 deletions(-)

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
index ebffd1e..c17266f 100755
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
@@ -28,7 +28,8 @@ sub usage
 {
 	my $exitcode = shift;
 	print << 'USAGE';
-usage: git difftool [-t|--tool=<tool>] [-x|--extcmd=<cmd>]
+usage: git difftool [-t|--tool=<tool>] [--tool-help]
+                    [-x|--extcmd=<cmd>]
                     [-y|--no-prompt]   [-g|--gui]
                     [-d|--dir-diff]
                     ['git diff' options]
@@ -129,18 +130,28 @@ sub setup_dir_diff
 
 # parse command-line options. all unrecognized options and arguments
 # are passed through to the 'git diff' command.
-my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $no_prompt, $prompt);
+my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $no_prompt, $prompt, $tool_help);
 GetOptions('g|gui' => \$gui,
 	'd|dir-diff' => \$dirdiff,
 	'h' => \$help,
 	'prompt' => \$prompt,
 	't|tool:s' => \$difftool_cmd,
+	'tool-help' => \$tool_help,
 	'x|extcmd:s' => \$extcmd,
 	'y|no-prompt' => \$no_prompt);
 
 if (defined($help)) {
 	usage(0);
 } 
+if (defined($tool_help)) {
+	my $gitpath = Git::exec_path();
+	print "'git difftool --tool=<tool>' may be set to one of the following:\n";
+	for (glob "mergetools/*") {
+		next if /defaults$/;
+		print "\t" . basename($_) . "\n";
+	}
+	exit(0);
+}
 if (defined($difftool_cmd)) {
 	if (length($difftool_cmd) > 0) {
 		$ENV{GIT_DIFF_TOOL} = $difftool_cmd;
-- 
1.7.9.1.290.gbd444
