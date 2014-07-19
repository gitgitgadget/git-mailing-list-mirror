From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/2] difftool: don't assume that default sh is sane
Date: Sat, 19 Jul 2014 17:35:17 +0100
Message-ID: <1405787717-30476-2-git-send-email-charles@hashpling.org>
References: <1405787717-30476-1-git-send-email-charles@hashpling.org>
To: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 18:38:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8XeQ-0001yf-LQ
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 18:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbaGSQiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 12:38:18 -0400
Received: from avasout05.plus.net ([84.93.230.250]:36766 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbaGSQiR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 12:38:17 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout05 with smtp
	id UGeF1o00Y2iA9hg01GeGlf; Sat, 19 Jul 2014 17:38:17 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=DIIB4k9b c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=SB3M0fYuqUAA:10 a=mSBy96HJJ2wA:10 a=BHUvooL90DcA:10
 a=BNFp--SqAAAA:8 a=2bPKHU0i3SaWKyS1YWMA:9 a=92rhvNbd_XgA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1X8XbR-0007xs-Da; Sat, 19 Jul 2014 17:35:17 +0100
X-Mailer: git-send-email 2.0.2.611.g8c85416
In-Reply-To: <1405787717-30476-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253896>

From: Charles Bailey <cbailey32@bloomberg.net>

git-difftool used to create a command list script containing $( ... )
and explicitly call "sh -c" with this list.

Instead, allow mergetool --tool-help to take a mode parameter and call
mergetool directly to invoke the show_tool_help function. This mode
parameter is intented for use solely by difftool.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
Another issue for Solaris. Originally I had a fix for this that
substituted "@SHELL_PATH@" even inside perl scripts but I felt that
having an interface for show_tool_help was a little neater all round but
I welcome alternative views.

 git-difftool.perl |  6 +-----
 git-mergetool.sh  | 12 +++++++++++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 18ca61e..598fcc2 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -47,13 +47,9 @@ sub find_worktree
 
 sub print_tool_help
 {
-	my $cmd = 'TOOL_MODE=diff';
-	$cmd .= ' && . "$(git --exec-path)/git-mergetool--lib"';
-	$cmd .= ' && show_tool_help';
-
 	# See the comment at the bottom of file_diff() for the reason behind
 	# using system() followed by exit() instead of exec().
-	my $rc = system('sh', '-c', $cmd);
+	my $rc = system(qw(git mergetool --tool-help=diff));
 	exit($rc | ($rc >> 8));
 }
 
diff --git a/git-mergetool.sh b/git-mergetool.sh
index e969dd0..d32b663 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -320,7 +320,17 @@ guessed_merge_tool=false
 while test $# != 0
 do
 	case "$1" in
-	--tool-help)
+	--tool-help*)
+		case "$#,$1" in
+		1,*=*)
+			TOOL_MODE=$(expr "z$1" : 'z-[^=]*=\(.*\)')
+			;;
+		1,--tool-help)
+			;;
+		*)
+			usage
+			;;
+		esac
 		show_tool_help
 		;;
 	-t|--tool*)
-- 
2.0.2.611.g8c85416
