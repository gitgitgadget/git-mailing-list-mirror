From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 2/3] gitk: do not parse "  >" context as submodule
 change
Date: Thu, 15 Apr 2010 21:57:22 +0200
Message-ID: <4BC76FA2.3030204@web.de>
References: <cover.1271260308.git.trast@student.ethz.ch> <5531510bfb94997f729a894a0b5a3158177a9add.1271260308.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:57:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2VBo-0004j5-RZ
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464Ab0DOT5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:57:25 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:34155 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756328Ab0DOT5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 15:57:24 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9480B14D96440;
	Thu, 15 Apr 2010 21:57:23 +0200 (CEST)
Received: from [80.128.60.61] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O2VBj-0005CJ-00; Thu, 15 Apr 2010 21:57:23 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <5531510bfb94997f729a894a0b5a3158177a9add.1271260308.git.trast@student.ethz.ch>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/Rgh4HOznswy5OIqi9PQCqHcR6QaXxL5HiFAxt
	S36N+d0qeNrqbnK7qVHajnUOckB6faMhx6snjL4KKV805BXlQI
	6z2NoozjtIJwnCcZySCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145019>

Am 14.04.2010 17:59, schrieb Thomas Rast:
> Since 5c838d2 (gitk: Use the --submodule option for displaying diffs
> when available, 2009-10-28) gitk erroneously matches "  >" and "  <"
> at the beginning of a line in the submodule code even if we're in the
> diff text section and the lines should be treated as context.
> 
> Fix by (ab)using the $diffinhdr variable also in the 'Submodule...'
> case, and move the "  >"/"  <" specific code inside the $diffinhdr
> test.  The existing code will set $diffinhdr to 0 when it hits a
> "+++", so that it is always 0 when we can hit a context line.

Thanks for fixing this issue I accidentally introduced!

In that said patch I unfortunately also managed to screw up the
submodule name detection when it was not followed just by commits
(but e.g. by "contains untracked content"). I did already send a
patch to address this issue, but here is a rebased version on top
of your patch series just in case:

--------------------8<--------------------
From: Jens Lehmann <Jens.Lehmann@web.de>
Date: Thu, 15 Apr 2010 21:53:12 +0200
Subject: [PATCH] Teach gitk to display dirty submodules correctly

Since 1.7.1 "git diff --submodule" prints out extra lines when the
submodule contains untracked or modified files. Show all those lines for
one submodule under the same header.

Also e.g. for newly added or removed submodules the submodule name
contained trailing garbage because the extraction of the name was not
done right. Now it scans either for the first hex number followed by a
".." or the string "contains ".

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 gitk-git/gitk |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index f2a1eb7..93d25ec 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7530,7 +7530,7 @@ proc getblobdiffs {ids} {
     global worddiff
     global limitdiffs vfilelimit curview
     global diffencoding targetline diffnparents
-    global git_version
+    global git_version currdiffsubmod

     set textconv {}
     if {[package vcompare $git_version "1.6.1"] >= 0} {
@@ -7560,6 +7560,7 @@ proc getblobdiffs {ids} {
     set diffencoding [get_path_encoding {}]
     fconfigure $bdf -blocking 0 -encoding binary -eofchar {}
     set blobdifffd($ids) $bdf
+    set currdiffsubmod ""
     filerun $bdf [list getblobdiffline $bdf $diffids]
 }

@@ -7631,7 +7632,7 @@ proc getblobdiffline {bdf ids} {
     global ctext_file_names ctext_file_lines
     global diffinhdr treediffs mergemax diffnparents
     global diffencoding jump_to_here targetline diffline
-    global worddiff
+    global worddiff currdiffsubmod

     set nr 0
     $ctext conf -state normal
@@ -7712,15 +7713,24 @@ proc getblobdiffline {bdf ids} {

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
 	    # pretend we're in a file header to correctly parse "  [><]"
 	    set diffinhdr 1
 	} elseif {$diffinhdr} {
@@ -8588,7 +8598,7 @@ proc do_cmp_commits {a b} {
 }

 proc diffcommits {a b} {
-    global diffcontext diffids blobdifffd diffinhdr
+    global diffcontext diffids blobdifffd diffinhdr currdiffsubmod

     set tmpdir [gitknewtmpdir]
     set fna [file join $tmpdir "commit-[string range $a 0 7]"]
@@ -8609,6 +8619,7 @@ proc diffcommits {a b} {
     set diffids [list commits $a $b]
     set blobdifffd($diffids) $fd
     set diffinhdr 0
+    set currdiffsubmod ""
     filerun $fd [list getblobdiffline $fd $diffids]
 }

-- 
1.7.1.rc1.252.gff9f
