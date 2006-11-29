X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH (take 3)] git blame -C: fix output format tweaks when crossing file boundary.
Date: Tue, 28 Nov 2006 22:32:00 -0800
Message-ID: <7vhcwiu5jz.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611282013430.3395@woody.osdl.org>
	<7vu00iu7lb.fsf@assigned-by-dhcp.cox.net>
	<7vmz6au626.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 06:32:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vmz6au626.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 28 Nov 2006 22:21:05 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32618>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpIzI-0003nf-Al for gcvg-git@gmane.org; Wed, 29 Nov
 2006 07:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935091AbWK2GcD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 01:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934989AbWK2GcD
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 01:32:03 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35989 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S935091AbWK2GcB
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 01:32:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061129063200.XPBF18207.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Wed, 29
 Nov 2006 01:32:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id sWXU1V00N1kojtg0000000; Wed, 29 Nov 2006
 01:31:28 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

We used to get the case that more than two paths came from the
same commit wrong when computing the output width and deciding
to turn on --show-name option automatically.  When we find that
lines that came from a path that is different from what we
started digging from, we should always turn --show-name on, and
we should count the name length for all files involved.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * BLUSH.  Both of the previous ones were botched.
   Third time lucky, hopefully.

 builtin-blame.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 066dee7..53fed45 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1435,14 +1435,14 @@ static void find_alignment(struct scoreboard *sb, int *option)
 		struct commit_info ci;
 		int num;
 
+		if (strcmp(suspect->path, sb->path))
+			*option |= OUTPUT_SHOW_NAME;
+		num = strlen(suspect->path);
+		if (longest_file < num)
+			longest_file = num;
 		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
 			suspect->commit->object.flags |= METAINFO_SHOWN;
 			get_commit_info(suspect->commit, &ci, 1);
-			if (strcmp(suspect->path, sb->path))
-				*option |= OUTPUT_SHOW_NAME;
-			num = strlen(suspect->path);
-			if (longest_file < num)
-				longest_file = num;
 			num = strlen(ci.author);
 			if (longest_author < num)
 				longest_author = num;
-- 
1.4.4.1.gad0c3-dirty

