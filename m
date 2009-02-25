From: Dirk Wallenstein <halsmit@t-online.de>
Subject: [PATCH 1/3] git-show-branch: allow for multiple branch head columns
Date: Wed, 25 Feb 2009 11:17:18 +0100
Message-ID: <fa82452302afa700e7cbbacbf2d58a8c188a0c62.1235499771.git.halsmit@t-online.de>
References: <cover.1235499771.git.halsmit@t-online.de>
Cc: Dirk Wallenstein <halsmit@t-online.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 11:38:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcHA8-0000So-OQ
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 11:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757426AbZBYKhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 05:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbZBYKhY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 05:37:24 -0500
Received: from mailout03.t-online.de ([194.25.134.81]:53405 "EHLO
	mailout03.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051AbZBYKhX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 05:37:23 -0500
Received: from fwd03.aul.t-online.de 
	by mailout03.sul.t-online.de with smtp 
	id 1LcGpd-0002UC-01; Wed, 25 Feb 2009 11:17:37 +0100
Received: from localhost.localdomain (Z4U31MZ-YheL3Ue8pdQzwDSZl0Z-SDZtZR4spgxriwCbHrHiB3vAZzveRaHNbWCQss@[84.139.85.50]) by fwd03.t-online.de
	with esmtp id 1LcGpL-0Hjvd40; Wed, 25 Feb 2009 11:17:19 +0100
X-Mailer: git-send-email 1.6.1
In-Reply-To: <cover.1235499771.git.halsmit@t-online.de>
In-Reply-To: <cover.1235499771.git.halsmit@t-online.de>
References: <cover.1235499771.git.halsmit@t-online.de>
X-ID: Z4U31MZ-YheL3Ue8pdQzwDSZl0Z-SDZtZR4spgxriwCbHrHiB3vAZzveRaHNbWCQss
X-TOI-MSGID: 355eeada-78fe-44f6-bbd3-462be1a16b76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111442>

If multiple refs point to the current branch head, each of them
should show a '*' in the corresponding column. This commit changes
this information about columns from an absolute index to a bitmask.
---
 builtin-show-branch.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 306b850..df83491 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -604,7 +604,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int sha1_name = 0;
 	int shown_merge_point = 0;
 	int with_current_branch = 0;
-	int head_at = -1;
+	unsigned int head_at = 0;
 	int topics = 0;
 	int dense = 1;
 	int reflog = 0;
@@ -855,8 +855,10 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			else
 				puts(reflog_msg[i]);
 
-			if (is_head)
-				head_at = i;
+			if (is_head) {
+				assert(MAX_REVS <= (sizeof(head_at) * 8));
+				head_at |= (1UL << i);
+			}
 		}
 		if (0 <= extra) {
 			for (i = 0; i < num_rev; i++)
@@ -900,7 +902,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 					mark = ' ';
 				else if (is_merge)
 					mark = '-';
-				else if (i == head_at)
+				else if (head_at & (1UL << i))
 					mark = '*';
 				else
 					mark = '+';
-- 
1.6.1
