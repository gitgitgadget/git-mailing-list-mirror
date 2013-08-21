From: Max Kirillov <max@max630.net>
Subject: [PATCH] Add gui.displayuntracked option
Date: Wed, 21 Aug 2013 06:29:13 +0300
Message-ID: <20130821032913.GA6092@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Aug 21 05:37:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBzEH-0005H2-Jt
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 05:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab3HUDg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 23:36:56 -0400
Received: from m1plsmtpa01-06.prod.mesa1.secureserver.net ([64.202.165.34]:36137
	"EHLO m1plsmtpa01-06.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085Ab3HUDgz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 23:36:55 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2013 23:36:55 EDT
Received: from wheezy.local ([89.27.29.195])
	by m1plsmtpa01-06.prod.mesa1.secureserver.net with 
	id FFV91m00K4CavkR01FVHuJ; Tue, 20 Aug 2013 20:29:19 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232683>

When git is used to track only a subset of a directory, or
there is no sure way to divide files to ignore from files to track,
git user have to live with large number of untracked files. These files
present in file list, and should always be scrolled through
to handle real changes. Situation can become even worse, then number
of the untracked files grows above the maxfilesdisplayed limit. In the
case, even staged can be hidden by git-gui.

This change introduces new configuration variable gui.displayuntracked,
which, when set to false, instructs git-gui not to show untracked files
in files list. They can be staged from commandline or other tools (like
IDE of file manager), then they become visible. Default value of the
option is true, which is compatible with current behavior.

Signed-off-by: Max Kirillov <max@max630.net>
---
Hi. I've been using git for some time and have collected a
number of changes which might worth sharing.
Please consider adding them to the upstream.

Thanks,
Max

 Documentation/config.txt |  4 ++++
 git-gui/git-gui.sh       | 14 ++++++++++----
 git-gui/lib/option.tcl   |  1 +
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bbba728..7a786b2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1277,6 +1277,10 @@ gui.diffcontext::
 	Specifies how many context lines should be used in calls to diff
 	made by the linkgit:git-gui[1]. The default is "5".
 
+gui.displayuntracked::
+	Determines if linkgit::git-gui[1] shows untracked files
+	in the file list. The defaulit is "true".
+
 gui.encoding::
 	Specifies the default encoding to use for displaying of
 	file contents in linkgit:git-gui[1] and linkgit:gitk[1].
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 89f636f..42c35ad 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -898,6 +898,7 @@ set font_descs {
 	{fontdiff font_diff {mc "Diff/Console Font"}}
 }
 set default_config(gui.stageuntracked) ask
+set default_config(gui.displayuntracked) true
 
 ######################################################################
 ##
@@ -1536,18 +1537,23 @@ proc rescan_stage2 {fd after} {
 	set buf_rdf {}
 	set buf_rlo {}
 
-	set rescan_active 3
+	set rescan_active 2
 	ui_status [mc "Scanning for modified files ..."]
 	set fd_di [git_read diff-index --cached -z [PARENT]]
 	set fd_df [git_read diff-files -z]
-	set fd_lo [eval git_read ls-files --others -z $ls_others]
 
 	fconfigure $fd_di -blocking 0 -translation binary -encoding binary
 	fconfigure $fd_df -blocking 0 -translation binary -encoding binary
-	fconfigure $fd_lo -blocking 0 -translation binary -encoding binary
+
 	fileevent $fd_di readable [list read_diff_index $fd_di $after]
 	fileevent $fd_df readable [list read_diff_files $fd_df $after]
-	fileevent $fd_lo readable [list read_ls_others $fd_lo $after]
+
+	if {[is_config_true gui.displayuntracked]} {
+		set fd_lo [eval git_read ls-files --others -z $ls_others]
+		fconfigure $fd_lo -blocking 0 -translation binary -encoding binary
+		fileevent $fd_lo readable [list read_ls_others $fd_lo $after]
+		incr rescan_active
+	}
 }
 
 proc load_message {file {encoding {}}} {
diff --git a/git-gui/lib/option.tcl b/git-gui/lib/option.tcl
index 0cf1da1..2177db6 100644
--- a/git-gui/lib/option.tcl
+++ b/git-gui/lib/option.tcl
@@ -159,6 +159,7 @@ proc do_options {} {
 		{c gui.encoding {mc "Default File Contents Encoding"}}
 		{b gui.warndetachedcommit {mc "Warn before committing to a detached head"}}
 		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes" "no" "ask"}}
+		{b gui.displayuntracked {mc "Show untracked files"}}
 		} {
 		set type [lindex $option 0]
 		set name [lindex $option 1]
-- 
1.8.4.rc3.902.g80a4b9e
