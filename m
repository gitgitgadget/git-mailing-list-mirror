From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH] git-gui: Add a search command to the blame viewer.
Date: Fri,  3 Oct 2008 11:36:53 +0400
Message-ID: <1223019414-24643-2-git-send-email-angavrilov@gmail.com>
References: <1223019414-24643-1-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 09:39:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlfGQ-0008FF-9E
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 09:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbYJCHie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 03:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbYJCHid
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 03:38:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:38170 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbYJCHib (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 03:38:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1015987fgg.17
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 00:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IkNWgIDSsp987J1CgT48lIQ4zvR5O/2r8J43XNou1MM=;
        b=JTxk4pnlxDqfkTzA5B70CSwZTMiQhIIXVMlOvBJThTS7HaaGQrkeXkO/3LtmNpuzpE
         2X/4pnKGSfBVc7PM58jbEvI/CysJytb4zwnI002jjAoU/Wqza9Nb6Sk4n65Jc4SDv+9b
         kytUESHfa+YToPv6t+LAzi1HjnqGWexdD+3pA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wgNE4t6ik2XrIvWrtOVjwn+/foKnigrY9/p3naGzXyBYO0ttsai6HFgAowLUx9jLar
         KxfjfUB4TLfvEXVTVPZT8u7JctJ3r3G3I3kHI/eHZ5kQze9eYk+FQdVQP+IeEfQtfem1
         n/2CSl9a5wz5GdINjHsU9eNkT+nKlOLtRIOrA=
Received: by 10.180.255.1 with SMTP id c1mr302243bki.23.1223019508835;
        Fri, 03 Oct 2008 00:38:28 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 31sm3873133fkt.3.2008.10.03.00.38.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 00:38:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223019414-24643-1-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97402>

One of the largest deficiencies in the blame viewer at
the moment is the impossibility to search for a text
string. This commit fixes it by adding a Firefox-like
search panel to the viewer.

The panel can be shown by pressing F7 or clicking a
menu entry, and is hidden by pressing Esc. Find Next
is available through the F3 key.

Implementation is based on the gitk code, but heavily
refactored. It now also supports case-insensitive
searches, and uses the text box background color to
signal success or failure of the search.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	I would have used Ctrl-F, but it is already occupied.
	
	-- Alexander


 git-gui.sh     |    3 +
 lib/blame.tcl  |   37 ++++++++++-
 lib/search.tcl |  190 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+), 3 deletions(-)
 create mode 100644 lib/search.tcl

diff --git a/git-gui.sh b/git-gui.sh
index 79a108d..4f95139 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -591,6 +591,7 @@ bind . <Visibility> {
 
 if {[is_Windows]} {
 	wm iconbitmap . -default $oguilib/git-gui.ico
+	set ::tk::AlwaysShowSelection 1
 }
 
 ######################################################################
@@ -1067,6 +1068,8 @@ set selected_commit_type new
 set nullid "0000000000000000000000000000000000000000"
 set nullid2 "0000000000000000000000000000000000000001"
 
+set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
+
 ######################################################################
 ##
 ## task management
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 221313c..a45784c 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -21,9 +21,11 @@ field w_amov     ; # text column: annotations + move tracking
 field w_asim     ; # text column: annotations (simple computation)
 field w_file     ; # text column: actual file data
 field w_cviewer  ; # pane showing commit message
+field finder     ; # find mini-dialog frame
 field status     ; # status mega-widget instance
 field old_height ; # last known height of $w.file_pane
 
+
 # Tk UI colors
 #
 variable active_color #c0edc5
@@ -59,7 +61,7 @@ field tooltip_timer     {} ; # Current timer event for our tooltip
 field tooltip_commit    {} ; # Commit(s) in tooltip
 
 constructor new {i_commit i_path i_jump} {
-	global cursor_ptr
+	global cursor_ptr M1B M1T have_tk85
 	variable active_color
 	variable group_colors
 
@@ -199,6 +201,11 @@ constructor new {i_commit i_path i_jump} {
 		-width 80 \
 		-xscrollcommand [list $w.file_pane.out.sbx set] \
 		-font font_diff
+	if {$have_tk85} {
+		$w_file configure -inactiveselectbackground darkblue
+	}
+	$w_file tag conf found \
+		-background yellow
 
 	set w_columns [list $w_amov $w_asim $w_line $w_file]
 
@@ -219,6 +226,11 @@ constructor new {i_commit i_path i_jump} {
 		-weight 1
 	grid rowconfigure $w.file_pane.out 0 -weight 1
 
+	set finder [::searchbar::new \
+		$w.file_pane.out.ff $w_file \
+		-column [expr {[llength $w_columns] - 1}] \
+		]
+
 	set w_cviewer $w.file_pane.cm.t
 	text $w_cviewer \
 		-background white \
@@ -259,6 +271,10 @@ constructor new {i_commit i_path i_jump} {
 		-label [mc "Copy Commit"] \
 		-command [cb _copycommit]
 	$w.ctxm add separator
+	$w.ctxm add command \
+		-label [mc "Find Text..."] \
+		-accelerator F7 \
+		-command [list searchbar::show $finder]
 	menu $w.ctxm.enc
 	build_encoding_menu $w.ctxm.enc [cb _setencoding]
 	$w.ctxm add cascade \
@@ -280,9 +296,15 @@ constructor new {i_commit i_path i_jump} {
 			$i tag conf color$g -background [lindex $group_colors $g]
 		}
 
+		if {$i eq $w_file} {
+			$w_file tag raise found
+		}
+		$i tag raise sel
+
 		$i conf -cursor $cursor_ptr
-		$i conf -yscrollcommand [list many2scrollbar \
-			$w_columns yview $w.file_pane.out.sby]
+		$i conf -yscrollcommand \
+			"[list ::searchbar::scrolled $finder]
+			 [list many2scrollbar $w_columns yview $w.file_pane.out.sby]"
 		bind $i <Button-1> "
 			[cb _hide_tooltip]
 			[cb _click $i @%x,%y]
@@ -319,6 +341,11 @@ constructor new {i_commit i_path i_jump} {
 	bind $w_cviewer <Tab>       "[list focus $w_file];break"
 	bind $w_cviewer <Button-1> [list focus $w_cviewer]
 	bind $w_file    <Visibility> [list focus $w_file]
+	bind $top       <F7>         [list searchbar::show $finder]
+	bind $top       <Escape>     [list searchbar::hide $finder]
+	bind $top       <F3>         [list searchbar::find_next $finder]
+	bind $top       <Shift-F3>   [list searchbar::find_prev $finder]
+	catch { bind $top <Shift-Key-XF86_Switch_VT_3> [list searchbar::find_prev $finder] }
 
 	grid configure $w.header -sticky ew
 	grid configure $w.file_pane -sticky nsew
@@ -873,6 +900,10 @@ method _showcommit {cur_w lno} {
 		foreach i $w_columns {
 			$i tag conf g$cmit -background $active_color
 			$i tag raise g$cmit
+			if {$i eq $w_file} {
+				$w_file tag raise found
+			}
+			$i tag raise sel
 		}
 
 		set author_name {}
diff --git a/lib/search.tcl b/lib/search.tcl
new file mode 100644
index 0000000..d292f20
--- /dev/null
+++ b/lib/search.tcl
@@ -0,0 +1,190 @@
+# incremental search panel
+# based on code from gitk, Copyright (C) Paul Mackerras
+
+class searchbar {
+
+field w
+field ctext
+
+field searchstring   {}
+field casesensitive  1
+field searchdirn     -forwards
+
+field smarktop
+field smarkbot
+
+constructor new {i_w i_text args} {
+	set w      $i_w
+	set ctext  $i_text
+
+	frame  $w
+	label  $w.l       -text [mc Find:]
+	button $w.bn      -text [mc Next] -command [cb find_next]
+	button $w.bp      -text [mc Prev] -command [cb find_prev]
+	checkbutton $w.cs -text [mc Case-Sensitive] \
+		-variable ${__this}::casesensitive -command [cb _incrsearch]
+	entry  $w.ent -textvariable ${__this}::searchstring -background lightgreen
+	pack   $w.l   -side left
+	pack   $w.cs  -side right
+	pack   $w.bp  -side right
+	pack   $w.bn  -side right
+	pack   $w.ent -side left -expand 1 -fill x
+
+	eval grid conf $w -sticky we $args
+	grid remove $w
+
+	trace add variable searchstring write [cb _incrsearch_cb]
+	
+	bind $w <Destroy> [cb delete_this]
+	return $this
+}
+
+method show {} {
+	if {![winfo ismapped $w]} {
+		grid $w
+	}
+	focus -force $w.ent
+}
+
+method hide {} {
+	if {[winfo ismapped $w]} {
+		focus $ctext
+		grid remove $w
+	}
+}
+
+method _get_new_anchor {} {
+	# use start of selection if it is visible,
+	# or the bounds of the visible area
+	set top    [$ctext index @0,0]
+	set bottom [$ctext index @0,[winfo height $ctext]]
+	set sel    [$ctext tag ranges sel]
+	if {$sel ne {}} {
+		set spos [lindex $sel 0]
+		if {[lindex $spos 0] >= [lindex $top 0] &&
+		    [lindex $spos 0] <= [lindex $bottom 0]} {
+			return $spos
+		}
+	}
+	if {$searchdirn eq "-forwards"} {
+		return $top
+	} else {
+		return $bottom
+	}
+}
+
+method _get_wrap_anchor {dir} {
+	if {$dir eq "-forwards"} {
+		return 1.0
+	} else {
+		return end
+	}
+}
+
+method _do_search {start {mlenvar {}} {dir {}} {endbound {}}} {
+	set cmd [list $ctext search]
+	if {$mlenvar ne {}} {
+		upvar $mlenvar mlen
+		lappend cmd -count mlen
+	}
+	if {!$casesensitive} {
+		lappend cmd -nocase
+	}
+	if {$dir eq {}} {
+		set dir $searchdirn
+	}
+	lappend cmd $dir -- $searchstring
+	if {$endbound ne {}} {
+		set here [eval $cmd [list $start] [list $endbound]]
+	} else {
+		set here [eval $cmd [list $start]]
+		if {$here eq {}} {
+			set here [eval $cmd [_get_wrap_anchor $this $dir]]
+		}
+	}
+	return $here
+}
+
+method _incrsearch_cb {name ix op} {
+	after idle [cb _incrsearch]
+}
+
+method _incrsearch {} {
+	$ctext tag remove found 1.0 end
+	if {[catch {$ctext index anchor}]} {
+		$ctext mark set anchor [_get_new_anchor $this]
+	}
+	if {$searchstring ne {}} {
+		set here [_do_search $this anchor mlen]
+		if {$here ne {}} {
+			$ctext see $here
+			$ctext tag remove sel 1.0 end
+			$ctext tag add sel $here "$here + $mlen c"
+			$w.ent configure -background lightgreen
+			_set_marks $this 1
+		} else {
+			$w.ent configure -background lightpink
+		}
+	}
+}
+
+method find_prev {} {
+	find_next $this -backwards
+}
+
+method find_next {{dir -forwards}} {
+	focus $w.ent
+	$w.ent icursor end
+	set searchdirn $dir
+	$ctext mark unset anchor
+	if {$searchstring ne {}} {
+		set start [_get_new_anchor $this]
+		if {$dir eq "-forwards"} {
+			set start "$start + 1c"
+		}
+		set match [_do_search $this $start mlen]
+		$ctext tag remove sel 1.0 end
+		if {$match ne {}} {
+			$ctext see $match
+			$ctext tag add sel $match "$match + $mlen c"
+		}
+	}
+}
+
+method _mark_range {first last} {
+	set mend $first.0
+	while {1} {
+		set match [_do_search $this $mend mlen -forwards $last.end]
+		if {$match eq {}} break
+		set mend "$match + $mlen c"
+		$ctext tag add found $match $mend
+	}
+}
+
+method _set_marks {doall} {
+	set topline [lindex [split [$ctext index @0,0] .] 0]
+	set botline [lindex [split [$ctext index @0,[winfo height $ctext]] .] 0]
+	if {$doall || $botline < $smarktop || $topline > $smarkbot} {
+		# no overlap with previous
+		_mark_range $this $topline $botline
+		set smarktop $topline
+		set smarkbot $botline
+	} else {
+		if {$topline < $smarktop} {
+			_mark_range $this $topline [expr {$smarktop-1}]
+			set smarktop $topline
+		}
+		if {$botline > $smarkbot} {
+			_mark_range $this [expr {$smarkbot+1}] $botline
+			set smarkbot $botline
+		}
+	}
+}
+
+method scrolled {} {
+	if {$searchstring ne {}} {
+		after idle [cb _set_marks 0]
+	}
+}
+
+}
\ No newline at end of file
-- 
1.6.0.20.g6148bc
