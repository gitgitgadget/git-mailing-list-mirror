From: Joshua Williams <joshua.williams@qlogic.com>
Subject: Re: [GIT-GUI PATCH] call prepare-commit-msg hook
Date: Wed, 24 Sep 2008 14:11:53 -0500
Message-ID: <48DA90F9.8070606@qlogic.com>
References: <48D02144.8030409@qlogic.com> <48D02D99.9090102@qlogic.com> <20080924170434.GW3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Jay Blakeborough <jay.blakeborough@qlogic.com>,
	Bill Lohse <bill.lohse@qlogic.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 21:13:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiZnO-0002qD-DZ
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 21:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbYIXTLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 15:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752829AbYIXTLz
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 15:11:55 -0400
Received: from eppat.qlogic.com ([198.186.5.11]:43711 "EHLO EPEXCH1.qlogic.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752778AbYIXTLy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 15:11:54 -0400
Received: from Enki2.local ([10.20.32.63]) by EPEXCH1.qlogic.org with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 24 Sep 2008 14:11:52 -0500
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080924170434.GW3669@spearce.org>
X-OriginalArrivalTime: 24 Sep 2008 19:11:52.0915 (UTC) FILETIME=[6743EA30:01C91E79]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96683>

Shawn O. Pearce wrote:
> Joshua Williams <joshua.williams@qlogic.com> wrote:
>> Small change.  Still need to load MERGE_MSG and SQUASH_MSG
>> if there's no prepare-commit-msg hook.  We now process the hook
>> first and if it's not there, load MERGE_MSG or SQUASH_MSG.
>>
>> Signed-off-by: Joshua Williams <joshua.williams@qlogic.com>
> 
> This patch looks reasonable.  My only comment is maybe we want
> to delete PREPARE_COMMIT_MSG file when we "exit 1" when the hook
> has declined.

Good catch.  I've added that to the latest patch.

>> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>> index 10d8a44..8d06cd1 100755
>> --- a/git-gui/git-gui.sh
>> +++ b/git-gui/git-gui.sh
> 
> Can you please try to put this onto my current git-gui tree?
> I don't have the base 10d8a44 object so I can't 3-way merge
> this in, and the patch doesn't apply cleanly anymore.

Absolutely.  Here it is:

Add support to git-gui for calling out to the prepare-commit-msg hook.
Signed-off-by: Joshua Williams <joshua.williams@qlogic.com>
---
diff --git a/git-gui.sh b/git-gui.sh
index 1939001..cb0fcac 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1170,6 +1170,7 @@ proc rescan {after {honor_trustmtime 1}} {
  		|| [string trim [$ui_comm get 0.0 end]] eq {})} {
  		if {[string match amend* $commit_type]} {
  		} elseif {[load_message GITGUI_MSG]} {
+		} elseif {[run_prepare_commit_msg_hook]} {
  		} elseif {[load_message MERGE_MSG]} {
  		} elseif {[load_message SQUASH_MSG]} {
  		}
@@ -1269,6 +1270,70 @@ proc load_message {file} {
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
+			catch {file delete [gitdir PREPARE_COMMIT_MSG]}
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
