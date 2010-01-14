From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH RESEND2] git gui: Use git diff --submodule when available
Date: Thu, 14 Jan 2010 23:41:51 +0100
Message-ID: <4B4F9DAF.30909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 23:42:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVYOC-00043E-CQ
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 23:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab0ANWlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 17:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141Ab0ANWlz
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 17:41:55 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:46907 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab0ANWly (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 17:41:54 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 3CEF2144FADD4;
	Thu, 14 Jan 2010 23:41:52 +0100 (CET)
Received: from [80.128.55.33] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NVYNz-0006sz-00; Thu, 14 Jan 2010 23:41:51 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18HP93CRYlZJ2RjvRp2arvcRh3pUZN82lEobPwp
	U4vH4YQh+jO5U4MyiQZ56QwiuITYfpS9C15HGhrjIUPi7ZPq/X
	BxV5maQJmYcxg+EJdgUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137033>

Changed the use of submodule summary to diff --submodule because the
implementation in C is much faster than the submodule script. Also a test
has been added to make sure that the underlying git supports the diff
option --submodule (which was introduced in 1.6.6).

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Did not hear anything about my last resend on December 28th, so i try
again.

To explain what i mean by "much faster", here are the numbers (best of
three) for a small repo with a changed submodule (git checkout HEAD^)
under Linux:


time git submodule summary
<snip>

real	0m0.219s
user	0m0.050s
sys	0m0.111s


time git diff --submodule
<snip>

real	0m0.012s
user	0m0.003s
sys	0m0.009s


In my experience this patch changes the user experience from
"a noticeable delay" to "instantaneous".


 git-gui/lib/diff.tcl |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index bd5d189..0623e3e 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -281,6 +281,14 @@ proc start_show_diff {cont_info {add_opts {}}} {
 		}
 	}

+	if {[git-version >= "1.6.6"]} {
+		if {[string match {160000 *} [lindex $s 2]]
+		    || [string match {160000 *} [lindex $s 3]]} {
+			set is_submodule_diff 1
+			lappend cmd --submodule
+		}
+	}
+
 	lappend cmd -p
 	lappend cmd --no-color
 	if {$repo_config(gui.diffcontext) >= 1} {
@@ -296,16 +304,6 @@ proc start_show_diff {cont_info {add_opts {}}} {
 		lappend cmd $path
 	}

-	if {[string match {160000 *} [lindex $s 2]]
-        || [string match {160000 *} [lindex $s 3]]} {
-		set is_submodule_diff 1
-		if {$w eq $ui_index} {
-			set cmd [list submodule summary --cached -- $path]
-		} else {
-			set cmd [list submodule summary --files -- $path]
-		}
-	}
-
 	if {[catch {set fd [eval git_read --nice $cmd]} err]} {
 		set diff_active 0
 		unlock_index
@@ -387,8 +385,7 @@ proc read_diff {fd cont_info} {
 			}
 		} elseif {$is_submodule_diff} {
 			if {$line == ""} continue
-			if {[regexp {^\* } $line]} {
-				set line [string replace $line 0 1 {Submodule }]
+			if {[regexp {^Submodule } $line]} {
 				set tags d_@
 			} else {
 				set op [string range $line 0 2]
-- 
1.6.6.rc2.274.g2cee7
