From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI FIX)] git-gui: Fix Blame Parent & Context for working copy lines.
Date: Mon, 8 Sep 2008 11:18:52 +0400
Organization: HOME
Message-ID: <200809081118.52705.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 09:21:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcb3n-0003X8-Bt
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 09:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbYIHHUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 03:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbYIHHUF
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 03:20:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:19927 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbYIHHUD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 03:20:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1382916fgg.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AzBX7MLYYsr/ymavltU7Fwedc7YfpGGoyWrn3pjUcf0=;
        b=bfwOm48GBA7OJy98eTXn5+U77aTsxw7bxkc3tsV/UjkljmGS/BNcXwIiSTYuyW2QQJ
         9nAYudMUprGp3pN3RQw0db6ILYu70qyUB2AJfiw3+H/TI2lRDNs22yrYKCckDu4Ek2dj
         GGwEXpPqyZaiGSVBQJXw5iwUMODdhJUfFl8YY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=YCXeKaCAcQUPcJ0TAjOvXZjjgGhE+zBAE9Oa8gJxx/PrIwevGilRHZTPGVdUT2w5jS
         8oq2SOL9yYsDqS4r1uBC0GF0AzBVp/0sPm8/fWn39i+dZc7kTrFh4MuDWhEc7FWcNzVm
         OFh3hGiewtuOeA2BkRo7zfP1jrXBfxUHWkVMw=
Received: by 10.86.27.19 with SMTP id a19mr11002785fga.56.1220858402009;
        Mon, 08 Sep 2008 00:20:02 -0700 (PDT)
Received: from ?192.168.100.3? ( [92.255.85.78])
        by mx.google.com with ESMTPS id d6sm4111341fga.2.2008.09.08.00.20.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 00:20:01 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95222>

Make Blame Parent Commit and Show History Context work
properly for lines blamed on the working copy.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	Currently it displays an ugly error box.

	-- Alexander

 git-gui.sh    |    3 +++
 lib/blame.tcl |   29 ++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 57a0c34..f249b0b 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1061,6 +1061,9 @@ set current_diff_path {}
 set is_3way_diff 0
 set selected_commit_type new
 
+set nullid "0000000000000000000000000000000000000000"
+set nullid2 "0000000000000000000000000000000000000001"
+
 ######################################################################
 ##
 ## task management
diff --git a/lib/blame.tcl b/lib/blame.tcl
index b5fc9fa..84d55b5 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -939,9 +939,20 @@ method _format_offset_date {base offset} {
 }
 
 method _gitkcommit {} {
+	global nullid
+
 	set dat [_get_click_amov_info $this]
 	if {$dat ne {}} {
 		set cmit [lindex $dat 0]
+
+		# If the line belongs to the working copy, use HEAD instead
+		if {$cmit eq $nullid} {
+			if {[catch {set cmit [git rev-parse --verify HEAD]} err]} {
+				error_popup [strcat [mc "Cannot find HEAD commit:"] "\n\n$err"]
+				return;
+			}
+		}
+
 		set radius [get_config gui.blamehistoryctx]
 		set cmdline [list --select-commit=$cmit]
 
@@ -978,12 +989,20 @@ method _gitkcommit {} {
 }
 
 method _blameparent {} {
+	global nullid
+
 	set dat [_get_click_amov_info $this]
 	if {$dat ne {}} {
 		set cmit [lindex $dat 0]
 		set new_path [lindex $dat 1]
 
-		if {[catch {set cparent [git rev-parse --verify "$cmit^"]}]} {
+		# Allow using Blame Parent on lines modified in the working copy
+		if {$cmit eq $nullid} {
+			set parent_ref "HEAD"
+		} else {
+			set parent_ref "$cmit^"
+		}
+		if {[catch {set cparent [git rev-parse --verify $parent_ref]} err]} {
 			error_popup [strcat [mc "Cannot find parent commit:"] "\n\n$err"]
 			return;
 		}
@@ -993,8 +1012,12 @@ method _blameparent {} {
 		# Generate a diff between the commit and its parent,
 		# and use the hunks to update the line number.
 		# Request zero context to simplify calculations.
-		if {[catch {set fd [eval git_read diff-tree \
-				--unified=0 $cparent $cmit $new_path]} err]} {
+		if {$cmit eq $nullid} {
+			set diffcmd [list diff-index --unified=0 $cparent -- $new_path]
+		} else {
+			set diffcmd [list diff-tree --unified=0 $cparent $cmit -- $new_path]
+		}
+		if {[catch {set fd [eval git_read $diffcmd]} err]} {
 			$status stop [mc "Unable to display parent"]
 			error_popup [strcat [mc "Error loading diff:"] "\n\n$err"]
 			return
-- 
1.6.0.20.g6148bc
