From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix read-tree merging more than 3 trees using 3-way merge
Date: Thu, 16 Aug 2007 20:38:30 -0700
Message-ID: <7v7inuj0eh.fsf@gitster.siamese.dyndns.org>
References: <600399.61066.qm@web52807.mail.re2.yahoo.com>
	<7vbqd8o1qs.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708161750550.30176@woody.linux-foundation.org>
	<7vbqd6j4a0.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708161930100.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Perrin Meyer <perrinmeyer@yahoo.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 05:38:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILsfc-00041G-UY
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 05:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbXHQDih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 23:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbXHQDih
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 23:38:37 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbXHQDig (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 23:38:36 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4914D122CA1;
	Thu, 16 Aug 2007 23:38:54 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708161930100.30176@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 16 Aug 2007 19:32:34 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56043>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 16 Aug 2007, Junio C Hamano wrote:
>>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> > 
>> > Sorry. I didn't even realize people did this. Oops.
>> 
>> This is no big deal.  It would have triggered if you are using
>> resolve strategy _and_ did a multi merge-base merge, the former
>> of which is quite unusual these days.
>
> Yeah, ok. I see what's up. 

So no worries.  It was triggered by an error in t1000 test.

-- >8 --
[PATCH] Clean-up read-tree error condition.

This is a follow-up to f34f2b0b; list_tree() function is where it
first notices that the command line fed too many trees for us to
handle, so move the error exit message to there, and raise the
MAX_TREES to 8 (not that it matters very much in practice).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-read-tree.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index f6764b9..43cd56a 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -13,7 +13,7 @@
 #include "dir.h"
 #include "builtin.h"
 
-#define MAX_TREES 4
+#define MAX_TREES 8
 static int nr_trees;
 static struct tree *trees[MAX_TREES];
 
@@ -21,8 +21,8 @@ static int list_tree(unsigned char *sha1)
 {
 	struct tree *tree;
 
-	if (nr_trees >= 4)
-		return -1;
+	if (nr_trees >= MAX_TREES)
+		die("I cannot read more than %d trees", MAX_TREES);
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		return -1;
@@ -264,9 +264,6 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			opts.head_idx = 1;
 	}
 
-	if (MAX_TREES < nr_trees)
-		die("I cannot read more than %d trees", MAX_TREES);
-
 	for (i = 0; i < nr_trees; i++) {
 		struct tree *tree = trees[i];
 		parse_tree(tree);
-- 
1.5.3.rc5
