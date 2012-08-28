From: Max Kirillov <max@max630.net>
Subject: [PATCH/RFC] Add gui.displayuntracked option
Date: Tue, 28 Aug 2012 23:46:47 +0300
Message-ID: <20120828204647.GA15612@findesk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 22:54:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6SoG-00075N-D6
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 22:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901Ab2H1Uyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 16:54:45 -0400
Received: from p3plsmtpa09-07.prod.phx3.secureserver.net ([173.201.193.236]:57932
	"EHLO p3plsmtpa09-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752276Ab2H1Uyp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Aug 2012 16:54:45 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Aug 2012 16:54:45 EDT
Received: from findesk ([89.27.29.195])
	by p3plsmtpa09-07.prod.phx3.secureserver.net with 
	id sLmX1j0014CavkR01Lmd4y; Tue, 28 Aug 2012 13:46:38 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204452>

When git is used to track only a subset of a directory, or
there is no sure way to divide files to ignore from files to track,
git user have to live with large number of untracked files. These files
present in file list, and should always be scrolled through
to handle real changes. Situation can become even worse, then number
of the untracked files grows above the maxfilesdisplayed limit. In the
case, even staged files can be hidden by git-gui.

This change introduces new configuration variable gui.displayuntracked,
which, when set to false, instructs git-gui not to show untracked files
in files list. They can be staged from commandline or other tools (like
IDE of file manager), then they become visible. Default value of the
option is true, which is compatible with current behavior.

Signed-off-by: Max Kirillov <max@max630.net>
---
 git-gui/git-gui.sh     |   14 ++++++++++----
 git-gui/lib/option.tcl |    1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index ba4e5c1..504fc4a 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -897,6 +897,7 @@ set font_descs {
 	{fontdiff font_diff {mc "Diff/Console Font"}}
 }
 set default_config(gui.stageuntracked) ask
+set default_config(gui.displayuntracked) true
 
 ######################################################################
 ##
@@ -1535,18 +1536,23 @@ proc rescan_stage2 {fd after} {
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
 
 proc load_message {file} {
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
1.7.9.1
