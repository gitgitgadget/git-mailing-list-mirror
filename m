From: Stefan Haller <stefan@haller-berlin.de>
Subject: [PATCH] gitk: Add "First parent" checkbox
Date: Thu, 31 Oct 2013 15:59:12 +0100
Message-ID: <1383231552-63504-1-git-send-email-stefan@haller-berlin.de>
References: <CAFAOj7orccjudOu4czDpaN-TZBCFb=T-Qo8f9eo_1dnKBGXJ4g@mail.gmail.com>
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 15:59:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbtio-0005ZA-Jn
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 15:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab3JaO7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 10:59:38 -0400
Received: from server90.greatnet.de ([83.133.96.186]:55033 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab3JaO7h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 10:59:37 -0400
Received: from macbook-stk.office.ableton.com (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 99B2FDD0DB;
	Thu, 31 Oct 2013 15:59:35 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2.747.g15edaa9
In-Reply-To: <CAFAOj7orccjudOu4czDpaN-TZBCFb=T-Qo8f9eo_1dnKBGXJ4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237126>

Sometimes it's desirable to see what changes were introduced by a
merge commit, rather than how conflicts were resolved. This adds
a checkbox which, when turned on, makes gitk show the equivalent
of "git show --first-parent <commit>" for merge commits.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
This is the same patch as the one I sent in
<http://comments.gmane.org/gmane.comp.version-control.git/160920>, with
the same issues discussed in that thread. I just brought it up to date
with current master.

 gitk | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 5cd00d8..3466054 100755
--- a/gitk
+++ b/gitk
@@ -2336,6 +2336,10 @@ proc makewindow {} {
 	pack .bleft.mid.worddiff -side left -padx 5
     }

+    ${NS}::checkbutton .bleft.mid.firstparent -text [mc "First parent"] \
+	-command changefirstparent -variable firstparent
+    pack .bleft.mid.firstparent -side left -padx 5
+
     set ctext .bleft.bottom.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font textfont \
@@ -7080,6 +7084,7 @@ proc selectline {l isnew {desired_loc {}}} {
     global cmitmode showneartags allcommits
     global targetrow targetid lastscrollrows
     global autoselect autosellen jump_to_here
+    global firstparent

     catch {unset pending_select}
     $canv delete hover
@@ -7221,7 +7226,7 @@ proc selectline {l isnew {desired_loc {}}} {
     init_flist [mc "Comments"]
     if {$cmitmode eq "tree"} {
 	gettree $id
-    } elseif {[llength $olds] <= 1} {
+    } elseif {[llength $olds] <= 1 || $firstparent} {
 	startdiff $id
     } else {
 	mergediff $id
@@ -7624,7 +7629,7 @@ proc diffcmd {ids flags} {
 proc gettreediffs {ids} {
     global treediff treepending limitdiffs vfilelimit curview

-    set cmd [diffcmd $ids {--no-commit-id}]
+    set cmd [diffcmd $ids {--no-commit-id -m --first-parent}]
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
 	    set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -7710,12 +7715,20 @@ proc changeworddiff {name ix op} {
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
     global worddiff
+    global firstparent
     global limitdiffs vfilelimit curview
     global diffencoding targetline diffnparents
     global git_version currdiffsubmod
@@ -7728,13 +7741,18 @@ proc getblobdiffs {ids} {
     if {[package vcompare $git_version "1.6.6"] >= 0} {
 	set submodule "--submodule"
     }
-    set cmd [diffcmd $ids "-p $textconv $submodule  -C --cc --no-commit-id -U$diffcontext"]
+    set cmd [diffcmd $ids "-p $textconv $submodule  -C --no-commit-id -U$diffcontext"]
     if {$ignorespace} {
 	append cmd " -w"
     }
     if {$worddiff ne [mc "Line diff"]} {
 	append cmd " --word-diff=porcelain"
     }
+    if {$firstparent} {
+	append cmd " -m --first-parent"
+    } else {
+	append cmd " --cc"
+    }
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -11865,6 +11883,7 @@ set diffcontext 3
 set mergecolors {red blue green purple brown "#009090" magenta "#808000" "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" "#f0b070" "#ff70b0"}
 set ignorespace 0
 set worddiff ""
+set firstparent 0
 set markbgcolor "#e0e0ff"

 set headbgcolor green
--
1.8.3.2.747.g15edaa9
