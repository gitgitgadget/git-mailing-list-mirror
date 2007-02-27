From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] diff-lib.c: Ignore type differences if the filesystem does not support symlinks.
Date: Tue, 27 Feb 2007 22:41:40 +0100
Message-ID: <11726125062739-git-send-email-johannes.sixt@telecom.at>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at> <11726125033437-git-send-email-johannes.sixt@telecom.at> <1172612504272-git-send-email-johannes.sixt@telecom.at> <11726125052184-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 22:41:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMA58-0000yR-J5
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbXB0Vlu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbXB0Vlu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:41:50 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:46980 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbXB0Vls (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:41:48 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 8AC1797636;
	Tue, 27 Feb 2007 22:41:46 +0100 (CET)
X-Mailer: git-send-email 1.5.0.19.gddff
In-Reply-To: <11726125052184-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40812>

If core.symlinks = false, the diff engine now compares the symlink in the
index or in the database with the file contents on disk (instead of insisting
in a symlink in the working copy).

As a side effect, git status now reports a change as "modified" instead of
"typechange".

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 diff-lib.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 60c0fa6..3a12f65 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -134,6 +134,9 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
 		    S_ISREG(newmode) && S_ISREG(oldmode) &&
 		    ((newmode ^ oldmode) == 0111))
 			newmode = oldmode;
+		else if (!trust_symlink_fmt &&
+		    S_ISREG(newmode) && S_ISLNK(oldmode))
+			newmode = oldmode;
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    ce->sha1, (changed ? null_sha1 : ce->sha1),
 			    ce->name, NULL);
-- 
1.5.0.19.gddff
