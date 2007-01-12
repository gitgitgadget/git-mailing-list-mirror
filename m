From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Fri, 12 Jan 2007 10:23:37 -0800
Message-ID: <7vr6u0t87q.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	<Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	<7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	<20070107163112.GA9336@steel.home>
	<7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
	<20070112184839.9431ddff.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 19:24:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5R4T-0007tA-3v
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 19:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbXALSXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 13:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbXALSXj
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 13:23:39 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46592 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964927AbXALSXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 13:23:38 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112182338.IBKL15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 13:23:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AJNm1W00R1kojtg0000000; Fri, 12 Jan 2007 13:22:46 -0500
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20070112184839.9431ddff.vsu@altlinux.ru> (Sergey Vlasov's
	message of "Fri, 12 Jan 2007 18:48:39 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36688>

Sergey Vlasov <vsu@altlinux.ru> writes:

> On Wed, 10 Jan 2007 11:28:14 -0800 Junio C Hamano wrote:
>
>> This revamps the merge-recursive implementation following the
>> outline in:
>> ...
> This commit broke t3401-rebase-partial.sh:
> ...
> ...and it is still used here - however, after the patch *result is
> uninitialized at this point.

Very true.  This untested patch should fix it.

Note that this stops (relative to the older
version of merge-recursive that always wrote a tree even when it
was not needed) reporting the tree object name for outermost
merge, but I think that reporting was primarily meant for people
who are debugging merge-recursive and did not have a real
value.  We could even remove the whole printf(), which I tend to
prefer.

--
diff --git a/merge-recursive.c b/merge-recursive.c
index 5237021..40c12aa 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1066,15 +1066,17 @@ static int merge_trees(struct tree *head,
 		path_list_clear(re_head, 0);
 		path_list_clear(entries, 1);
 
-	} else {
+	}
+	else
 		clean = 1;
+
+	if (index_only) {
+		*result = git_write_tree();
 		printf("merging of trees %s and %s resulted in %s\n",
 		       sha1_to_hex(head->object.sha1),
 		       sha1_to_hex(merge->object.sha1),
 		       sha1_to_hex((*result)->object.sha1));
 	}
-	if (index_only)
-		*result = git_write_tree();
 
 	return clean;
 }
