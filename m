From: Jeff King <peff@peff.net>
Subject: Re: How to make gitk not overwrite my selection?
Date: Tue, 4 Mar 2008 18:03:07 -0500
Message-ID: <20080304230306.GA18246@sigill.intra.peff.net>
References: <47CD6D1C.1080202@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Jean-Luc Herren <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Wed Mar 05 00:03:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWgAt-0005e6-Hy
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 00:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934177AbYCDXDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 18:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934094AbYCDXDL
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 18:03:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1694 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934091AbYCDXDK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 18:03:10 -0500
Received: (qmail 20066 invoked by uid 111); 4 Mar 2008 23:03:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 04 Mar 2008 18:03:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Mar 2008 18:03:07 -0500
Content-Disposition: inline
In-Reply-To: <47CD6D1C.1080202@gmx.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76152>

On Tue, Mar 04, 2008 at 04:39:08PM +0100, Jean-Luc Herren wrote:

> In gitk, whenever I select a commit in the tree, the SHA1 field
> gets automatically selected, putting its hash into the current
> selection for easy pasting into other applications.  I wonder if I
> can disable this, because I find it rather annoying; if I do
> happen to want to paste the hash somewhere, I can easily double
> click the SHA1 field.
>
> This is specially annoying when I select a hash in xterm and then
> start gitk to paste it in the SHA1 field.  But immediately after
> gitk opens, it preselects the current HEAD, overwriting my
> previous selection from xterm.
>
> Generally I think an application should not replace the selection
> unless the user explicitely marks something.  Although I can
> understand that it can be useful sometimes with gitk.  Therefore
> it should maybe be optional.

The patch below seems to work for me (see the "auto-select sha1" option
under preferences). However, I don't actually know tcl, so I
cargo-culted all of the option processing magic. Paul, if you want to
take this patch, please read it carefully. ;)

-- >8 --
gitk: make autoselect optional

Some users find it annoying to have the selection automatically changed
without any user intervention, since it can overwrite something they
actually wanted to keep in the selection buffer.

---
 gitk-git/gitk |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index f1f21e9..915dfb8 100644
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
+    label $top.autoselect.l -text [mc "Auto-select sha1"] -font optionfont
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
1.5.4.3.530.gbda49

