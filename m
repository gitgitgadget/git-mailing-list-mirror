From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 1/2] git-gui: Fix "Stage/Unstage Line" with one line of context.
Date: Tue, 15 Jul 2008 23:11:00 +0200
Message-ID: <1216156261-9687-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 23:12:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIrob-0006Ff-IA
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 23:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbYGOVLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 17:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbYGOVLG
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 17:11:06 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:54991 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYGOVLF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 17:11:05 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 8673E33BAB;
	Tue, 15 Jul 2008 23:11:01 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.3.323.g1e58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88595>

To "Stage/Unstage Line" we construct a patch that contains exactly one
change (either addition or removal); the hunk header was forged by counting
the old side and adjusting the count by +/-1 for the new side. But when we
counted the context we never counted the changed line itself. If the hunk
had only one removal line and one line of context, like this:

    @@ -1,3 +1,2 @@
     context 1
    -removal
     context 2

We had constructed this patch:

    @@ -1,2 +1,1 @@
     context 1
    -removal
     context 2

which does not apply because git apply deduces that it must apply at the
end of the file. ("context 2" is considered garbage and ignored.) The fix
is that removal lines must be counted towards the context of the old side.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 lib/diff.tcl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 96ba949..ee7f391 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -423,6 +423,9 @@ proc apply_line {x y} {
 			# the line to stage/unstage
 			set ln [$ui_diff get $i_l $next_l]
 			set patch "$patch$ln"
+			if {$c1 eq {-}} {
+				set n [expr $n+1]
+			}
 		} elseif {$c1 ne {-} && $c1 ne {+}} {
 			# context line
 			set ln [$ui_diff get $i_l $next_l]
-- 
1.5.6.3.323.g1e58
