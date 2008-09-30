From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-gui: Do not automatically stage file after merge tool
 finishes
Date: Tue, 30 Sep 2008 08:43:11 +0200
Message-ID: <48E1CA7F.5050501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Alexander Gavrilov <angavrilov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 08:44:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkYy7-0002lC-79
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 08:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbYI3GnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 02:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbYI3GnO
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 02:43:14 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18225 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYI3GnN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 02:43:13 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KkYwx-00060Z-Ei; Tue, 30 Sep 2008 08:43:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 33F954FB; Tue, 30 Sep 2008 08:43:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97069>

From: Johannes Sixt <johannes.sixt@telecom.at>

If a merge tool was invoked on a conflicted file and the tool completed,
then the conflicted file was staged automatically. However, the fact that
the user closed the merge tool cannot be understood as the unequivocal
sign that the conflict was completely resolved. For example, the user
could have decided to postpone the resolution of the conflict, or could
have accidentally closed the tool. We better leave the file unstaged and
let the user stage it explicitly.

Since the file is not staged anyway, the check for an unmodified
timestamp is pointless and removed.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 I had sent this patch last week (but marked as RFC). Here it is again
 without 'RFC' because I think it is a necessary change.

 -- Hannes

 lib/mergetool.tcl |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index 6ab5701..8d1ee5b 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -375,14 +375,6 @@ proc merge_tool_finish {fd} {
 		}
 	}

-	# Check the modification time of the target file
-	if {!$failed && [file mtime $mtool_target] eq $mtool_mtime} {
-		if {[ask_popup [mc "File %s unchanged, still accept as resolved?" \
-				[short_path $mtool_target]]] ne {yes}} {
-			set failed 1
-		}
-	}
-
 	# Finish
 	if {$failed} {
 		file rename -force -- $backup $mtool_target
@@ -395,6 +387,6 @@ proc merge_tool_finish {fd} {

 		delete_temp_files $mtool_tmpfiles

-		merge_add_resolution $mtool_target
+		reshow_diff
 	}
 }
-- 
1.6.0.2.1262.ge466e
