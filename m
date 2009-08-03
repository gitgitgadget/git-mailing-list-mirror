From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] gitk: new option to hide remote refs
Date: Mon, 3 Aug 2009 23:53:36 +0200
Message-ID: <55b7e43bcd59aa64c70edde83ac87147aa0091bb.1249336225.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thell Fowler <tbfowler4@gmail.com>, <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:54:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY5Tj-0000P3-DS
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 23:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbZHCVxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 17:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754667AbZHCVxv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 17:53:51 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:53482 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181AbZHCVxu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 17:53:50 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 3 Aug
 2009 23:53:48 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 3 Aug
 2009 23:53:48 +0200
X-Mailer: git-send-email 1.6.4.251.g3362f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124725>

In repositories with lots of remotes, looking at the history in gitk
can be borderline insane with all the red labels for remote refs.
Introduce a new option in the preferences that hides them.

Wished-for-by: Thell Fowler <tbfowler4@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I hope the IRC-to-mail matching worked out right.  I needed this too,
for a repo where I deploy for testing directly through git (with
hooks) -- to several machines, resulting in a forest of remote labels.


 gitk |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 4604c83..aabebac 100755
--- a/gitk
+++ b/gitk
@@ -1677,6 +1677,7 @@ proc readrefs {} {
     global tagids idtags headids idheads tagobjid
     global otherrefids idotherrefs mainhead mainheadid
     global selecthead selectheadid
+    global hideremotes
 
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
 	catch {unset $v}
@@ -1689,7 +1690,7 @@ proc readrefs {} {
 	if {![string match "refs/*" $ref]} continue
 	set name [string range $ref 5 end]
 	if {[string match "remotes/*" $name]} {
-	    if {![string match "*/HEAD" $name]} {
+	    if {![string match "*/HEAD" $name] && !$hideremotes} {
 		set headids($name) $id
 		lappend idheads($id) $name
 	    }
@@ -2520,6 +2521,7 @@ proc savestuff {w} {
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
     global autoselect extdifftool perfile_attrs markbgcolor
+    global hideremotes
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
@@ -2539,6 +2541,7 @@ proc savestuff {w} {
 	puts $f [list set wrapcomment $wrapcomment]
 	puts $f [list set autoselect $autoselect]
 	puts $f [list set showneartags $showneartags]
+	puts $f [list set hideremotes $hideremotes]
 	puts $f [list set showlocalchanges $showlocalchanges]
 	puts $f [list set datetimeformat $datetimeformat]
 	puts $f [list set limitdiffs $limitdiffs]
@@ -10383,6 +10386,7 @@ proc doprefs {} {
     global oldprefs prefstop showneartags showlocalchanges
     global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     global tabstop limitdiffs autoselect extdifftool perfile_attrs
+    global hideremotes
 
     set top .gitkprefs
     set prefstop $top
@@ -10391,7 +10395,7 @@ proc doprefs {} {
 	return
     }
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-		   limitdiffs tabstop perfile_attrs} {
+		   limitdiffs tabstop perfile_attrs hideremotes} {
 	set oldprefs($v) [set $v]
     }
     toplevel $top
@@ -10423,6 +10427,9 @@ proc doprefs {} {
     checkbutton $top.ntag -text [mc "Display nearby tags"] \
 	-font optionfont -variable showneartags
     grid x $top.ntag -sticky w
+    checkbutton $top.hideremotes -text [mc "Hide remote refs"] \
+	-font optionfont -variable hideremotes
+    grid x $top.hideremotes -sticky w
     checkbutton $top.ldiff -text [mc "Limit diffs to listed paths"] \
 	-font optionfont -variable limitdiffs
     grid x $top.ldiff -sticky w
@@ -10547,7 +10554,7 @@ proc prefscan {} {
     global oldprefs prefstop
 
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-		   limitdiffs tabstop perfile_attrs} {
+		   limitdiffs tabstop perfile_attrs hideremotes} {
 	global $v
 	set $v $oldprefs($v)
     }
@@ -10561,6 +10568,7 @@ proc prefsok {} {
     global oldprefs prefstop showneartags showlocalchanges
     global fontpref mainfont textfont uifont
     global limitdiffs treediffs perfile_attrs
+    global hideremotes
 
     catch {destroy $prefstop}
     unset prefstop
@@ -10606,6 +10614,9 @@ proc prefsok {} {
 	  $limitdiffs != $oldprefs(limitdiffs)} {
 	reselectline
     }
+    if {$hideremotes != $oldprefs(hideremotes)} {
+	rereadrefs
+    }
 }
 
 proc formatdate {d} {
@@ -11011,6 +11022,7 @@ set mingaplen 100
 set cmitmode "patch"
 set wrapcomment "none"
 set showneartags 1
+set hideremotes 0
 set maxrefs 20
 set maxlinelen 200
 set showlocalchanges 1
-- 
1.6.4.249.gea1ec
