From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH RESEND] Teach gitk to display dirty submodules correctly
Date: Fri, 09 Apr 2010 22:16:42 +0200
Message-ID: <4BBF8B2A.5090208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 22:16:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0KdF-0000S8-Uk
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 22:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794Ab0DIUQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 16:16:45 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:34145 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961Ab0DIUQo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 16:16:44 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 3BA83156451FF;
	Fri,  9 Apr 2010 22:16:43 +0200 (CEST)
Received: from [80.128.86.62] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O0Kd8-00078J-00; Fri, 09 Apr 2010 22:16:42 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18GoXWT4dvMp6jH2D2uDsC8MfgdXmx+cX6uxbgW
	iJYhPAkfb20v6M5Ja+QDGtPxw+8cjz6MFy7Y7d63Fjvr0fThfo
	ahWQ8q4nVl2xIaOx8bOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144467>

Since recently "git diff --submodule" prints out extra lines when the
submodule contains untracked or modified files. Show all those lines of
one submodule under the same header.

Also for newly added or removed submodules the submodule name contained
trailing garbage because the extraction of the name was not done right.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

I didn't receive a response in the last two weeks, so here is a resend.

No need to test for the version of the underlying git here, as the
string "Submodule" does not appear in the diff output when older git
versions are used and the changed code is not executed at all in this
case (except for setting the new "currdiffsubmod" variable to the
empty string, but that doesn't have any negative side effects).

 gitk-git/gitk |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1f36a3e..36a9dcf 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7501,7 +7501,7 @@ proc getblobdiffs {ids} {
     global ignorespace
     global limitdiffs vfilelimit curview
     global diffencoding targetline diffnparents
-    global git_version
+    global git_version currdiffsubmod

     set textconv {}
     if {[package vcompare $git_version "1.6.1"] >= 0} {
@@ -7528,6 +7528,7 @@ proc getblobdiffs {ids} {
     set diffencoding [get_path_encoding {}]
     fconfigure $bdf -blocking 0 -encoding binary -eofchar {}
     set blobdifffd($ids) $bdf
+    set currdiffsubmod ""
     filerun $bdf [list getblobdiffline $bdf $diffids]
 }

@@ -7598,7 +7599,7 @@ proc getblobdiffline {bdf ids} {
     global diffnexthead diffnextnote difffilestart
     global ctext_file_names ctext_file_lines
     global diffinhdr treediffs mergemax diffnparents
-    global diffencoding jump_to_here targetline diffline
+    global diffencoding jump_to_here targetline diffline currdiffsubmod

     set nr 0
     $ctext conf -state normal
@@ -7679,19 +7680,30 @@ proc getblobdiffline {bdf ids} {

 	} elseif {![string compare -length 10 "Submodule " $line]} {
 	    # start of a new submodule
-	    if {[string compare [$ctext get "end - 4c" end] "\n \n\n"]} {
+	    if {[regexp -indices "\[0-9a-f\]+\\.\\." $line nameend]} {
+		set fname [string range $line 10 [expr [lindex $nameend 0] - 2]]
+	    } else {
+		set fname [string range $line 10 [expr [string first "contains " $line] - 2]]
+	    }
+	    if {$currdiffsubmod != $fname} {
 		$ctext insert end "\n";     # Add newline after commit message
 	    }
 	    set curdiffstart [$ctext index "end - 1c"]
 	    lappend ctext_file_names ""
-	    set fname [string range $line 10 [expr [string last " " $line] - 1]]
-	    lappend ctext_file_lines $fname
-	    makediffhdr $fname $ids
-	    $ctext insert end "\n$line\n" filesep
+	    if {$currdiffsubmod != $fname} {
+		lappend ctext_file_lines $fname
+		makediffhdr $fname $ids
+		set currdiffsubmod $fname
+		$ctext insert end "\n$line\n" filesep
+	    } else {
+		$ctext insert end "$line\n" filesep
+	    }
 	} elseif {![string compare -length 3 "  >" $line]} {
+	    set $currdiffsubmod ""
 	    set line [encoding convertfrom $diffencoding $line]
 	    $ctext insert end "$line\n" dresult
 	} elseif {![string compare -length 3 "  <" $line]} {
+	    set $currdiffsubmod ""
 	    set line [encoding convertfrom $diffencoding $line]
 	    $ctext insert end "$line\n" d0
 	} elseif {$diffinhdr} {
@@ -8527,7 +8539,7 @@ proc do_cmp_commits {a b} {
 }

 proc diffcommits {a b} {
-    global diffcontext diffids blobdifffd diffinhdr
+    global diffcontext diffids blobdifffd diffinhdr currdiffsubmod

     set tmpdir [gitknewtmpdir]
     set fna [file join $tmpdir "commit-[string range $a 0 7]"]
@@ -8548,6 +8560,7 @@ proc diffcommits {a b} {
     set diffids [list commits $a $b]
     set blobdifffd($diffids) $fd
     set diffinhdr 0
+    set currdiffsubmod ""
     filerun $fd [list getblobdiffline $fd $diffids]
 }

-- 
1.7.0.2.448.g45e29
