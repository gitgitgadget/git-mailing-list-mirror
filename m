From: "Eric Raible" <raible@gmail.com>
Subject: [PATCH] gitk: synchronize highlighting in file view for 'f'&'b' commands
Date: Sun, 16 Mar 2008 19:50:44 -0700
Message-ID: <279b37b20803161950q73853290w864eda69896efb9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 17 03:51:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb5Re-0004MK-Dz
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 03:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbYCQCur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 22:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbYCQCur
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 22:50:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:52946 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbYCQCuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 22:50:46 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1555581fgb.17
        for <git@vger.kernel.org>; Sun, 16 Mar 2008 19:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=6v1hHnFLedS/lmvikSWOo0F7GiN40VXj8NhDac1yjCs=;
        b=E/xBtnTlu4VH8S6IUg3TCpjH6V2ev4Uu7gCJMGSRiUg6RS3xvKJdeM9TIXeYxeMDhcZGLEzeR+cKeJQaCEPGAbObMy1MXDkcrJpMuoEw2OmLegkSUdSlB/1bpuxDn9Cl1NDrF4EZQz3De1fx0sNFVW/RvmdsoHUaGKW/tZh0spk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XFt1U5tp+/uAwT0RrQBuJZ2TdQhycjaJgW0l9KdObQ1PLmU33TF1neQXam+x+Rvgk2Niek3LiJ2oAvDDkmKN+QhwHcastbmjsdcmfBaZtVNrIc/BNjqCTmZ/OzO0iiAqJGKECoBTQu8iDCN4yD4hHmwOmS+KbyOVioNKDnS5EL4=
Received: by 10.78.157.19 with SMTP id f19mr39899431hue.48.1205722244746;
        Sun, 16 Mar 2008 19:50:44 -0700 (PDT)
Received: by 10.78.175.15 with HTTP; Sun, 16 Mar 2008 19:50:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77414>

>From 03603a207b2caad8b52dd4a24860e387d418f800 Mon Sep 17 00:00:00 2001
From: Eric Raible <raible+git@gmail.com>
Date: Sun, 16 Mar 2008 19:33:52 -0700
Subject: [PATCH] gitk: synchronize highlighting in file view for
'f'&'b' commands

Previously, 'b', backspace, and delete all did the same thing.
This changes 'b' to perform the inverse of 'f'.  And both of
them now highlight the filename of the currently diff.

This makes it easier to review the diffs associated with
a particular commit using only f,b, and space.

Signed-off-by: Eric Raible <raible+git@gmail.com>
---
 gitk-git/gitk |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 84ab02e..e9ca6f7 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1016,7 +1016,7 @@ proc makewindow {} {
     bindkey k "selnextline 1"
     bindkey j "goback"
     bindkey l "goforw"
-    bindkey b "$ctext yview scroll -1 pages"
+    bindkey b prevfile
     bindkey d "$ctext yview scroll 18 units"
     bindkey u "$ctext yview scroll -18 units"
     bindkey / {dofind 1 1}
@@ -5478,13 +5478,30 @@ proc changediffdisp {} {
     $ctext tag conf d1 -elide [lindex $diffelide 1]
 }

+proc highlightfile {loc} {
+    global ctext
+    $ctext yview $loc
+
+    global cmitmode ctext cflist cflist_top
+    if {$cmitmode eq "tree"} return
+
+    $cflist tag remove highlight $cflist_top.0 "$cflist_top.0 lineend"
+
+    set file [regsub -- "-* (.*?) -*" [$ctext get $loc "$loc lineend"] "\\1"]
+    set cline [$cflist search -regexp [subst {^$file$}] 0.0]
+
+    $cflist tag add highlight $cline "$cline lineend"
+    $cflist see $cline
+    set cflist_top [lindex [split $cline .] 0]
+}
+
 proc prevfile {} {
     global difffilestart ctext
     set prev [lindex $difffilestart 0]
     set here [$ctext index @0,0]
     foreach loc $difffilestart {
 	if {[$ctext compare $loc >= $here]} {
-	    $ctext yview $prev
+	    highlightfile $prev
 	    return
 	}
 	set prev $loc
@@ -5497,7 +5514,7 @@ proc nextfile {} {
     set here [$ctext index @0,0]
     foreach loc $difffilestart {
 	if {[$ctext compare $loc > $here]} {
-	    $ctext yview $loc
+	    highlightfile $loc
 	    return
 	}
     }
-- 
1.5.4.2.1161.g1a6f0
