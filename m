From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rerere: Fix removal of already resolved path.
Date: Thu, 04 Jan 2007 00:09:08 -0800
Message-ID: <7vlkkjmcwr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 04 09:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2Nf4-0004rT-Fx
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 09:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbXADIJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 03:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbXADIJP
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 03:09:15 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52032 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbXADIJP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 03:09:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070104080914.DVGI25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Thu, 4 Jan 2007 03:09:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6w9U1W00Y1kojtg0000000; Thu, 04 Jan 2007 03:09:29 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35923>

There was an obvious thinko in memmove() to remove an entry that
was resolved from the in-core data structure.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * If you were seeing mysterious "Cannot open" messages after
   "git merge", "git rebase", and "git am" runs, this should fix
   them.

 builtin-rerere.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 7442498..079c0bd 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -350,11 +350,10 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
 		copy_file(path, rr_path(name, "postimage"));
 tail_optimization:
-		if (i < rr->nr - 1) {
+		if (i < rr->nr - 1)
 			memmove(rr->items + i,
-					rr->items + i + 1,
-					rr->nr - i - 1);
-		}
+				rr->items + i + 1,
+				sizeof(rr->items[0]) * (rr->nr - i - 1));
 		rr->nr--;
 		i--;
 	}
