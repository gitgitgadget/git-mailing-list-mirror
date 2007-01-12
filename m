From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] merge-recursive: do not report the resulting tree object name
Date: Fri, 12 Jan 2007 12:09:56 -0800
Message-ID: <7v8xg8t3aj.fsf_-_@assigned-by-dhcp.cox.net>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	<Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	<7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	<20070107163112.GA9336@steel.home>
	<7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
	<20070112184839.9431ddff.vsu@altlinux.ru>
	<7vr6u0t87q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 12 21:10:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Sj5-0000tD-Lq
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 21:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbXALUJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 15:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbXALUJ7
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 15:09:59 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42229 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030241AbXALUJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 15:09:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112200957.ERTG3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 15:09:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AL951W00h1kojtg0000000; Fri, 12 Jan 2007 15:09:06 -0500
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <7vr6u0t87q.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 12 Jan 2007 10:23:37 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36699>

It is not available in the outermost merge, and it is only
useful for debugging merge-recursive in the inner merges.

Sergey Vlasov noticed that the old code accesses an
uninitialized location.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Junio C Hamano <junkio@cox.net> writes:

 > Very true.  This untested patch should fix it.
 >
 > Note that this stops (relative to the older
 > version of merge-recursive that always wrote a tree even when it
 > was not needed) reporting the tree object name for outermost
 > merge, but I think that reporting was primarily meant for people
 > who are debugging merge-recursive and did not have a real
 > value.  We could even remove the whole printf(), which I tend to
 > prefer.

 So I'd commit this -- I tested it this time, with

 	if (result) *result = NULL

 at the beginning of that function.

 merge-recursive.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5237021..b4acbb7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1066,13 +1066,10 @@ static int merge_trees(struct tree *head,
 		path_list_clear(re_head, 0);
 		path_list_clear(entries, 1);
 
-	} else {
-		clean = 1;
-		printf("merging of trees %s and %s resulted in %s\n",
-		       sha1_to_hex(head->object.sha1),
-		       sha1_to_hex(merge->object.sha1),
-		       sha1_to_hex((*result)->object.sha1));
 	}
+	else
+		clean = 1;
+
 	if (index_only)
 		*result = git_write_tree();
 
-- 
1.5.0.rc1.g397d
