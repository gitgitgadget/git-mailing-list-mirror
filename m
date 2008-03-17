From: "Eric Raible" <raible@gmail.com>
Subject: gitk: synchronize highlighting in file view for 'f'&'b' commands
Date: Mon, 17 Mar 2008 13:00:55 -0700
Message-ID: <279b37b20803171300v748b5d23rcc5c0e534429d1be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Mar 17 21:02:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbLWw-0006yG-3J
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 21:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbYCQUBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 16:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbYCQUBM
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 16:01:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:19783 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbYCQUBL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 16:01:11 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2134342nfb.21
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=KqIU9bWLf76IwXOIZ7Q17lMIYnHAXT0tHwMCoFWv7rE=;
        b=uWFri+sF8DvUXwoa6GkFdOvRHM6R/a7VZlVbMuV5ZMkWm7XKtXgoHe2QrJ8Y8vIgCARaRcfDmb85KpqxJ2QzLsSb1AL16gQ1cNBdalWg7GkZFDSKNQYJ9g+kANx6OqiHX0mpMifzvSYzgoRycFiOR8wAR9scR1gOXvtcxZtuibM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D5JSpvK7WcfPv8fTTpOIDitIzLIRp0bVWwTQ83ZVgSmTaj6QduvNYcsGytB9o9Q4VOqM/ttyRCNb1X96uZz5KZmEBMxRNoFf4Wx0K7Iwu12X5hIr3f3hLlTNpNNWt0NwcET/kaKPZFwTCqhGh2Ld/WSKv0TMjbl/EU4hdeO6U+U=
Received: by 10.78.141.12 with SMTP id o12mr321458hud.22.1205784055805;
        Mon, 17 Mar 2008 13:00:55 -0700 (PDT)
Received: by 10.78.175.15 with HTTP; Mon, 17 Mar 2008 13:00:55 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77462>

Previously, 'b', backspace, and delete all did the same thing.
This changes 'b' to perform the inverse of 'f'.  And both of
them now highlight the filename of the currently diff.

This makes it easier to review and navigate the diffs associated
with a particular commit using only f, b, and space because the
filename of the currently display diff will be dynamically
highlighted.

Signed-off-by: Eric Raible <raible@gmail.com>
---
 gitk-git/gitk |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 84ab02e..51ba3ff 100644
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
@@ -5478,18 +5478,34 @@ proc changediffdisp {} {
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
-           $ctext yview $prev
+           highlightfile $prev
            return
        }
        set prev $loc
     }
-    $ctext yview $prev
 }

 proc nextfile {} {
@@ -5497,7 +5513,7 @@ proc nextfile {} {
     set here [$ctext index @0,0]
     foreach loc $difffilestart {
        if {[$ctext compare $loc > $here]} {
-           $ctext yview $loc
+           highlightfile $loc
            return
        }
     }
--
1.5.4.2.1161.g1a6f0
