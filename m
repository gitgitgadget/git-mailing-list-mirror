From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] gitk: Use the --submodule option for diffs
Date: Tue, 27 Oct 2009 15:59:21 +0100
Message-ID: <4AE70AC9.6040302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 15:59:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2nWF-0007UT-6w
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 15:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbZJ0O7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 10:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754722AbZJ0O7V
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 10:59:21 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:54975 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617AbZJ0O7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 10:59:20 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 81A4713985419;
	Tue, 27 Oct 2009 15:59:24 +0100 (CET)
Received: from [80.128.59.71] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1N2nW6-0001F8-00; Tue, 27 Oct 2009 15:59:22 +0100
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19fG/h5KYwQX8jjm7UOBhaEIi+F7AMtZfpLPfkC
	hZJeYcC4nFgOZMxuDhOh42DDFN/oM4rX222D/L0ISElcvwT7hr
	1acWAetwp7AqSPTdCNSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131345>

Instead of just showing not-quite-helpful SHA-1 pairs display the first
lines of the corresponding commit messages in the submodule (similar to
the output of 'git submodule summary').

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

This patch applies to 'next' and uses the new --submodule option of git
diff to achieve a more meaningful output of submodule differences in
gitk.

Any objections against making this the default?

(for those interested: a version of git gui with similar functionality
is available in 'master' of Shawn's repo but not yet merged).


 gitk-git/gitk |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a0214b7..5e2572d 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7207,7 +7207,7 @@ proc diffcmd {ids flags} {
     if {$i >= 0} {
 	if {[llength $ids] > 1 && $j < 0} {
 	    # comparing working directory with some specific revision
-	    set cmd [concat | git diff-index $flags]
+	    set cmd [concat | git diff-index --submodule $flags]
 	    if {$i == 0} {
 		lappend cmd -R [lindex $ids 1]
 	    } else {
@@ -7215,13 +7215,13 @@ proc diffcmd {ids flags} {
 	    }
 	} else {
 	    # comparing working directory with index
-	    set cmd [concat | git diff-files $flags]
+	    set cmd [concat | git diff-files --submodule $flags]
 	    if {$j == 1} {
 		lappend cmd -R
 	    }
 	}
     } elseif {$j >= 0} {
-	set cmd [concat | git diff-index --cached $flags]
+	set cmd [concat | git diff-index --cached --submodule $flags]
 	if {[llength $ids] > 1} {
 	    # comparing index with specific revision
 	    if {$i == 0} {
@@ -7234,7 +7234,7 @@ proc diffcmd {ids flags} {
 	    lappend cmd HEAD
 	}
     } else {
-	set cmd [concat | git diff-tree -r $flags $ids]
+	set cmd [concat | git diff-tree -r --submodule $flags $ids]
     }
     return $cmd
 }
@@ -7481,6 +7481,21 @@ proc getblobdiffline {bdf ids} {
 	    set diffnparents [expr {[string length $ats] - 1}]
 	    set diffinhdr 0

+	} elseif {![string compare -length 10 "Submodule " $line]} {
+	    # start of a new submodule
+	    if {[string compare [$ctext get "end - 4c" end] "\n \n\n"]} {
+		$ctext insert end "\n";     # Add newline after commit message
+	    }
+	    set curdiffstart [$ctext index "end - 1c"]
+	    lappend ctext_file_names ""
+	    set fname [string range $line 10 [expr [string last " " $line] - 1]]
+	    lappend ctext_file_lines $fname
+	    makediffhdr $fname $ids
+	    $ctext insert end "\n$line\n" filesep
+	} elseif {![string compare -length 3 "  >" $line]} {
+	    $ctext insert end "$line\n" dresult
+	} elseif {![string compare -length 3 "  <" $line]} {
+	    $ctext insert end "$line\n" d0
 	} elseif {$diffinhdr} {
 	    if {![string compare -length 12 "rename from " $line]} {
 		set fname [string range $line [expr 6 + [string first " from " $line] ] end]
-- 
1.6.5.2.182.g338ab.dirty
