From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] merge-index: fix longstanding bug in merging symlinks
Date: Sun, 25 Feb 2007 18:46:18 -0800
Message-ID: <7vy7mlpret.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 26 03:46:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLVsc-00071T-6z
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 03:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933699AbXBZCqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 21:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933736AbXBZCqU
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 21:46:20 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:45094 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933699AbXBZCqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 21:46:19 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070226024620.HZD3767.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 21:46:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U2mJ1W00Q1kojtg0000000; Sun, 25 Feb 2007 21:46:19 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40606>

Ancient commit e2b6a9d0 added code to pass "file modes" from
merge-index to merge-one-file, and then later commit 54dd99a1
wanted to make sure we do not end up creating a nonsense symlink
that points at a path whose name contains conflict markers.

However, nobody that the code in merge-index added by e2b6a9d0
were stripping the S_IFMT bits so the code in 54dd99a1 was
meaningless.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 merge-index.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-index.c b/merge-index.c
index a9983dd..7027d78 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -60,7 +60,7 @@ static int merge_entry(int pos, const char *path)
 			break;
 		found++;
 		strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
-		sprintf(ownbuf[stage], "%o", ntohl(ce->ce_mode) & (~S_IFMT));
+		sprintf(ownbuf[stage], "%o", ntohl(ce->ce_mode));
 		arguments[stage] = hexbuf[stage];
 		arguments[stage + 4] = ownbuf[stage];
 	} while (++pos < active_nr);
-- 
1.5.0.1.793.gedfd5
