From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI)] git-gui: Make Ctrl-T safe to use for conflicting files.
Date: Tue, 30 Sep 2008 12:12:16 +0400
Organization: HOME
Message-ID: <200809301212.17080.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 10:19:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkaNv-0004UH-1n
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 10:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbYI3INw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 04:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbYI3INv
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 04:13:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:37608 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbYI3INu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 04:13:50 -0400
Received: by ug-out-1314.google.com with SMTP id k3so520337ugf.37
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VLxHCfaja+muGWNGyo1zjOVXSjyhGV1lL8buLMt3RIc=;
        b=DZZx3pBEqWCZk3Fj9wh6DDhHjW3PaTXHZZJOY8zct7fLskzS+m0C/fybiMrWXzIZya
         5VtkfMLT3D0Ro7eysaX47JUgwXc1gtzrz0oiXr7nYgxaaO9Fs1oJEiz9W5vEPxY7TNqA
         VSe5P00GEs/Hqz5P5T7LyMqBE4AYUZhoi+nKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=tRSRJWb6+Wrz1TfRBzIJDpXHfGM4Rr8xTx87SJjcTcwIg0YNdCIYsramccM17F0ENY
         gYWIojMD5q/3vokwK19IU1dPObAYwz9kLEor6/wmdCl2BMBq0IeRkNdt0MBxv+ry5x8o
         ag0rmbIlYIdeeIPjaQDblZWvDBfER+jRktgmI=
Received: by 10.103.203.4 with SMTP id f4mr4608000muq.8.1222762428294;
        Tue, 30 Sep 2008 01:13:48 -0700 (PDT)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id w5sm6685566mue.10.2008.09.30.01.13.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 01:13:47 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.3-29.fc9.i686; KDE/4.1.1; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97079>

A previous patch added a check for conflict markers, which
is done when the file is about to be staged due to a click
on the icon. However, pressing Ctrl-T still immediately
stages the file without confirmation. This patch fixes it.

The check requires a loaded diff, so staging multiple files
at once won't work if they are unmerged.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

 git-gui.sh        |    4 +++-
 lib/index.tcl     |   11 +++++++++--
 lib/merge.tcl     |    1 +
 lib/mergetool.tcl |    7 ++++---
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 4085e8f..717817e 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2090,7 +2090,9 @@ proc toggle_or_diff {w x y} {
 	if {$col == 0 && $y > 1} {
 		# Conflicts need special handling
 		if {[string first {U} $state] >= 0} {
-			merge_stage_workdir $path $w $lno
+			# $w must always be $ui_workdir, but...
+			if {$w ne $ui_workdir} { set lno {} }
+			merge_stage_workdir $path $lno
 			return
 		}
 
diff --git a/lib/index.tcl b/lib/index.tcl
index b045219..d33896a 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -298,11 +298,18 @@ proc add_helper {txt paths} {
 	set after {}
 	foreach path $paths {
 		switch -glob -- [lindex $file_states($path) 0] {
+		_U -
+		U? {
+			if {$path eq $current_diff_path} {
+				unlock_index
+				merge_stage_workdir $path
+				return
+			}
+		}
 		_O -
 		?M -
 		?D -
-		?T -
-		U? {
+		?T {
 			lappend pathList $path
 			if {$path eq $current_diff_path} {
 				set after {reshow_diff;}
diff --git a/lib/merge.tcl b/lib/merge.tcl
index 5c01875..ac4c7de 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -40,6 +40,7 @@ The rescan will be automatically started now.
 		_O {
 			continue; # and pray it works!
 		}
+		_U
 		U? {
 			error_popup [mc "You are in the middle of a conflicted merge.
 
diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index 6ab5701..1984c64 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -23,13 +23,14 @@ This operation can be undone only by restarting the merge." \
 	}
 }
 
-proc merge_stage_workdir {path w lno} {
+proc merge_stage_workdir {path {lno {}}} {
 	global current_diff_path diff_active
+	global current_diff_side ui_workdir
 
 	if {$diff_active} return
 
-	if {$path ne $current_diff_path} {
-		show_diff $path $w $lno {} [list do_merge_stage_workdir $path]
+	if {$path ne $current_diff_path || $ui_workdir ne $current_diff_side} {
+		show_diff $path $ui_workdir $lno {} [list do_merge_stage_workdir $path]
 	} else {
 		do_merge_stage_workdir $path
 	}
-- 
1.6.0.20.g6148bc
