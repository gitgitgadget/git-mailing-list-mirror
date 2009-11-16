From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: Use git-difftool for external diffs
Date: Sun, 15 Nov 2009 19:12:06 -0800
Message-ID: <1258341126-2108-1-git-send-email-davvid@gmail.com>
Cc: peff@peff.net, sam@vilain.net, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Nov 16 04:12:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9s10-0001Ul-MX
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 04:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbZKPDMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 22:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbZKPDMU
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 22:12:20 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:38769 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbZKPDMR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 22:12:17 -0500
Received: by yxe17 with SMTP id 17so4389292yxe.33
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 19:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=T59Z+FLiLC3Qi/2eDjBsrez+G+AamyVJOnXH0h+ikic=;
        b=Zrzn0w37z3xguYseRVDHHzgJ0ti/mykz2NXkx3st9zzUOM5q2OhMCRP6j53yLOWwQX
         iavesjEVsax4myCz9KP7IWSculbSx6s5pxFcH/8A0QiKA/eJne0lUl0isOcVcbIxHCQX
         cEhDJ4OAi0M9urzCgpMMnnGBgkbqBta1IP4pk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=s2tr08jaGurQDgPUlIWT+wnf1KwRl889bksB81v5TywVXfv5Tt7Q+apT80tvqd4HjZ
         5PIbMWKRJD1/UwgQ/ccuIKgVnf8YMSw6LSDtUDYGFM1DQm9YXlaoyPFBIw0kNtLfMYLT
         KM48hjOGJ6t6/RB1UMwkMCeWUD5gGU4Yh6eRc=
Received: by 10.90.37.36 with SMTP id k36mr1159536agk.111.1258341142303;
        Sun, 15 Nov 2009 19:12:22 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 9sm1237774yxf.23.2009.11.15.19.12.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Nov 2009 19:12:21 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.180.gc5b3e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132983>

This teaches gitk about git-difftool.  A benefit of this change is
that gitk's external diff now works with read-only repositories.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

The diffstat alone makes me happy.

 gitk |   83 ++++--------------------------------------------------------------
 1 files changed, 5 insertions(+), 78 deletions(-)

diff --git a/gitk b/gitk
index db5ec54..881ef95 100755
--- a/gitk
+++ b/gitk
@@ -2520,7 +2520,7 @@ proc savestuff {w} {
     global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors uicolor bgcolor fgcolor diffcolors diffcontext selectbgcolor
-    global autoselect extdifftool perfile_attrs markbgcolor
+    global autoselect perfile_attrs markbgcolor
     global hideremotes
 
     if {$stuffsaved} return
@@ -2554,7 +2554,6 @@ proc savestuff {w} {
 	puts $f [list set markbgcolor $markbgcolor]
 	puts $f [list set diffcontext $diffcontext]
 	puts $f [list set selectbgcolor $selectbgcolor]
-	puts $f [list set extdifftool $extdifftool]
 	puts $f [list set perfile_attrs $perfile_attrs]
 
 	puts $f "set geometry(main) [wm geometry .]"
@@ -3204,31 +3203,10 @@ proc save_file_from_commit {filename output what} {
     return $output
 }
 
-proc external_diff_get_one_file {diffid filename diffdir} {
-    global nullid nullid2 nullfile
-    global gitdir
-
-    if {$diffid == $nullid} {
-        set difffile [file join [file dirname $gitdir] $filename]
-	if {[file exists $difffile]} {
-	    return $difffile
-	}
-	return $nullfile
-    }
-    if {$diffid == $nullid2} {
-        set difffile [file join $diffdir "\[index\] [file tail $filename]"]
-        return [save_file_from_commit :$filename $difffile index]
-    }
-    set difffile [file join $diffdir "\[$diffid\] [file tail $filename]"]
-    return [save_file_from_commit $diffid:$filename $difffile \
-	       "revision $diffid"]
-}
-
 proc external_diff {} {
     global nullid nullid2
     global flist_menu_file
     global diffids
-    global extdifftool
 
     if {[llength $diffids] == 1} {
         # no reference commit given
@@ -3249,23 +3227,9 @@ proc external_diff {} {
         set diffidto [lindex $diffids 1]
     }
 
-    # make sure that several diffs wont collide
-    set diffdir [gitknewtmpdir]
-    if {$diffdir eq {}} return
-
-    # gather files to diff
-    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
-    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
-
-    if {$difffromfile ne {} && $difftofile ne {}} {
-        set cmd [list [shellsplit $extdifftool] $difffromfile $difftofile]
-        if {[catch {set fl [open |$cmd r]} err]} {
-            file delete -force $diffdir
-            error_popup "$extdifftool: [mc "command failed:"] $err"
-        } else {
-            fconfigure $fl -blocking 0
-            filerun $fl [list delete_at_eof $fl $diffdir]
-        }
+    set cmd {git difftool --no-prompt $diffidfrom $diffidto -- $flist_menu_file}
+    if {[catch {eval exec $cmd &} err]} {
+        error_popup "[mc "git difftool: command failed:"] $err"
     }
 }
 
@@ -3557,19 +3521,6 @@ proc read_line_source {fd inst} {
     return 0
 }
 
-# delete $dir when we see eof on $f (presumably because the child has exited)
-proc delete_at_eof {f dir} {
-    while {[gets $f line] >= 0} {}
-    if {[eof $f]} {
-	if {[catch {close $f} err]} {
-	    error_popup "[mc "External diff viewer failed:"] $err"
-	}
-	file delete -force $dir
-	return 0
-    }
-    return 1
-}
-
 # Functions for adding and removing shell-type quoting
 
 proc shellquote {str} {
@@ -10446,7 +10397,7 @@ proc doprefs {} {
     global maxwidth maxgraphpct
     global oldprefs prefstop showneartags showlocalchanges
     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
-    global tabstop limitdiffs autoselect extdifftool perfile_attrs
+    global tabstop limitdiffs autoselect perfile_attrs
     global hideremotes
 
     set top .gitkprefs
@@ -10498,15 +10449,6 @@ proc doprefs {} {
 	-font optionfont -variable perfile_attrs
     grid x $top.lattr -sticky w
 
-    entry $top.extdifft -textvariable extdifftool
-    frame $top.extdifff
-    label $top.extdifff.l -text [mc "External diff tool" ] -font optionfont \
-	-padx 10
-    button $top.extdifff.b -text [mc "Choose..."] -font optionfont \
-	-command choose_extdiff
-    pack $top.extdifff.l $top.extdifff.b -side left
-    grid x $top.extdifff $top.extdifft -sticky w
-
     label $top.cdisp -text [mc "Colors: press to choose"]
     grid $top.cdisp - -sticky w -pady 10
     label $top.ui -padx 40 -relief sunk -background $uicolor
@@ -10566,15 +10508,6 @@ proc doprefs {} {
     bind $top <Visibility> "focus $top.buts.ok"
 }
 
-proc choose_extdiff {} {
-    global extdifftool
-
-    set prog [tk_getOpenFile -title [mc "External diff tool"] -multiple false]
-    if {$prog ne {}} {
-	set extdifftool $prog
-    }
-}
-
 proc choosecolor {v vi w x cmd} {
     global $v
 
@@ -11100,12 +11033,6 @@ set datetimeformat "%Y-%m-%d %H:%M:%S"
 set autoselect 1
 set perfile_attrs 0
 
-if {[tk windowingsystem] eq "aqua"} {
-    set extdifftool "opendiff"
-} else {
-    set extdifftool "meld"
-}
-
 set colors {green red blue magenta darkgrey brown orange}
 set uicolor grey85
 set bgcolor white
-- 
1.6.5.2.180.gc5b3e
