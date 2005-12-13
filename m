From: Junio C Hamano <junkio@cox.net>
Subject: Re: Delitifier broken (Re: diff-core segfault)
Date: Mon, 12 Dec 2005 17:08:20 -0800
Message-ID: <7vlkypdcsb.fsf@assigned-by-dhcp.cox.net>
References: <1134404990.5928.4.camel@localhost.localdomain>
	<7vmzj6i206.fsf@assigned-by-dhcp.cox.net>
	<7virtui1kj.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512121620380.26663@localhost.localdomain>
	<7vek4igevq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512121529200.15597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 02:09:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElyeX-0004YR-6z
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 02:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVLMBIX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 20:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVLMBIW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 20:08:22 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:29886 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932319AbVLMBIW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 20:08:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051213010741.UJAB15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 20:07:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13555>

Linus Torvalds <torvalds@osdl.org> writes:

> Do what pack-objects.c does: just call "diff_delta()" and check the result 
> for NULL. If the result is NULL, then you have to do some special code, 
> because that means that it's a full create or a full delete (or it's an 
> unchanged empty file). Regardless, it really _is_ a special case, and it 
> would be silly to generate a delta for it.

When the result is NULL, it could be delta against empty, or
other failure in diff_delta() (could be it exceeded max_size,
could be it could not allocate memory, could be we introduced
some other failure modes later...).

I'll revert the changes anyway, but not because I necessarily
agree with you two.  I am not 100% confident that the core of
the diff_delta code would work fine with empty input (it seems
to from my limited test), and I do not want to break things
unnecessarily at this point.  More importantly, for the updated
delta code that allows empty input to work, the codepaths the
various existing callers that check with NULL must not be
assuming non-NULL return means non empty input -- otherwise my
change would subtly break things -- and I do not have enough
energy to verify that right now.

Since we do not break files smaller than MINIMUM_BREAK_SIZE,
this becomes a non-issue with the attached patch.  I do not know
why I did not check both sides when I did it the first time; I
do not know why I was too stupid to notice that the earlier test
in the if() was far more expensive than the later one, either ;-).

-- >8 --
diff --git a/diffcore-break.c b/diffcore-break.c
index e6a468e..9b27456 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -55,12 +55,6 @@ static int should_break(struct diff_file
 			     * is the default.
 			     */
 
-	if (!S_ISREG(src->mode) || !S_ISREG(dst->mode))
-		return 0; /* leave symlink rename alone */
-
-	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
-		return 0; /* error but caught downstream */
-
 	base_size = ((src->size < dst->size) ? src->size : dst->size);
 
 	delta = diff_delta(src->data, src->size,
@@ -169,9 +163,15 @@ void diffcore_break(int break_score)
 		if (DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two) &&
 		    !S_ISDIR(p->one->mode) && !S_ISDIR(p->two->mode) &&
 		    !strcmp(p->one->path, p->two->path)) {
-			if (should_break(p->one, p->two,
-					 break_score, &score) &&
-			    MINIMUM_BREAK_SIZE <= p->one->size) {
+			
+			if (S_ISREG(p->one->mode) &&
+			    S_ISREG(p->two->mode) &&
+			    !diff_populate_filespec(p->one, 0) &&
+			    MINIMUM_BREAK_SIZE <= p->one->size &&
+			    !diff_populate_filespec(p->two, 0) &&
+			    MINIMUM_BREAK_SIZE <= p->two->size &&
+			    should_break(p->one, p->two,
+					 break_score, &score)) {
 				/* Split this into delete and create */
 				struct diff_filespec *null_one, *null_two;
 				struct diff_filepair *dp;
