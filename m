From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 4/4] git-difftool: use git-mergetool--lib for "--tool-help"
Date: Thu, 24 Jan 2013 19:55:16 +0000
Message-ID: <b791e866c02b0c118f08bde1d7ca6c41d6239989.1359057056.git.john@keeping.me.uk>
References: <cover.1359057056.git.john@keeping.me.uk>
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 20:56:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TySud-0007ah-3z
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 20:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082Ab3AXT4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 14:56:08 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:55698 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab3AXT4E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 14:56:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 8976F23100;
	Thu, 24 Jan 2013 19:56:02 +0000 (GMT)
X-Quarantine-ID: <jIaGmFFtOjc8>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jIaGmFFtOjc8; Thu, 24 Jan 2013 19:56:01 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 769B22318D;
	Thu, 24 Jan 2013 19:55:56 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.1.364.gbbf604e.dirty
In-Reply-To: <cover.1359057056.git.john@keeping.me.uk>
In-Reply-To: <cover.1359057056.git.john@keeping.me.uk>
References: <cover.1359057056.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214449>

The "--tool-help" option to git-difftool currently displays incorrect
output since it uses the names of the files in
"$GIT_EXEC_PATH/mergetools/" rather than the list of command names in
git-mergetool--lib.

Fix this by simply delegating the "--tool-help" argument to the
show_tool_help function in git-mergetool--lib.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-difftool.perl | 57 ++++++++-----------------------------------------------
 1 file changed, 8 insertions(+), 49 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index edd0493..0a90de4 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -59,57 +59,16 @@ sub find_worktree
 	return $worktree;
 }
 
-sub filter_tool_scripts
-{
-	my ($tools) = @_;
-	if (-d $_) {
-		if ($_ ne ".") {
-			# Ignore files in subdirectories
-			$File::Find::prune = 1;
-		}
-	} else {
-		if ((-f $_) && ($_ ne "defaults")) {
-			push(@$tools, $_);
-		}
-	}
-}
-
 sub print_tool_help
 {
-	my ($cmd, @found, @notfound, @tools);
-	my $gitpath = Git::exec_path();
-
-	find(sub { filter_tool_scripts(\@tools) }, "$gitpath/mergetools");
-
-	foreach my $tool (@tools) {
-		$cmd  = "TOOL_MODE=diff";
-		$cmd .= ' && . "$(git --exec-path)/git-mergetool--lib"';
-		$cmd .= " && get_merge_tool_path $tool >/dev/null 2>&1";
-		$cmd .= " && can_diff >/dev/null 2>&1";
-		if (system('sh', '-c', $cmd) == 0) {
-			push(@found, $tool);
-		} else {
-			push(@notfound, $tool);
-		}
-	}
-
-	print << 'EOF';
-'git difftool --tool=<tool>' may be set to one of the following:
-EOF
-	print "\t$_\n" for (sort(@found));
-
-	print << 'EOF';
-
-The following tools are valid, but not currently available:
-EOF
-	print "\t$_\n" for (sort(@notfound));
-
-	print << 'EOF';
-
-NOTE: Some of the tools listed above only work in a windowed
-environment. If run in a terminal-only session, they will fail.
-EOF
-	exit(0);
+	my $cmd = 'TOOL_MODE=diff';
+	$cmd .= ' && . "$(git --exec-path)/git-mergetool--lib"';
+	$cmd .= ' && show_tool_help';
+
+	# See the comment at the bottom of file_diff() for the reason behind
+	# using system() followed by exit() instead of exec().
+	my $rc = system('sh', '-c', $cmd);
+	exit($rc | ($rc >> 8));
 }
 
 sub exit_cleanup
-- 
1.8.1
