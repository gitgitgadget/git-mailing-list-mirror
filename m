From: Leon KUKOVEC <leon.kukovec@gmail.com>
Subject: [PATCH] gitk tag delete/rename support
Date: Sun, 25 Nov 2012 20:05:45 +0100
Message-ID: <1353870345-3054-1-git-send-email-leon.kukovec@gmail.com>
References: <CAOrOd9woDs16as+t-EReQ8NtXfYm9mpd0XaFFs-XL=pg+JK1Lw@mail.gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Leon KUKOVEC <leon.kukovec@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 20:06:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TchXW-0002oU-QL
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 20:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab2KYTGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 14:06:35 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50667 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab2KYTGe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 14:06:34 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4515394pad.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 11:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jfH8PGV7j3YOgTTGOqjIGwgYitydoL0X348Y/XvS+GU=;
        b=lGqaq8jnITLZfEGbOOSGbQxJWSmIi6jVIBKAUg5uagx2wyMZSMDirpVy+c+/LW4lK3
         BuJ1uAtBL68Jw4G6wPcDTMdbXFCgNTsUnLW08uvj9TSDFSHdRUZST1VECQlC6tu3WXmG
         Lb1pAVk4/7OHyX0m7OD/5v8S+ge8T4TlwklNpN+0AcV3CpvLOtntT1OZmryPDpsWvEhp
         tej8VQdHw/bLPmH6rF62zh5aPxpkCOLtqgyj8vuWi8H9w94Cxwp/9dkCORjP4fuemgkS
         qW1FTKDilVQr3DdJ6W04UgR2/rRTPR8/D84kkgvacSWPQ58eSCkWxdqtHM5C6/p7c64V
         33ag==
Received: by 10.68.138.229 with SMTP id qt5mr30698734pbb.122.1353870393954;
        Sun, 25 Nov 2012 11:06:33 -0800 (PST)
Received: from localhost.localdomain ([12.3.154.2])
        by mx.google.com with ESMTPS id sg7sm7393585pbb.50.2012.11.25.11.06.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 11:06:33 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CAOrOd9woDs16as+t-EReQ8NtXfYm9mpd0XaFFs-XL=pg+JK1Lw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210380>

Right clicking on a tag pops up a menu, which allows
tag to be renamed or deleted.

Signed-off-by: Leon KUKOVEC <leon.kukovec@gmail.com>
---
 gitk-git/gitk |  154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d93bd99..38cc233 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2032,6 +2032,7 @@ proc makewindow {} {
     global have_tk85 use_ttk NS
     global git_version
     global worddiff
+    global tagctxmenu
 
     # The "mc" arguments here are purely so that xgettext
     # sees the following string as needing to be translated
@@ -2581,6 +2582,13 @@ proc makewindow {} {
 	{mc "Run git gui blame on this line" command {external_blame_diff}}
     }
     $diff_menu configure -tearoff 0
+
+    set tagctxmenu .tagctxmenu
+    makemenu $tagctxmenu {
+	{mc "Rename this tag" command mvtag}
+	{mc "Delete this tag" command rmtag}
+    }
+    $tagctxmenu configure -tearoff 0
 }
 
 # Windows sends all mouse wheel events to the current focused window, not
@@ -6400,6 +6408,7 @@ proc drawtags {id x xt y1} {
 		   -font $font -tags [list tag.$id text]]
 	if {$ntags >= 0} {
 	    $canv bind $t <1> [list showtag $tag_quoted 1]
+	    $canv bind $t $ctxbut [list showtagmenu %X %Y $id $tag_quoted]
 	} elseif {$nheads >= 0} {
 	    $canv bind $t $ctxbut [list headmenu %X %Y $id $tag_quoted]
 	}
@@ -8931,6 +8940,113 @@ proc domktag {} {
     return 1
 }
 
+proc mvtag {} {
+    global mvtagtop
+    global tagmenuid tagmenutag tagctxmenu maintag NS
+    global mvtagtag
+
+    set mvtagtag $tagmenutag
+    set top .movetag
+    set mvtagtop $top
+    catch {destroy $top}
+    ttk_toplevel $top
+    make_transient $top .
+
+    ${NS}::label $top.msg -text [mc "Enter a new tag name:"]
+    ${NS}::entry $top.tag -width 60 -textvariable mvtagtag
+
+    grid $top.msg -sticky w -row 0 -column 0
+    grid $top.tag -sticky w -row 0 -column 1
+
+    ${NS}::frame $top.buts
+    ${NS}::button $top.buts.gen -text [mc "Rename"] -command mvtaggo
+    ${NS}::button $top.buts.can -text [mc "Cancel"] -command mvtagcan
+    bind $top <Key-Return> mvtaggo
+    bind $top <Key-Escape> mvtagcan
+    grid $top.buts.gen $top.buts.can
+    grid columnconfigure $top.buts 0 -weight 1 -uniform a
+    grid columnconfigure $top.buts 1 -weight 1 -uniform a
+    grid $top.buts - -pady 10 -sticky ew
+}
+
+proc domvtag {} {
+    global mvtagtop env tagids idtags tagmenutag tagmenuid mvtagtag
+
+    set tag $mvtagtag
+    set id $tagmenuid
+
+    # add tag
+    # XXX: reuse domktag including keeping comment from the original tag.
+    if {[catch {
+        exec git tag $tag $id
+    } err]} {
+        error_popup "[mc "Error renaming tag:"] $err" $mvtagtop
+        return 0
+    }
+
+    # delete old tag, content stored in $tagmenutag and $tagmenuid
+    dormtag
+
+    set tagids($tag) $id
+    lappend idtags($id) $tag
+    redrawtags $id
+    addedtag $id
+    dispneartags 0
+    run refill_reflist
+    return 1
+}
+
+proc rmtag {} {
+    global rmtagtop
+    global tagmenuid tagmenutag tagctxmenu maintag NS
+
+    set top .maketag
+    set rmtagtop $top
+    catch {destroy $top}
+    ttk_toplevel $top
+    make_transient $top .
+    ${NS}::label $top.title -text [mc "Delete tag"]
+    grid $top.title - -pady 10
+
+    ${NS}::label $top.msg -text [mc "You are about to delete a tag"]
+    ${NS}::label $top.tagname -foreground Red -text [mc "$tagmenutag"]
+    grid $top.msg -sticky w -row 0 -column 0
+    grid $top.tagname -sticky w -row 0 -column 1
+
+    ${NS}::frame $top.buts
+    ${NS}::button $top.buts.gen -text [mc "Delete"] -command rmtaggo
+    ${NS}::button $top.buts.can -text [mc "Cancel"] -command rmtagcan
+    bind $top <Key-Return> rmtaggo
+    bind $top <Key-Escape> rmtagcan
+    grid $top.buts.gen $top.buts.can
+    grid columnconfigure $top.buts 0 -weight 1 -uniform a
+    grid columnconfigure $top.buts 1 -weight 1 -uniform a
+    grid $top.buts - -pady 10 -sticky ew
+}
+
+proc dormtag {} {
+    global rmtagtop env tagids idtags tagmenutag tagmenuid
+
+    set tag $tagmenutag
+    set id $tagmenuid
+
+    if {[catch {
+        exec git tag -d $tag
+    } err]} {
+        error_popup "[mc "Error deleting tag:"] $err" $rmtagtop
+        return 0
+    }
+
+    unset tagids($tag)
+    set idx [lsearch $idtags($id) $tag]
+    set idtags($id) [lreplace $idtags($id) $idx $idx]
+
+    redrawtags $id
+    dispneartags 0
+    run refill_reflist
+    return 1
+}
+
 proc redrawtags {id} {
     global canv linehtag idpos currentid curview cmitlisted markedid
     global canvxmax iddrawn circleitem mainheadid circlecolors
@@ -8974,6 +9090,30 @@ proc mktaggo {} {
     mktagcan
 }
 
+proc rmtagcan {} {
+    global rmtagtop
+
+    catch {destroy $rmtagtop}
+    unset rmtagtop
+}
+
+proc rmtaggo {} {
+    if {![dormtag]} return
+    rmtagcan
+}
+
+proc mvtagcan {} {
+    global mvtagtop
+
+    catch {destroy $mvtagtop}
+    unset mvtagtop
+}
+
+proc mvtaggo {} {
+    if {![domvtag]} return
+    mvtagcan
+}
+
 proc writecommit {} {
     global rowmenuid wrcomtop commitinfo wrcomcmd NS
 
@@ -9288,6 +9428,20 @@ proc headmenu {x y id head} {
     tk_popup $headctxmenu $x $y
 }
 
+# context menu for a tag
+proc showtagmenu {x y id tag} {
+    global tagmenuid tagmenutag tagctxmenu maintag
+
+    stopfinding
+    set tagmenuid $id
+    set tagmenutag $tag
+    set state normal
+
+    $tagctxmenu entryconfigure 0 -state normal
+    $tagctxmenu entryconfigure 1 -state normal
+    tk_popup $tagctxmenu $x $y
+}
+
 proc cobranch {} {
     global headmenuid headmenuhead headids
     global showlocalchanges
-- 
1.7.9.5
