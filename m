From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH/RFC/WIP/POC] git-gui: grep prototype
Date: Sun, 14 Nov 2010 22:41:09 +0100
Message-ID: <1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 22:41:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHkK8-0006Zt-Cq
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160Ab0KNVlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 16:41:15 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50859 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab0KNVlO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 16:41:14 -0500
Received: by bwz15 with SMTP id 15so4671733bwz.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=GH1gh6gzUl/ZgwKf6L0n4Rv3uTTs2gUFvfzxwjAOd+o=;
        b=Cyhc3w2vBkpsOBto37UyXvBQF6SUMeqaT25fY5Y58GWvEeyBXxBr6zogsBwAPMEvpp
         YNPioLfcVoUFeHIGgzvPq1tlxpnKOiGYZlm0Gx22MVEH6bWXdrObul6dW5BsOUEV/4JQ
         tAGfDGGVD6WHvxVWNvje9TNiAMHNuBMzYnq+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CpkDheJvoT+Ht/33skwDsmJv48ptIpZiCH1fvhIrdCBzDx6vP1yqPZA/PrcZbWGF/w
         W1GLbl/iJ09NrNvFmWZXtKxebKkxjfFuEzu/c81SsGN7LhdOU0CY/PiRn9RKr3fSWC5H
         LgxLWbZxHMwXe41vYCXFajh8XtzvtoUG0+N6k=
Received: by 10.204.64.139 with SMTP id e11mr5332670bki.212.1289770872552;
        Sun, 14 Nov 2010 13:41:12 -0800 (PST)
Received: from localhost (p3E99037B.dip.t-dialin.net [62.153.3.123])
        by mx.google.com with ESMTPS id g8sm2665300bkg.23.2010.11.14.13.41.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 13:41:10 -0800 (PST)
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-Mailer: git-send-email 1.7.3.1.1075.g263d8
To: Pat Thoyts <patthoyts@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161447>

This is a prototype gui to show the result from git grep.

It has a similar layout to git gui. That is, left is the list of matched files.
And the right side shows the grep result for one file.

The prototype lives completely outside of git gui at the moment. The usage is:

    $ git-gui-grep.tcl [git-grep-match-options]

-p and -C 3 are currently hard coded in the file. And you should also not
use any pathspecs after a --. Though, patchspecs without the -- separator
may work.

There is one feature that the upstream git gui lacks[1]: This grep gui can start
the git editor on every line by clicking with button 2 in the result area. The
git editor will than be started with the environment variable FILENAME and
LINENUMBER set but no argument given. This makes it possible to distinguish
between normal, blocking edit operation (like git commit) from this
open-and-forget type of operation.

How to proceed from this prototype isn't perfectly clear for me at the moment.
I don't know if we need to enter/edit grep match options? If this should be a
new mode for git gui like blame and therefore in its one windows. I can imagine
that a tabbed interface would be nice for git gui. That would include having
a blame view inside a tab.

So any advice would be very welcome here.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

[1]: I have done this for git-gui first, but it lacks the precise linenumber
     detection used here. Ie. I plan to add these line number columns to the
     diff view.

 git-gui-grep.tcl |  320 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 320 insertions(+), 0 deletions(-)

diff --git a/git-gui-grep.tcl b/git-gui-grep.tcl
new file mode 100755
index 0000000..fb61745
--- /dev/null
+++ b/git-gui-grep.tcl
@@ -0,0 +1,320 @@
+#!/bin/sh
+# Tcl ignores the next line -*- tcl -*- \
+ argv0=$0; \
+ exec 'wish8.5' "$argv0" -- "$@"
+
+if {[catch {package require Tcl 8.5} err]
+ || [catch {package require Tk  8.5} err]
+} {
+	catch {wm withdraw .}
+	tk_messageBox \
+		-icon error \
+		-type ok \
+		-title "git gui-grep: fatal error" \
+		-message $err
+	exit 1
+}
+
+proc scrollbar2many {list mode args} {
+	foreach w $list {eval $w $mode $args}
+}
+
+proc many2scrollbar {list mode sb top bottom} {
+	$sb set $top $bottom
+	foreach w $list {$w $mode moveto $top}
+}
+
+wm title . "git gui-grep"
+
+ttk::panedwindow .pane -orient horizontal
+ttk::labelframe .pane.files -borderwidth 0 -text "Matched files"
+ttk::labelframe .pane.out -borderwidth 0 -text "Matches"
+.pane add .pane.files
+.pane add .pane.out
+
+pack .pane -expand 1 -fill both
+
+text .pane.out.lnos \
+	-takefocus 0 \
+	-highlightthickness 0 \
+	-padx 0 -pady 0 \
+	-background white \
+	-foreground black \
+	-borderwidth 0 \
+	-width 6 -height 25 \
+	-wrap none \
+	-state disabled
+.pane.out.lnos tag conf linenumber -justify right -rmargin 5
+bind .pane.out.lnos <ButtonRelease-2> {open_from_grep_view .pane.out.lnos %x %y}
+
+text .pane.out.grep \
+	-takefocus 0 \
+	-highlightthickness 0 \
+	-padx 0 -pady 0 \
+	-background white \
+	-foreground black \
+	-borderwidth 0 \
+	-width 80 -height 25 \
+	-wrap none \
+	-xscrollcommand {.pane.out.sx set} \
+	-state disabled
+.pane.out.grep tag conf match -foreground red
+foreach {n c} {0 black 1 red4 2 green4 3 yellow4 4 blue4 5 magenta4 6 cyan4 7 grey60} {
+	.pane.out.grep tag configure clr4$n -background $c
+	.pane.out.grep tag configure clri4$n -foreground $c
+	.pane.out.grep tag configure clr3$n -foreground $c
+	.pane.out.grep tag configure clri3$n -background $c
+}
+bind .pane.out.grep <ButtonRelease-2> {open_from_grep_view .pane.out.grep %x %y}
+
+set outcols [list .pane.out.lnos .pane.out.grep]
+
+ttk::scrollbar .pane.out.sx \
+	-orient h \
+	-command [list .pane.out.grep xview]
+ttk::scrollbar .pane.out.sy \
+	-orient v \
+	-command [list scrollbar2many $outcols yview]
+
+grid .pane.out.lnos .pane.out.grep .pane.out.sy -sticky nsew
+grid conf .pane.out.sx \
+	-column 1 \
+	-sticky we
+grid columnconfigure .pane.out \
+	1 \
+	-weight 1
+grid rowconfigure .pane.out \
+	0 \
+	-weight 1
+
+text .pane.files.list \
+	-background white \
+	-foreground black \
+	-borderwidth 0 \
+	-state disabled \
+	-wrap none \
+	-height 25 \
+	-width 16 \
+	-cursor arrow \
+	-xscrollcommand [list .pane.files.sbx set] \
+	-yscrollcommand [list .pane.files.sby set]
+.pane.files.list tag raise sel
+ttk::scrollbar .pane.files.sbx \
+	-orient h \
+	-command [list .pane.files.list xview]
+ttk::scrollbar .pane.files.sby \
+	-orient v \
+	-command [list .pane.files.list yview]
+pack .pane.files.sbx -side bottom -fill x
+pack .pane.files.sby -side right -fill y
+pack .pane.files.list -side left -expand 1 -fill both
+bind .pane.files.list <Button-1> "select_to_grep %x %y; break"
+
+foreach i $outcols {
+	$i tag raise sel
+
+	$i conf -cursor arrow
+	$i conf -yscrollcommand \
+		"[list many2scrollbar $outcols yview .pane.out.sy]"
+}
+
+proc escape_path {path} {
+	regsub -all {\\} $path "\\\\" path
+	regsub -all "\n" $path "\\n" path
+	return $path
+}
+
+proc parse_color_line {line} {
+	set start 0
+	set result ""
+	set markup [list]
+	set regexp {\033\[((?:\d+;)*\d+)?m}
+	while {[regexp -indices -start $start $regexp $line match code]} {
+		foreach {begin end} $match break
+		append result [string range $line $start [expr {$begin - 1}]]
+		lappend markup [string length $result] \
+		[eval [linsert $code 0 string range $line]]
+		set start [incr end]
+	}
+	append result [string range $line $start end]
+	if {[llength $markup] < 4} {set markup {}}
+	return [list $result $markup]
+}
+
+
+proc scan_grep {} {
+	global buf_rgl grep_patterns
+
+	set buf_rgl {}
+	set cmd [concat [list | git grep -l -z] $grep_patterns]
+	if {[catch {set fd [open $cmd r]} err]} {
+		tk_messageBox \
+			-icon error \
+			-type ok \
+			-title {git gui-grep: fatal error} \
+			-message $err
+		exit 1
+	}
+	fconfigure $fd -eofchar {}
+	fconfigure $fd \
+		-blocking 0 \
+		-buffering full \
+		-buffersize 512 \
+		-translation binary
+	fileevent $fd readable [list read_grep_l $fd]
+}
+
+proc read_grep_l {fd} {
+	global buf_rgl grep_file_list grep_patterns current_grep_path
+
+	append buf_rgl [read $fd]
+	set pck [split $buf_rgl "\0"]
+	set buf_rgl [lindex $pck end]
+
+	.pane.files.list conf -state normal
+	foreach p [lrange $pck 0 end-1] {
+		#set p [encoding convertfrom $p]
+		if {[string index $p end] eq {/}} {
+			set p [string range $p 0 end-1]
+		}
+		lappend grep_file_list $p
+		.pane.files.list insert end "[escape_path $p]\n"
+	}
+	.pane.files.list conf -state disabled
+
+	if {![eof $fd]} return
+	set buf_rgl {}
+	close $fd
+
+	if {[llength $grep_file_list] eq 0} {
+		exit 0
+	}
+	grep_file [lindex $grep_file_list 0]
+}
+
+proc grep_file {path} {
+	global outcols grep_patterns
+	set cmd [concat [list | git grep --color -h -n -p -3] $grep_patterns [list -- $path]]
+
+	foreach i $outcols {
+		$i conf -state normal
+		$i delete 0.0 end
+		$i conf -state disabled
+	}
+
+	if {[catch {set fd [open $cmd r]} err]} {
+		tk_messageBox \
+			-icon error \
+			-type ok \
+			-title {gui-grep: fatal error} \
+			-message $err
+		exit 1
+	}
+	fconfigure $fd -eofchar {}
+	fconfigure $fd \
+		-blocking 0 \
+		-buffering full \
+		-buffersize 512 \
+		-translation lf
+	fileevent $fd readable [list read_grep $fd $path]
+}
+
+proc read_grep {fd path} {
+	global outcols current_grep_path
+
+	foreach i $outcols {$i conf -state normal}
+
+	set l 0
+	while {[gets $fd line] >= 0} {
+		incr l
+		if {$l > 1} {
+			foreach i $outcols {$i insert end "\n"}
+		}
+
+		# catch hunk sep --
+		if {[regexp {^(?:\033\[(?:(?:\d+;)*\d+)m)?--(?:\033\[m)?} $line]} {
+			.pane.out.lnos insert end "--" linenumber
+			continue
+		}
+
+		# remove any color from lno and sep
+		regexp {^(?:\033\[(?:(?:\d+;)*\d+)m)?(\d+)(?:\033\[m)?(?:\033\[(?:(?:\d+;)*\d+)m)?[-:=](?:\033\[m)?(.*)$} $line all lno mline
+		foreach {mline markup} [parse_color_line $mline] break
+		set mline [string map {\033 ^} $mline]
+		#regsub "\r\$" $line {} line
+
+		set mark [.pane.out.grep index "end - 1 line linestart"]
+
+		.pane.out.lnos insert end $lno linenumber
+		.pane.out.grep insert end $mline
+
+		foreach {posbegin colbegin posend colend} $markup {
+			set prefix clr
+			foreach style [split $colbegin ";"] {
+				if {$style eq "7"} {append prefix i; continue}
+				if {$style < 30 || $style > 47} {continue}
+				set a "$mark linestart + $posbegin chars"
+				set b "$mark linestart + $posend chars"
+				catch {.pane.out.grep tag add $prefix$style $a $b}
+			}
+		}
+	}
+
+	foreach i $outcols {$i conf -state disabled}
+
+	if {[eof $fd]} {
+		close $fd
+		set current_grep_path $path
+		wm title . "git gui-grep: [escape_path $path]"
+	}
+}
+
+proc select_to_grep {x y} {
+	global grep_file_list current_grep_path
+
+	set lno [lindex [split [.pane.files.list index @$x,$y] .] 0]
+	set path [lindex $grep_file_list [expr {$lno - 1}]]
+	if {$path eq {}} {
+		return
+	}
+	if {$path eq $current_grep_path} {
+		return
+	}
+	grep_file $path
+}
+
+proc open_in_git_editor {path {lno 0}} {
+	global env
+
+	set env(FILENAME) $path
+	if {$lno != 0} {
+		set env(LINENUMBER) $lno
+	}
+	exec [exec  -- git var GIT_EDITOR] &
+	unset env(FILENAME)
+	catch { unset env(LINENUMBER) }
+}
+
+proc open_from_grep_view {w x y} {
+	global current_grep_path
+	global grep_file_list
+
+	if {$current_grep_path eq {}} {
+		return
+	}
+
+	set grep_lno [lindex [split [$w index @$x,$y] .] 0]
+	set lno [.pane.out.lnos get $grep_lno.0 $grep_lno.end]
+	if {$lno eq {--}} {
+		incr grep_lno
+		set lno [.pane.out.lnos get $grep_lno.0 $grep_lno.end]
+	}
+
+	open_in_git_editor $current_grep_path $lno
+}
+
+
+set grep_file_list [list]
+set current_grep_path {}
+set grep_patterns $argv
+scan_grep
-- 
tg: (6f10c41..) bw/git-gui/grep-support-prototype (depends on: master)
