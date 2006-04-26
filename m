From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] reverse the pack-objects delta window logic
Date: Tue, 25 Apr 2006 22:45:00 -0700
Message-ID: <7vpsj4sxer.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604252330190.18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 07:45:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYcpv-0001Bo-7f
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 07:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWDZFpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 01:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWDZFpF
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 01:45:05 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48262 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750722AbWDZFpD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 01:45:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060426054502.SZFJ4388.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Apr 2006 01:45:02 -0400
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19186>

Nicolas Pitre <nico@cam.org> writes:

> Note, this is a RFC particularly to Junio since the resulting pack is 
> larger than without the patch with git-repack -a -f.  However using a 
> subsequent git-repack -a brings the pack size down to expected size.  So 
> I'm not sure I've got everything right.

I haven't tested it seriously yet, but there is nothing that
looks obviously wrong that might cause the inflation problem,
from the cursory look after applying the patch on top of your
last round.

> +	if (nr_objects == nr_result && trg_entry->delta_limit >= max_depth)
> +		return 0;

The older code was loosening this check only for a delta chain
that is already in pack (which is limited to its previous
max_depth).  The end result is almost the same -- a thin pack
recipient would have deeper delta than it asked. The difference
is that the earlier code had implicit 2*max_depth limit, but
this one makes the chain length unbounded, which I do not think
it is necessarily a bad change.  In any case it does not explain
why you are getting larger resulting pack, though.

> +	/* Now some size filtering euristics. */
> +	size = trg_entry->size;
>  	if (size < 50)
> -		return -1;
> -	if (old_entry->depth >= max_depth)
>  		return 0;

This is necessary because you are scanning from smaller to
larger, and I think it is a good change.

> -	/*
> -	 * NOTE!
> -	 *
> -	 * We always delta from the bigger to the smaller, since that's
> -	 * more space-efficient (deletes don't have to say _what_ they
> -	 * delete).
> -	 */

This comment by Linus still applies, even though the scan order
is now reversed; no need to remove it.

> +
> +	if (trg_entry->delta) {
> +		/*
> +		 * The target object already has a delta base but we just
> +		 * found a better one.  Remove it from its former base
> +		 * childhood and redetermine the base delta_limit (if used).
> +		 */

And you are making the delta chain unbound for thin case, you
can probably omit this with the same if() here; the
recomputation seems rather expensive.

> +			die("object %s inconsistent object length (%lu vs %lu)",
> +			    sha1_to_hex(entry->sha1), size, entry->size);
> +		if (!size)
> +			continue;
> +		delta_index = create_delta_index(n->data, size);
> +		if (!delta_index)
> +			die("out of memory");

It might be worth saying "if (size < 50)" here as well; no point
wasting the delta window for small sources.

> -#if 0
> -		/* if we made n a delta, and if n is already at max
> -		 * depth, leaving it in the window is pointless.  we
> -		 * should evict it first.
> -		 * ... in theory only; somehow this makes things worse.
> -		 */
> -		if (entry->delta && depth <= entry->depth)
> -			continue;
> -#endif

I was almost tempted to suggest that the degradation you are
seeing might be related to this mystery I did not get around to
solve.  By allowing to give chance to try delta against less
optimum candidates, it appeared that we ended up making the
final pack size bigger than otherwise, which suggests that our
choice between plain undeltified and a delta half its size might
be favoring delta too much.  But it does not appear to be
related to the inflation you are seeing.

With object list taken between v1.2.3..v1.3.0 in git.git
repository and without delta reuse, 3054 objects are packed
(delta 1734) with this code.  The "next" makes 1818 delta (only
5% more), which makes me suspect that it is making a bad choice
of delta base, because the final pack size is 1.5M vs 1.9M.

The chain length distribution is a bit different (run
"git-verify-pack -v" and look at the end of its output).

The "next" version:

chain length = 1: 257 objects
chain length = 2: 189 objects
chain length = 3: 156 objects
chain length = 4: 149 objects
chain length = 5: 113 objects
chain length = 6: 105 objects
chain length = 7: 105 objects
chain length = 8: 102 objects
chain length = 9: 103 objects
chain length = 10: 539 objects

this version:

chain length = 1: 415 objects
chain length = 2: 333 objects
chain length = 3: 259 objects
chain length = 4: 197 objects
chain length = 5: 155 objects
chain length = 6: 134 objects
chain length = 7: 106 objects
chain length = 8: 69 objects
chain length = 9: 47 objects
chain length = 10: 19 objects

The resulting pack would be faster to access (it has much
shorter median chain length).

BTW, have you tried it without --no-reuse-pack on an object list
that is not thin?  It appears you are busting the depth limit.

Using the same "git rev-list --objects v1.2.3..v1.3.0" as input,
git-pack-objects without --no-reuse-pack gives this
distribution:

chain length = 1: 364 objects
chain length = 2: 269 objects
chain length = 3: 198 objects
chain length = 4: 164 objects
chain length = 5: 148 objects
chain length = 6: 123 objects
chain length = 7: 122 objects
chain length = 8: 103 objects
chain length = 9: 92 objects
chain length = 10: 234 objects
chain length = 11: 12 objects
chain length = 12: 1 object
chain length = 13: 2 objects

So it _might_ be that the depth limiting code is subtly broken
which is causing you throw away a perfectly good delta base
which in turn results in a bad pack.  The distribution from the
"next" version looks like this:

chain length = 1: 358 objects
chain length = 2: 250 objects
chain length = 3: 214 objects
chain length = 4: 169 objects
chain length = 5: 150 objects
chain length = 6: 122 objects
chain length = 7: 126 objects
chain length = 8: 100 objects
chain length = 9: 101 objects
chain length = 10: 232 objects


-- >8 --

Summary of the experiment.

# test dataset
git rev-list --objects v1.2.3..v1.3.0 >RL-1.2.3--1.3.0

# baseline: "next" version is what is on my $PATH
git-pack-objects --no-reuse-delta test-next-pack-nr <RL-1.2.3--1.3.0
git-verify-pack -v test-next-pack-nr-*.pack | tail -n 20
git-pack-objects test-next-pack <RL-1.2.3--1.3.0
git-verify-pack -v test-next-pack-*.pack | tail -n 20

# freshly compiled version with the patch in question
./git-pack-objects --no-reuse-delta test-nico-pack-nr <RL-1.2.3--1.3.0
git-verify-pack -v test-nico-pack-nr-*.pack | tail -n 20
./git-pack-objects test-nico-pack <RL-1.2.3--1.3.0
git-verify-pack -v test-nico-pack-*.pack | tail -n 20
