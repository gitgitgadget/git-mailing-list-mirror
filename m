From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC PATCH (GIT-GUI)] git-gui: Add more integration options to citool.
Date: Fri, 12 Sep 2008 22:43:49 +0400
Organization: HOME
Message-ID: <200809122243.50007.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 20:46:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeDep-0008Fd-NZ
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 20:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbYILSpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 14:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753614AbYILSpI
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 14:45:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:35214 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbYILSpG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 14:45:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so562768fgg.17
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2XeotsewM+n7JD8oZ5b0kZapBmbydddozaixBTk5OAQ=;
        b=Vd3j2geA6ojKxFamUrpc5nUX+lLe6y9hCSApWS3Y2CmcwR23nPCvA19Sl6c5GpK4dn
         0Un909VrwEzbfwKuVTlV/jkgq/KaJ+VPwOVfmHPc0HaBA7xhIuuxit4nzCwi5HD793QJ
         tmlFnCdHz5oYhxb2EZl8Us/Wtw9YI37lfidbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=Kcdm1ljLhIBcqHEovhhxoFjv6ropWQwgT5f/hyCHCqJFa1kdzbx8Qqvp53tmxKH4f0
         h25St6+AgqBjGx8I+QJ4B51vN/eASwkGjG3XCRYnVe13JoLImGRG1Yg2HxE63E4e0e01
         epKcaipKMW1fy9dmj3pv+3NWYnkIyPBAtyfRI=
Received: by 10.180.225.16 with SMTP id x16mr3495602bkg.91.1221245104190;
        Fri, 12 Sep 2008 11:45:04 -0700 (PDT)
Received: from ?192.168.100.3? ( [92.255.85.78])
        by mx.google.com with ESMTPS id g28sm10788865fkg.8.2008.09.12.11.45.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 11:45:02 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95759>

- Make citool return nonzero exit code if it did not commit.
- Add a mode where it does not actually commit and simply
  exits with zero code. Commit message is either disabled,
  or simply dumped to GITGUI_EDITMSG before exiting.
- Add an option to immediately start it in amend mode.

Rationale:

1) Use 'git citool --nocommit' instead of mergetool in scripts.
2) Use 'git citool --amend' to edit commits while rebasing.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	I think this functionality might be useful, in particular for some of
	my own scripts. But I'm not sure if this is the best way to do it.

	-- Alexander


 git-gui.sh     |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 lib/commit.tcl |    8 ++++-
 2 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index fb43255..91457a2 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -961,10 +961,32 @@ blame {
 }
 citool {
 	enable_option singlecommit
+	enable_option retcode
 
 	disable_option multicommit
 	disable_option branch
 	disable_option transport
+
+	while {[llength $argv] > 0} {
+		set a [lindex $argv 0]
+		switch -- $a {
+		--amend {
+			enable_option initialamend
+		}
+		--nocommit {
+			enable_option nocommit
+			enable_option nocommitmsg
+		}
+		--commitmsg {
+			disable_option nocommitmsg
+		}
+		default {
+			break
+		}
+		}
+
+		set argv [lrange $argv 1 end]
+	}
 }
 }
 
@@ -1121,6 +1143,20 @@ proc PARENT {} {
 	return $empty_tree
 }
 
+proc force_amend {} {
+	global selected_commit_type
+	global HEAD PARENT MERGE_HEAD commit_type
+
+	repository_state newType newHEAD newMERGE_HEAD
+	set HEAD $newHEAD
+	set PARENT $newHEAD
+	set MERGE_HEAD $newMERGE_HEAD
+	set commit_type $newType
+
+	set selected_commit_type amend
+	do_select_commit_type
+}
+
 proc rescan {after {honor_trustmtime 1}} {
 	global HEAD PARENT MERGE_HEAD commit_type
 	global ui_index ui_workdir ui_comm
@@ -1767,11 +1803,19 @@ proc do_gitk {revs} {
 }
 
 set is_quitting 0
+set ret_code    1
 
-proc do_quit {} {
+proc terminate_me {win} {
+	global ret_code
+	if {$win ne {.}} return
+	exit $ret_code
+}
+
+proc do_quit {{rc {1}}} {
 	global ui_comm is_quitting repo_config commit_type
 	global GITGUI_BCK_exists GITGUI_BCK_i
 	global ui_comm_spell
+	global ret_code
 
 	if {$is_quitting} return
 	set is_quitting 1
@@ -1826,6 +1870,7 @@ proc do_quit {} {
 		}
 	}
 
+	set ret_code $rc
 	destroy .
 }
 
@@ -2228,6 +2273,14 @@ if {[is_enabled branch]} {
 
 # -- Commit Menu
 #
+proc commit_btn_caption {} {
+	if {[is_enabled nocommit]} {
+		return [mc "Done"]
+	} else {
+		return [mc Commit@@verb]
+	}
+}
+
 if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 	menu .mbar.commit
 
@@ -2293,7 +2346,7 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 		-command do_signoff \
 		-accelerator $M1T-S
 
-	.mbar.commit add command -label [mc Commit@@verb] \
+	.mbar.commit add command -label [commit_btn_caption] \
 		-command do_commit \
 		-accelerator $M1T-Return
 	lappend disable_on_lock \
@@ -2621,7 +2674,7 @@ button .vpane.lower.commarea.buttons.signoff -text [mc "Sign Off"] \
 	-command do_signoff
 pack .vpane.lower.commarea.buttons.signoff -side top -fill x
 
-button .vpane.lower.commarea.buttons.commit -text [mc Commit@@verb] \
+button .vpane.lower.commarea.buttons.commit -text [commit_btn_caption] \
 	-command do_commit
 pack .vpane.lower.commarea.buttons.commit -side top -fill x
 lappend disable_on_lock \
@@ -2631,6 +2684,13 @@ button .vpane.lower.commarea.buttons.push -text [mc Push] \
 	-command do_push_anywhere
 pack .vpane.lower.commarea.buttons.push -side top -fill x
 
+if {[is_enabled nocommitmsg]} {
+	.vpane.lower.commarea.buttons.signoff configure -state disabled
+}
+if {[is_enabled nocommit]} {
+	.vpane.lower.commarea.buttons.push configure -state disabled
+}
+
 # -- Commit Message Buffer
 #
 frame .vpane.lower.commarea.buffer
@@ -3212,7 +3272,20 @@ lock_index begin-read
 if {![winfo ismapped .]} {
 	wm deiconify .
 }
-after 1 do_rescan
+after 1 {
+	if {[is_enabled initialamend]} {
+		force_amend
+	} else {
+		do_rescan
+	}
+
+	if {[is_enabled nocommitmsg]} {
+		$ui_comm configure -state disabled -background gray
+	}
+}
 if {[is_enabled multicommit]} {
 	after 1000 hint_gc
 }
+if {[is_enabled retcode]} {
+	bind . <Destroy> {+terminate_me %W}
+}
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 2977315..3345149 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -168,7 +168,7 @@ File %s cannot be committed by this program.
 		}
 		}
 	}
-	if {!$files_ready && ![string match *merge $curType]} {
+	if {!$files_ready && ![string match *merge $curType] && ![is_enabled nocommit]} {
 		info_popup [mc "No changes to commit.
 
 You must stage at least 1 file before you can commit.
@@ -177,6 +177,8 @@ You must stage at least 1 file before you can commit.
 		return
 	}
 
+	if {[is_enabled nocommitmsg]} { do_quit 0 }
+
 	# -- A message is required.
 	#
 	set msg [string trim [$ui_comm get 1.0 end]]
@@ -212,6 +214,8 @@ A good commit message has the following format:
 	puts $msg_wt $msg
 	close $msg_wt
 
+	if {[is_enabled nocommit]} { do_quit 0 }
+
 	# -- Run the pre-commit hook.
 	#
 	set fd_ph [githook_read pre-commit]
@@ -410,7 +414,7 @@ A rescan will be automatically started now.
 		set ::GITGUI_BCK_exists 0
 	}
 
-	if {[is_enabled singlecommit]} do_quit
+	if {[is_enabled singlecommit]} { do_quit 0 }
 
 	# -- Update in memory status
 	#
-- 
1.6.0.20.g6148bc
