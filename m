From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Mon, 04 Feb 2008 11:08:47 -0800
Message-ID: <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
References: <20080202122135.GA5783@code-monkey.de>
	<20080203030054.GA18654@coredump.intra.peff.net>
	<20080203043310.GA5984@coredump.intra.peff.net>
	<alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 20:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM6hK-0001Ct-5U
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 20:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914AbYBDTJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 14:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755648AbYBDTJH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 14:09:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382AbYBDTJF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 14:09:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F09774C22;
	Mon,  4 Feb 2008 14:09:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 571E74BFC;
	Mon,  4 Feb 2008 14:08:58 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 4 Feb 2008 09:32:15 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72551>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I think the real problem here is not that the logic is wrong in 
> general, but that there is one *special* case where the logic to break out 
> is wrong.
>
> And that special case is when we hit the root commit which isn't negative.
>
> That case is special because *normally*, if we have a positive commit, we 
> will always continue to walk the parents of that positive commit, so the 
> "everybody_interesting()" check will not trigger. BUT! If we hit a root 
> commit and it is positive, that won't happen (since, by definition, it has 
> no parents to keep the list populated with), and now we break out early.
>
> So I think your fix is wrong, but it's "close" to right: I suspect that we 
> can fix it by marking the "we hit the root commit" case, and just 
> disabling it for that case.

Ahh, I was preparing a response that begins with "Wow, a joy of
working in a mailing list with people more clever than me!  It's
so obvious but I did not think of it."  I've written something
like that more than a few times on this list responding to
several people, I think.

However, I am afraid that is not quite enough.  It is not just
"when we hit the root".

Consider the same topology in the small test (1-2-3-4) but with
three additional commits:

         B---C
        /
    ---A---1---2---3---4

Again, 2-3-4 are in nice chronological order, but 1 has the
younguest timestamp, and A-B-C are all younger than 1.

	$ rev-list 1 ^4 ^A
        $ rev-list 1 ^4 ^B

These two would both mark A as uninteresting while processing
the command line (revision.c::handle_commit()).  When we pop 1
off, the call to add_parents_to_list() for it will not add
anything positive back.

	$ rev-list 1 ^4 ^C

This would not mark A as uninteresting immediately, but by the
time 1 gets its turn, A is marked uninteresting.

So I think the rule to notice this situation with "hit-root"
flag is something like:

    when we pop a positive commit that does not have any
    positive parent left (root is a special case of this), and
    the negative parents were contaminated either by:

        (1) being listed as negative on the command line or being a
            direct parent of a negative commit listed on the
            command line; or by

        (2) traversing the list of negative commits who are all
            younger than the positive commit in question.

---

 t/t6009-rev-list-parent.sh |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index be3d238..0bb5ac4 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -16,6 +16,14 @@ test_expect_success setup '
 	touch file &&
 	git add file &&
 
+	commit zero &&
+	commit A &&
+	commit B &&
+	commit C &&
+
+	git reset --hard A &&
+
+	test_tick=$(($test_tick - 1200))
 	commit one &&
 
 	test_tick=$(($test_tick - 2400))
@@ -27,9 +35,33 @@ test_expect_success setup '
 	git log --pretty=oneline --abbrev-commit
 '
 
-test_expect_failure 'one is ancestor of others and should not be shown' '
+test_expect_failure '"zero ^four" should be empty' '
+
+	git rev-list zero --not four >result &&
+	>expect &&
+	diff -u expect result
+
+'
+
+test_expect_failure '"one ^four ^A" should be empty' '
+
+	git rev-list one --not four A >result &&
+	>expect &&
+	diff -u expect result
+
+'
+
+test_expect_failure '"one ^four ^B should be empty' '
+
+	git rev-list one --not four B >result &&
+	>expect &&
+	diff -u expect result
+
+'
+
+test_expect_failure '"one ^four ^C should be empty' '
 
-	git rev-list one --not four >result &&
+	git rev-list one --not four C >result &&
 	>expect &&
 	diff -u expect result
 
