From: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Sun, 24 Feb 2008 19:21:07 +0100
Message-ID: <20080224192107.323a6abc.froese@gmx.de>
References: <47AAA254.2020008@thorn.ws>
	<20080207063020.GP24004@spearce.org>
	<200802071056.19370.robin.rosenberg.lists@dewire.com>
	<20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
	<20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
	<18368.41742.689290.877767@cargo.ozlabs.ibm.com>
	<47C190E3.6000407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 19:21:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTLTw-0000IB-NU
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 19:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbYBXSVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 13:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbYBXSVM
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 13:21:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:58118 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751022AbYBXSVK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 13:21:10 -0500
Received: (qmail invoked by alias); 24 Feb 2008 18:21:08 -0000
Received: from p5B0107C5.dip0.t-ipconnect.de (EHLO dialup) [91.1.7.197]
  by mail.gmx.net (mp004) with SMTP; 24 Feb 2008 19:21:08 +0100
X-Authenticated: #271361
X-Provags-ID: V01U2FsdGVkX1+WyVR0gzmWTWYQt2eTILArP2HxZcaI9xUFbai/oI
	2T5vOr0DkIkuPr
In-Reply-To: <47C190E3.6000407@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74951>

Mark Levedahl wrote:
>
> [...] so gitk's current behavior is not (at least to me) an aberration
> and I would like that behavior to at least remain an option.

It would be really annoying if I had to resize and reconfigure (the
panes) each time I start gitk.

How about only taking the saved geometry/fonts/etc when the screen
size hasn't changed?

The easiest method (for a Tcl-noob like me) would be to wrap the
"set geometry..." in .gitk with an if-statement which checks the
screen size.

Something like this:

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 5560e4d..1c572c9 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1158,14 +1158,12 @@ proc savestuff {w} {
     global viewname viewfiles viewargs viewperm nextviewnum
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
+    global screen_size
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
     catch {
 	set f [open "~/.gitk-new" w]
-	puts $f [list set mainfont $mainfont]
-	puts $f [list set textfont $textfont]
-	puts $f [list set uifont $uifont]
 	puts $f [list set tabstop $tabstop]
 	puts $f [list set findmergefiles $findmergefiles]
 	puts $f [list set maxgraphpct $maxgraphpct]
@@ -1183,6 +1181,10 @@ proc savestuff {w} {
 	puts $f [list set diffcontext $diffcontext]
 	puts $f [list set selectbgcolor $selectbgcolor]
 
+	puts $f "if {\$screen_size == \"$screen_size\"} {"
+	puts $f [list set mainfont $mainfont]
+	puts $f [list set textfont $textfont]
+	puts $f [list set uifont $uifont]
 	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
 	puts $f "set geometry(topheight) [winfo height .tf]"
@@ -1198,6 +1200,7 @@ proc savestuff {w} {
 	    }
 	}
 	puts $f "}"
+	puts $f "}"
 	close $f
 	file rename -force "~/.gitk-new" "~/.gitk"
     }
@@ -8461,6 +8464,8 @@ set diffcolors {red "#00a000" blue}
 set diffcontext 3
 set selectbgcolor gray85
 
+set screen_size [winfo screenwidth .]x[winfo screenheight .]
+
 ## For msgcat loading, first locate the installation location.
 if { [info exists ::env(GITK_MSGSDIR)] } {
     ## Msgsdir was manually set in the environment.

Saving geometries for multiple screen sizes would be even better
(i.e. geometry_1440x900(main) etc or an additional ".gitk-$screen_size"
for the geometry data) but that is beyond my Tcl-skills.

Ciao, ET.
