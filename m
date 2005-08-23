From: Ingo Bormuth <ibormuth@efil.de>
Subject: gitk tree view
Date: Tue, 23 Aug 2005 06:24:32 +0200
Message-ID: <20050823042432.GA21140@kruemel>
Reply-To: Ingo Bormuth <ibormuth@efil.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Cc: paulus@samba.org
X-From: git-owner@vger.kernel.org Tue Aug 23 14:28:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7Xqc-0002Ai-39
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 14:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVHWMZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 08:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVHWMZ1
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 08:25:27 -0400
Received: from efil.de ([81.3.25.37]:48905 "EHLO efil.de") by vger.kernel.org
	with ESMTP id S932137AbVHWMZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 08:25:26 -0400
Received: by efil.de (Postfix, from userid 1000)
	id 89EE896B70C; Tue, 23 Aug 2005 14:25:41 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
X-Attribution: Ingo Bormuth
X-Url: http://ibormuth.efil.de/contact
User-Agent: Mutt/1.5.8i
Cc: ingo@bormuth.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi.

This is a quick hack which allows you to browser the entire tree using gitk.

Keybindings:  n - toggle line numbers
              v - toggle tree view

I know, it should be cleaned up. It needs some locking.=20
Colored diffs in the tree would be nice.

Is anybody interested in a propper version ???

Cheers Ingo


--=20
   +--------------------------------------------------------+
   | Ingo Bormuth,  voicebox & telefax: +49-12125-10226517  |
   | GnuPG key 86326EC9 at http://ibormuth.efil.de/contact  |
   +--------------------------------------------------------+





Added tree view.
This is a rather quick hack.

---
commit 4f697f79d6e82d0d0269eeda5f746174c6ba047e
tree c6f82a184da82ed417f170d1b7e2025a801c879b
parent 792fe559d02e55c12d2d544fd6d6f202cbaab6f4
author <ingo@kruemel.(none)> Tue, 23 Aug 2005 06:08:21 +0200
committer <ingo@kruemel.(none)> Tue, 23 Aug 2005 06:08:21 +0200

 gitk |  189 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 files changed, 183 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -329,12 +329,13 @@ proc makewindow {} {
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
     global maincursor textcursor curtextcursor
-    global rowctxmenu gaudydiff mergemax
+    global rowctxmenu gaudydiff mergemax viewmodebutton
=20
     menu .bar
     .bar add cascade -label "File" -menu .bar.file
     menu .bar.file
     .bar.file add command -label "Reread references" -command rereadrefs
+    .bar.file add command -label "Toggle line numbers" -command toggleline=
num
     .bar.file add command -label "Quit" -command doquit
     menu .bar.help
     .bar add cascade -label "Help" -menu .bar.help
@@ -381,6 +382,9 @@ proc makewindow {} {
     .ctop.top.clist add $canv3
     bind .ctop.top.clist <Configure> {resizeclistpanes %W %w}
=20
+    set viewmodebutton Tree
+    button .ctop.top.bar.viewmodebutton -textvariable viewmodebutton -comm=
and togglesetviewmode
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
@@ -2056,7 +2062,7 @@ proc selectline {l isnew} {
     global lineid linehtag linentag linedtag
     global canvy0 linespc parents nparents children
     global cflist currentid sha1entry
-    global commentend idtags idline linknum
+    global commentend idtags idline linknum viewmodebutton
=20
     $canv delete hover
     if {![info exists lineid($l)] || ![info exists linehtag($l)]} return
@@ -2815,10 +2821,173 @@ proc gettreediffline {gdtf ids} {
     lappend treediff $file
 }
=20
+proc toggleviewmode {} {
+    global viewmodebutton selectedline
+    if { $viewmodebutton =3D=3D "Commit" } {=20
+        set viewmodebutton Tree
+    } else {=20
+        set viewmodebutton Commit
+    }
+    if {![info exists selectedline]} return
+    set l [expr $selectedline]
+    selectline $l 1
+}
+
+proc togglelinenum {} {
+    global showlinenum selectedline
+    if { $showlinenum } { set showlinenum false } else { set showlinenum t=
rue }
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
+    if { $viewpath =3D=3D "Comments" || $path =3D=3D "/" } {
+        set path ""
+        set viewpath ""
+    }
+    if { $path !=3D "" } {
+        set viewpath $path
+    }
+
+    if [catch {set stream [open "|git-ls-tree $currentid $viewpath" r]}] {
+        $ctext insert end "ERROR: viewfull: git-ls-tree $currentid $viewpa=
th"
+        return
+    }
+    gets $stream line
+    close $stream
+   =20
+    set kind [lindex $line 1]
+    set sha  [lindex $line 2]
+
+    if { $viewpath =3D=3D "" } {
+        set kind root
+        set sha $currentid
+    }
+
+    if { $line =3D=3D "" } {
+      set kind "NOT FOUND !!!"
+    }
+   =20
+    viewheader $viewpath $kind
+   =20
+    if { $kind =3D=3D "blob"} {
+      viewblob $sha
+    } elseif { $kind =3D=3D "tree" || $kind =3D=3D "root"} {
+      viewtree $sha
+    }
+}
+
+proc viewheader { path kind } {
+    global ctext
+    $ctext insert end "type: $kind\n"
+    $ctext insert end "path: "
+   =20
+    set splitpath [ linsert [ split [ string trim $path "/" ] "/" ] 0 "ROO=
T" ]
+    set name [ lindex $splitpath end ]
+    set splitpath [ lrange $splitpath 0 end-1 ]
+    set buildpath "/"
+    foreach next $splitpath {
+        if { $next !=3D "ROOT" } {=20
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
+    $ctext tag bind linkfile$name <Leave> { %W configure -cursor $curtextc=
ursor }
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
+   =20
+proc printviewtreefilter {filter} {
+    global ctext lstree viewpath
+    foreach line $lstree  {
+        set kind [ lindex $line 1 ]
+        if { $kind !=3D $filter} continue
+        set name [ lindex $line 3 ]
+        $ctext insert end "    $kind  "
+        viewprintlink $name "$viewpath/$name"
+        $ctext insert end " \n"
+    }
+}
+
 proc getblobdiffs {ids} {
     global diffopts blobdifffd diffids env curdifftag curtagstart
-    global difffilestart nextupdate diffinhdr treediffs
-
+    global difffilestart nextupdate diffinhdr treediffs viewmodebutton
+    # If the button says COMMIT, we are in TREE mode)
+    if { $viewmodebutton =3D=3D "Commit" } {=20
+      viewfull ""=20
+      return=20
+    }
     set id [lindex $ids 0]
     set p [lindex $ids 1]
     set env(GIT_DIFF_OPTS) $diffopts
@@ -2951,12 +3120,18 @@ proc nextfile {} {
 }
=20
 proc listboxsel {} {
-    global ctext cflist currentid
+    global ctext cflist currentid viewmodebutton viewpath
     if {![info exists currentid]} return
     set sel [lsort [$cflist curselection]]
     if {$sel eq {}} return
     set first [lindex $sel 0]
-    catch {$ctext yview fmark.$first}
+    set viewpath [ $cflist get $first ]
+    # If the button says COMMIT, we are in TREE mode
+    if {$viewmodebutton =3D=3D "Commit"} {
+      viewfull [$cflist get $first]
+    } else {
+        catch {$ctext yview fmark.$first}
+    }
 }
=20
 proc setcoords {} {
@@ -3576,6 +3751,8 @@ set stopped 0
 set redisplaying 0
 set stuffsaved 0
 set patchnum 0
+set viewpath ""
+set showlinenum false
 setcoords
 makewindow
 readrefs



--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDCqT/NzWqdIYybskRAtMHAJ4xJTWh5mT9Go09Tiig0/aTwMlkAwCfSQBo
pCKmZJU9lgHKSqXjY3W3j3o=
=zu2h
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
