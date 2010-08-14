From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: change the termination checks to avoid potential hang.
Date: Sun, 15 Aug 2010 00:21:30 +0100
Message-ID: <87iq3bh1op.fsf_-_@fox.patthoyts.tk>
References: <20100704203342.6064.32250.reportbug@balanced-tree>
	<20100704212125.GA1613@burratino> <20100704212439.GA1765@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 01:54:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okn2N-0002NU-Fz
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 01:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735Ab0HOXym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 19:54:42 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:54786 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750993Ab0HOXym (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 19:54:42 -0400
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Okn2G-000266-9i; Mon, 16 Aug 2010 00:54:40 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1Okn26-0004UD-K3; Mon, 16 Aug 2010 00:54:30 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 4138723AC7; Mon, 16 Aug 2010 00:54:30 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20100704212439.GA1765@burratino> (Jonathan Nieder's message of
	"Sun, 4 Jul 2010 16:24:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153632>

Supposedly the askpass utility can hang under some circumstances. This
patch adjusts the Tk application to terminate properly and should avoid
this problem.

Reported-by: Anders Kaseorg <andersk@mit.edu>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 git-gui--askpass |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/git-gui--askpass b/git-gui--askpass
index 12e117e..8ba4779 100755
--- a/git-gui--askpass
+++ b/git-gui--askpass
@@ -30,16 +30,20 @@ if {!$yesno} {
 
 frame .b
 button .b.ok     -text OK     -command finish
-button .b.cancel -text Cancel -command {destroy .}
+button .b.cancel -text Cancel -command cancel
 
 pack .b.ok -side left -expand 1
 pack .b.cancel -side right -expand 1
 pack .b -side bottom -fill x -padx 10 -pady 10
 
 bind . <Visibility> {focus -force .e}
-bind . <Key-Return> finish
-bind . <Key-Escape> {destroy .}
-bind . <Destroy>    {exit $rc}
+bind . <Key-Return> [list .b.ok invoke]
+bind . <Key-Escape> [list .b.cancel invoke]
+bind . <Destroy>    {set rc $rc}
+
+proc cancel {} {
+	set ::rc 255
+}
 
 proc finish {} {
 	if {$::yesno} {
@@ -50,10 +54,11 @@ proc finish {} {
 		}
 	}
 
-	set ::rc 0
 	puts $::answer
-	destroy .
+	set ::rc 0
 }
 
 wm title . "OpenSSH"
 tk::PlaceWindow .
+vwait rc
+exit $rc
-- 
1.7.2.1.44.g721e7
