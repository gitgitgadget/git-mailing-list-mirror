From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH/RFC 2/2 v2] git-gui: Do not automatically stage file after merge tool finishes
Date: Wed, 24 Sep 2008 21:08:01 +0200
Message-ID: <200809242108.01616.johannes.sixt@telecom.at>
References: <200808310052.21595.angavrilov@gmail.com> <bb6f213e0809170525q286f5d42xfd734660dc935cbf@mail.gmail.com> <20080924175033.GZ3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexander Gavrilov <angavrilov@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 21:09:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiZjh-0001Cd-LA
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 21:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbYIXTII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 15:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbYIXTIH
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 15:08:07 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:41133 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbYIXTIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 15:08:06 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id B02CC13A3C9;
	Wed, 24 Sep 2008 21:08:02 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0A8E21D23A;
	Wed, 24 Sep 2008 21:08:02 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080924175033.GZ3669@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96682>

If a merge tool was invoked on a conflicted file and the tool completed,
then the conflicted file was staged automatically. However, the fact that
the user closed the merge tool cannot be understood as the unequivocal
sign that the conflict was completely resolved. For example, the user
could have decided to postpone the resolution of the conflict, or could
have accidentally closed the tool. We better leave the file unstaged and
let the user stage it explicitly.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
On Mittwoch, 24. September 2008, Shawn O. Pearce wrote:
> Alexander Gavrilov <angavrilov@gmail.com> wrote:
> > You also cannot simply remove merge_add_resolution, because then it
> > would leave the diff view stale.
>
> Is it just a matter of calling reshow_diff instead?

Indeed. I'd tried do_rescan, but reshow_diff does it, too, and it doesn't
mess with the file lists!

This version of the patch also removes the check whether the merge tool
had modified the file, because now we don't do anything with the file
anyway.

-- Hannes

 lib/mergetool.tcl |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index 965cfe4..f292f30 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -348,14 +348,6 @@ proc merge_tool_finish {fd} {
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
@@ -368,6 +360,6 @@ proc merge_tool_finish {fd} {
 
 		delete_temp_files $mtool_tmpfiles
 
-		merge_add_resolution $mtool_target
+		reshow_diff
 	}
 }
-- 
1.6.0.2.295.g3898d
