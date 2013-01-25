From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 4/7] git-difftool: use git-mergetool--lib for "--tool-help"
Date: Fri, 25 Jan 2013 01:43:51 -0800
Message-ID: <1359107034-14606-5-git-send-email-davvid@gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:45:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyfqM-0008GQ-SU
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618Ab3AYJoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:44:15 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39513 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab3AYJoL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:44:11 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so26257ieb.20
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hiEk3HX7wnl22a++psO/I+ap7TTunDCiBzdO0hOdep8=;
        b=Y1U21mWpzeVi2UqD5nJ2nZLdFW0o1SlXNiojOWRuuiG9FFm8Snj/pnGRFUZ/GrmoW5
         hPi4LXmTdTPHTr8yDE/ndUK5aYzwsW8Tn8U1CO8YA/4YgpmlvfFIG5pmNlTN2m5UTBwC
         o0HTlkpzW5xu5u/XORtLcSQ5ls7v7U/ZNTEtYNAI1Ccex29K1g2ueU2YLo4x+yxKrn+O
         HXjIKwcU4bVfeuISQaZWLU/v52tprPhmDm2iAtk6DeP3EsFUldHo6v18XgUFakkwKFos
         R/+4rj9T3eyGsETECTl+y/g5agh1c3jyjxwi9M2ilt9+DsbhScJOgkDdCnHk9pKYiGgM
         RYQQ==
X-Received: by 10.50.95.227 with SMTP id dn3mr1194007igb.99.1359107050828;
        Fri, 25 Jan 2013 01:44:10 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id gs6sm314611igc.11.2013.01.25.01.44.09
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 01:44:10 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.367.g22b1720.dirty
In-Reply-To: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214530>

From: John Keeping <john@keeping.me.uk>

The "--tool-help" option to git-difftool currently displays incorrect
output since it uses the names of the files in
"$GIT_EXEC_PATH/mergetools/" rather than the list of command names in
git-mergetool--lib.

Fix this by simply delegating the "--tool-help" argument to the
show_tool_help function in git-mergetool--lib.

Signed-off-by: John Keeping <john@keeping.me.uk>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 55 +++++++------------------------------------------------
 1 file changed, 7 insertions(+), 48 deletions(-)

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
+	my $cmd = 'TOOL_MODE=diff';
+	$cmd .= ' && . "$(git --exec-path)/git-mergetool--lib"';
+	$cmd .= ' && show_tool_help';
 
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
+	# See the comment at the bottom of file_diff() for the reason behind
+	# using system() followed by exit() instead of exec().
+	my $rc = system('sh', '-c', $cmd);
+	exit($rc | ($rc >> 8));
 }
 
 sub exit_cleanup
-- 
1.8.1.1.367.g22b1720.dirty
