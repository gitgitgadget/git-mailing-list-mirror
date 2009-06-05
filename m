From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] bisect: when skipping, choose a commit away from a skipped commit
Date: Thu, 04 Jun 2009 23:48:44 -0700
Message-ID: <7vmy8np44z.fsf@alter.siamese.dyndns.org>
References: <20090605040238.8885.92790.chriscool@tuxfamily.org>
	<20090605041044.8885.92104.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 08:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCTES-0003eD-Am
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 08:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbZFEGso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 02:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbZFEGsn
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 02:48:43 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62764 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbZFEGsm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 02:48:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090605064844.FXHO17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jun 2009 02:48:44 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 06ok1c0054aMwMQ036okiL; Fri, 05 Jun 2009 02:48:44 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=4e42I7BXjMAA:10 a=8Hn-nT45BrsA:10
 a=dIu3SnmMAAAA:8 a=4jeSDQ5ESFwpc1j9W20A:9 a=NUGhV9p8TBdj_EiO5VkA:7
 a=3XT02gUjgi7ozifvo_yyzr5qQyoA:4 a=Rn8qiON8_f4A:10 a=W_IPJG6GV6jLZQEh:21
 a=4jrxYgVNN24d40gx:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120755>

Christian Couder <chriscool@tuxfamily.org> writes:

> +static struct commit_list *apply_skip_ratio(struct commit_list *list,
> +					    int count,
> +					    int skip_num, int skip_denom)
> +{
> +	int index, i;
> +	struct commit_list *cur, *previous;
> +
> +	cur = list;
> +	previous = NULL;
> +	index = count * skip_num / skip_denom;
> +
> +	for (i = 0; cur; cur = cur->next, i++) {
> +		if (i == index) {
> +			if (hashcmp(cur->item->object.sha1, current_bad_sha1))
> +				return cur;
> +			if (previous)
> +				return previous;

When you return "previous", don't you need to make sure it is not the
currently bad one?  That is,...

> +			return list;
> +		}
> +		previous = cur;

... shouldn't this be

                if (hashcmp(cur->item->object.sha1, curret_bad_sha1))
                        previous = cur;

> +	}

I do not understand the math/logic you are using here.  The incoming list
is sorted by the "goodness" value, and untestable ones have already been
removed.  By picking ones that are far from the tip, you are deliberately
accepting far suboptimal bisection, but I do not see how you are
guaranteeing that making such a trade-off is driving you away from the
untestable ones.  It almost feels to me that it is no better than randomly
picking one from the list, so why can this be an improvement over "pick
the one that is testable that appears first in the list that is sorted by
the goodness value"?

Imagine you have a graph like this (G is good, B is bad, and both branches
have similar number of commits):

	G-------------y--z--a--b--c--B
                              /
        G--------------f--e--d

In the above graph, a and d would give the best bisection, because they
can reach about half the number of nodes in the entire graph, and the goal
of the basic "find_bisection()" is to find a commit that cuts the graph
into closest-to-the-equal halves.  For this reason, 'a' and 'd' would be
near the beginning of the output from find_bisection(find_all) you run
when there are untestable commits in your managed_skipped().

Suppose 'd' was already marked untestable, but 'a' is not.  And 'd' has
slightly better "goodness" value than 'a'.

	Side note.  I do not think the situation should change drastically
	if 'a' has a better "goodness" value than 'd' has, but your
	"skipped_first" logic that I already said I do not understand in
	my earlier comment treats them quite differently, so this example
	explicitly talks about the case where 'd' is better than 'a'.

You do not check 'a' but check somewhere much older, either on the top
branch or on the bottom branch.  Why?

'b', because it is direct descendant of 'd', is likely to have inherited
the unrelated breakage from 'd' that made it untestable.  'c', being its
descendant, can also be contaminated with the unrelated breakage, but
there is a chance that such an unrelated breakage was fixed there.
Similarly, 'e' is likely to share the same unrelated breakage as 'd' has,
because it is a direct ancestor.  'f' shares the possibility but has a
better chance of being testable than 'e' is.

But 'a' does not have any relationship with 'd' and it is unlikely such an
unrelated breakage exists there.

I _think_ the solution to the "bisection with untestable" problem should
be handled as an optimization problem of two goodness values that cannot
be directly compared and traded-off:

 - The point chosen should be close to the mid-point.  The closer "weight"
   value given in do_find_bisection() is to half the number of nodes, the
   better;

 - The point chosen should be far from any known untestable commits.  We
   do not currently have function to count distance from untestable
   commits, nor make a call to such a function after filtering untestable
   commits, but I think we should.

We already have an efficient and good implementation to compute the former
criteria (find_bisection).

The "badness" value that comes from the latter criteria essentially should
be how close, from ancestry point of view, each commit is related to the
ones that are known to be untestable.  In the picture, 'b' and 'e' are
close relatives (they have thick blood relationship with 'd') and worse
than 'c' and 'f' but 'a' shouldn't be punished for being married to 'd'
that has a bad blood at all.

Now coming back to the "skipped_first" topic.  Let's use the same graph,
but now let's assume neither 'a' nor 'd' is known to be untestable, and
also 'a' gives slightly better "goodness" value than 'd' does.  Further
suppose that 'z' was already known to be untestable this time.

Even though 'a' may have a better goodness value, hence it is not skipped,
shouldn't we be favoring 'd' over 'a' because 'a' is far likely to be
untestable (due to closer blood tie with 'z') than 'd' is, and 'a' and 'd'
would give roughly the same "goodness" value?

This is why I said I do not understand your skipped_first logic.

> +static struct commit_list *managed_skipped(struct commit_list *list,
> +					   struct commit_list **tried)
> +{
> +	int count, skipped_first;
> +	int skip_num, skip_denom;
> +
> +	*tried = NULL;
> +
> +	if (!skipped_revs.sha1_nr)
> +		return list;
> +
> +	if (!skip_num)
> +		return filter_skipped(list, tried, 0, NULL, NULL);

skip_num is uninitialized and then checked here.  Is it supposed to be
"static int" with implied 0 initialization?

> +	list = filter_skipped(list, tried, 0, &count, &skipped_first);
> +
> +	if (!skipped_first)
> +		return list;
> +
> +	/* Use alternatively 1/5, 2/5 and 3/5 as skip ratio. */
> +	skip_num = count % 3 + 1;
> +	skip_denom = 5;
> +
> +	return apply_skip_ratio(list, count, skip_num, skip_denom);
> +}
