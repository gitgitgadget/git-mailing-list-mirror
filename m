From: Paul Mackerras <paulus@samba.org>
Subject: Re: [BUG] gitk draws a wrong line
Date: Tue, 25 Apr 2006 11:31:16 +1000
Message-ID: <17485.31716.452326.229628@cargo.ozlabs.ibm.com>
References: <20060418104014.GA2299@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 03:35:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYCSC-0006c1-Qa
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 03:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWDYBe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 21:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWDYBe6
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 21:34:58 -0400
Received: from ozlabs.org ([203.10.76.45]:52394 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751504AbWDYBe5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 21:34:57 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 77C5167A06; Tue, 25 Apr 2006 11:34:56 +1000 (EST)
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20060418104014.GA2299@informatik.uni-freiburg.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19119>

Uwe Zeisberger writes:

> and then going to commit 10c2df65060e1ab57b2f75e0749de0ee9b8f4810, 
> I see a small superfluous line between the two commits under 10c2df.
> 
> But still worse, if I select the line going down from 10c2df and then
> select it's parent (i.e c76b6b) I get a big line ending in the commit
> descriptions and four lines ending in midair.

That is an X server bug, it seems.  Tk already clips vertices that it
sends to the X server to be within a box that is no more than 32000
pixels wide or high, but that seems not to be enough with some X
servers.  What X server version are you using and what sort of video
card?

If you're feeling adventurous, you can rebuild Tk with the patch below
(courtesy of D. Richard Hipp) and see if that fixes it.  If it does it
proves that it is an X server bug.

Paul.

--- tkCanvUtil.c.orig   2006-02-08 08:51:31.859761208 -0500
+++ tkCanvUtil.c        2006-02-08 08:57:11.744090936 -0500
@@ -1657,25 +1657,27 @@
 
     /*
     ** Constrain all vertices of the path to be within a box that is no
-    ** larger than 32000 pixels wide or height.  The top-left corner of
+    ** larger than 16000 pixels wide or height.  The top-left corner of
     ** this clipping box is 1000 pixels above and to the left of the top
     ** left corner of the window on which the canvas is displayed.
     **
     ** This means that a canvas will not display properly on a canvas
-    ** window that is larger than 31000 pixels wide or high.  That is no
+    ** window that is larger than 14000 pixels wide or high.  That is no
     ** a problem today, but might someday become a factor for ultra-high
     ** resolutions displays.
     **
     ** The X11 protocol allows us (in theory) to expand the size of the
     ** clipping box to 32767 pixels.  But we have found experimentally that
-    ** XFree86 sometimes fails to draw lines correctly if they are longe
-    ** than about 32500 pixels.  So we have left a little margin in the
-    ** size to mask that bug.
+    ** XFree86 has problems with sizes bigger than 32500 pixels and we
+    ** have received reports of other X servers running in to trouble
+    ** at around 29000 pixels.  So we are going to play it safe a limit
+    ** pixel values to 14 bytes: 16384.  That is still sufficient for
+    ** a 4x4 ft display at 300 dpi.
     */
     lft = canvPtr->xOrigin - 1000.0;
     top = canvPtr->yOrigin - 1000.0;
-    rgh = lft + 32000.0;
-    btm = top + 32000.0;
+    rgh = lft + 16383.0;
+    btm = top + 16383.0;
 
     /* Try the common case first - no clipping.  Loop over the input
     ** coordinates and translate them into appropriate output coordinates.
