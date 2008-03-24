From: Thomas Arcila <thomas.arcila@gmail.com>
Subject: [PATCH] gitk : External diff viewer.
Date: Mon, 24 Mar 2008 12:55:36 +0100
Message-ID: <1206359736.7362.5.camel@pumpkins.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 12:56:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdlI5-00066K-OK
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 12:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758367AbYCXLz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 07:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758351AbYCXLz4
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 07:55:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:20300 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758301AbYCXLzy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 07:55:54 -0400
Received: by nf-out-0910.google.com with SMTP id g13so776656nfb.21
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:x-tuid:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=Tu/3JqA9dJLYwEHE1a51RjEOXejmFvXmaR1JxQq6F2Y=;
        b=hLidL1zExb2TO5ZjKqOXlv8EiCQ2O0WMQ8XiXXgYgOcQOx9s9OYqiosS+H42cIlbBtYKBzvcTZS6yVJOqh57xiMvOrIN+Pw/qgwKi4ieoRN4CHYidqDqN/IHCA/v92I2DB7rH6tONgzuTfm4Yzm06HaZgnmnnSeRfv3I8WYByGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=subject:from:to:cc:x-tuid:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=jKbiK71Ij/gXRk0z1gVwfgzUpxmzzjdj7D+6WXqKRrJSs+MD4xdWVAtGIDLrfujO+3OZiImz5HLiuw2z43F8Pj5zE5zwJVWpPIa6UU/vvPRTpZ+Io2Upe9MdOT0HfxLPxMQ9LJcu+EOCieJ+9Ub+lzCb5YM75IXk7cH8upT28LY=
Received: by 10.78.146.11 with SMTP id t11mr20136771hud.70.1206359749865;
        Mon, 24 Mar 2008 04:55:49 -0700 (PDT)
Received: from ?192.168.0.2? ( [85.69.2.238])
        by mx.google.com with ESMTPS id s10sm8068340mue.15.2008.03.24.04.55.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Mar 2008 04:55:48 -0700 (PDT)
X-TUID: f4929b65dec17891
X-Mailer: Evolution 2.22.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78025>

Right click on patched file list view gives "External diff" popup menu entry,
launching selected external diff tool.
The diff tool is configurable through Edit/Preference/External diff tool.

Signed-off-by: Thomas Arcila <thomas.arcila@gmail.com>
---
Hi,

Here is a patch to gitk that allows to run an external diff viewer.
It can be configured in Edit/Preferences/External diff tool.

To see the diff between two files:
- select revisions to diff
- right click on a file in the patched files list view
- choose "External diff"

* About the UI : 
This pane is already meant to show which files are different between selected revisions
and it's also used to select the diff displayed in the diff viewer. It only required
few modifications to gitk except for adding the external_diff method and
tweaking the menu.

flist_menu has been split up into flist_menu (contextual menu for patched files list
view) and flist_menu_tree (contextual menu for tree view).

* Diff tool :
It defaults to meld and can be configured through Edit/Preferences/External diff tool

* Diff tool calling conventions :
The choice done here is to consider that any diff tool can take the two
files to diff. No git information should be required - filenames give
information about revisions currently diffed (see Temporay files).
The few ones I tried could worked this way ([g]vimdiff, meld, kdiff3,
beyond compare), others can be warped in scripts as it has to be done
when using GIT_EXTERNAL_DIFF_TOOL.

* Temporary files :
Temporary files are stored at the top level of project directory along with .git.
- As each instance of gitk should be able to diff, temporary directory is name by pid.
- One instance of gitk can run several diffs at the same time so diffs must be numbered.
- Name of a file should be self describing : it should tell the revision it came from
  and its name
- name mangling should keep extension as is as smart diff viewer can do syntactic
  coloration
- diffing with working copy should directly involve file from the working copy (not a copy) 
  so it can be edited (some changes could be discarded from there...)
The naming convention used is
.gitk-tmp.$pid/$diffnum/[$revision|index] $basefile.$ext

* Clean up
Temporary files are removed :
- when diff viewer exits(through [file delete -force $gitktmpdir .gitk-tmp.$pid/$diffnum])
-when gitk exits (through [file delete -force $gitktmpdir .gitk-tmp.$pid])


Any feedback is welcome.
Thomas



 gitk |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 84ab02e..21d79e3 100755
--- a/gitk
+++ b/gitk
@@ -1088,6 +1088,16 @@ proc makewindow {} {
 	-command {flist_hl 0}
     $flist_menu add command -label [mc "Highlight this only"] \
 	-command {flist_hl 1}
+    $flist_menu add command -label [mc "External diff"] \
+        -command {external_diff}
+
+    global flist_menu_tree
+    set flist_menu_tree .flistctxmenutree
+    menu $flist_menu_tree -tearoff 0
+    $flist_menu_tree add command -label [mc "Highlight this too"] \
+	-command {flist_hl 0}
+    $flist_menu_tree add command -label [mc "Highlight this only"] \
+	-command {flist_hl 1}
 }
 
 # Windows sends all mouse wheel events to the current focused window, not
@@ -1192,7 +1202,7 @@ proc savestuff {w} {
     global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
-    global autoselect
+    global autoselect extdifftool
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
@@ -1218,6 +1228,7 @@ proc savestuff {w} {
 	puts $f [list set diffcolors $diffcolors]
 	puts $f [list set diffcontext $diffcontext]
 	puts $f [list set selectbgcolor $selectbgcolor]
+	puts $f [list set extdifftool $extdifftool]
 
 	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
@@ -1755,7 +1766,7 @@ proc sel_flist {w x y} {
 }
 
 proc pop_flist_menu {w X Y x y} {
-    global ctext cflist cmitmode flist_menu flist_menu_file
+    global ctext cflist cmitmode flist_menu flist_menu_tree flist_menu_file
     global treediffs diffids
 
     stopfinding
@@ -1768,7 +1779,11 @@ proc pop_flist_menu {w X Y x y} {
 	set e [lindex $treediffs($diffids) [expr {$l-2}]]
     }
     set flist_menu_file $e
-    tk_popup $flist_menu $X $Y
+    if {$cmitmode eq "tree"} {
+      tk_popup $flist_menu_tree $X $Y
+    } else {
+      tk_popup $flist_menu $X $Y
+    }
 }
 
 proc flist_hl {only} {
@@ -1783,6 +1798,88 @@ proc flist_hl {only} {
     set gdttype [mc "touching paths:"]
 }
 
+proc save_file_from_commit {filename output} {
+    exec git show $filename > $output
+}
+
+proc external_diff_get_one_file {diffid filename diffdir} {
+    global nullid nullid2
+    global gitdir
+    set failure_reason "File has probably been created, deleted, renamed \
+            in a different commit."
+    if {$diffid == $nullid} {
+        set difffile [file join $gitdir ".." $filename]
+    } elseif {$diffid == $nullid2} {
+        set difffile [file join $diffdir "\[index\] [file tail $filename]"]
+        if {[catch {save_file_from_commit :$filename $difffile} err]} {
+            error_popup "\"$filename\" cannot be found in the index. \
+                $failure_reason ($err)"
+            return 0;
+        }
+    } else {
+        set difffile [file join $diffdir "\[$diffid\] [file tail $filename]"]
+        if {[catch {save_file_from_commit $diffid:$filename $difffile} err]} {
+            error_popup "\"$filename\" cannot be found in revision $diffid. \
+                $failure_reason ($err)"
+            return 0;
+        }
+    }
+    return $difffile
+}
+
+proc external_diff {} {
+    global gitktmpdir nullid nullid2
+    global flist_menu_file
+    global diffids
+    global diffnum
+    global gitdir extdifftool
+
+    set diffidto [lindex $diffids 0]
+
+    if {[llength $diffids] == 1} {
+        # no reference commit given
+        set diffidto [lindex $diffids 0]
+        if {$diffidto eq $nullid} {
+            # diffing working copy with index
+            set diffidfrom $nullid2
+        } elseif {$diffidto eq $nullid2} {
+            # diffing index with HEAD
+            set diffidfrom "HEAD"
+        } else {
+            # use parent commit
+            global allparents
+            set diffidfrom $allparents($diffidto)
+        }
+    } else {
+        set diffidfrom [lindex $diffids 0]
+        set diffidto [lindex $diffids 1]
+    }
+
+    # make sure that several diffs wont collide
+    if {! [info exists diffnum]} {
+        set diffnum 0
+    } else {
+        set diffnum [expr $diffnum + 1]
+    }
+    set diffdir [file join $gitktmpdir "$diffnum"]
+    file mkdir $diffdir
+
+    # gather files to diff
+    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
+    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
+
+    if {$difffromfile != 0 && $difftofile != 0} {
+        set cmd [concat | $extdifftool [shellarglist [list $difffromfile $difftofile]]]
+        if {[catch {set fl [open $cmd]} err]} {
+            file delete -force [ file join $gitktmpdir $diffnum ]
+            error_popup [mc "$extdifftool command failed: $err"]
+        } else {
+            fconfigure $fl -blocking 0
+            filerun $fl [list file delete -force [file join $gitktmpdir $diffnum]]
+        }
+    }
+}
+
 # Functions for adding and removing shell-type quoting
 
 proc shellquote {str} {
@@ -7858,9 +7955,13 @@ proc showtag {tag isnew} {
 
 proc doquit {} {
     global stopped
+    global gitktmpdir
+
     set stopped 100
     savestuff .
     destroy .
+
+    catch {file delete -force $gitktmpdir}
 }
 
 proc mkfontdisp {font top which} {
@@ -7989,7 +8090,7 @@ proc doprefs {} {
     global maxwidth maxgraphpct
     global oldprefs prefstop showneartags showlocalchanges
     global bgcolor fgcolor ctext diffcolors selectbgcolor
-    global tabstop limitdiffs autoselect
+    global tabstop limitdiffs autoselect extdifftool
 
     set top .gitkprefs
     set prefstop $top
@@ -8041,6 +8142,13 @@ proc doprefs {} {
     pack $top.ldiff.b $top.ldiff.l -side left
     grid x $top.ldiff -sticky w
 
+    entry $top.extdifft -textvariable extdifftool
+    button $top.extdiffb -text [mc "External diff tool" ] -font optionfont \
+  -command {set extdifftool \"[tk_getOpenFile -title "External diff tool" \
+  -multiple "false"]\"}
+    grid x $top.extdiffb $top.extdifft -sticky w
+
+
     label $top.cdisp -text [mc "Colors: press to choose"]
     grid $top.cdisp - -sticky w -pady 10
     label $top.bg -padx 40 -relief sunk -background $bgcolor
@@ -8516,6 +8624,8 @@ set limitdiffs 1
 set datetimeformat "%Y-%m-%d %H:%M:%S"
 set autoselect 1
 
+set extdifftool "meld"
+
 set colors {green red blue magenta darkgrey brown orange}
 set bgcolor white
 set fgcolor black
@@ -8570,6 +8680,9 @@ if {![file isdirectory $gitdir]} {
     exit 1
 }
 
+set gitktmpdir [file normalize [file join $gitdir ".." [format ".gitk-tmp.%s" [pid]]]]
+file mkdir $gitktmpdir
+
 set mergeonly 0
 set revtreeargs {}
 set cmdline_files {}
-- 
1.5.4.3
