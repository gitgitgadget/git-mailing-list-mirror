From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2] git-gui: Automatically spell check commit messages as the user types
Date: Thu, 7 Feb 2008 02:52:50 -0500
Message-ID: <20080207075250.GA24709@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 08:53:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN1ZZ-0005q4-U2
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 08:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbYBGHw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 02:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbYBGHw4
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 02:52:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34363 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbYBGHwy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 02:52:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JN1Yx-0006v8-Kf
	for git@vger.kernel.org; Thu, 07 Feb 2008 02:52:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0B41920FBAE; Thu,  7 Feb 2008 02:52:50 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72905>

This is likely going to be moved to my master branch in the next
day or two.  I've been using it for a few days now and am pretty
happy with it.  Currently its parked in my pu branch.

Major changes since the first version are:

  *) Options dialog allows dictionary selection;
  *) We try to only spellcheck modified lines not everything;
  *) It can be disabled by setting gui.spellingdictionary = none;

I think there may still be a quirk with the suggestions popup.
Sometimes it doesn't show the suggestions for a word.

--8>--
git-gui: Automatically spell check commit messages as the user types

Many user friendly tools like word processors, email editors and web
browsers allow users to spell check the message they are writing
as they type it, making it easy to identify a common misspelling
of a word and correct it on the fly.

We now open a bi-directional pipe to Aspell and feed the message
text the user is editing off to the program about once every 300
milliseconds.  This is frequent enough that the user sees the results
almost immediately, but is not so frequent as to cause significant
additional load on the system.  If the user has modified the message
text during the last 300 milliseconds we delay until the next period,
ensuring that we avoid flooding the Aspell process with a lot of
text while the user is actively typing their message.

We wait to send the current message buffer to Aspell until the user
is at a word boundary, thus ensuring that we are not likely to ask
for misspelled word detection on a word that the user is actively
typing, as most words are misspelled when only partially typed,
even if the user has thus far typed it correctly.

Misspelled words are highlighted in red and are given an underline,
causing the word to stand out from the others in the buffer.  This is
a very common user interface idiom for displaying misspelled words,
but differs from one platform to the next in slight variations.
For example the Mac OS X system prefers using a dashed red underline,
leaving the word in the original text color.  Unfortunately the
control that Tk gives us over text display is not powerful enough
to handle such formatting so we have to work with the least common
denominator.

The top suggestions for a misspelling are saved in an array and
offered to the user when they right-click (or on the Mac ctrl-click)
a misspelled word.  Selecting an entry from this menu will replace
the misspelling with the correction shown.  Replacement is integrated
with the undo/redo stack so undoing a replacement will restore the
misspelled original text.

If Aspell could not be started during git-gui launch we silently eat
the error and run without spell checking support.  This way users
who do not have Aspell in their $PATH can continue to use git-gui,
although they will not get the advanced spelling functionality.

If Aspell started successfully the version line and language are
shown in git-gui's about box, below the Tcl/Tk versions.  This way
the user can verify the Aspell function has been activated.

If Aspell crashes while we are running we inform the user with an
error dialog and then disable Aspell entirely for the rest of this
git-gui session.  This prevents us from fork-bombing the system
with Aspell instances that always crash when presented with the
current message text, should there be a bug in either Aspell or in
git-gui's output to it.

We escape all input lines with ^, as recommended by the Aspell manual
page, as this allows Aspell to properly ignore any input line that is
otherwise looking like a command (e.g. ! to enable terse output).  By
using this escape however we need to correct all word offsets by -1 as
Aspell is apparently considering the ^ escape to be part of the line's
character count, but our Tk text widget obviously does not.

Available dictionaries are offered in the Options dialog, allowing
the user to select the language they want to spellcheck commit
messages with for the current repository, as well as the global
user setting that all repositories inherit.

Special thanks to Adam Flott for suggesting connecting git-gui
to Aspell for the purpose of spell checking the commit message,
and to Wincent Colaiuta for the idea to wait for a word boundary
before passing the message over for checking.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-gui.sh         |   34 +++++-
 lib/about.tcl      |    5 +
 lib/option.tcl     |   41 ++++++
 lib/spellcheck.tcl |  363 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 442 insertions(+), 1 deletions(-)
 create mode 100644 lib/spellcheck.tcl

diff --git a/git-gui.sh b/git-gui.sh
index f42e461..5d65272 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -612,6 +612,7 @@ set default_config(gui.pruneduringfetch) false
 set default_config(gui.trustmtime) false
 set default_config(gui.diffcontext) 5
 set default_config(gui.newbranchtemplate) {}
+set default_config(gui.spellingdictionary) {}
 set default_config(gui.fontui) [font configure font_ui]
 set default_config(gui.fontdiff) [font configure font_diff]
 set font_descs {
@@ -1683,6 +1684,7 @@ set is_quitting 0
 proc do_quit {} {
 	global ui_comm is_quitting repo_config commit_type
 	global GITGUI_BCK_exists GITGUI_BCK_i
+	global ui_comm_spell
 
 	if {$is_quitting} return
 	set is_quitting 1
@@ -1710,6 +1712,12 @@ proc do_quit {} {
 			}
 		}
 
+		# -- Cancel our spellchecker if its running.
+		#
+		if {[info exists ui_comm_spell]} {
+			$ui_comm_spell stop
+		}
+
 		# -- Remove our editor backup, its not needed.
 		#
 		after cancel $GITGUI_BCK_i
@@ -2454,7 +2462,7 @@ $ctxm add separator
 $ctxm add command \
 	-label [mc "Sign Off"] \
 	-command do_signoff
-bind_button3 $ui_comm "tk_popup $ctxm %X %Y"
+set ui_comm_ctxm $ctxm
 
 # -- Diff Header
 #
@@ -2857,6 +2865,30 @@ if {[winfo exists $ui_comm]} {
 	}
 
 	backup_commit_buffer
+
+	# -- If the user has aspell available we can drive it
+	#    in pipe mode to spellcheck the commit message.
+	#
+	set spell_cmd [list |]
+	set spell_dict [get_config gui.spellingdictionary]
+	lappend spell_cmd aspell
+	if {$spell_dict ne {}} {
+		lappend spell_cmd --master=$spell_dict
+	}
+	lappend spell_cmd --mode=none
+	lappend spell_cmd --encoding=utf-8
+	lappend spell_cmd pipe
+	if {$spell_dict eq {none}
+	 || [catch {set spell_fd [open $spell_cmd r+]} spell_err]} {
+		bind_button3 $ui_comm [list tk_popup $ui_comm_ctxm %X %Y]
+	} else {
+		set ui_comm_spell [spellcheck::init \
+			$spell_fd \
+			$ui_comm \
+			$ui_comm_ctxm \
+		]
+	}
+	unset -nocomplain spell_cmd spell_fd spell_err spell_dict
 }
 
 lock_index begin-read
diff --git a/lib/about.tcl b/lib/about.tcl
index 719fc54..47be8eb 100644
--- a/lib/about.tcl
+++ b/lib/about.tcl
@@ -4,6 +4,7 @@
 proc do_about {} {
 	global appvers copyright oguilib
 	global tcl_patchLevel tk_patchLevel
+	global ui_comm_spell
 
 	set w .about_dialog
 	toplevel $w
@@ -40,6 +41,10 @@ proc do_about {} {
 		append v "Tcl version $tcl_patchLevel"
 		append v ", Tk version $tk_patchLevel"
 	}
+	if {[info exists ui_comm_spell]} {
+		append v "\n"
+		append v [$ui_comm_spell version]
+	}
 
 	set d {}
 	append d "git wrapper: $::_git\n"
diff --git a/lib/option.tcl b/lib/option.tcl
index f812e5e..3bfa2ed 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -5,6 +5,7 @@ proc save_config {} {
 	global default_config font_descs
 	global repo_config global_config
 	global repo_config_new global_config_new
+	global ui_comm_spell
 
 	foreach option $font_descs {
 		set name [lindex $option 0]
@@ -52,11 +53,23 @@ proc save_config {} {
 			set repo_config($name) $value
 		}
 	}
+
+	if {[info exists repo_config(gui.spellingdictionary)]} {
+		set value $repo_config(gui.spellingdictionary)
+		if {$value eq {none}} {
+			if {[info exists ui_comm_spell]} {
+				$ui_comm_spell stop
+			}
+		} elseif {[info exists ui_comm_spell]} {
+			$ui_comm_spell lang $value
+		}
+	}
 }
 
 proc do_options {} {
 	global repo_config global_config font_descs
 	global repo_config_new global_config_new
+	global ui_comm_spell
 
 	array unset repo_config_new
 	array unset global_config_new
@@ -159,6 +172,34 @@ proc do_options {} {
 		}
 	}
 
+	set all_dicts [linsert \
+		[spellcheck::available_langs] \
+		0 \
+		none]
+	incr optid
+	foreach f {repo global} {
+		if {![info exists ${f}_config_new(gui.spellingdictionary)]} {
+			if {[info exists ui_comm_spell]} {
+				set value [$ui_comm_spell lang]
+			} else {
+				set value none
+			}
+			set ${f}_config_new(gui.spellingdictionary) $value
+		}
+
+		frame $w.$f.$optid
+		label $w.$f.$optid.l -text [mc "Spelling Dictionary:"]
+		eval tk_optionMenu $w.$f.$optid.v \
+			${f}_config_new(gui.spellingdictionary) \
+			$all_dicts
+		pack $w.$f.$optid.l -side left -anchor w -fill x
+		pack $w.$f.$optid.v -side left -anchor w \
+			-fill x -expand 1 \
+			-padx 5
+		pack $w.$f.$optid -side top -anchor w -fill x
+	}
+	unset all_dicts
+
 	set all_fonts [lsort [font families]]
 	foreach option $font_descs {
 		set name [lindex $option 0]
diff --git a/lib/spellcheck.tcl b/lib/spellcheck.tcl
new file mode 100644
index 0000000..01c2c4f
--- /dev/null
+++ b/lib/spellcheck.tcl
@@ -0,0 +1,363 @@
+# git-gui spellchecking support through aspell
+# Copyright (C) 2008 Shawn Pearce
+
+class spellcheck {
+
+field s_fd     {} ; # pipe to aspell
+field s_version   ; # aspell version string
+field s_lang      ; # current language code
+
+field w_text      ; # text widget we are spelling
+field w_menu      ; # context menu for the widget
+field s_menuidx 0 ; # last index of insertion into $w_menu
+
+field s_i              ; # timer registration for _run callbacks
+field s_clear        0 ; # did we erase mispelled tags yet?
+field s_seen    [list] ; # lines last seen from $w_text in _run
+field s_checked [list] ; # lines already checked
+field s_pending [list] ; # [$line $data] sent to aspell
+field s_suggest        ; # array, list of suggestions, keyed by misspelling
+
+constructor init {pipe_fd ui_text ui_menu} {
+	set w_text $ui_text
+	set w_menu $ui_menu
+
+	_connect $this $pipe_fd
+	return $this
+}
+
+method _connect {pipe_fd} {
+	fconfigure $pipe_fd \
+		-encoding utf-8 \
+		-eofchar {} \
+		-translation lf
+
+	if {[gets $pipe_fd s_version] <= 0} {
+		close $pipe_fd
+		error [mc "Not connected to aspell"]
+	}
+	if {{@(#) } ne [string range $s_version 0 4]} {
+		close $pipe_fd
+		error [strcat [mc "Unrecognized aspell version"] ": $s_version"]
+	}
+	set s_version [string range $s_version 5 end]
+
+	puts $pipe_fd !             ; # enable terse mode
+	puts $pipe_fd {$$cr master} ; # fetch the language
+	flush $pipe_fd
+
+	gets $pipe_fd s_lang
+	regexp {[/\\]([^/\\]+)\.[^\.]+$} $s_lang _ s_lang
+
+	if {$::default_config(gui.spellingdictionary) eq {}
+	 && [get_config gui.spellingdictionary] eq {}} {
+		set ::default_config(gui.spellingdictionary) $s_lang
+	}
+
+	if {$s_fd ne {}} {
+		catch {close $s_fd}
+	}
+	set s_fd $pipe_fd
+
+	fconfigure $s_fd -blocking 0
+	fileevent $s_fd readable [cb _read]
+
+	$w_text tag conf misspelled \
+		-foreground red \
+		-underline 1
+	bind_button3 $w_text [cb _popup_suggest %X %Y @%x,%y]
+
+	array unset s_suggest
+	set s_seen    [list]
+	set s_checked [list]
+	set s_pending [list]
+	_run $this
+}
+
+method lang {{n {}}} {
+	if {$n ne {} && $s_lang ne $n} {
+		set spell_cmd [list |]
+		lappend spell_cmd aspell
+		lappend spell_cmd --master=$n
+		lappend spell_cmd --mode=none
+		lappend spell_cmd --encoding=UTF-8
+		lappend spell_cmd pipe
+		_connect $this [open $spell_cmd r+]
+	}
+	return $s_lang
+}
+
+method version {} {
+	return "$s_version, $s_lang"
+}
+
+method stop {} {
+	while {$s_menuidx > 0} {
+		$w_menu delete 0
+		incr s_menuidx -1
+	}
+	$w_text tag delete misspelled
+
+	catch {close $s_fd}
+	catch {after cancel $s_i}
+	set s_fd {}
+	set s_i {}
+	set s_lang {}
+}
+
+method _popup_suggest {X Y pos} {
+	while {$s_menuidx > 0} {
+		$w_menu delete 0
+		incr s_menuidx -1
+	}
+
+	set b_loc [$w_text index "$pos wordstart"]
+	set e_loc [_wordend $this $b_loc]
+	set orig  [$w_text get $b_loc $e_loc]
+	set tags  [$w_text tag names $b_loc]
+
+	if {[lsearch -exact $tags misspelled] >= 0} {
+		if {[info exists s_suggest($orig)]} {
+			set cnt 0
+			foreach s $s_suggest($orig) {
+				if {$cnt < 5} {
+					$w_menu insert $s_menuidx command \
+						-label $s \
+						-command [cb _replace $b_loc $e_loc $s]
+					incr s_menuidx
+					incr cnt
+				} else {
+					break
+				}
+			}
+		} else {
+			$w_menu insert $s_menuidx command \
+				-label [mc "No Suggestions"] \
+				-state disabled
+			incr s_menuidx
+		}
+		$w_menu insert $s_menuidx separator
+		incr s_menuidx
+	}
+
+	$w_text mark set saved-insert insert
+	tk_popup $w_menu $X $Y
+}
+
+method _replace {b_loc e_loc word} {
+	$w_text configure -autoseparators 0
+	$w_text edit separator
+
+	$w_text delete $b_loc $e_loc
+	$w_text insert $b_loc $word
+
+	$w_text edit separator
+	$w_text configure -autoseparators 1
+	$w_text mark set insert saved-insert
+}
+
+method _restart_timer {} {
+	set s_i [after 300 [cb _run]]
+}
+
+proc _match_length {max_line arr_name} {
+	upvar $arr_name a
+
+	if {[llength $a] > $max_line} {
+		set a [lrange $a 0 $max_line]
+	}
+	while {[llength $a] <= $max_line} {
+		lappend a {}
+	}
+}
+
+method _wordend {pos} {
+	set pos  [$w_text index "$pos wordend"]
+	set tags [$w_text tag names $pos]
+	while {[lsearch -exact $tags misspelled] >= 0} {
+		set pos  [$w_text index "$pos +1c"]
+		set tags [$w_text tag names $pos]
+	}
+	return $pos
+}
+
+method _run {} {
+	set cur_pos  [$w_text index {insert -1c}]
+	set cur_line [lindex [split $cur_pos .] 0]
+	set max_line [lindex [split [$w_text index end] .] 0]
+	_match_length $max_line s_seen
+	_match_length $max_line s_checked
+
+	# Nothing in the message buffer?  Nothing to spellcheck.
+	#
+	if {$cur_line == 1
+	 && $max_line == 2
+	 && [$w_text get 1.0 end] eq "\n"} {
+		array unset s_suggest
+		_restart_timer $this
+		return
+	}
+
+	set active 0
+	for {set n 1} {$n <= $max_line} {incr n} {
+		set s [$w_text get "$n.0" "$n.end"]
+
+		# Don't spellcheck the current line unless we are at
+		# a word boundary.  The user might be typing on it.
+		#
+		if {$n == $cur_line
+		 && ![regexp {^\W$} [$w_text get $cur_pos insert]]} {
+
+			# If the current word is mispelled remove the tag
+			# but force a spellcheck later.
+			#
+			set tags [$w_text tag names $cur_pos]
+			if {[lsearch -exact $tags misspelled] >= 0} {
+				$w_text tag remove misspelled \
+					"$cur_pos wordstart" \
+					[_wordend $this $cur_pos]
+				lset s_seen    $n $s
+				lset s_checked $n {}
+			}
+
+			continue
+		}
+
+		if {[lindex $s_seen    $n] eq $s
+		 && [lindex $s_checked $n] ne $s} {
+			# Don't send empty lines to Aspell it doesn't check them.
+			#
+			if {$s eq {}} {
+				lset s_checked $n $s
+				continue
+			}
+
+			# Don't send typical s-b-o lines as the emails are
+			# almost always misspelled according to Aspell.
+			#
+			if {[regexp -nocase {^[a-z-]+-by:.*<.*@.*>$} $s]} {
+				$w_text tag remove misspelled "$n.0" "$n.end"
+				lset s_checked $n $s
+				continue
+			}
+
+			puts $s_fd ^$s
+			lappend s_pending [list $n $s]
+			set active 1
+		} else {
+			# Delay until another idle loop to make sure we don't
+			# spellcheck lines the user is actively changing.
+			#
+			lset s_seen $n $s
+		}
+	}
+
+	if {$active} {
+		set s_clear 1
+		flush $s_fd
+	} else {
+		_restart_timer $this
+	}
+}
+
+method _read {} {
+	while {[gets $s_fd line] >= 0} {
+		set lineno [lindex $s_pending 0 0]
+
+		if {$s_clear} {
+			$w_text tag remove misspelled "$lineno.0" "$lineno.end"
+			set s_clear 0
+		}
+
+		if {$line eq {}} {
+			lset s_checked $lineno [lindex $s_pending 0 1]
+			set s_pending [lrange $s_pending 1 end]
+			set s_clear 1
+			continue
+		}
+
+		set sugg [list]
+		switch -- [string range $line 0 1] {
+		{& } {
+			set line [split [string range $line 2 end] :]
+			set info [split [lindex $line 0] { }]
+			set orig [lindex $info 0]
+			set offs [lindex $info 2]
+			foreach s [split [lindex $line 1] ,] {
+				lappend sugg [string range $s 1 end]
+			}
+		}
+		{# } {
+			set info [split [string range $line 2 end] { }]
+			set orig [lindex $info 0]
+			set offs [lindex $info 1]
+		}
+		default {
+			puts stderr "<spell> $line"
+			continue
+		}
+		}
+
+		incr offs -1
+		set b_loc "$lineno.$offs"
+		set e_loc [$w_text index "$lineno.$offs wordend"]
+		set curr [$w_text get $b_loc $e_loc]
+
+		# At least for English curr = "bob", orig = "bob's"
+		# so Tk didn't include the 's but Aspell did.  We
+		# try to round out the word.
+		#
+		while {$curr ne $orig
+		 && [string equal -length [llength $curr] $curr $orig]} {
+			set n_loc  [$w_text index "$e_loc +1c"]
+			set n_curr [$w_text get $b_loc $n_loc]
+			if {$n_curr eq $curr} {
+				break
+			}
+			set curr  $n_curr
+			set e_loc $n_loc
+		}
+
+		if {$curr eq $orig} {
+			$w_text tag add misspelled $b_loc $e_loc
+			if {[llength $sugg] > 0} {
+				set s_suggest($orig) $sugg
+			} else {
+				unset -nocomplain s_suggest($orig)
+			}
+		} else {
+			unset -nocomplain s_suggest($orig)
+		}
+	}
+
+	fconfigure $s_fd -block 1
+	if {[eof $s_fd]} {
+		if {![catch {close $s_fd} err]} {
+			set err [mc "unexpected eof from aspell"]
+		}
+		catch {after cancel $s_i}
+		$w_text tag remove misspelled 1.0 end
+		error_popup [strcat "Spell Checker Failed" "\n\n" $err]
+		return
+	}
+	fconfigure $s_fd -block 0
+
+	if {[llength $s_pending] == 0} {
+		_restart_timer $this
+	}
+}
+
+proc available_langs {} {
+	set langs [list]
+	catch {
+		set fd [open [list | aspell dump dicts] r]
+		while {[gets $fd line] >= 0} {
+			if {$line eq {}} continue
+			lappend langs $line
+		}
+		close $fd
+	}
+	return $langs
+}
+
+}
-- 
1.5.4.1213.g2bdeb
