From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] gitk: Fix "git gui blame" invocation when called from topdir
Date: Sun, 21 Jun 2009 19:34:11 +0200
Message-ID: <1245605651-27001-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Jun 21 19:36:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIQxj-0000MK-Is
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 19:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbZFURgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 13:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbZFURgE
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 13:36:04 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:52539 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbZFURgD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 13:36:03 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id AEA411042DA1D;
	Sun, 21 Jun 2009 19:36:04 +0200 (CEST)
Received: from [89.59.120.52] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MIQvp-0003A7-00; Sun, 21 Jun 2009 19:34:17 +0200
X-Mailer: git-send-email 1.6.3.2.369.gdf06
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121989>

In this case "git rev-parse --git-dir" doesn't return an absolute path,
but merely ".git", so the selected file has a relative path.
The function make_relative then tries to make the already relative path
relative, which results in a path like "../../../../Makefile" with as
much ".." as the number of parts [pwd] consists of.

This regression was introduced by commit 9712b81 (gitk: Fix bugs in
blaming code, 2008-12-06), which fixed "git gui blame" when called from
subdirs.

This also fixes it for bare repositories.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

    For convencience the output of diff -w:

    @@ -3366,6 +3366,7 @@ proc index_sha1 {fname} {
    
     # Turn an absolute path into one relative to the current directory
     proc make_relative {f} {
    +    if {[file pathtype $f] ne "relative"} {
         set elts [file split $f]
         set here [file split [pwd]]
         set ei 0
    @@ -3381,6 +3382,9 @@ proc make_relative {f} {
         }
         set elts [concat $res [lrange $elts $ei end]]
         return [eval file join $elts]
    +    } else {
    +       return $f
    +    }
     }
    
     proc external_blame {parent_idx {line {}}} {


    While fixing this I also noticed that the tree view treats pwd as the
    topdir, so it shows directly .gitignore instead of po/.gitignore for
    example.

 gitk |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/gitk b/gitk
index 4604c83..46d7782 100755
--- a/gitk
+++ b/gitk
@@ -3366,21 +3366,25 @@ proc index_sha1 {fname} {
 
 # Turn an absolute path into one relative to the current directory
 proc make_relative {f} {
-    set elts [file split $f]
-    set here [file split [pwd]]
-    set ei 0
-    set hi 0
-    set res {}
-    foreach d $here {
-	if {$ei < $hi || $ei >= [llength $elts] || [lindex $elts $ei] ne $d} {
-	    lappend res ".."
-	} else {
-	    incr ei
+    if {[file pathtype $f] ne "relative"} {
+	set elts [file split $f]
+	set here [file split [pwd]]
+	set ei 0
+	set hi 0
+	set res {}
+	foreach d $here {
+	    if {$ei < $hi || $ei >= [llength $elts] || [lindex $elts $ei] ne $d} {
+		lappend res ".."
+	    } else {
+		incr ei
+	    }
+	    incr hi
 	}
-	incr hi
+	set elts [concat $res [lrange $elts $ei end]]
+	return [eval file join $elts]
+    } else {
+	return $f
     }
-    set elts [concat $res [lrange $elts $ei end]]
-    return [eval file join $elts]
 }
 
 proc external_blame {parent_idx {line {}}} {
-- 
1.6.3.2.369.gdf06
