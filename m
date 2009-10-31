From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH resend] gitk: Fix "git gui blame" invocation when called from topdir
Date: Sat, 31 Oct 2009 13:09:34 +0100
Message-ID: <1256990974-32671-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 13:09:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Cm9-0000uS-DP
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 13:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757669AbZJaMJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 08:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757645AbZJaMJf
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 08:09:35 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:32779 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757621AbZJaMJe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 08:09:34 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id A95161356395E;
	Sat, 31 Oct 2009 13:09:38 +0100 (CET)
Received: from [89.59.96.177] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N4Cm2-0002PB-00; Sat, 31 Oct 2009 13:09:38 +0100
X-Mailer: git-send-email 1.6.5.2.155.gaa0e5
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/JQDSUMGC0n/gnFKhO+ZzfIE281r1cRAhg4jp0
	CAc8WYhIeYP2+6aVUdhZqMUvn0XJypbO9qaIsDGZ/rmHV4zGFx
	vTGCdXFHdu640k2wZ4+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131843>

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
 gitk |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/gitk b/gitk
index a0214b7..07a9440 100755
--- a/gitk
+++ b/gitk
@@ -3377,21 +3377,25 @@ proc index_sha1 {fname} {
 
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
1.6.5.2.155.gaa0e5
