From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-diff: fix combined diff
Date: Thu, 22 Feb 2007 22:09:45 -0800
Message-ID: <7v3b4xbe1i.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702230517480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vbqjlbg8y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 07:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKTct-0008KY-Ad
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 07:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbXBWGJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 01:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbXBWGJr
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 01:09:47 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36863 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbXBWGJq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 01:09:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223060947.USTY6078.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Feb 2007 01:09:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Su9l1W00T1kojtg0000000; Fri, 23 Feb 2007 01:09:46 -0500
In-Reply-To: <7vbqjlbg8y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 22 Feb 2007 21:22:05 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40418>

Junio C Hamano <junkio@cox.net> writes:

> With this,
>
> 	$ git diff maint master next pu
>
> starts working as planned ;-).

By the way, your commit log message does not seem to say
why it is a fix correctly.  Here is what I replaced it with.

-- >8 -- cut here -- >8 --
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date: Fri, 23 Feb 2007 05:20:32 +0100
Subject: [PATCH] git-diff: fix combined diff

The code forgets that typecast binds tighter than addition, in
other words:

    (cast *)array + i  === ((cast *)array) + i

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-diff.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index a659020..c387ebb 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -192,7 +192,8 @@ static int builtin_diff_combined(struct rev_info *revs,
 	parent = xmalloc(ents * sizeof(*parent));
 	/* Again, the revs are all reverse */
 	for (i = 0; i < ents; i++)
-		hashcpy((unsigned char*)parent + i, ent[ents - 1 - i].item->sha1);
+		hashcpy((unsigned char *)(parent + i),
+			ent[ents - 1 - i].item->sha1);
 	diff_tree_combined(parent[0], parent + 1, ents - 1,
 			   revs->dense_combined_merges, revs);
 	return 0;
-- 
1.5.0.1.619.g04c5c
