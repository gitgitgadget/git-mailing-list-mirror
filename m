From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] gitk: Add a visual tag for remote refs
Date: Tue, 18 Apr 2006 23:53:07 +0200
Message-ID: <200604182353.07759.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 18 23:53:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVy8J-0006r4-HX
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 23:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWDRVxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 17:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWDRVxM
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 17:53:12 -0400
Received: from mail.gmx.de ([213.165.64.20]:64916 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750720AbWDRVxK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 17:53:10 -0400
Received: (qmail invoked by alias); 18 Apr 2006 21:53:09 -0000
Received: from p5496A6BA.dip0.t-ipconnect.de (EHLO linux) [84.150.166.186]
  by mail.gmx.net (mp043) with SMTP; 18 Apr 2006 23:53:09 +0200
X-Authenticated: #352111
To: Paul Mackerras <paulus@samba.org>
User-Agent: KMail/1.9.1
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18882>

This patch partly changes the background color for remote refs.
It makes it easy to quickly distinguish remote refs from local
developer branches.

I ignore remote HEADs, as these really should be drawn as
aliases to other heads. But there is no simple way to
detect that HEADs really are aliases for other refs via
"git-ls-remote".

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---

To see the effect of this patch, you need remote refs in your
repository. Such refs are created when using "--use-separate-remote"
with git-clone.

IMHO showing HEAD refs as aliases to real refs would be nice to
have in gitk (What is the current branch?). Unfortunately,
"git-ls-remote", which is used in gitk, does not give the info
whether a ref is a symbolic link to another.
So for this time, I ignore remote HEADs, too. They are only confusing
as they would have been drawn now.

Josef


 gitk |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

f073dd11d6f2d473797b4c85cd4ac9758b6141b6
diff --git a/gitk b/gitk
index 87e7162..b642326 100755
--- a/gitk
+++ b/gitk
@@ -290,10 +290,16 @@ proc readrefs {} {
 	    match id path]} {
 	    continue
 	}
+	if {[regexp {^remotes/.*/HEAD$} $path match]} {
+	    continue
+	}
 	if {![regexp {^(tags|heads)/(.*)$} $path match type name]} {
 	    set type others
 	    set name $path
 	}
+	if {[regexp {^remotes/} $path match]} {
+	    set type heads
+	}
 	if {$type == "tags"} {
 	    set tagids($name) $id
 	    lappend idtags($id) $name
@@ -1718,6 +1724,14 @@ proc drawtags {id x xt y1} {
 	    set xl [expr {$xl - $delta/2}]
 	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
 		-width 1 -outline black -fill $col -tags tag.$id
+	    if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
+	        set rwid [font measure $mainfont $remoteprefix]
+		set xi [expr {$x + 1}]
+		set yti [expr {$yt + 1}]
+		set xri [expr {$x + $rwid}]
+		$canv create polygon $xi $yti $xri $yti $xri $yb $xi $yb \
+			-width 0 -fill "#ffddaa" -tags tag.$id
+	    }
 	}
 	set t [$canv create text $xl $y1 -anchor w -text $tag \
 		   -font $mainfont -tags tag.$id]
-- 
1.3.0.rc4.g8060-dirty
