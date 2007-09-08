From: Unknown <unknown@unknown.invalid>
Subject: [PATCH] Button added to performs a GUI diff (inline)
Date: Sat, 8 Sep 2007 12:31:26 +0930
Message-ID: <200709081231.26894.pmdumuid@pezdell>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: pierre.dumuid@adelaide.edu.au
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 05:02:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITqa7-0006rR-Ra
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 05:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbXIHDBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 23:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbXIHDBw
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 23:01:52 -0400
Received: from bld-mail01.adl2.internode.on.net ([203.16.214.65]:39973 "EHLO
	mail.internode.on.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751081AbXIHDBw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 23:01:52 -0400
Received: from [192.168.1.100] (unverified [121.45.30.146]) 
	by mail.internode.on.net (SurgeMail 3.8f2) with ESMTP id 14189314-1927428 
	for multiple; Sat, 08 Sep 2007 12:31:45 +0930 (CST)
From: Pierre Marc Dumuid <pmdumuid@pezdell>
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58099>

>From bd43cca7aa88282455b6bbe6e2f9d8134da1029c Mon Sep 17 00:00:00 2001
From: Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
Date: Sat, 8 Sep 2007 00:32:10 +0930
Subject: [PATCH] Button added to performs a GUI diff

Signed-off-by: Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
---
 gitk |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 300fdce..b8b0b2e 100755
--- a/gitk
+++ b/gitk
@@ -737,7 +737,9 @@ proc makewindow {} {
 	-command changediffdisp -variable diffelide -value {1 0}
     label .bleft.mid.labeldiffcontext -text "      Lines of context: " \
 	-font $uifont
-    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
+    button .bleft.top.guidiff -text "GUI diff" -command doguidiff \
+	-font $uifont
+    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new .bleft.top.guidiff -side left
     spinbox .bleft.mid.diffcontext -width 5 -font $textfont \
 	-from 1 -increment 1 -to 10000000 \
 	-validate all -validatecommand "diffcontextvalidate %P" \
@@ -5332,6 +5334,48 @@ proc incrsearch {name ix op} {
     }
 }
 
+proc doguidiff {} {
+    global cflist sha1string
+
+    set taglist [$cflist tag ranges highlight]
+    set from [lindex $taglist 0]
+    set to [lindex $taglist 1]
+
+    set fname [$cflist get $from $to]
+
+    if {[catch {set merge_tool [exec git-config merge.tool]} err]} {
+	error_popup "Sorry, 'merge.tool' not defined in git-config"
+	return
+    }
+
+    if {[catch {exec git cat-file -p $sha1string^:$fname > .gitk_diffolder} err] 
+	|| [catch {exec git cat-file -p $sha1string:$fname > .gitk_diffnewer} err]} {
+	error_popup "Invalid file selected for comparison"
+	return
+    }
+
+    switch -regexp $merge_tool {
+	"kdiff3" {
+	    exec kdiff3 --L1 "$fname (Older)" --L2 "$fname (Newer)" .gitk_diffolder .gitk_diffnewer  &
+	}
+	"meld|opendiff|vimdiff|xxdiff" {
+	    exec $merge_tool .gitk_diffolder .gitk_diffnewer &
+	}
+	"tkdiff" {
+	    exec $merge_tool -L "$fname (Older)" -L "$fname (Newer)" .gitk_diffolder .gitk_diffnewer &
+	}
+	"vimdiff" {
+	    exec $merge_tool .gitk_diffolder .gitk_diffnewer 
+	}
+	"emerge" {
+	    exec emacs -f emerge-files-command .gitk_diffolder .gitk_diffnewer &
+	}
+	default {
+	    show_error {} "No merge.tool defined."
+	}
+    }
+} 
+
 proc dosearch {} {
     global sstring ctext searchstring searchdirn
 
-- 
1.5.2.4
