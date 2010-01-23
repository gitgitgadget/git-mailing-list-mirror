From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH (resend 3)] git gui: Use git diff --submodule when available
Date: Sat, 23 Jan 2010 23:04:12 +0100
Message-ID: <4B5B725C.6060301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 23 23:05:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYo79-0003eg-8q
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 23:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab0AWWEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 17:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523Ab0AWWEP
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 17:04:15 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:51776 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab0AWWEO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 17:04:14 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 2F2FB145794B6;
	Sat, 23 Jan 2010 23:04:13 +0100 (CET)
Received: from [80.128.48.239] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NYo5U-0002pB-00; Sat, 23 Jan 2010 23:04:12 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19xldMtdPyiO1k4tnK5q5gY12KctmXnvl0Bmme6
	bjJxReqGJa6GNC5GgMTq/CavbVLlYU0pHbgsgHs1F8WV28cleq
	skcQB9MuKWvLua1KCyqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137865>

The necessary feature is present since 1.6.6, it would be good
to have this patch in the next release (see numbers below).

Shawn, This is a third re-send, in case you missed the previous
rounds. Thanks.

-- >8 --
Subject: [PATCH] git gui: Use git diff --submodule when available

Doing so is much faster and gives the same output. Here are some
numbers:

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


Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
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
1.6.6.1.558.gc20e6.dirty
