From: Teun Grinwis <teun@adesys.nl>
Subject: gitk show branch in commit overview
Date: Tue, 22 Jan 2013 14:45:54 +0100
Message-ID: <50FE9812.2020405@adesys.nl>
References: <50FE70F0.8020600@adesys.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060602010101010109050308"
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 14:51:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxeFg-0007kP-1u
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 14:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab3AVNuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 08:50:37 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:4131 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab3AVNug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 08:50:36 -0500
Received: from adesys.nl (a83-163-225-34.adsl.xs4all.nl [83.163.225.34])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id r0MDoEQX063200;
	Tue, 22 Jan 2013 14:50:15 +0100 (CET)
	(envelope-from teun@adesys.nl)
Received: from [192.168.10.119] (teuns-pc.ads.local [192.168.10.119])
	by adesys.nl (Postfix) with ESMTP id F4038314005;
	Tue, 22 Jan 2013 14:50:13 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <50FE70F0.8020600@adesys.nl>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214234>

This is a multi-part message in MIME format.
--------------060602010101010109050308
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


> Hello,
> We recently changed from using CVS to GIT, previous company I worked 
> we used clearcase.
>
> We do feature development / bug fixing (complex) on branches, trivial 
> changes commit direct on Develop branch.
>
> What I am missing in all the gui tools is the relation on what 
> specific branch did one do a commit.
>
> I searched on the internet and read that  there is need to see on 
> which branch a specific commit is done.
>
> From the link below,
> https://github.com/pajp/git/compare/master...x-working-branch
> I tried this version, but could not see the branches when I started 
> gitk in a git repository,
> so I looked into his changes, and adapted his code with use of the git 
> commands
> git show-branch --all and git show-branch --all --sha1name.
> And see the result below:
>


-- 
Met vriendelijke groeten / With kind regards,

Teun Grinwis
Software engineer

Adesys B.V.
Molenweer 4, 2291 NR, Wateringen, NL.
P.O. Box 60, 2290 AB, Wateringen, NL.

Tfn         : +31 174 296389
Fax         : +31 174 293807
e-mail      : teun@adesys.nl
internet    : www.adesys.nl


--------------060602010101010109050308
Content-Type: text/plain; charset=windows-1252;
 name="0001-show-branch-canvas-in-commit-overview.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-show-branch-canvas-in-commit-overview.patch"

>From 15427e2dc35c58ab2ad7e9466aa280f5c70e9eda Mon Sep 17 00:00:00 2001
From: Teun Grinwis <teun@adesys.nl>
Date: Tue, 22 Jan 2013 11:43:39 +0100
Subject: [PATCH] show branch canvas in commit overview

---
 gitk | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 12 deletions(-)

diff --git a/gitk b/gitk
index b3706fc..cdde3b2 100755
--- a/gitk
+++ b/gitk
@@ -496,7 +496,9 @@ proc updatecommits {} {
     global hasworktree
     global varcid vposids vnegids vflags vrevs
     global show_notes
+    global workbranches_set
 
+    set workbranches_set false
     set hasworktree [hasworktree]
     rereadrefs
     set view $curview
@@ -577,7 +579,9 @@ proc reloadcommits {} {
     global curview viewcomplete selectedline currentid thickerline
     global showneartags treediffs commitinterest cached_commitrow
     global targetid
+    global workbranches_set
 
+    set workbranches_set false
     set selid {}
     if {$selectedline ne {}} {
 	set selid $currentid
@@ -1652,6 +1656,50 @@ proc readcommit {id} {
     parsecommit $id $contents 1
 }
 
+set workbranches_set false
+
+proc set_workbranches { } {
+    global workbranches
+
+    catch {set allbranches [exec git show-branch --all]}
+    catch {set allsha1names [exec git show-branch --all --sha1-name]}
+
+    set allbranches [split $allbranches \n\n]
+    set allsha1names [split $allsha1names \n\n]
+
+    foreach br $allbranches sha1 $allsha1names {
+
+        set branch [lindex [split $br "\["] 1 ]
+        set branch [lindex [split $branch "]"] 0 ]
+        set branch [lindex [split $branch "~"] 0 ]
+        set branch [lindex [split $branch "^"] 0 ]
+
+        set sha1Id [lindex [split $sha1 "\["] 1 ]
+        set sha1Id [lindex [split $sha1Id "]"] 0 ]
+        set workbranches($sha1Id) $branch
+    }
+}
+
+proc get_workbranch { shaid } {
+
+    global workbranches workbranches_set
+    set workbranch ""
+
+#   use 1st 7 digits of shaid
+    set shaid [string range $shaid 0 6]
+
+    if { $workbranches_set == false } {
+        set_workbranches
+        set workbranches_set true
+    }
+
+    if { [ info exist workbranches($shaid) ] } {
+        return $workbranches($shaid)
+    } else {
+        return "unknown"
+    }
+}
+
 proc parsecommit {id contents listed} {
     global commitinfo
 
@@ -1662,6 +1710,7 @@ proc parsecommit {id contents listed} {
     set audate {}
     set comname {}
     set comdate {}
+    set workbranch {}
     set hdrend [string first "\n\n" $contents]
     if {$hdrend < 0} {
 	# should never happen...
@@ -1703,9 +1752,11 @@ proc parsecommit {id contents listed} {
 	}
 	set comment $newcomment
     }
+    set workbranch [get_workbranch $id]
     set hasnote [string first "\nNotes:\n" $contents]
     set commitinfo($id) [list $headline $auname $audate \
-			     $comname $comdate $comment $hasnote]
+                 $comname $comdate $comment $hasnote $workbranch]
+
 }
 
 proc getcommit {id} {
@@ -2015,7 +2066,7 @@ proc makedroplist {w varname args} {
 }
 
 proc makewindow {} {
-    global canv canv2 canv3 linespc charspc ctext cflist cscroll
+    global canv canv2 canv3 canv4 linespc charspc ctext cflist cscroll
     global tabstop
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
@@ -2109,7 +2160,7 @@ proc makewindow {} {
 	.tf.histframe.pwclist configure -sashpad 0 -handlesize 4
     }
 
-    # create three canvases
+    # create four canvases
     set cscroll .tf.histframe.csb
     set canv .tf.histframe.pwclist.canv
     canvas $canv \
@@ -2127,6 +2178,11 @@ proc makewindow {} {
 	-selectbackground $selectbgcolor \
 	-background $bgcolor -bd 0 -yscrollincr $linespc
     .tf.histframe.pwclist add $canv3
+    set canv4 .tf.histframe.pwclist.canv4
+    canvas $canv4 \
+    -selectbackground $selectbgcolor \
+    -background $bgcolor -bd 0 -yscrollincr $linespc
+    .tf.histframe.pwclist add $canv4
     if {$use_ttk} {
 	bind .tf.histframe.pwclist <Map> {
 	    bind %W <Map> {}
@@ -2602,11 +2658,11 @@ proc makewindow {} {
 # the one where the mouse hovers, so bind those events here and redirect
 # to the correct window
 proc windows_mousewheel_redirector {W X Y D} {
-    global canv canv2 canv3
+    global canv canv2 canv3 canv4
     set w [winfo containing -displayof $W $X $Y]
     if {$w ne ""} {
 	set u [expr {$D < 0 ? 5 : -5}]
-	if {$w == $canv || $w == $canv2 || $w == $canv3} {
+    if {$w == $canv || $w == $canv2 || $w == $canv3 || $w == $canv4} {
 	    allcanvs yview scroll $u units
 	} else {
 	    catch {
@@ -2715,7 +2771,7 @@ proc doprogupdate {} {
 }
 
 proc savestuff {w} {
-    global canv canv2 canv3 mainfont textfont uifont tabstop
+    global canv canv2 canv3 canv4 mainfont textfont uifont tabstop
     global stuffsaved findmergefiles maxgraphpct
     global maxwidth showneartags showlocalchanges
     global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
@@ -2859,17 +2915,19 @@ proc resizecdetpanes {win w} {
 }
 
 proc allcanvs args {
-    global canv canv2 canv3
+    global canv canv2 canv3 canv4
     eval $canv $args
     eval $canv2 $args
     eval $canv3 $args
+    eval $canv4 $args
 }
 
 proc bindall {event action} {
-    global canv canv2 canv3
+    global canv canv2 canv3 canv4
     bind $canv $event $action
     bind $canv2 $event $action
     bind $canv3 $event $action
+    bind $canv4 $event $action
 }
 
 proc about {} {
@@ -4997,13 +5055,14 @@ proc initlayout {} {
 }
 
 proc setcanvscroll {} {
-    global canv canv2 canv3 numcommits linespc canvxmax canvy0
+    global canv canv2 canv3 canv4 numcommits linespc canvxmax canvy0
     global lastscrollset lastscrollrows
 
     set ymax [expr {$canvy0 + ($numcommits - 0.5) * $linespc + 2}]
     $canv conf -scrollregion [list 0 0 $canvxmax $ymax]
     $canv2 conf -scrollregion [list 0 0 0 $ymax]
     $canv3 conf -scrollregion [list 0 0 0 $ymax]
+    $canv4 conf -scrollregion [list 0 0 0 $ymax]
     set lastscrollset [clock clicks -milliseconds]
     set lastscrollrows $numcommits
 }
@@ -5919,7 +5978,7 @@ proc drawlines {id} {
 }
 
 proc drawcmittext {id row col} {
-    global linespc canv canv2 canv3 fgcolor curview
+    global linespc canv canv2 canv3 canv4 fgcolor curview
     global cmitlisted commitinfo rowidlist parentlist
     global rowtextx idpos idtags idheads idotherrefs
     global linehtag linentag linedtag selectedline
@@ -5986,6 +6045,7 @@ proc drawcmittext {id row col} {
     set headline [lindex $commitinfo($id) 0]
     set name [lindex $commitinfo($id) 1]
     set date [lindex $commitinfo($id) 2]
+    set workbranch [lindex $commitinfo($id) 7]
     set date [formatdate $date]
     set font mainfont
     set nfont mainfont
@@ -6001,9 +6061,12 @@ proc drawcmittext {id row col} {
     set linehtag($id) [$canv create text $xt $y -anchor w -fill $fgcolor \
 			   -text $headline -font $font -tags text]
     $canv bind $linehtag($id) $ctxbut "rowmenu %X %Y $id"
+# set workbranch before the name
     set linentag($id) [$canv2 create text 3 $y -anchor w -fill $fgcolor \
-			   -text $name -font $nfont -tags text]
+               -text $workbranch -font $nfont -tags text]
     set linedtag($id) [$canv3 create text 3 $y -anchor w -fill $fgcolor \
+               -text $name -font mainfont -tags text]
+    set linedtag($id) [$canv4 create text 3 $y -anchor w -fill $fgcolor \
 			   -text $date -font mainfont -tags text]
     if {$selectedline == $row} {
 	make_secsel $id
@@ -6993,7 +7056,7 @@ proc dispnexttag {} {
 }
 
 proc make_secsel {id} {
-    global linehtag linentag linedtag canv canv2 canv3
+    global linehtag linentag linedtag canv canv2 canv3 canv4
 
     if {![info exists linehtag($id)]} return
     $canv delete secsel
@@ -7008,6 +7071,10 @@ proc make_secsel {id} {
     set t [eval $canv3 create rect [$canv3 bbox $linedtag($id)] -outline {{}} \
 	       -tags secsel -fill [$canv3 cget -selectbackground]]
     $canv3 lower $t
+    $canv4 delete secsel
+    set t [eval $canv4 create rect [$canv4 bbox $linedtag($id)] -outline {{}} \
+            -tags secsel -fill [$canv4 cget -selectbackground]]
+    $canv4 lower $t
 }
 
 proc make_idmark {id} {
-- 
1.7.11.msysgit.1


--------------060602010101010109050308--
