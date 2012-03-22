From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 10/9 v4] difftool: fix regression in '--prompt' options
Date: Wed, 21 Mar 2012 21:53:56 -0400
Message-ID: <1332381236-16004-1-git-send-email-tim.henigan@gmail.com>
References: <1332358560-13774-4-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 02:54:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAXEF-0001YV-Cw
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 02:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab2CVByK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 21:54:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38052 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab2CVByH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 21:54:07 -0400
Received: by iagz16 with SMTP id z16so2397964iag.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 18:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AjwUjNgwM1rOGi90U4ULWoWlyDGYXeSrZ5ZE9LHx+iE=;
        b=O8Vwl+ZMW2po8/8hS9k8+kw2aFc22L9R5Lypx8Cee4tM68M1PlbIBVrnqYdGGIaiax
         s1i4s4SXmHm+iKztKIwm//ll2x2/Xku2+JbcO9IfPOS8XqqEGbs0BYMCCbeT0IPdpiTQ
         TNGQT8Jx8psYdE8seULyzRja/Z3caNNP2HFnrRVzEEl+1yXtbol6N+rYMMalL/FI6PY3
         feuPrP1bmCwSPdh8w6Rsn4donYGVL25s/UeIv/AvEbxjAOAMq+riIygMhD28c//yOXDh
         IraWg+3kIZgG+l1vbBRqFKhw4mBibeSTwmlRuiYMH+mza44Uzi5/wnLP/8PiTNLBWEgx
         LSeA==
Received: by 10.50.220.138 with SMTP id pw10mr147156igc.71.1332381246769;
        Wed, 21 Mar 2012 18:54:06 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id en8sm385679igc.7.2012.03.21.18.54.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 18:54:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.39.gdeb0e
In-Reply-To: <1332358560-13774-4-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193630>

When difftool was changed to use Getopt::Long, it changed the way
that the '--prompt' and '--no-prompt' options were handled. The
expected behavior is that the two options may be given any number
of times. The last option given "wins".

For example, if a user sets "[alias] mdt = difftool --prompt", the
following must still run without error:

$ git mdt --no-prompt

The changes made during the switch to Getopt::Long broke this
behavior. This commit teaches difftool to handle them properly
again.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This replaces 10/9 in v3 of the series.

Changes in v4:
  - '--prompt' and '--no-prompt' may be used together again.
  - Removed changes made to t7800.  The old test now passes.


 git-difftool.perl |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 9f0f9a9..41c6557 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -22,6 +22,7 @@ use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
 
+my @diffargs;
 my @working_tree;
 
 sub usage
@@ -41,7 +42,7 @@ sub setup_dir_diff
 {
 	# Run the diff; exit immediately if no diff found
 	my $repo = Git->repository();
-	my $diffrtn = $repo->command_oneline(['diff', '--raw', '--no-abbrev', '-z', @ARGV]);
+	my $diffrtn = $repo->command_oneline(['diff', '--raw', '--no-abbrev', '-z', @diffargs]);
 	exit(0) if (length($diffrtn) == 0);
 
 	# Setup temp directories
@@ -131,15 +132,25 @@ sub setup_dir_diff
 
 # parse command-line options. all unrecognized options and arguments
 # are passed through to the 'git diff' command.
-my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $no_prompt, $prompt, $tool_help);
+my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $prompt, $tool_help);
 GetOptions('g|gui' => \$gui,
 	'd|dir-diff' => \$dirdiff,
 	'h' => \$help,
-	'prompt' => \$prompt,
 	't|tool:s' => \$difftool_cmd,
 	'tool-help' => \$tool_help,
-	'x|extcmd:s' => \$extcmd,
-	'y|no-prompt' => \$no_prompt);
+	'x|extcmd:s' => \$extcmd);
+
+# the '--prompt' and '--no-prompt' options require special treatment
+# because they may be specified more than once...the last one "wins".
+for (@ARGV) {
+	if (($_ eq "-y") or ($_ eq "--no-prompt")) {
+		$prompt = 0;
+	} elsif ($_ eq "--prompt") {
+		$prompt = 1;
+	} else {
+		push(@diffargs, $_);
+	}
+}
 
 if (defined($help)) {
 	usage(0);
@@ -203,13 +214,14 @@ if (defined($dirdiff)) {
 	}
 } else {
 	if (defined($prompt)) {
-		$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
-	}
-	elsif (defined($no_prompt)) {
-		$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+		if ($prompt) {
+			$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
+		} else {
+			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+		}
 	}
 
 	$ENV{GIT_PAGER} = '';
 	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
-	git_cmd_try { Git::command_noisy(('diff', @ARGV)) } 'exit code %d';
+	git_cmd_try { Git::command_noisy(('diff', @diffargs)) } 'exit code %d';
 }
-- 
1.7.10.rc1.39.gdeb0e
