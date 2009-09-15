From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 2/2] Fix the geometry when restoring from zoomed state.
Date: Tue, 15 Sep 2009 10:37:51 +0100
Message-ID: <8763bkcsxb.fsf@users.sourceforge.net>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexy Borzenkov <snaury@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 14:08:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnWq9-0002OE-P2
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 14:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbZIOMHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 08:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753349AbZIOMHy
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 08:07:54 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:58630 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753315AbZIOMHx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 08:07:53 -0400
Received: from [172.23.170.147] (helo=anti-virus03-10)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MnWp9-0005Qu-36; Tue, 15 Sep 2009 13:07:55 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MnWp8-0001vz-HL; Tue, 15 Sep 2009 13:07:54 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 2A76451843; Tue, 15 Sep 2009 13:07:45 +0100 (BST)
Cc: Paul Mackerras <paulus@samba.org>
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128533>


The patch to handle the geometry of a restored gitk by Alexy Borzenkov
causes the position of the columns to creep each time the application
is restarted. This patch addresses this by remembering the application
geometry for the normal state and saving that regardless of the actual
state when the application is closed.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index a0214b7..67122c3 100755
--- a/gitk
+++ b/gitk
@@ -2251,6 +2251,8 @@ proc makewindow {} {
 	    }
 	    wm geometry . "${w}x$h"
 	}
+    } else {
+	set geometry(main) [wm geometry .]
     }
 
     if {[info exists geometry(state)] && $geometry(state) eq "zoomed"} {
@@ -2265,6 +2267,11 @@ proc makewindow {} {
         set ::BM "2"
     }
 
+    bind . <Configure> {
+	if {[winfo toplevel %W] eq "%W" && [wm state %W] eq "normal"} {
+	    set ::geometry(main) %wx%h+%x+%y
+	}
+    }
     bind .pwbottom <Configure> {resizecdetpanes %W %w}
     pack .ctop -fill both -expand 1
     bindall <1> {selcanvline %W %x %y}
@@ -2556,7 +2563,7 @@ proc savestuff {w} {
 	puts $f [list set extdifftool $extdifftool]
 	puts $f [list set perfile_attrs $perfile_attrs]
 
-	puts $f "set geometry(main) [wm geometry .]"
+	puts $f "set geometry(main) $::geometry(main)"
 	puts $f "set geometry(state) [wm state .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
 	puts $f "set geometry(topheight) [winfo height .tf]"
-- 
1.6.4.msysgit.0
