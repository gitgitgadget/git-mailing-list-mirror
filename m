From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Thu, 6 Mar 2008 23:17:08 +1100
Message-ID: <18383.57540.26282.526111@cargo.ozlabs.ibm.com>
References: <47AAA254.2020008@thorn.ws>
	<20080207063020.GP24004@spearce.org>
	<200802071056.19370.robin.rosenberg.lists@dewire.com>
	<20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
	<20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
	<18368.41742.689290.877767@cargo.ozlabs.ibm.com>
	<47C190E3.6000407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 13:18:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXF2n-0006FK-LT
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 13:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183AbYCFMRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 07:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbYCFMRQ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 07:17:16 -0500
Received: from ozlabs.org ([203.10.76.45]:41231 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbYCFMRP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 07:17:15 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7E57CDDF1C; Thu,  6 Mar 2008 23:17:14 +1100 (EST)
In-Reply-To: <47C190E3.6000407@gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76385>

Mark Levedahl writes:

> I can only offer to test the proposed patch, I am unable to predict what 
> will or won't trip up the buggy geometry engine in Cygwin's Tk. I do 
> remember I had trouble finding a way to restore the size but not the 
> position of the main window on Cygwin: that doesn't mean it can't be 
> done (logically, it should be easy), just that I didn't find the right 
> spell or incantation that would work. I'll also admit to not having 
> tried after I got to a completely working geometry solution, so perhaps 
> just restoring the size without position will now work on Cygwin.
> 
> Using the saved panel sizes in conjunction with the default window size 
> yields an unusable screen: many elements are obscured. The same occurs 
> using the defaults altogether: either way the user must resize and 
> adjust things to get to a workable layout. So, I am very opposed to 
> disabling the memory altogether. Also, I have a number of X apps that 
> remember their layout, so gitk's current behavior is not (at least to 
> me) an aberration and I would like that behavior to at least remain an 
> option.

Here's a patch for people to test.  It only restores the width and
height, and limits the width and height to be at most the width and
height of the screen.  It seems to work fine under X; I would be
interested to know what happens under macos and windows.

Paul.
---
diff --git a/gitk b/gitk
index f1f21e9..f8f006f 100755
--- a/gitk
+++ b/gitk
@@ -930,9 +930,17 @@ proc makewindow {} {
     .pwbottom add .bright
     .ctop add .pwbottom
 
-    # restore window position if known
+    # restore window width & height if known
     if {[info exists geometry(main)]} {
-        wm geometry . "$geometry(main)"
+	if {[scan $geometry(main) "%dx%d" w h] >= 2} {
+	    if {$w > [winfo screenwidth .]} {
+		set w [winfo screenwidth .]
+	    }
+	    if {$h > [winfo screenheight .]} {
+		set h [winfo screenheight .]
+	    }
+	    wm geometry . "${w}x$h"
+	}
     }
 
     if {[tk windowingsystem] eq {aqua}} {

