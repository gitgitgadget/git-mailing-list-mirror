From: Jeff King <peff@peff.net>
Subject: [PATCH] gitk: make autoselect optional
Date: Thu, 6 Mar 2008 06:49:25 -0500
Message-ID: <20080306114925.GA6942@sigill.intra.peff.net>
References: <47CD6D1C.1080202@gmx.ch> <20080304230306.GA18246@sigill.intra.peff.net> <18383.51382.866732.308234@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Luc Herren <jlh@gmx.ch>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 12:51:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXEcL-0005Fr-U6
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 12:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759286AbYCFLta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 06:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758356AbYCFLta
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 06:49:30 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4515 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759286AbYCFLt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 06:49:28 -0500
Received: (qmail 3106 invoked by uid 111); 6 Mar 2008 11:49:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 06 Mar 2008 06:49:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2008 06:49:25 -0500
Content-Disposition: inline
In-Reply-To: <18383.51382.866732.308234@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76381>

Whenever a commit is selected in the graph pane, its SHA1
is automatically put into the selection buffer for cut and
paste. However, some users may find this behavior annoying
since it can overwrite something they actually wanted to
keep in the buffer.

This patch makes the behavior optional under the name
"Auto-select SHA1", but continues to default to "on".

Signed-off-by: Jeff King <peff@peff.net>
---
On Thu, Mar 06, 2008 at 09:34:30PM +1100, Paul Mackerras wrote:

> Looks OK to me.  Care to re-send it with a Signed-off-by?  Oh, and
> put "sha1" in capitals, i.e. "SHA1".

Here it is, with both requested items and a slightly more coherent
commit message.

> (Tcl is actually a very simple language, and there are man pages for
> it; try "man Tcl" for a start. :)

Heh. My biggest concern was "did I get everywhere that options must be
mentioned" (which isn't a Tcl thing at all, of course). I tested that
the option works, and that it correctly saves the value in the .gitk
file and respects it on the next run.

 gitk-git/gitk |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index f1f21e9..36fdecd 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1163,6 +1163,7 @@ proc savestuff {w} {
     global viewname viewfiles viewargs viewperm nextviewnum
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
+    global autoselect
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
@@ -1177,6 +1178,7 @@ proc savestuff {w} {
 	puts $f [list set maxwidth $maxwidth]
 	puts $f [list set cmitmode $cmitmode]
 	puts $f [list set wrapcomment $wrapcomment]
+	puts $f [list set autoselect $autoselect]
 	puts $f [list set showneartags $showneartags]
 	puts $f [list set showlocalchanges $showlocalchanges]
 	puts $f [list set datetimeformat $datetimeformat]
@@ -4650,6 +4652,7 @@ proc selectline {l isnew} {
     global commentend idtags linknum
     global mergemax numcommits pending_select
     global cmitmode showneartags allcommits
+    global autoselect
 
     catch {unset pending_select}
     $canv delete hover
@@ -4705,8 +4708,10 @@ proc selectline {l isnew} {
     set currentid $id
     $sha1entry delete 0 end
     $sha1entry insert 0 $id
-    $sha1entry selection from 0
-    $sha1entry selection to end
+    if {$autoselect} {
+	$sha1entry selection from 0
+	$sha1entry selection to end
+    }
     rhighlight_sel $id
 
     $ctext conf -state normal
@@ -7943,7 +7948,7 @@ proc doprefs {} {
     global maxwidth maxgraphpct
     global oldprefs prefstop showneartags showlocalchanges
     global bgcolor fgcolor ctext diffcolors selectbgcolor
-    global tabstop limitdiffs
+    global tabstop limitdiffs autoselect
 
     set top .gitkprefs
     set prefstop $top
@@ -7973,6 +7978,11 @@ proc doprefs {} {
     checkbutton $top.showlocal.b -variable showlocalchanges
     pack $top.showlocal.b $top.showlocal.l -side left
     grid x $top.showlocal -sticky w
+    frame $top.autoselect
+    label $top.autoselect.l -text [mc "Auto-select SHA1"] -font optionfont
+    checkbutton $top.autoselect.b -variable autoselect
+    pack $top.autoselect.b $top.autoselect.l -side left
+    grid x $top.autoselect -sticky w
 
     label $top.ddisp -text [mc "Diff display options"]
     grid $top.ddisp - -sticky w -pady 10
@@ -8463,6 +8473,7 @@ set maxlinelen 200
 set showlocalchanges 1
 set limitdiffs 1
 set datetimeformat "%Y-%m-%d %H:%M:%S"
+set autoselect 1
 
 set colors {green red blue magenta darkgrey brown orange}
 set bgcolor white
-- 
1.5.4.3.532.gf15a6

