From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] gitk: Fix the Makefile to cope with systems lacking msgfmt
Date: Wed, 9 Jan 2008 14:31:09 +0000
Message-ID: <20080109143109.GA15069@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 15:31:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCbyC-0005a2-UR
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 15:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbYAIObR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 09:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbYAIObR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 09:31:17 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:58574 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYAIObQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 09:31:16 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JCbxa-0007YS-5h
	for git@vger.kernel.org; Wed, 09 Jan 2008 14:31:14 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m09EV9ZS015402
	for <git@vger.kernel.org>; Wed, 9 Jan 2008 14:31:09 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m09EV9fE015401
	for git@vger.kernel.org; Wed, 9 Jan 2008 14:31:09 GMT
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69995>

The po2msg.sh script and the .gitignore in the po directory have been
shamelessly copied from the current git-gui.  This enables the top
level "make NO_MSGFMT" to work consistently for git across the git-gui
and gitk sub-projects.

This is the same effective patch that has previously been posted as a
git.git patch which more succinctly described the copying of
po/.gitignore and po/po2msg.sh from git-gui.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 Makefile      |    7 +++-
 po/.gitignore |    2 +
 po/po2msg.sh  |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 1 deletions(-)
 create mode 100644 po/.gitignore
 create mode 100644 po/po2msg.sh

diff --git a/Makefile b/Makefile
index 6158504..ae2b80b 100644
--- a/Makefile
+++ b/Makefile
@@ -18,7 +18,12 @@ TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
 ## po-file creation rules
 XGETTEXT   ?= xgettext
-MSGFMT     ?= msgfmt
+ifdef NO_MSGFMT
+	MSGFMT ?= $(TCL_PATH) po/po2msg.sh
+else
+	MSGFMT ?= msgfmt
+endif
+
 PO_TEMPLATE = po/gitk.pot
 ALL_POFILES = $(wildcard po/*.po)
 ALL_MSGFILES = $(subst .po,.msg,$(ALL_POFILES))
diff --git a/po/.gitignore b/po/.gitignore
new file mode 100644
index 0000000..a89cf44
--- /dev/null
+++ b/po/.gitignore
@@ -0,0 +1,2 @@
+*.msg
+*~
diff --git a/po/po2msg.sh b/po/po2msg.sh
new file mode 100644
index 0000000..c63248e
--- /dev/null
+++ b/po/po2msg.sh
@@ -0,0 +1,133 @@
+#!/bin/sh
+# Tcl ignores the next line -*- tcl -*- \
+exec tclsh "$0" -- "$@"
+
+# This is a really stupid program, which serves as an alternative to
+# msgfmt.  It _only_ translates to Tcl mode, does _not_ validate the
+# input, and does _not_ output any statistics.
+
+proc u2a {s} {
+	set res ""
+	foreach i [split $s ""] {
+		scan $i %c c
+		if {$c<128} {
+			# escape '[', '\' and ']'
+			if {$c == 0x5b || $c == 0x5d} {
+				append res "\\"
+			}
+			append res $i
+		} else {
+			append res \\u[format %04.4x $c]
+		}
+	}
+	return $res
+}
+
+set output_directory "."
+set lang "dummy"
+set files [list]
+set show_statistics 0
+
+# parse options
+for {set i 0} {$i < $argc} {incr i} {
+	set arg [lindex $argv $i]
+	if {$arg == "--statistics"} {
+		incr show_statistics
+		continue
+	}
+	if {$arg == "--tcl"} {
+		# we know
+		continue
+	}
+	if {$arg == "-l"} {
+		incr i
+		set lang [lindex $argv $i]
+		continue
+	}
+	if {$arg == "-d"} {
+		incr i
+		set tmp [lindex $argv $i]
+		regsub "\[^/\]$" $tmp "&/" output_directory
+		continue
+	}
+	lappend files $arg
+}
+
+proc flush_msg {} {
+	global msgid msgstr mode lang out fuzzy
+	global translated_count fuzzy_count not_translated_count
+
+	if {![info exists msgid] || $mode == ""} {
+		return
+	}
+	set mode ""
+	if {$fuzzy == 1} {
+		incr fuzzy_count
+		set fuzzy 0
+		return
+	}
+
+	if {$msgid == ""} {
+		set prefix "set ::msgcat::header"
+	} else {
+		if {$msgstr == ""} {
+			incr not_translated_count
+			return
+		}
+		set prefix "::msgcat::mcset $lang \"[u2a $msgid]\""
+		incr translated_count
+	}
+
+	puts $out "$prefix \"[u2a $msgstr]\""
+}
+
+set fuzzy 0
+set translated_count 0
+set fuzzy_count 0
+set not_translated_count 0
+foreach file $files {
+	regsub "^.*/\(\[^/\]*\)\.po$" $file "$output_directory\\1.msg" outfile
+	set in [open $file "r"]
+	fconfigure $in -encoding utf-8
+	set out [open $outfile "w"]
+
+	set mode ""
+	while {[gets $in line] >= 0} {
+		if {[regexp "^#" $line]} {
+			if {[regexp ", fuzzy" $line]} {
+				set fuzzy 1
+			} else {
+				flush_msg
+			}
+			continue
+		} elseif {[regexp "^msgid \"(.*)\"$" $line dummy match]} {
+			flush_msg
+			set msgid $match
+			set mode "msgid"
+		} elseif {[regexp "^msgstr \"(.*)\"$" $line dummy match]} {
+			set msgstr $match
+			set mode "msgstr"
+		} elseif {$line == ""} {
+			flush_msg
+		} elseif {[regexp "^\"(.*)\"$" $line dummy match]} {
+			if {$mode == "msgid"} {
+				append msgid $match
+			} elseif {$mode == "msgstr"} {
+				append msgstr $match
+			} else {
+				puts stderr "I do not know what to do: $match"
+			}
+		} else {
+			puts stderr "Cannot handle $line"
+		}
+	}
+	flush_msg
+	close $in
+	close $out
+}
+
+if {$show_statistics} {
+	puts [concat "$translated_count translated messages, " \
+		"$fuzzy_count fuzzy ones, " \
+		"$not_translated_count untranslated ones."]
+}
-- 
1.5.4.rc2.60.gb2e62
