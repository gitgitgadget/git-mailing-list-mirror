From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] gitk: Add "Refs" menu - revised
Date: Thu, 06 Oct 2005 00:11:23 -0400
Message-ID: <1128571883.32103.48.camel@dv>
References: <1128559088.32103.8.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 06:12:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENN76-0006VH-0O
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 06:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVJFEL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 00:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVJFEL1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 00:11:27 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:45029 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751211AbVJFEL1
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 00:11:27 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1ENN6K-0007Ny-Gy
	for git@vger.kernel.org; Thu, 06 Oct 2005 00:11:24 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1ENN6J-0007ts-AU; Thu, 06 Oct 2005 00:11:23 -0400
To: git <git@vger.kernel.org>
In-Reply-To: <1128559088.32103.8.camel@dv>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9758>

Hello!

This is an updated revision of the original patch.  Unneeded concat has
been removed.  Error message uses name, not SHA1 ID.  If there is
information for the tag, it's displayed even in the ID is not in the
list.  Thanks to Brett Schwarz for help.

---------------------------------

This patch adds "Refs" menu to gitk.  It makes all branches, tags and
other ref objects appear as menu items.  Selecting one of the items
selects the corresponding line in the view.

It's only possible to go to the refs present in the current view.
However, information for tags is shown even if the corresponding ID is
not available.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff -u b/gitk b/gitk
--- b/gitk
+++ b/gitk
@@ -285,6 +285,7 @@
 	}
     }
     readotherrefs refs {} {tags heads}
+    setrefsmenu
 }
 
 proc readotherrefs {base dname excl} {
@@ -538,6 +539,65 @@
     $rowctxmenu add command -label "Write commit to file" -command writecommit
 }
 
+proc gotocommit_menu {sha1 name} {
+    global idline tagids tagcontents
+
+    if {[info exists idline($sha1)]} {
+	selectline $idline($sha1) 1
+    } else {
+	# Should we re-run git-rev-list?
+	error_popup "$name is not in the current view"
+    }
+
+    if {[info exists tagcontents($name)]} {
+	showtag $name 1
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
+    set refids [lsort -unique [array names headids]]
+    if {[llength $refids] > 0} {
+	.bar.refs add cascade -label "Branches" -menu .bar.refs.heads
+	menu .bar.refs.heads
+	foreach v $refids {
+	    .bar.refs.heads add command -label $v \
+		-command [list gotocommit_menu $headids($v) $v]
+	}
+    }
+
+    set refids [lsort -unique [array names tagids]]
+    if {[llength $refids] > 0} {
+	.bar.refs add cascade -label "Tags" -menu .bar.refs.tags
+	menu .bar.refs.tags
+	foreach v $refids {
+	    .bar.refs.tags add command -label $v \
+		-command [list gotocommit_menu $tagids($v) $v]
+	}
+    }
+
+    set refids [lsort -unique [array names otherrefids]]
+    if {[llength $refids] > 0} {
+	.bar.refs add cascade -label "Other" -menu .bar.refs.other
+	menu .bar.refs.other
+	foreach v $refids {
+	    .bar.refs.other add command -label $v \
+		-command [list gotocommit_menu $otherrefids($v) $v]
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
