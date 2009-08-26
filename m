From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git-gui: fix diff for partially staged submodule changes
Date: Wed, 26 Aug 2009 22:25:15 +0200
Message-ID: <4A959A2B.9080505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 26 22:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgP3e-00041F-GZ
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 22:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbZHZUZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 16:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbZHZUZP
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 16:25:15 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:59503 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbZHZUZO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 16:25:14 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id BB21210FBAAD6;
	Wed, 26 Aug 2009 22:25:15 +0200 (CEST)
Received: from [80.128.73.184] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1MgP3T-0008Sn-00; Wed, 26 Aug 2009 22:25:15 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1//4lue6Ck9zt+sO2UUBV/6ktJC8PW8LasuhtC0
	KMQAROiDoUtchlDAg2uAx7rTNHrZKN4eF1doiYSB4E68Wh/tQZ
	YCL1tRhAjsuMlW5IQO4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127116>

When a submodule commit had already been staged and another commit had
been checked out inside the submodule, the diff always displayed the
submodule commit log messages between the last supermodule commit and
the working tree, totally ignoring the commit in the index.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

This fixes a regression introduced by this recent patch of mine:
"git-gui: display summary when showing diff of a submodule"

Sorry for the inconvenience.


 git-gui/lib/diff.tcl |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index ae1ea3a..d593323 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -298,7 +298,12 @@ proc start_show_diff {cont_info {add_opts {}}} {

 	if {[string match {160000 *} [lindex $s 2]]
         || [string match {160000 *} [lindex $s 3]]} {
-		set cmd {submodule summary -- $current_diff_path}
+		set is_submodule_diff 1
+		if {$w eq $ui_index} {
+			set cmd {submodule summary --cached -- $current_diff_path}
+		} else {
+			set cmd {submodule summary --files -- $current_diff_path}
+		}
 	}

 	if {[catch {set fd [eval git_read --nice $cmd]} err]} {
@@ -343,9 +348,6 @@ proc read_diff {fd cont_info} {
 		}
 		set ::current_diff_inheader 0

-		if {[regexp {^\* } $line]} {
-			set is_submodule_diff 1
-		}
 		# -- Automatically detect if this is a 3 way diff.
 		#
 		if {[string match {@@@ *} $line]} {set is_3way_diff 1}
-- 
1.6.4.184.ge7b6.dirty
