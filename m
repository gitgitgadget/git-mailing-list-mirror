From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-format-patch -3
Date: Wed, 17 Jan 2007 13:35:13 -0800
Message-ID: <7vk5zlqqum.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 17 22:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7IRM-00027g-KH
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 22:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbXAQVfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 16:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbXAQVfQ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 16:35:16 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:44297 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbXAQVfO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 16:35:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070117213513.NNON16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 16:35:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CMbW1W0171kojtg0000000; Wed, 17 Jan 2007 16:35:31 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37042>

This teaches "git-format-patch" to honor the --max-count
parameter revision traversal machinery takes, so that you can
say "git-format-patch -3" to process the three topmost commits
from the current HEAD (or "git-format-patch -2 topic" to name a
specific branch).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I think this is incompatible with --ignore-if-upstream, which
   I haven't bothered to look into yet.

   Likes, dislikes?

 builtin-log.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 1cd9d3f..9453e6d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -482,8 +482,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (rev.pending.nr == 1) {
-		rev.pending.objects[0].item->flags |= UNINTERESTING;
-		add_head(&rev);
+		if (rev.max_count < 0) {
+			rev.pending.objects[0].item->flags |= UNINTERESTING;
+			add_head(&rev);
+		}
+		/* Otherwise, it is "format-patch -22 HEAD", and
+		 * get_revision() would return only the specified count.
+		 */
 	}
 
 	if (ignore_if_in_upstream)
