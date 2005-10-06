From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] gitk: Add "Refs" menu
Date: Wed, 05 Oct 2005 20:38:08 -0400
Message-ID: <1128559088.32103.8.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 06 02:38:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENJmH-0000Yd-Qo
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 02:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVJFAiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 20:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVJFAiT
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 20:38:19 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:23256 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750701AbVJFAiS
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 20:38:18 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1ENJm1-0001u5-AZ
	for git@vger.kernel.org; Wed, 05 Oct 2005 20:38:15 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1ENJlw-0008Mp-7k; Wed, 05 Oct 2005 20:38:08 -0400
To: git <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9753>

Hello, Paul!

This patch adds "Refs" menu to gitk.  It makes all branches, tags and
other ref objects appear as menu items.  Selecting one of the items
selects the corresponding line in the view.

Known limitation: it's only possible to go to the refs present in the
current view.  Otherwise, gitk would have to re-run git-rev-list.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -285,6 +285,7 @@ proc readrefs {} {
 	}
     }
     readotherrefs refs {} {tags heads}
+    setrefsmenu
 }
 
 proc readotherrefs {base dname excl} {
@@ -538,6 +539,62 @@ proc makewindow {} {
     $rowctxmenu add command -label "Write commit to file" -command writecommit
 }
 
+proc gotocommit_menu {sha1} {
+    global idline
+
+    if {[info exists idline($sha1)]} {
+	selectline $idline($sha1) 1
+	return
+    } else {
+	# Should we re-run git-rev-list?
+	error_popup "$sha1 is not in the current view"
+    }
+}
+
+proc setrefsmenu {} {
+    global headids tagids otherrefids
+
+    if {[winfo exists .bar.refs]} {
+	foreach w [winfo children .bar.refs] {
+	    destroy $w
+	}
+	.bar.refs delete 1 3
+    } else {
+	.bar add cascade -label "Refs" -menu .bar.refs
+	menu .bar.refs
+    }
+
+    set refids [lsort -unique [concat [array names headids]]]
+    if {[llength $refids] > 0} {
+	.bar.refs add cascade -label "Branches" -menu .bar.refs.heads
+	menu .bar.refs.heads
+	foreach v $refids {
+	    .bar.refs.heads add command -label $v \
+		-command "gotocommit_menu $headids($v)"
+	}
+    }
+
+    set refids [lsort -unique [concat [array names tagids]]]
+    if {[llength $refids] > 0} {
+	.bar.refs add cascade -label "Tags" -menu .bar.refs.tags
+	menu .bar.refs.tags
+	foreach v $refids {
+	    .bar.refs.tags add command -label $v \
+		-command "gotocommit_menu $tagids($v)"
+	}
+    }
+
+    set refids [lsort -unique [concat [array names otherrefids]]]
+    if {[llength $refids] > 0} {
+	.bar.refs add cascade -label "Other" -menu .bar.refs.other
+	menu .bar.refs.other
+	foreach v $refids {
+	    .bar.refs.other add command -label $v \
+		-command "gotocommit_menu $otherrefids($v)"
+	}
+    }
+}
+
 # when we make a key binding for the toplevel, make sure
 # it doesn't get triggered when that key is pressed in the
 # find string entry widget.


-- 
Regards,
Pavel Roskin
