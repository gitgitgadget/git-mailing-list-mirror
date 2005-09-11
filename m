From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Mon, 12 Sep 2005 01:12:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509120110050.10414@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <deofnh$jl0$1@sea.gmane.org>  <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
 <46a038f9050911040762f53552@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	John Ellson <ellson@research.att.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 01:13:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEb0K-00084i-P4
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 01:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVIKXMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 19:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVIKXMo
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 19:12:44 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:37077 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751046AbVIKXMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 19:12:43 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 29E63E23F7; Mon, 12 Sep 2005 01:12:42 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0D45087EC5; Mon, 12 Sep 2005 01:12:42 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ECB7E87200; Mon, 12 Sep 2005 01:12:41 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 472DFE23F7; Mon, 12 Sep 2005 01:12:41 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f9050911040762f53552@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8338>

Hi,

On Sun, 11 Sep 2005, Martin Langhoff wrote:

> On 9/11/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > - gitk gets very confused about the window layout. My preliminary tests on
> >   cygwin showed that this seems to be rather a problem of Tk with rootless
> >   Xwin. I worked around it by explicitely stating the dimensions of some
> >   canvas windows which would not automatically resize with their contents
> >   otherwise.
>  
> Can you share that fix? 

I'm reluctant to do it, because it is not really a fix: the layout is 
better, but not perfect (BTW this is the reason I don't sign it off this 
time). For example, the width of the commit message window is not really 
the same when restarting. Worse, the upper part is shrinking with every 
restart of gitk. But anyhow, this is as far as I got to make it at least a 
bit usable:

diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -357,13 +357,13 @@ proc makewindow {} {
 	set geometry(ctexth) [expr {($texth - 8) /
 				    [font metrics $textfont -linespace]}]
     }
-    frame .ctop.top
+    frame .ctop.top -height $geometry(canvh)
     frame .ctop.top.bar
     pack .ctop.top.bar -side bottom -fill x
     set cscroll .ctop.top.csb
     scrollbar $cscroll -command {allcanvs yview} -highlightthickness 0
     pack $cscroll -side right -fill y
-    panedwindow .ctop.top.clist -orient horizontal -sashpad 0 -handlesize 4
+    panedwindow .ctop.top.clist -orient horizontal -sashpad 0 -handlesize 4 -height $geometry(canvh)
     pack .ctop.top.clist -side top -fill both -expand 1
     .ctop add .ctop.top
     set canv .ctop.top.clist.canv
@@ -433,9 +433,10 @@ proc makewindow {} {
     # for making sure type==Exact whenever loc==Pickaxe
     trace add variable findloc write findlocchange
 
-    panedwindow .ctop.cdet -orient horizontal
+    panedwindow .ctop.cdet -orient horizontal \
+	-height [expr $geometry(ctexth)*$linespc+4]
     .ctop add .ctop.cdet
-    frame .ctop.cdet.left
+    frame .ctop.cdet.left -width [expr $geometry(ctextw)*[font measure $textfont "0"]+8]
     set ctext .ctop.cdet.left.ctext
     text $ctext -bg white -state disabled -font $textfont \
 	-width $geometry(ctextw) -height $geometry(ctexth) \
