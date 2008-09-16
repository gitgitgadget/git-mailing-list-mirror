From: Joshua Williams <joshua.williams@qlogic.com>
Subject: Re: [GIT-GUI PATCH] call prepare-commit-msg hook
Date: Tue, 16 Sep 2008 17:05:13 -0500
Message-ID: <48D02D99.9090102@qlogic.com>
References: <48D02144.8030409@qlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Jay Blakeborough <jay.blakeborough@qlogic.com>,
	Bill Lohse <bill.lohse@qlogic.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:06:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfigh-0007aI-1l
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 00:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbYIPWFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 18:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbYIPWFP
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 18:05:15 -0400
Received: from eppat.qlogic.com ([198.186.5.11]:15606 "EHLO EPEXCH1.qlogic.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751432AbYIPWFO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 18:05:14 -0400
Received: from Enki2.local ([10.20.32.63]) by EPEXCH1.qlogic.org with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 16 Sep 2008 17:05:12 -0500
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <48D02144.8030409@qlogic.com>
X-OriginalArrivalTime: 16 Sep 2008 22:05:12.0904 (UTC) FILETIME=[4AD64C80:01C91848]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96037>

Small change.  Still need to load MERGE_MSG and SQUASH_MSG
if there's no prepare-commit-msg hook.  We now process the hook
first and if it's not there, load MERGE_MSG or SQUASH_MSG.

Signed-off-by: Joshua Williams <joshua.williams@qlogic.com>
---
  git-gui/git-gui.sh |   64 
++++++++++++++++++++++++++++++++++++++++++++++++++++
  1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 10d8a44..8d06cd1 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1131,6 +1131,7 @@ proc rescan {after {honor_trustmtime 1}} {
  		|| [string trim [$ui_comm get 0.0 end]] eq {})} {
  		if {[string match amend* $commit_type]} {
  		} elseif {[load_message GITGUI_MSG]} {
+		} elseif {[run_prepare_commit_msg_hook]} {
  		} elseif {[load_message MERGE_MSG]} {
  		} elseif {[load_message SQUASH_MSG]} {
  		}
@@ -1230,6 +1231,69 @@ proc load_message {file} {
  	return 0
  }

+proc run_prepare_commit_msg_hook {} {
+	global pch_error
+
+	# prepare-commit-msg requires PREPARE_COMMIT_MSG exist.  From git-gui
+	# it will be .git/MERGE_MSG (merge), .git/SQUASH_MSG (squash), or an
+	# empty file but existant file.
+
+	set fd_pcm [open [gitdir PREPARE_COMMIT_MSG] a]
+
+	if {[file isfile [gitdir MERGE_MSG]]} {
+		set pcm_source "merge"
+		set fd_mm [open [gitdir MERGE_MSG] r]
+		puts -nonewline $fd_pcm [read $fd_mm]
+		close $fd_mm
+	} elseif {[file isfile [gitdir SQUASH_MSG]]} {
+		set pcm_source "squash"
+		set fd_sm [open [gitdir SQUASH_MSG] r]
+		puts -nonewline $fd_pcm [read $fd_sm]
+		close $fd_sm
+	} else {
+		set pcm_source ""
+	}
+
+	close $fd_pcm
+
+	set fd_ph [githook_read prepare-commit-msg \
+			[gitdir PREPARE_COMMIT_MSG] $pcm_source]
+	if {$fd_ph eq {}} {
+		catch {file delete [gitdir PREPARE_COMMIT_MSG]}
+		return 0;
+	}
+
+	ui_status [mc "Calling prepare-commit-msg hook..."]
+	set pch_error {}
+
+	fconfigure $fd_ph -blocking 0 -translation binary -eofchar {}
+	fileevent $fd_ph readable \
+		[list prepare_commit_msg_hook_wait $fd_ph]
+
+	return 1;
+}
+
+proc prepare_commit_msg_hook_wait {fd_ph} {
+	global pch_error
+
+	append pch_error [read $fd_ph]
+	fconfigure $fd_ph -blocking 1
+	if {[eof $fd_ph]} {
+		if {[catch {close $fd_ph}]} {
+			ui_status [mc "Commit declined by prepare-commit-msg hook."]
+			hook_failed_popup prepare-commit-msg $pch_error
+			exit 1
+		} else {
+			load_message PREPARE_COMMIT_MSG
+		}
+		set pch_error {}
+		catch {file delete [gitdir PREPARE_COMMIT_MSG]}
+		return
+        }
+	fconfigure $fd_ph -blocking 0
+	catch {file delete [gitdir PREPARE_COMMIT_MSG]}
+}
+
  proc read_diff_index {fd after} {
  	global buf_rdi
