From: Stefan Haller <lists@haller-berlin.de>
Subject: [PATCH] gitk: Add "First parent" checkbox
Date: Mon,  8 Nov 2010 11:42:59 +0100
Message-ID: <1289212979-64246-1-git-send-email-lists@haller-berlin.de>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 11:43:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFPC9-0002EC-OB
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 11:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab0KHKnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 05:43:06 -0500
Received: from mail.ableton.net ([62.96.12.115]:42845 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754421Ab0KHKnE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 05:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-Id:Date:Subject:Cc:To:From; bh=NCKpoAHvXsLV62AXQsxvuMNO0a228ouv5alonYIPyZs=;
	b=OMpdl1gNZ3EpUKNEjXU+PdGyawnnfkfB62fpBSbz2WFgcl+GGnsbJtBVjxnJiYokHswQ7vMkM0wbLJDilHTBjfVMvlhISwsTyFNXutC2ElmsTSev06P0z9Owu4nuzizNoRxu3Yn+uDVXbS6aGREihcVnCtsut6HQSNE+ySpYKJc=;
Received: from macbook-stk.office.ableton.com ([10.1.12.43])
	by mail.ableton.net with esmtp (Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PFPBl-0002Q7-3Y; Mon, 08 Nov 2010 11:43:01 +0100
X-Mailer: git-send-email 1.7.3.2.153.g8250e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160920>

Sometimes it's desirable to see what changes were introduced by a
merge commit, rather than how conflicts were resolved. This adds
a checkbox which, when turned on, makes gitk show the equivalent
of "git show --first-parent <commit>" for merge commits.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
I realize this conflicts with Thomas Rast's recent patch to
add a word-diff dropdown box; things are fighting for space
in the diff pane header...

 gitk |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 45e3380..db0f022 100755
--- a/gitk
+++ b/gitk
@@ -2245,6 +2245,9 @@ proc makewindow {} {
     ${NS}::checkbutton .bleft.mid.ignspace -text [mc "Ignore space change"] \
 	-command changeignorespace -variable ignorespace
     pack .bleft.mid.ignspace -side left -padx 5
+    ${NS}::checkbutton .bleft.mid.firstparent -text [mc "First parent"] \
+	-command changefirstparent -variable firstparent
+    pack .bleft.mid.firstparent -side left -padx 5
     set ctext .bleft.bottom.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font textfont \
@@ -6872,6 +6875,7 @@ proc selectline {l isnew {desired_loc {}}} {
     global cmitmode showneartags allcommits
     global targetrow targetid lastscrollrows
     global autoselect jump_to_here
+    global firstparent
 
     catch {unset pending_select}
     $canv delete hover
@@ -7013,7 +7017,7 @@ proc selectline {l isnew {desired_loc {}}} {
     init_flist [mc "Comments"]
     if {$cmitmode eq "tree"} {
 	gettree $id
-    } elseif {[llength $olds] <= 1} {
+    } elseif {[llength $olds] <= 1 || $firstparent} {
 	startdiff $id
     } else {
 	mergediff $id
@@ -7416,7 +7420,7 @@ proc diffcmd {ids flags} {
 proc gettreediffs {ids} {
     global treediff treepending
 
-    if {[catch {set gdtf [open [diffcmd $ids {--no-commit-id}] r]}]} return
+    if {[catch {set gdtf [open [diffcmd $ids {--no-commit-id -m --first-parent}] r]}]} return
 
     set treepending $ids
     set treediff {}
@@ -7504,11 +7508,19 @@ proc changeignorespace {} {
     reselectline
 }
 
+proc changefirstparent {} {
+    global treediffs
+    catch {unset treediffs}
+
+    reselectline
+}
+
 proc getblobdiffs {ids} {
     global blobdifffd diffids env
     global diffinhdr treediffs
     global diffcontext
     global ignorespace
+    global firstparent
     global limitdiffs vfilelimit curview
     global diffencoding targetline diffnparents
     global git_version currdiffsubmod
@@ -7521,10 +7533,15 @@ proc getblobdiffs {ids} {
     if {[package vcompare $git_version "1.6.6"] >= 0} {
 	set submodule "--submodule"
     }
-    set cmd [diffcmd $ids "-p $textconv $submodule  -C --cc --no-commit-id -U$diffcontext"]
+    set cmd [diffcmd $ids "-p $textconv $submodule  -C --no-commit-id -U$diffcontext"]
     if {$ignorespace} {
 	append cmd " -w"
     }
+    if {$firstparent} {
+	append cmd " -m --first-parent"
+    } else {
+	append cmd " --cc"
+    }
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -11393,6 +11410,7 @@ if {[tk windowingsystem] eq "win32"} {
 set diffcolors {red "#00a000" blue}
 set diffcontext 3
 set ignorespace 0
+set firstparent 0
 set markbgcolor "#e0e0ff"
 
 set circlecolors {white blue gray blue blue}
-- 
1.7.3.2.153.g8250e
