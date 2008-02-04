From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] git-gui: Automatically spell check commit messages as the user types
Date: Mon, 4 Feb 2008 03:41:54 -0500
Message-ID: <20080204084153.GA9997@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Christian Stimming <stimming@tuhh.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Adam Flott <adam@npjh.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 09:42:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLwun-0006YX-Ox
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 09:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbYBDImI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 03:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbYBDImI
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 03:42:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55019 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbYBDImF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 03:42:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JLwtn-00055D-3C; Mon, 04 Feb 2008 03:41:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7D91820FBAE; Mon,  4 Feb 2008 03:41:54 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72479>

[This is also in my `pu` branch on repo.or.cz/git-gui.]

As you can see the commit message was rather long.  I used this
feature the entire time while writing it, and I have to say, it
saved me from my horrible spelling and typing skills.  It also
didn't feel like there was any significant lag, although every
once in a while it will mark a word that you are in the middle
of typing as misspelled, and catch up and correct that once you
finish the word.  I guess that's what you get for slowing down
and taking a few extra milliseconds to move the fingers.  :)

I need to test this on other platforms and with other languages,
but its working quite nicely on my Mac OS X system.  I did have to
install Aspell through DarwinPorts, sadly Mac OS 10.4 does not come
with it pre-installed.

Personally I prefer this style of spellchecking over the "lets show
a modal dialog and ask the user to check one word at a time through
the document".  Mainly because this style gives you full context,
while the modal dialog forms almost never do.

I'm not sure how to configure Aspell for other languages, it just
magically came up with English on my system.  Since git-gui has i18n
support almost everywhere else I want to get that settled before
this topic merges into my master branch.  I've CC'd Christian and
Johannes as they have been a big help in the past with the git-gui
i18n effort and I would value any input they might have.


--8>--
[PATCH] git-gui: Automatically spell check commit messages as the user types

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

We take the simple approach and shove the entire message at Aspell
each time we decide to run the spellchecker.  The end of the message
is determined by also sending a command to get the current language,
as this line's result is uniquely different from the other output we
are receiving from Aspell.  While Aspell is chewing on a message we
stop sending output to it, even if the user has modified the message
buffer and waited at least our 300 millisecond window.  This single
message at a time validation prevents flooding the pipe to Aspell.

We escape all input lines with ^, as recommended by the Aspell manual
page, as this allows Aspell to properly ignore any input line that is
otherwise looking like a command (e.g. ! to enable terse output).  By
using this escape however we need to correct all word offsets by -1 as
Aspell is apparently considering the ^ escape to be part of the line's
character count, but our Tk text widget obviously does not.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-gui.sh         |   53 ++++++++++++++++-
 lib/about.tcl      |    5 ++
 lib/spellcheck.tcl |  169 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+), 1 deletions(-)
 create mode 100644 lib/spellcheck.tcl

diff --git a/git-gui.sh b/git-gui.sh
index f42e461..0f8627e 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1683,6 +1683,7 @@ set is_quitting 0
 proc do_quit {} {
 	global ui_comm is_quitting repo_config commit_type
 	global GITGUI_BCK_exists GITGUI_BCK_i
+	global SPELL_fd SPELL_i
 
 	if {$is_quitting} return
 	set is_quitting 1
@@ -1710,6 +1711,16 @@ proc do_quit {} {
 			}
 		}
 
+		# -- Cancel our spellchecker if its running.
+		#
+		if {[info exists SPELL_fd]} {
+			catch {fileevent $SPELL_fd readable {}}
+			catch {close $SPELL_fd}
+		}
+		if {[info exists SPELL_i]} {
+			after cancel $SPELL_i
+		}
+
 		# -- Remove our editor backup, its not needed.
 		#
 		after cancel $GITGUI_BCK_i
@@ -2416,6 +2427,9 @@ text $ui_comm -background white -borderwidth 1 \
 	-width 75 -height 9 -wrap none \
 	-font font_diff \
 	-yscrollcommand {.vpane.lower.commarea.buffer.sby set}
+$ui_comm tag conf misspelled \
+	-foreground red \
+	-underline 1
 scrollbar .vpane.lower.commarea.buffer.sby \
 	-command [list $ui_comm yview]
 pack .vpane.lower.commarea.buffer.header -side top -fill x
@@ -2454,7 +2468,7 @@ $ctxm add separator
 $ctxm add command \
 	-label [mc "Sign Off"] \
 	-command do_signoff
-bind_button3 $ui_comm "tk_popup $ctxm %X %Y"
+set ui_comm_ctxm $ctxm
 
 # -- Diff Header
 #
@@ -2857,6 +2871,43 @@ if {[winfo exists $ui_comm]} {
 	}
 
 	backup_commit_buffer
+
+	# -- If the user has aspell available we can drive it
+	#    in pipe mode to spellcheck the commit message.
+	#
+	set spell_cmd [list |]
+	lappend spell_cmd aspell
+	lappend spell_cmd --mode=none
+	lappend spell_cmd --encoding=UTF-8
+	lappend spell_cmd pipe
+	if {[catch {set SPELL_fd [open $spell_cmd r+]} spell_err]} {
+		unset spell_err
+		set popcmd [list tk_popup $ui_comm_ctxm %X %Y]
+	} else {
+		fconfigure $SPELL_fd \
+			-encoding utf-8 \
+			-eofchar {} \
+			-translation lf
+
+		gets $SPELL_fd SPELL_version
+		if {{@(#) } eq [string range $SPELL_version 0 4]} {
+			set SPELL_version [string range $SPELL_version 5 end]
+		}
+
+		puts $SPELL_fd !     ; # enable terse mode
+		puts $SPELL_fd {$$l} ; # fetch the language
+		flush $SPELL_fd
+		gets $SPELL_fd SPELL_lang
+		fconfigure $SPELL_fd -blocking 0
+		fileevent $SPELL_fd readable spellcheck_read
+		spellcheck_commit_buffer
+		set popcmd [list \
+			spellcheck_popup_suggest \
+			$ui_comm_ctxm \
+			%X %Y @%x,%y]
+	}
+	bind_button3 $ui_comm $popcmd
+	unset spell_cmd popcmd
 }
 
 lock_index begin-read
diff --git a/lib/about.tcl b/lib/about.tcl
index 719fc54..bd62f2a 100644
--- a/lib/about.tcl
+++ b/lib/about.tcl
@@ -4,6 +4,7 @@
 proc do_about {} {
 	global appvers copyright oguilib
 	global tcl_patchLevel tk_patchLevel
+	global SPELL_version SPELL_lang
 
 	set w .about_dialog
 	toplevel $w
@@ -40,6 +41,10 @@ proc do_about {} {
 		append v "Tcl version $tcl_patchLevel"
 		append v ", Tk version $tk_patchLevel"
 	}
+	if {[info exists SPELL_version]} {
+		append v "\n"
+		append v "$SPELL_version, $SPELL_lang"
+	}
 
 	set d {}
 	append d "git wrapper: $::_git\n"
diff --git a/lib/spellcheck.tcl b/lib/spellcheck.tcl
new file mode 100644
index 0000000..c032725
--- /dev/null
+++ b/lib/spellcheck.tcl
@@ -0,0 +1,169 @@
+# git-gui spellchecking support through aspell
+# Copyright (C) 2008 Shawn Pearce
+
+set SPELL_sent {}
+set SPELL_last {}
+set SPELL_line 0
+set SPELL_clear 0
+set SPELL_menuidx 0
+array set SPELL_suggest [list]
+
+proc spellcheck_popup_suggest {menu X Y pos} {
+	global ui_comm SPELL_suggest SPELL_menuidx
+
+	while {$SPELL_menuidx > 0} {
+		$menu delete 0
+		incr SPELL_menuidx -1
+	}
+
+	set b_loc [$ui_comm index "$pos wordstart"]
+	set e_loc [$ui_comm index "$b_loc wordend"]
+	set orig  [$ui_comm get $b_loc $e_loc]
+
+	if {[lsearch -exact [$ui_comm tag names $b_loc] misspelled] >= 0} {
+		if {[info exists SPELL_suggest($orig)]} {
+			set cnt 0
+			foreach s $SPELL_suggest($orig) {
+				if {$cnt < 5} {
+					$menu insert $SPELL_menuidx command \
+						-label $s \
+						-command [list \
+							spellcheck_replace \
+							$b_loc \
+							$e_loc \
+							$s]
+					incr SPELL_menuidx
+					incr cnt
+				} else {
+					break
+				}
+			}
+		} else {
+			$menu insert $SPELL_menuidx command \
+				-label [mc "No Suggestions"] \
+				-state disabled
+			incr SPELL_menuidx
+		}
+		$menu insert $SPELL_menuidx separator
+		incr SPELL_menuidx
+	}
+
+	$ui_comm mark set saved-insert insert
+	tk_popup $menu $X $Y
+}
+
+proc spellcheck_replace {b_loc e_loc word} {
+	global ui_comm
+
+	$ui_comm configure -autoseparators 0
+	$ui_comm edit separator
+
+	$ui_comm delete $b_loc $e_loc
+	$ui_comm insert $b_loc $word
+
+	$ui_comm edit separator
+	$ui_comm configure -autoseparators 1
+	$ui_comm mark set insert saved-insert
+}
+
+proc spellcheck_commit_buffer {} {
+	global ui_comm \
+		SPELL_i SPELL_sent SPELL_last \
+		SPELL_fd SPELL_line SPELL_suggest
+
+	set buf [$ui_comm get 1.0 end]
+	if {$buf ne $SPELL_sent && $buf eq $SPELL_last} {
+		foreach line [split $buf "\n"] {
+			if {$line eq {}} continue
+			puts $SPELL_fd ^$line
+		}
+		puts $SPELL_fd {$$l}
+		flush $SPELL_fd
+
+		set SPELL_sent $buf
+		set SPELL_line 1
+		set SPELL_clear 1
+		array unset SPELL_suggest
+	} else {
+		set SPELL_last $buf
+		set SPELL_i [after 300 spellcheck_commit_buffer]
+	}
+}
+
+proc spellcheck_read {} {
+	global ui_comm SPELL_fd SPELL_lang SPELL_i
+	global SPELL_line SPELL_clear SPELL_suggest
+
+	while {[gets $SPELL_fd line] >= 0} {
+		if {$line eq $SPELL_lang} {
+			set SPELL_i [after 300 spellcheck_commit_buffer]
+			continue
+		}
+
+		if {$SPELL_clear} {
+			$ui_comm tag remove misspelled \
+				"$SPELL_line.0" \
+				"$SPELL_line.end"
+			set SPELL_clear 0
+		}
+
+		if {$line eq {}} {
+			incr SPELL_line
+
+			set max_line [lindex [split [$ui_comm index end] .] 0]
+			while {$SPELL_line <= $max_line
+				&& [$ui_comm get \
+				"$SPELL_line.0" \
+				"$SPELL_line.end -1c"] eq {}} {
+				$ui_comm tag remove misspelled \
+					"$SPELL_line.0" \
+					"$SPELL_line.end"
+				incr SPELL_line
+			}
+
+			set SPELL_clear 1
+			continue
+		}
+
+		switch -- [string range $line 0 1] {
+		{& } {
+			set line [split [string range $line 2 end] :]
+			set info [split [lindex $line 0] { }]
+			set orig [lindex $info 0]
+			set offs [lindex $info 2]
+			set sugg [list]
+			foreach s [split [lindex $line 1] ,] {
+				lappend sugg [string range $s 1 end]
+			}
+			set SPELL_suggest($orig) $sugg
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
+		set b_loc "$SPELL_line.$offs"
+		set e_loc [$ui_comm index "$SPELL_line.$offs wordend"]
+		set curr [$ui_comm get $b_loc $e_loc]
+		if {$curr eq $orig} {
+			$ui_comm tag add misspelled $b_loc $e_loc
+		}
+	}
+
+	fconfigure $SPELL_fd -block 1
+	if {[eof $SPELL_fd] && [catch {close $SPELL_fd} err]} {
+		catch {after cancel $SPELL_i}
+		unset SPELL_i SPELL_fd
+		$ui_comm tag remove misspelled 1.0 end
+		error_popup [strcat "Spell Checker Failed" "\n\n" $err]
+		return
+	}
+	fconfigure $SPELL_fd -block 0
+}
-- 
1.5.4.1134.ge34cf
