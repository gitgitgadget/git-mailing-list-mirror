From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] gitk: add Update menu item.
Date: Tue, 20 Sep 2005 16:56:58 +0200
Message-ID: <20050920145658.GA13292MdfPADPa@greensroom.kotnet.org>
References: <20050920122423.GA4228MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Sep 20 16:59:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHjYM-0000rN-J9
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 16:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVITO5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 10:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVITO5A
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 10:57:00 -0400
Received: from smtp13.wxs.nl ([195.121.6.27]:52457 "EHLO smtp13.wxs.nl")
	by vger.kernel.org with ESMTP id S965026AbVITO47 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 10:56:59 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp13.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IN400I4HEUYW1@smtp13.wxs.nl> for git@vger.kernel.org; Tue,
 20 Sep 2005 16:56:58 +0200 (CEST)
Received: (qmail 13309 invoked by uid 500); Tue, 20 Sep 2005 14:56:58 +0000
In-reply-to: <20050920122423.GA4228MdfPADPa@greensroom.kotnet.org>
To: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Mail-followup-to: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8999>

On Tue, Sep 20, 2005 at 02:24:23PM +0200, Sven Verdoolaege wrote:
> Update will redraw the commits if any commits have been added to any
> of the selected heads.  The new commits appear on the top.
> 

It appears I sent this patch to soon.
With the additional patch below, it seems to work,
that is, it survives a rebase.

I can send a replacement patch combining the two patches if
anyone is interested.

skimo

diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -68,6 +68,7 @@ proc getcommitlines {commfd}  {
     global oldcommits commits parents cdate children
     global commitlisted phase commitinfo nextupdate
     global stopped redisplaying leftover
+    global canv
 
     set stuff [read $commfd]
     if {$stuff == {}} {
@@ -126,6 +127,7 @@ to allow selection of commits to be disp
 	set olds [lrange $ids 1 end]
 	set cmit [string range $cmit [expr {$j + 1}] end]
 	if {$phase == "updatecommits"} {
+	    $canv delete all
 	    set oldcommits $commits
 	    set commits {}
 	    set phase getcommits
@@ -133,7 +135,7 @@ to allow selection of commits to be disp
 	lappend commits $id
 	set commitlisted($id) 1
 	parsecommit $id $cmit 1 [lrange $ids 1 end]
-	drawcommit $id
+	drawcommit $id 1
 	if {[clock clicks -milliseconds] >= $nextupdate} {
 	    doupdate 1
 	}
@@ -143,7 +145,7 @@ to allow selection of commits to be disp
 		set stopped 0
 		set phase "getcommits"
 		foreach id $commits {
-		    drawcommit $id
+		    drawcommit $id 1
 		    if {$stopped} break
 		    if {[clock clicks -milliseconds] >= $nextupdate} {
 			doupdate 1
@@ -1449,7 +1451,7 @@ proc decidenext {{noread 0}} {
     return $level
 }
 
-proc drawcommit {id} {
+proc drawcommit {id reading} {
     global phase todo nchildren datemode nextupdate
     global numcommits ncmupdate displayorder todo onscreen
 
@@ -1478,7 +1480,7 @@ proc drawcommit {id} {
 	    break
 	}
     }
-    drawmore 1
+    drawmore $reading
 }
 
 proc finishcommits {} {
@@ -1487,7 +1489,7 @@ proc finishcommits {} {
 
     if {$phase == "incrdraw"} {
 	foreach id $oldcommits {
-	    drawcommit $id
+	    drawcommit $id 0
 	}
 	set oldcommits {}
 	drawrest
@@ -3636,7 +3638,7 @@ proc rereadrefs {} {
 }
 
 proc updatecommits {rargs} {
-    global phase
+    global commfd phase
     global startmsecs nextupdate ncmupdate
     global idtags idheads idotherrefs
     global leftover
