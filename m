From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH RESEND] git gui: Use git diff --submodule when available
Date: Mon, 28 Dec 2009 17:22:57 +0100
Message-ID: <4B38DB61.7000801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 17:23:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPIND-0002j4-Em
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 17:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbZL1QXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 11:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbZL1QXG
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 11:23:06 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:45061 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZL1QXE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 11:23:04 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6BC4413AD7E41;
	Mon, 28 Dec 2009 17:23:01 +0100 (CET)
Received: from [80.128.87.19] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NPIN3-00028Y-00; Mon, 28 Dec 2009 17:23:01 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18HA39ogoTjSFFoGbWmbOV61sxyWTBN2H40ZSKH
	PPOL6huJMb6+pHtv7CxRB4gLGnKGEojz36RrbApD5iMvT6Y3eV
	8yDGpPIK+0x7UNaQfumg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135745>

Changed the use of submodule summary to diff --submodule because the
implementation in C is much faster than the submodule script. Also a test
has been added to make sure that the underlying git supports the diff
option --submodule (which was introduced in 1.6.6).

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
1.6.6.rc2.274.g2cee7
