From: Csaba Kiraly <kiraly@disi.unitn.it>
Subject: [PATCH 1/2] git-gui: fix problem with "important" files not shown
 if, gui.maxfilesdisplayed is exceeded
Date: Thu, 23 Oct 2014 15:37:25 +0200
Message-ID: <54490495.2010200@disi.unitn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Dan Zwell <dzwell@zwell.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Csaba Kiraly <kiraly@fbk.eu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 15:47:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhIjL-0005oS-Nr
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 15:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbaJWNrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 09:47:04 -0400
Received: from mail3.unitn.it ([193.205.206.24]:60563 "EHLO mail3.unitn.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbaJWNrC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 09:47:02 -0400
Received: from mail3.unitn.it (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id 89BDDC0752_449049BB;
	Thu, 23 Oct 2014 13:37:31 +0000 (GMT)
Received: from mailhub1.unitn.it (mailhub1.unitn.it [192.168.206.46])
	by mail3.unitn.it (Sophos Email Appliance) with ESMTP id 30B00BBDFD_449049BF;
	Thu, 23 Oct 2014 13:37:31 +0000 (GMT)
Received: from disi.unitn.it (disi.unitn.it [193.205.194.4])
	by mailhub1.unitn.it (Postfix) with ESMTP id 1E137AE5466;
	Thu, 23 Oct 2014 15:37:31 +0200 (CEST)
Received: by disi.unitn.it  with ESMTP id s9NDbPZt012660;Thu, 23 Oct 2014 15:37:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gui.maxfilesdisplayed (added in dd6451f9c7c5a36d3006231b618ac6da06c7c7b4)
was applied brute force on the file list in alphabetic order. As a result,
files that had modifications might not be displayed by git-gui. Even
worse, files that are already in the index might not be displayed, which
makes git-gui unusable.

This fix changes the meaning of gui.maxfilesdisplayed, making it a soft
limit that only applies to "_O" files, i.e. files that are "Untracked,
not staged".

Signed-off-by: Csaba Kiraly <kiraly@disi.unitn.it>
---
 git-gui.sh | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index bf68699..f86a948 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1967,20 +1967,22 @@ proc display_all_files {} {
 
     set to_display [lsort [array names file_states]]
     set display_limit [get_config gui.maxfilesdisplayed]
-    if {[llength $to_display] > $display_limit} {
-        if {!$files_warning} {
-            # do not repeatedly warn:
-            set files_warning 1
-            info_popup [mc "Displaying only %s of %s files." \
-                $display_limit [llength $to_display]]
-        }
-        set to_display [lrange $to_display 0 [expr {$display_limit-1}]]
-    }
+    set displayed 0
     foreach path $to_display {
         set s $file_states($path)
         set m [lindex $s 0]
         set icon_name [lindex $s 1]
 
+        if {$displayed > $display_limit && [string index $m 1] eq {O} } {
+            if {!$files_warning} {
+                # do not repeatedly warn:
+                set files_warning 1
+                info_popup [mc "Displaying only %s of %s files." \
+                    $display_limit [llength $to_display]]
+            }
+            continue
+        }
+
         set s [string index $m 0]
         if {$s ne {U} && $s ne {_}} {
             display_all_files_helper $ui_index $path \
@@ -1995,6 +1997,7 @@ proc display_all_files {} {
         if {$s ne {_}} {
             display_all_files_helper $ui_workdir $path \
                 $icon_name $s
+            incr displayed
         }
     }
 
-- 
1.9.1
