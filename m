From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH 3/7] gitk: Allow starting gui blame for a specific line.
Date: Wed,  8 Oct 2008 11:05:36 +0400
Message-ID: <1223449540-20457-4-git-send-email-angavrilov@gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-3-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 09:09:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnTAR-0006GO-7u
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 09:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbYJHHHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 03:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbYJHHHb
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 03:07:31 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:14986 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbYJHHHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 03:07:25 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3173798fkq.5
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UytdttsG1wHpFiE9rb4xCtD2zWUOwCiB+SJL1YeYRS8=;
        b=KSo2PKVAvDE2B7E4RGo1uczQy0gwUnhdQUZKIv9OqM5AwyZT3KoV/b+8c5JC45GHOG
         qDSZPQm9R3ds4YP/d/6NhaweJ9hxXYlUNi8aGXzUnIK5616T/UrNQMdWdVvlaRtGgRg/
         8nW73MX7HmfmApXJJ9ncWQFy3PxoUmFm8E0d8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e/eyP1BrmxApscrLMvTOvnLhG6PVrYajYb/y79Ut8MPdddTEMNwPuGiqH3uLFLJBFa
         skEICQ6C6mXHj1EPLtlLChrG4uQedgpOJjM6NFAGWR1UMK3cilcW3sQDgE9WmTqmOcNG
         PqJb66AO2y5+1YKkpFWf2/4CHd+8pnjs8DaBI=
Received: by 10.180.234.2 with SMTP id g2mr5836413bkh.54.1223449643397;
        Wed, 08 Oct 2008 00:07:23 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id e17sm15096059fke.10.2008.10.08.00.07.22
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 00:07:22 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223449540-20457-3-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97777>

Adds a context menu item to the diff viewer pane that
calls blame, focusing it on the clicked line. In case
of combined diffs, it also automatically deduces which
parent is to be blamed.

The context menu itself is added by this patch. It is
possible to populate it with commands from the flist
menu.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |  135 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 96ca965..3c77909 100755
--- a/gitk
+++ b/gitk
@@ -2184,6 +2184,7 @@ proc makewindow {} {
     bind $cflist <ButtonRelease-1> {treeclick %W %x %y}
     global ctxbut
     bind $cflist $ctxbut {pop_flist_menu %W %X %Y %x %y}
+    bind $ctext $ctxbut {pop_diff_menu %W %X %Y %x %y}
 
     set maincursor [. cget -cursor]
     set textcursor [$ctext cget -cursor]
@@ -2233,6 +2234,12 @@ proc makewindow {} {
         -command {external_diff}
     $flist_menu add command -label [mc "Blame parent commit"] \
         -command {external_blame 1}
+
+    global diff_menu
+    set diff_menu .diffctxmenu
+    menu $diff_menu -tearoff 0
+    $diff_menu add command -label [mc "Blame parent commit"] \
+        -command {external_blame_diff}
 }
 
 # Windows sends all mouse wheel events to the current focused window, not
@@ -2935,6 +2942,34 @@ proc pop_flist_menu {w X Y x y} {
     tk_popup $flist_menu $X $Y
 }
 
+proc find_ctext_fileinfo {line} {
+    global ctext_file_names ctext_file_lines
+
+    set ok [bsearch $ctext_file_lines $line]
+    set tline [lindex $ctext_file_lines $ok]
+
+    if {$ok >= [llength $ctext_file_lines] || $line < $tline} {
+        return {}
+    } else {
+        return [list [lindex $ctext_file_names $ok] $tline]
+    }
+}
+
+proc pop_diff_menu {w X Y x y} {
+    global ctext diff_menu flist_menu_file
+    global diff_menu_txtpos diff_menu_line
+    global diff_menu_filebase
+
+    stopfinding
+    set diff_menu_txtpos [split [$w index "@$x,$y"] "."]
+    set diff_menu_line [lindex $diff_menu_txtpos 0]
+    set f [find_ctext_fileinfo $diff_menu_line]
+    if {$f eq {}} return
+    set flist_menu_file [lindex $f 0]
+    set diff_menu_filebase [lindex $f 1]
+    tk_popup $diff_menu $X $Y
+}
+
 proc flist_hl {only} {
     global flist_menu_file findstring gdttype
 
@@ -3041,7 +3076,84 @@ proc external_diff {} {
     }
 }
 
-proc external_blame {parent_idx} {
+proc find_hunk_blamespec {base line} {
+    global ctext
+
+    # Find and parse the hunk header
+    set s_lix [$ctext search -backwards -regexp ^@@ "$line.0 lineend" $base.0]
+    if {$s_lix eq {}} return
+
+    set s_line [$ctext get $s_lix "$s_lix + 1 lines"]
+    if {![regexp {^@@@?(( -\d+(,\d+)?)+) \+(\d+)(,\d+)? @@} $s_line \
+	    s_line old_specs osz osz1 new_line nsz]} {
+	return
+    }
+
+    # base lines for the parents
+    set old_lines [list]
+    foreach old_spec [lrange [split $old_specs " "] 1 end] {
+	if {![regexp -- {-(\d+)(,\d+)?} $old_spec \
+	        old_spec old_line osz]} {
+	    return
+	}
+	lappend old_lines $old_line
+    }
+
+    # Now scan the lines to determine offset within the hunk
+    set parent {}
+    set dline 0
+    set s_lno [lindex [split $s_lix "."] 0]
+
+    for {set i $line} {$i > $s_lno} {incr i -1} {
+	set c_line [$ctext get $i.0 "$i.0 + 1 lines"]
+	if {$parent eq {}} {
+	    # find first preceeding line that belongs to some parent
+	    for {set j 0} {$j < [llength $old_lines]} {incr j} {
+		set code [string index $c_line $j]
+		if {$code ne {-} && $code ne { }} continue
+		if {$code eq { } && $parent ne {}} continue
+		set parent $j
+		if {$code eq {-}} break
+	    }
+	}
+	if {$parent ne {}} {
+	    # then count other lines that belong to it
+	    set code [string index $c_line $parent]
+	    if {$code ne {+}} {
+		incr dline
+	    }
+	}
+    }
+
+    if {$parent eq {}} { set parent 0 }
+    incr dline [lindex $old_lines $parent]
+    incr parent
+    return [list $parent $dline]
+}
+
+proc external_blame_diff {} {
+    global currentid diffmergeid cmitmode
+    global diff_menu_txtpos diff_menu_line
+    global diff_menu_filebase flist_menu_file
+
+    if {$cmitmode eq "tree"} {
+	set parent_idx 1
+	set line [expr {$diff_menu_line - $diff_menu_filebase - 1}]
+    } else {
+	set hinfo [find_hunk_blamespec $diff_menu_filebase $diff_menu_line]
+	if {$hinfo ne {}} {
+	    set parent_idx [lindex $hinfo 0]
+	    set line [lindex $hinfo 1]
+	} else {
+	    set parent_idx 1
+	    set line 0
+	}
+    }
+
+    external_blame $parent_idx $line
+}
+
+proc external_blame {parent_idx {line {}}} {
     global flist_menu_file
     global nullid nullid2
     global parentlist selectedline currentid
@@ -3057,7 +3169,12 @@ proc external_blame {parent_idx} {
 	return
     }
 
-    if {[catch {exec git gui blame $base_commit $flist_menu_file &} err]} {
+    set cmdline [list git gui blame]
+    if {$line ne {} && $line > 1} {
+	lappend cmdline "--line=$line"
+    }
+    lappend cmdline $base_commit $flist_menu_file
+    if {[catch {eval exec $cmdline &} err]} {
 	error_popup "[mc "git gui blame: command failed:"] $err"
     }
 }
@@ -6305,6 +6422,7 @@ proc gettreeline {gtf id} {
 
 proc showfile {f} {
     global treefilelist treeidlist diffids nullid nullid2
+    global ctext_file_names ctext_file_lines
     global ctext commentend
 
     set i [lsearch -exact $treefilelist($diffids) $f]
@@ -6328,6 +6446,8 @@ proc showfile {f} {
     filerun $bf [list getblobline $bf $diffids]
     $ctext config -state normal
     clear_ctext $commentend
+    lappend ctext_file_names $f
+    lappend ctext_file_lines [lindex [split $commentend "."] 0]
     $ctext insert end "\n"
     $ctext insert end "$f\n" filesep
     $ctext config -state disabled
@@ -6387,6 +6507,7 @@ proc mergediff {id} {
 proc getmergediffline {mdf id np} {
     global diffmergeid ctext cflist mergemax
     global difffilestart mdifffd
+    global ctext_file_names ctext_file_lines
     global diffencoding
 
     $ctext conf -state normal
@@ -6404,6 +6525,8 @@ proc getmergediffline {mdf id np} {
 	    set here [$ctext index "end - 1c"]
 	    lappend difffilestart $here
 	    add_flist [list $fname]
+	    lappend ctext_file_names $fname
+	    lappend ctext_file_lines [lindex [split $here "."] 0]
 	    set diffencoding [get_cached_encoding $fname]
 	    set l [expr {(78 - [string length $fname]) / 2}]
 	    set pad [string range "----------------------------------------" 1 $l]
@@ -6661,11 +6784,13 @@ proc setinlist {var i val} {
 
 proc makediffhdr {fname ids} {
     global ctext curdiffstart treediffs
+    global ctext_file_names
 
     set i [lsearch -exact $treediffs($ids) $fname]
     if {$i >= 0} {
 	setinlist difffilestart $i $curdiffstart
     }
+    set ctext_file_names [lreplace $ctext_file_names end end $fname]
     set l [expr {(78 - [string length $fname]) / 2}]
     set pad [string range "----------------------------------------" 1 $l]
     $ctext insert $curdiffstart "$pad $fname $pad" filesep
@@ -6674,6 +6799,7 @@ proc makediffhdr {fname ids} {
 proc getblobdiffline {bdf ids} {
     global diffids blobdifffd ctext curdiffstart
     global diffnexthead diffnextnote difffilestart
+    global ctext_file_names ctext_file_lines
     global diffinhdr treediffs
     global diffencoding
 
@@ -6691,6 +6817,8 @@ proc getblobdiffline {bdf ids} {
 	    # start of a new file
 	    $ctext insert end "\n"
 	    set curdiffstart [$ctext index "end - 1c"]
+	    lappend ctext_file_names ""
+	    lappend ctext_file_lines [lindex [split $curdiffstart "."] 0]
 	    $ctext insert end "\n" filesep
 	    # If the name hasn't changed the length will be odd,
 	    # the middle char will be a space, and the two bits either
@@ -6827,6 +6955,7 @@ proc nextfile {} {
 
 proc clear_ctext {{first 1.0}} {
     global ctext smarktop smarkbot
+    global ctext_file_names ctext_file_lines
     global pendinglinks
 
     set l [lindex [split $first .] 0]
@@ -6840,6 +6969,8 @@ proc clear_ctext {{first 1.0}} {
     if {$first eq "1.0"} {
 	catch {unset pendinglinks}
     }
+    set ctext_file_names {}
+    set ctext_file_lines {}
 }
 
 proc settabs {{firstab {}}} {
-- 
1.6.0.20.g6148bc
