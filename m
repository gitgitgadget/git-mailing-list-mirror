From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 2/8] git-gui: Support resolving conflicts via the diff context menu.
Date: Sun, 31 Aug 2008 00:55:45 +0400
Organization: TEPKOM
Message-ID: <200808310055.45679.angavrilov@gmail.com>
References: <200808310052.21595.angavrilov@gmail.com> <200808310054.19732.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 23:16:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXo3-00089f-8a
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757263AbYH3VOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 17:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757258AbYH3VO3
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:14:29 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:57628 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603AbYH3VO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 17:14:26 -0400
Received: by fk-out-0910.google.com with SMTP id 18so883437fkq.5
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 14:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=M0CaemuurZQLxIz2KuL9WXIOZIsgG0rlf5rNWHAsoWk=;
        b=xOcIdnrDOiCzosy69GZ+YQT0jczwp/mfiXcXhexjmodAWGvVgbIf45SZ9P8dnEqe4c
         Vu6MQW/ZmFnr0oJyYEdX9pTdMhpTobPaQnayZUnx/iFN5rOomX6WySoqO3d35tjXXzEs
         B3tsgsggvyzNJXUZIbZS3Ki1MdUM0bPDnR90Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fDkdmR9KDYvFsd8IZHoRqMC4cI57nCDkphmVPff84IUv+qDqKXFUjwYEqFAN+G9MoS
         bUWzwsoctOP54gd/leVY1Feg4XqZIslNYP5WAXPqTm6SEB9TCrzAl/CteQJ4zMdc+FA6
         L554h4t2AzaT1EsbsJqTwYMHdHaxhbOsEFbuk=
Received: by 10.180.228.12 with SMTP id a12mr4115016bkh.34.1220130865700;
        Sat, 30 Aug 2008 14:14:25 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id d13sm4092560fka.3.2008.08.30.14.14.24
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 14:14:24 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808310054.19732.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94426>

If the file has merge conflicts, show a special version of the
diff context menu, which includes conflict resolution commands
instead of Stage Hunk/Line. This patch only supports resolving
by discarding all sides except one.

Discarding is the only way to resolve conflicts involving symlinks
and/or deletion, excluding manual editing.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh        |  152 ++++++++++++++++++++++++++++++++---------------------
 lib/mergetool.tcl |   98 ++++++++++++++++++++++++++++++++++
 2 files changed, 190 insertions(+), 60 deletions(-)
 create mode 100644 lib/mergetool.tcl

diff --git a/git-gui.sh b/git-gui.sh
index 9df4f8c..90d597e 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2721,6 +2721,51 @@ $ui_diff tag raise sel
 
 # -- Diff Body Context Menu
 #
+
+proc create_common_diff_popup {ctxm} {
+	$ctxm add command \
+		-label [mc "Show Less Context"] \
+		-command show_less_context
+	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+	$ctxm add command \
+		-label [mc "Show More Context"] \
+		-command show_more_context
+	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+	$ctxm add separator
+	$ctxm add command \
+		-label [mc Refresh] \
+		-command reshow_diff
+	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+	$ctxm add command \
+		-label [mc Copy] \
+		-command {tk_textCopy $ui_diff}
+	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+	$ctxm add command \
+		-label [mc "Select All"] \
+		-command {focus $ui_diff;$ui_diff tag add sel 0.0 end}
+	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+	$ctxm add command \
+		-label [mc "Copy All"] \
+		-command {
+			$ui_diff tag add sel 0.0 end
+			tk_textCopy $ui_diff
+			$ui_diff tag remove sel 0.0 end
+		}
+	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+	$ctxm add separator
+	$ctxm add command \
+		-label [mc "Decrease Font Size"] \
+		-command {incr_font_size font_diff -1}
+	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+	$ctxm add command \
+		-label [mc "Increase Font Size"] \
+		-command {incr_font_size font_diff 1}
+	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+	$ctxm add separator
+	$ctxm add command -label [mc "Options..."] \
+		-command do_options
+}
+
 set ctxm .vpane.lower.diff.body.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
@@ -2734,73 +2779,60 @@ $ctxm add command \
 set ui_diff_applyline [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyline -state]
 $ctxm add separator
-$ctxm add command \
-	-label [mc "Show Less Context"] \
-	-command show_less_context
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-$ctxm add command \
-	-label [mc "Show More Context"] \
-	-command show_more_context
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-$ctxm add separator
-$ctxm add command \
-	-label [mc Refresh] \
-	-command reshow_diff
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-$ctxm add command \
-	-label [mc Copy] \
-	-command {tk_textCopy $ui_diff}
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-$ctxm add command \
-	-label [mc "Select All"] \
-	-command {focus $ui_diff;$ui_diff tag add sel 0.0 end}
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-$ctxm add command \
-	-label [mc "Copy All"] \
-	-command {
-		$ui_diff tag add sel 0.0 end
-		tk_textCopy $ui_diff
-		$ui_diff tag remove sel 0.0 end
-	}
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-$ctxm add separator
-$ctxm add command \
-	-label [mc "Decrease Font Size"] \
-	-command {incr_font_size font_diff -1}
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-$ctxm add command \
-	-label [mc "Increase Font Size"] \
-	-command {incr_font_size font_diff 1}
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-$ctxm add separator
-$ctxm add command -label [mc "Options..."] \
-	-command do_options
-proc popup_diff_menu {ctxm x y X Y} {
+create_common_diff_popup $ctxm
+
+set ctxmmg .vpane.lower.diff.body.ctxmmg
+menu $ctxmmg -tearoff 0
+$ctxmmg add command \
+	-label [mc "Use Remote Version"] \
+	-command {merge_resolve_one 3}
+lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
+$ctxmmg add command \
+	-label [mc "Use Local Version"] \
+	-command {merge_resolve_one 2}
+lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
+$ctxmmg add command \
+	-label [mc "Revert To Base"] \
+	-command {merge_resolve_one 1}
+lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
+$ctxmmg add separator
+create_common_diff_popup $ctxmmg
+
+proc popup_diff_menu {ctxm ctxmmg x y X Y} {
 	global current_diff_path file_states
 	set ::cursorX $x
 	set ::cursorY $y
-	if {$::ui_index eq $::current_diff_side} {
-		set l [mc "Unstage Hunk From Commit"]
-		set t [mc "Unstage Line From Commit"]
+	if {[info exists file_states($current_diff_path)]} {
+		set state [lindex $file_states($current_diff_path) 0]
 	} else {
-		set l [mc "Stage Hunk For Commit"]
-		set t [mc "Stage Line For Commit"]
-	}
-	if {$::is_3way_diff
-		|| $current_diff_path eq {}
-		|| ![info exists file_states($current_diff_path)]
-		|| {_O} eq [lindex $file_states($current_diff_path) 0]
-		|| {_T} eq [lindex $file_states($current_diff_path) 0]
-		|| {T_} eq [lindex $file_states($current_diff_path) 0]} {
-		set s disabled
+		set state {__}
+	}
+	if {[string index $state 0] eq {U}} {
+		tk_popup $ctxmmg $X $Y
 	} else {
-		set s normal
+		if {$::ui_index eq $::current_diff_side} {
+			set l [mc "Unstage Hunk From Commit"]
+			set t [mc "Unstage Line From Commit"]
+		} else {
+			set l [mc "Stage Hunk For Commit"]
+			set t [mc "Stage Line For Commit"]
+		}
+		if {$::is_3way_diff
+			|| $current_diff_path eq {}
+			|| {__} eq $state
+			|| {_O} eq $state
+			|| {_T} eq $state
+			|| {T_} eq $state} {
+			set s disabled
+		} else {
+			set s normal
+		}
+		$ctxm entryconf $::ui_diff_applyhunk -state $s -label $l
+		$ctxm entryconf $::ui_diff_applyline -state $s -label $t
+		tk_popup $ctxm $X $Y
 	}
-	$ctxm entryconf $::ui_diff_applyhunk -state $s -label $l
-	$ctxm entryconf $::ui_diff_applyline -state $s -label $t
-	tk_popup $ctxm $X $Y
 }
-bind_button3 $ui_diff [list popup_diff_menu $ctxm %x %y %X %Y]
+bind_button3 $ui_diff [list popup_diff_menu $ctxm $ctxmmg %x %y %X %Y]
 
 # -- Status Bar
 #
diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
new file mode 100644
index 0000000..7945d74
--- /dev/null
+++ b/lib/mergetool.tcl
@@ -0,0 +1,98 @@
+# git-gui merge conflict resolution
+# parts based on git-mergetool (c) 2006 Theodore Y. Ts'o
+
+proc merge_resolve_one {stage} {
+	global current_diff_path
+
+	switch -- $stage {
+		1 { set target [mc "the base version"] }
+		2 { set target [mc "this branch"] }
+		3 { set target [mc "the other branch"] }
+	}
+
+	set op_question [mc "Force resolution to %s?
+Note that the diff shows only conflicting changes.
+
+%s will be overwritten.
+
+This operation can be undone only by restarting the merge." \
+		$target [short_path $current_diff_path]]
+
+	if {[ask_popup $op_question] eq {yes}} {
+		merge_load_stages $current_diff_path [list merge_force_stage $stage]
+	}
+}
+
+proc merge_add_resolution {path} {
+	global current_diff_path
+
+	if {$path eq $current_diff_path} {
+		set after {reshow_diff;}
+	} else {
+		set after {}
+	}
+
+	update_index \
+		[mc "Adding resolution for %s" [short_path $path]] \
+		[list $path] \
+		[concat $after [list ui_ready]]
+}
+
+proc merge_force_stage {stage} {
+	global current_diff_path merge_stages
+
+	if {$merge_stages($stage) ne {}} {
+		git checkout-index -f --stage=$stage -- $current_diff_path
+	} else {
+		file delete -- $current_diff_path
+	}
+
+	merge_add_resolution $current_diff_path
+}
+
+proc merge_load_stages {path cont} {
+	global merge_stages_fd merge_stages merge_stages_buf
+
+	if {[info exists merge_stages_fd]} {
+		catch { kill_file_process $merge_stages_fd }
+		catch { close $merge_stages_fd }
+	}
+
+	set merge_stages(0) {}
+	set merge_stages(1) {}
+	set merge_stages(2) {}
+	set merge_stages(3) {}
+	set merge_stages_buf {}
+
+	set merge_stages_fd [eval git_read ls-files -u -z -- $path]
+
+	fconfigure $merge_stages_fd -blocking 0 -translation binary -encoding binary
+	fileevent $merge_stages_fd readable [list read_merge_stages $merge_stages_fd $cont]
+}
+
+proc read_merge_stages {fd cont} {
+	global merge_stages_buf merge_stages_fd merge_stages
+
+	append merge_stages_buf [read $fd]
+	set pck [split $merge_stages_buf "\0"]
+	set merge_stages_buf [lindex $pck end]
+
+	if {[eof $fd] && $merge_stages_buf ne {}} {
+		lappend pck {}
+		set merge_stages_buf {}
+	}
+
+	foreach p [lrange $pck 0 end-1] {
+		set fcols [split $p "\t"]
+		set cols  [split [lindex $fcols 0] " "]
+		set stage [lindex $cols 2]
+		
+		set merge_stages($stage) [lrange $cols 0 1]
+	}
+
+	if {[eof $fd]} {
+		close $fd
+		unset merge_stages_fd
+		eval $cont
+	}
+}
-- 
1.6.0.20.g6148bc
