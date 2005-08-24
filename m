From: Ingo Bormuth <ibormuth@efil.de>
Subject: [PATCH] Gitk tree view (correction)
Date: Thu, 25 Aug 2005 00:35:50 +0200
Message-ID: <20050824223550.GA23693@kruemel>
References: <20050823042432.GA21140@kruemel>
Reply-To: Ingo Bormuth <ibormuth@efil.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
X-From: git-owner@vger.kernel.org Thu Aug 25 00:39:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E83t3-0007v0-R8
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 00:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVHXWhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 18:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVHXWhX
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 18:37:23 -0400
Received: from efil.de ([81.3.25.37]:34067 "EHLO efil.de") by vger.kernel.org
	with ESMTP id S932333AbVHXWhX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 18:37:23 -0400
Received: by efil.de (Postfix, from userid 1000)
	id B995596DF67; Thu, 25 Aug 2005 00:37:41 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050823042432.GA21140@kruemel>
X-Attribution: Ingo Bormuth
X-Url: http://ibormuth.efil.de/contact
User-Agent: Mutt/1.5.8i
Cc: ingo@bormuth.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7734>


I'm sorry for sending a non-working patch. Apparently I got lost in /tmp.

So here is the patch for gitk that allows you to browse the entire tree for
every revision.

The patched gitk script and some screenshots can be found at:

    http://public.efil.de/gitk/

For my personal use it's rather sufficient.
If anybody is interested in using it, I would clean it up.

   - Ingo







Add tree view.

   This allows you to browse the entire tree for every revision.
   You may switch back an forward betweem the two modes at any time.

   Keybindings:  v - toggle view mode (tree/commit)
                 l - toggle line numbers

---
commit dbbfcc0cabb8eaaff998dc95957d73867f0e2f35
tree 53d7597f0f42ca1c3f7f01c7ca60d14541077a89
parent ccf1ee327f9a7d51704578fa41ba255abfd3a730
author <ingo@kruemel.(none)> Thu, 25 Aug 2005 00:13:22 +0200
committer <ingo@kruemel.(none)> Thu, 25 Aug 2005 00:13:22 +0200

 gitk |  192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 187 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -329,12 +329,13 @@ proc makewindow {} {
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
     global maincursor textcursor curtextcursor
-    global rowctxmenu gaudydiff mergemax
+    global rowctxmenu gaudydiff mergemax viewmodebutton
 
     menu .bar
     .bar add cascade -label "File" -menu .bar.file
     menu .bar.file
     .bar.file add command -label "Reread references" -command rereadrefs
+    .bar.file add command -label "Toggle line numbers" -command togglelinenum
     .bar.file add command -label "Quit" -command doquit
     menu .bar.help
     .bar add cascade -label "Help" -menu .bar.help
@@ -381,6 +382,9 @@ proc makewindow {} {
     .ctop.top.clist add $canv3
     bind .ctop.top.clist <Configure> {resizeclistpanes %W %w}
 
+    set viewmodebutton Tree
+    button .ctop.top.bar.viewmodebutton -textvariable viewmodebutton -command toggleviewmode
+    pack .ctop.top.bar.viewmodebutton -side left
     set sha1entry .ctop.top.bar.sha1
     set entries $sha1entry
     set sha1but .ctop.top.bar.sha1label
@@ -493,9 +497,11 @@ proc makewindow {} {
     bindkey <Key-space> "$ctext yview scroll 1 pages"
     bindkey p "selnextline -1"
     bindkey n "selnextline 1"
+    bindkey l "togglelinenum"
     bindkey b "$ctext yview scroll -1 pages"
     bindkey d "$ctext yview scroll 18 units"
     bindkey u "$ctext yview scroll -18 units"
+    bindkey v "toggleviewmode"
     bindkey / {findnext 1}
     bindkey <Key-Return> {findnext 0}
     bindkey ? findprev
@@ -2815,10 +2821,178 @@ proc gettreediffline {gdtf ids} {
     lappend treediff $file
 }
 
+proc toggleviewmode {} {
+    global treemode viewmodebutton selectedline cflist viewpath ctext
+    if { $treemode } {
+        set viewmodebutton Tree
+        set treemode false
+    } else { 
+        set viewmodebutton Commit
+        set treemode true
+    }
+    # redraw
+    if {![info exists selectedline]} return
+    set l [expr $selectedline]
+    selectline $l 1
+    # select current file 
+    if {! $treemode } {
+        set commitfiles [ $cflist get 0 end ] 
+        set index [ lsearch $commitfiles $viewpath ]
+        if { $index > 0 } {
+            catch { after 500 $ctext yview fmark.$index }
+        }
+    }
+}
+
+proc togglelinenum {} {
+    global showlinenum selectedline
+    if { $showlinenum } { set showlinenum false } else { set showlinenum true }
+    if {![info exists selectedline]} return
+    set l [expr $selectedline]
+    selectline $l 1
+}
+
+proc viewfull { path } {
+    global ctext currentid viewpath
+    $ctext conf -state normal
+    $ctext delete 0.0 end
+
+    if { $path != "" } { set viewpath $path }
+    if { $viewpath == "Comments" ||  $viewpath == "/" || $viewpath == "" } {
+        set path ""
+        set viewpath "/"
+        set kind root
+        set sha $currentid
+    } else {
+        if [catch {set stream [open "|git-ls-tree $currentid $viewpath" r]}] {
+            $ctext insert end "ERROR: viewfull: git-ls-tree $currentid $viewpath"
+            return
+        }
+        gets $stream line
+        fconfigure $stream -blocking 0
+        close $stream
+        if { $line == "" } {
+            set kind "NOT FOUND !!!"
+        } else {
+            set kind [lindex $line 1]
+        }
+        set sha  [lindex $line 2]
+    }
+   
+    viewheader $viewpath $kind
+    
+    if { $kind == "blob"} {
+      viewblob $sha
+    } elseif { $kind == "tree" || $kind == "root"} {
+      viewtree $sha
+    }
+}
+
+proc viewheader { path kind } {
+    global ctext
+    $ctext insert end "type: $kind\n"
+    $ctext insert end "path: "
+    
+    set splitpath [ linsert [ split [ string trim $path "/" ] "/" ] 0 "ROOT" ]
+    set name [ lindex $splitpath end ]
+    set splitpath [ lrange $splitpath 0 end-1 ]
+    set buildpath "/"
+    foreach next $splitpath {
+        if { $next != "ROOT" } { 
+            append buildpath "$next/"
+        }
+        viewprintlink "$next" $buildpath
+        $ctext insert end " / "
+    }
+    $ctext insert end "$name \n"
+    set l [expr {(78 - [string length $name]) / 2}]
+    set pad [string range "----------------------------------------" 1 $l]
+    $ctext insert end "$pad $name $pad\n" filesep
+}
+
+proc viewprintlink { name path } {
+    global ctext
+    set linkbeg [$ctext index "end - 1c"]
+    $ctext insert end "$name"
+    set linkend [$ctext index "end - 1c"]
+    $ctext tag add  linkfile$name "$linkbeg + 0 c" "$linkend + 0 c"
+    $ctext tag conf linkfile$name -foreground blue -underline 1
+    $ctext tag bind linkfile$name <Enter> { %W configure -cursor hand2 }
+    $ctext tag bind linkfile$name <Leave> { %W configure -cursor $curtextcursor }
+    $ctext tag bind linkfile$name <1> [ list viewfull "$path" ]
+}
+
+
+proc viewblob {sha} {
+    global ctext linenum
+    set linenum 0
+    if [catch {set stream [open "|git-cat-file blob $sha" r]}] {
+        $ctext insert end "ERROR: viewblob"
+        return
+    }
+    fconfigure $stream -blocking 0
+    fileevent $stream readable [list getviewblobline $stream $sha]
+}
+
+proc getviewblobline {stream sha} {
+    global ctext linenum showlinenum
+    set n [gets $stream line]
+    if {$n < 0} {
+	if {![eof $stream]} return
+	close $stream
+        return
+    }
+    incr linenum
+    set num [format "%5s" "$linenum"]
+    if { $showlinenum } { $ctext insert end "$num " hunksep }
+    $ctext insert end "$line\n"
+}
+
+proc viewtree {sha} {
+    global ctext lstree
+    set lstree ""
+    $ctext insert end "\n\n"
+    if [catch {set stream [open "|git-ls-tree $sha" r]}] {
+        $ctext insert end "ERROR viewtree"
+        return
+    }
+    fconfigure $stream -blocking 0
+    fileevent $stream readable [list getviewtreeline $stream]
+}
+
+proc getviewtreeline {stream} {
+    global ctext viewpath lstree
+    set n [gets $stream line]
+    if {$n < 0} {
+	if {![eof $stream]} return
+	close $stream
+        printviewtreefilter "tree"
+        $ctext insert end "\n"
+        printviewtreefilter "blob"
+        return
+    }
+    lappend lstree $line
+}
+    
+proc printviewtreefilter {filter} {
+    global ctext lstree viewpath
+    foreach line $lstree  {
+        set kind [ lindex $line 1 ]
+        if { $kind != $filter} continue
+        $ctext insert end "    $kind  "
+        set name [ lindex $line 3 ]
+        viewprintlink $name "$viewpath/$name"
+        $ctext insert end "\n"
+    }
+}
+
 proc getblobdiffs {ids} {
     global diffopts blobdifffd diffids env curdifftag curtagstart
-    global difffilestart nextupdate diffinhdr treediffs
-
+    global difffilestart nextupdate diffinhdr treediffs treemode
+    if { $treemode } { 
+      viewfull "" 
+      return 
+    }
     set id [lindex $ids 0]
     set p [lindex $ids 1]
     set env(GIT_DIFF_OPTS) $diffopts
@@ -2951,12 +3125,17 @@ proc nextfile {} {
 }
 
 proc listboxsel {} {
-    global ctext cflist currentid
+    global ctext cflist currentid treemode viewpath
     if {![info exists currentid]} return
     set sel [lsort [$cflist curselection]]
     if {$sel eq {}} return
     set first [lindex $sel 0]
-    catch {$ctext yview fmark.$first}
+    set viewpath [ $cflist get $first ]
+    if { $treemode } {
+      viewfull [$cflist get $first]
+    } else {
+        catch {$ctext yview fmark.$first}
+    }
 }
 
 proc setcoords {} {
@@ -3576,6 +3755,9 @@ set stopped 0
 set redisplaying 0
 set stuffsaved 0
 set patchnum 0
+set treemode false
+set viewpath ""
+set showlinenum true
 setcoords
 makewindow
 readrefs




-- 
   +--------------------------------------------------------+
   | Ingo Bormuth,  voicebox & telefax: +49-12125-10226517  |
   | GnuPG key 86326EC9 at http://ibormuth.efil.de/contact  |
   +--------------------------------------------------------+
