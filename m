From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK)] gitk: Fix transient windows on Win32 and MacOS.
Date: Tue, 11 Nov 2008 23:55:42 +0300
Organization: HOME
Message-ID: <200811112355.43352.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 21:59:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L00KS-0005S0-Fu
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 21:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbYKKU5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 15:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbYKKU5s
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 15:57:48 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:25318 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbYKKU5q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 15:57:46 -0500
Received: by ey-out-2122.google.com with SMTP id 6so35617eyi.37
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 12:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2MxzkoPs3a09hKXlXxp6MIcFglwBkTd/F6R+acvYxpI=;
        b=X61HR5kXlv2ugWVmJpQZgEzuqtxpiTNWzhaaKVGoDHxPkySqYePFGQTu9pGNqvl1qP
         CF+ubkyAdAFLGIU6Xdnw5RnsTF9ux0y06TVeeKN56vilhPSA/Y2FX5vgYCXD+fVT539r
         3yHDwR4FxnfZzj2OTGNokqchJjjhuJnAS+HCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=Di3MVEmIOjLwAWO3SwEtpdX1pD0sC9I9G43BP78mPYJ133dMcU3wPh+vIy+c65hVYW
         uZXvSw0PobxZzXHIRxnBsG6/fMdX033FvxD8tU2mtBBZSiWwGHD5qHHzSZHjZovbKkXH
         aWoGRT73YqBkloL4hmZ2SN25d/Zewjinx3tyA=
Received: by 10.187.201.15 with SMTP id d15mr3020209faq.11.1226437063435;
        Tue, 11 Nov 2008 12:57:43 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id d13sm3096290fka.19.2008.11.11.12.57.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Nov 2008 12:57:42 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100677>

Transient windows cause problems on these platforms:

- On Win32 the windows appear in the top left corner
  of the screen. In order to fix it, this patch causes
  them to be explicitly centered on their parents by
  an idle handler.

- On MacOS with Tk 8.4 they appear without a title bar.
  Since it is clearly unacceptable, this patch disables
  transient on that platform.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	NOTE: This patch DEPRECATES the earlier one, called
		"Explicitly position popup windows"

	Alexander

 gitk |   44 +++++++++++++++++++++++++++++++-------------
 1 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/gitk b/gitk
index 9b2a6e5..e6aafe8 100755
--- a/gitk
+++ b/gitk
@@ -1739,6 +1739,24 @@ proc removehead {id name} {
     unset headids($name)
 }
 
+proc make_transient {window origin} {
+    global have_tk85
+
+    # In MacOS Tk 8.4 transient appears to work by setting
+    # overrideredirect, which is utterly useless, since the
+    # windows get no border, and are not even kept above
+    # the parent.
+    if {!$have_tk85 && [tk windowingsystem] eq {aqua}} return
+
+    wm transient $window $origin
+
+    # Windows fails to place transient windows normally, so
+    # schedule a callback to center them on the parent.
+    if {[tk windowingsystem] eq {win32}} {
+	after idle [list tk::PlaceWindow $window widget $origin]
+    }
+}
+
 proc show_error {w top msg} {
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
@@ -1754,7 +1772,7 @@ proc show_error {w top msg} {
 proc error_popup {msg {owner .}} {
     set w .error
     toplevel $w
-    wm transient $w $owner
+    make_transient $w $owner
     show_error $w $w $msg
 }
 
@@ -1763,7 +1781,7 @@ proc confirm_popup {msg {owner .}} {
     set confirm_ok 0
     set w .confirm
     toplevel $w
-    wm transient $w $owner
+    make_transient $w $owner
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
     button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
@@ -2558,7 +2576,7 @@ proc about {} {
     }
     toplevel $w
     wm title $w [mc "About gitk"]
-    wm transient $w .
+    make_transient $w .
     message $w.m -text [mc "
 Gitk - a commit viewer for git
 
@@ -2587,7 +2605,7 @@ proc keys {} {
     }
     toplevel $w
     wm title $w [mc "Gitk key bindings"]
-    wm transient $w .
+    make_transient $w .
     message $w.m -text "
 [mc "Gitk key bindings:"]
 
@@ -3669,7 +3687,7 @@ proc vieweditor {top n title} {
 
     toplevel $top
     wm title $top $title
-    wm transient $top .
+    make_transient $top .
 
     # View name
     frame $top.nfr
@@ -7912,7 +7930,7 @@ proc mkpatch {} {
     set patchtop $top
     catch {destroy $top}
     toplevel $top
-    wm transient $top .
+    make_transient $top .
     label $top.title -text [mc "Generate patch"]
     grid $top.title - -pady 10
     label $top.from -text [mc "From:"]
@@ -7999,7 +8017,7 @@ proc mktag {} {
     set mktagtop $top
     catch {destroy $top}
     toplevel $top
-    wm transient $top .
+    make_transient $top .
     label $top.title -text [mc "Create tag"]
     grid $top.title - -pady 10
     label $top.id -text [mc "ID:"]
@@ -8102,7 +8120,7 @@ proc writecommit {} {
     set wrcomtop $top
     catch {destroy $top}
     toplevel $top
-    wm transient $top .
+    make_transient $top .
     label $top.title -text [mc "Write commit to file"]
     grid $top.title - -pady 10
     label $top.id -text [mc "ID:"]
@@ -8159,7 +8177,7 @@ proc mkbranch {} {
     set top .makebranch
     catch {destroy $top}
     toplevel $top
-    wm transient $top .
+    make_transient $top .
     label $top.title -text [mc "Create new branch"]
     grid $top.title - -pady 10
     label $top.id -text [mc "ID:"]
@@ -8322,7 +8340,7 @@ proc resethead {} {
     set confirm_ok 0
     set w ".confirmreset"
     toplevel $w
-    wm transient $w .
+    make_transient $w .
     wm title $w [mc "Confirm reset"]
     message $w.m -text \
 	[mc "Reset branch %s to %s?" $mainhead [string range $rowmenuid 0 7]] \
@@ -8502,7 +8520,7 @@ proc showrefs {} {
     }
     toplevel $top
     wm title $top [mc "Tags and heads: %s" [file tail [pwd]]]
-    wm transient $top .
+    make_transient $top .
     text $top.list -background $bgcolor -foreground $fgcolor \
 	-selectbackground $selectbgcolor -font mainfont \
 	-xscrollcommand "$top.xsb set" -yscrollcommand "$top.ysb set" \
@@ -9844,7 +9862,7 @@ proc choosefont {font which} {
 	font create sample
 	eval font config sample [font actual $font]
 	toplevel $top
-	wm transient $top $prefstop
+	make_transient $top $prefstop
 	wm title $top [mc "Gitk font chooser"]
 	label $top.l -textvariable fontparam(which)
 	pack $top.l -side top
@@ -9961,7 +9979,7 @@ proc doprefs {} {
     }
     toplevel $top
     wm title $top [mc "Gitk preferences"]
-    wm transient $top .
+    make_transient $top .
     label $top.ldisp -text [mc "Commit list display options"]
     grid $top.ldisp - -sticky w -pady 10
     label $top.spacer -text " "
-- 
1.6.0.3.15.gb8d36
