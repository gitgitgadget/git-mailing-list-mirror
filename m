From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 2/2] git-gui: change to display the combined diff in the case of conflicts.
Date: Wed, 31 Mar 2010 02:34:49 +1100
Message-ID: <1269963289-480-2-git-send-email-jon.seymour@gmail.com>
References: <1269963289-480-1-git-send-email-jon.seymour@gmail.com>
Cc: git@vger.kernel.org, spearce@spearce.org, j.sixt@viscovery.net
To: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 30 17:44:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwdc7-00049m-1Q
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 17:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab0C3PoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 11:44:17 -0400
Received: from outbound.icp-qv1-irony-out5.iinet.net.au ([203.59.1.105]:38094
	"EHLO outbound.icp-qv1-irony-out5.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752218Ab0C3PoQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 11:44:16 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Mar 2010 11:44:13 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvYFAHu3sUt8qoyc/2dsb2JhbACPP4FOiiJxr3mCK4R9LYhRhQAE
X-IronPort-AV: E=Sophos;i="4.51,334,1267372800"; 
   d="scan'208";a="122256064"
Received: from unknown (HELO localhost.localdomain) ([124.170.140.156])
  by outbound.icp-qv1-irony-out5.iinet.net.au with ESMTP; 30 Mar 2010 23:34:51 +0800
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1269963289-480-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143572>

The rationale for this change is that the previous behaviour did not allow
the user to make an informed decision about the likely consequences
of "Use Local Version", "Stage to commit" or "Use Remote Version" for conflicted files. The
reason for this is that in the conflicted case, successfully staged
remote hunks are effectively invisible to user (via the git-gui interface)
and hence cannot inform the user's decision making process.

For example, previously use of "Use Local Version" would silently discard
from the index, and the working tree any successfully merged remote hunks.
Since these hunks had never been displayed to the user, this
loss would be unnoticed and unexpected.

In the case of "Stage to commit", the successfully merged remote
hunks would be preserved in the index and the working tree but the fact
that there are successfully merged remote hunks would not be not
visible until after the "Stage to commit" action has been taken.
If the user did not check diff _after_ taking the action, the user
may have unwittingly commit changes from a remote hunk
that she was not aware of.

Similar coniderations also imply that the probable consequences
of "Use Remote Version" cannot be properly evaluated since the changes
in the local branch that would be undone by accepting the remote
branch's version of the file would are not visible to the user.

With this change, in the case of conflicted paths only, the git-gui diff window
displays the output of git diff -c. This output allows the user to properly
evaluate the consequences of the possible resolution actions.

Previous versions of this patch uses "diff HEAD" instead of "diff".
This version uses "diff -c" at the suggestion of Johannes Sixt.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-gui/lib/diff.tcl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index e7b1986..693830f 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -300,7 +300,11 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 	if {$w eq $ui_index} {
 		lappend cmd [PARENT]
-	}
+	} else {
+		if {$is_unmerged} {
+			lappend cmd -c 
+		}
+        }
 	if {$add_opts ne {}} {
 		eval lappend cmd $add_opts
 	} else {
-- 
1.6.6.1
