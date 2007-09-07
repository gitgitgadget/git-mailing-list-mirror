From: Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
Subject: [PATCH] Button added to performs a GUI diff
Date: Sat, 08 Sep 2007 00:37:19 +0930
Message-ID: <46E16927.4070009@adelaide.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030000000303050106080801"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 17:22:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITffK-0004Qx-2S
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 17:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377AbXIGPWc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 11:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757089AbXIGPWc
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 11:22:32 -0400
Received: from bld-mail02.adl2.internode.on.net ([203.16.214.66]:33377 "EHLO
	mail.internode.on.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754814AbXIGPWb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 11:22:31 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Sep 2007 11:22:31 EDT
Received: from [192.168.1.100] (unverified [121.45.30.146]) 
	by mail.internode.on.net (SurgeMail 3.8f2) with ESMTP id 304708583-1927428 
	for <git@vger.kernel.org>; Sat, 08 Sep 2007 00:37:24 +0930 (CST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58042>

This is a multi-part message in MIME format.
--------------030000000303050106080801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here is an updated version of the previous patch to handle the various 
GUI merging tools.

Pierre

--------------030000000303050106080801
Content-Type: text/x-patch;
 name="gitk_0001-Button-added-to-performs-a-GUI-diff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gitk_0001-Button-added-to-performs-a-GUI-diff.patch"

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


--------------030000000303050106080801--
