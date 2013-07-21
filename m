From: Andreas Amann <a.amann@ucc.ie>
Subject: [PATCH] gitk: Add a "Save file as" menu item
Date: Sun, 21 Jul 2013 13:38:45 +0100
Message-ID: <87ppuculyi.fsf@msstf091.ucc.ie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Jul 21 14:39:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0sue-0006lA-Ul
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 14:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab3GUMix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 08:38:53 -0400
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:22846
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754945Ab3GUMiw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jul 2013 08:38:52 -0400
Received: from mail93-co1-R.bigfish.com (10.243.78.228) by
 CO1EHSOBE015.bigfish.com (10.243.66.78) with Microsoft SMTP Server id
 14.1.225.22; Sun, 21 Jul 2013 12:38:50 +0000
Received: from mail93-co1 (localhost [127.0.0.1])	by mail93-co1-R.bigfish.com
 (Postfix) with ESMTP id 7A4BAA00395;	Sun, 21 Jul 2013 12:38:50 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:143.239.1.23;KIP:(null);UIP:(null);IPV:NLI;H:mail3.ucc.ie;RD:mail3.ucc.ie;EFVD:NLI
X-SpamScore: 0
X-BigFish: VPS0(zzzz1f42h208ch1ee6h1de0h1d18h1fdah2073h1202h1e76h1d1ah1d2ah1fc6hzz1de098h1de097hz2fh2a8h668h839hd24he5bhf0ahfa3h107ah11b5h121eh1288h12a5h12a9h12bdh12e5h137ah13b6h1441h14afh1504h1537h153bh162dh1631h1758h18e1h1946h19b5h1b0ah1d0ch1d2eh1d3fh1dc1h1dfeh1dffh1e1dh1155h)
Received-SPF: pass (mail93-co1: domain of ucc.ie designates 143.239.1.23 as permitted sender) client-ip=143.239.1.23; envelope-from=a.amann@ucc.ie; helo=mail3.ucc.ie ;mail3.ucc.ie ;
Received: from mail93-co1 (localhost.localdomain [127.0.0.1]) by mail93-co1
 (MessageSwitch) id 137441032816762_31262; Sun, 21 Jul 2013 12:38:48 +0000
 (UTC)
Received: from CO1EHSMHS013.bigfish.com (unknown [10.243.78.249])	by
 mail93-co1.bigfish.com (Postfix) with ESMTP id EA8D94C0049;	Sun, 21 Jul 2013
 12:38:47 +0000 (UTC)
Received: from mail3.ucc.ie (143.239.1.23) by CO1EHSMHS013.bigfish.com
 (10.243.66.23) with Microsoft SMTP Server (TLS) id 14.16.227.3; Sun, 21 Jul
 2013 12:38:47 +0000
Received: from msstf091.ucc.ie (msstf091.ucc.ie [143.239.76.91])	by
 mail3.ucc.ie (8.14.4/8.14.4) with ESMTP id r6LCcjxL029698;	Sun, 21 Jul 2013
 13:38:45 +0100
Received: by msstf091.ucc.ie (Postfix, from userid 1000)	id 3302BA0939; Sun,
 21 Jul 2013 13:38:45 +0100 (IST)
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
X-OriginatorOrg: ucc.ie
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230927>

Previously, there was no easy way to save a particular file from the
currently selected revision.

This patch adds a menu item "Save file as" to the file list popup
menu, which opens a file selection dialog to determine the name under
which a file should be saved.  The default filename is of the form
"[shortid] basename".  If the current revision is the index, the
default pattern is of the form "[index] basename".  This works for
both, the "Patch" and "Tree" view.  The menu item is disabled for the
"local uncommitted changes" fake revision.

Signed-off-by: Andreas Amann <andreas.amann@web.de>
---
 gitk | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/gitk b/gitk
index 5cd00d8..dbedaf6 100755
--- a/gitk
+++ b/gitk
@@ -2595,6 +2595,7 @@ proc makewindow {} {
 	{mc "Highlight this too" command {flist_hl 0}}
 	{mc "Highlight this only" command {flist_hl 1}}
 	{mc "External diff" command {external_diff}}
+	{mc "Save file as" command {save_file_as}}
 	{mc "Blame parent commit" command {external_blame 1}}
     }
     $flist_menu configure -tearoff 0
@@ -3378,6 +3379,7 @@ proc sel_flist {w x y} {
 proc pop_flist_menu {w X Y x y} {
     global ctext cflist cmitmode flist_menu flist_menu_file
     global treediffs diffids
+    global nullid
 
     stopfinding
     set l [lindex [split [$w index "@$x,$y"] "."] 0]
@@ -3395,6 +3397,12 @@ proc pop_flist_menu {w X Y x y} {
     }
     # Disable "External diff" item in tree mode
     $flist_menu entryconf 2 -state $xdiffstate
+    set savefilestate "normal"
+    if {[lindex $diffids 0] eq $nullid} {
+	set savefilestate "disabled"
+    }
+    # Disable "Save file as" item for worktree
+    $flist_menu entryconf 3 -state $savefilestate
     tk_popup $flist_menu $X $Y
 }
 
@@ -3496,6 +3504,28 @@ proc external_diff_get_one_file {diffid filename diffdir} {
 	       "revision $diffid"]
 }
 
+proc save_file_as {} {
+    global nullid nullid2
+    global flist_menu_file
+    global diffids
+
+    set diffid [lindex $diffids 0]
+    if {$diffid == $nullid} {
+	return
+    } elseif {$diffid == $nullid2} {
+	set diffidtext "\[index\]"
+	set diffid ""
+    } else {
+	set diffidtext "\[[shortids $diffid]\]"
+    }
+    set difffile "$diffidtext [file tail $flist_menu_file]"
+    set difffile [tk_getSaveFile -initialfile $difffile -title "Save file as" -parent .]
+    if {$difffile eq {}} {
+	return
+    }
+    save_file_from_commit $diffid:$flist_menu_file $difffile "revision $diffid"
+}
+
 proc external_diff {} {
     global nullid nullid2
     global flist_menu_file
-- 
1.8.3.1
