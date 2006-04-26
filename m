From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH/RFC] reverse the pack-objects delta window logic
Date: Wed, 26 Apr 2006 11:48:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604261108430.18520@localhost.localdomain>
References: <Pine.LNX.4.64.0604252330190.18520@localhost.localdomain>
 <7vpsj4sxer.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 17:50:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYmGA-0001NJ-NN
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 17:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWDZPsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 11:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWDZPsz
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 11:48:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8354 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964834AbWDZPsy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 11:48:54 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYC000XB6LH27V0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 26 Apr 2006 11:48:53 -0400 (EDT)
In-reply-to: <7vpsj4sxer.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19210>

On Tue, 25 Apr 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Note, this is a RFC particularly to Junio since the resulting pack is 
> > larger than without the patch with git-repack -a -f.  However using a 
> > subsequent git-repack -a brings the pack size down to expected size.  So 
> > I'm not sure I've got everything right.
> 
> I haven't tested it seriously yet, but there is nothing that
> looks obviously wrong that might cause the inflation problem,
> from the cursory look after applying the patch on top of your
> last round.
> 
> > +	if (nr_objects == nr_result && trg_entry->delta_limit >= max_depth)
> > +		return 0;
> 
> The older code was loosening this check only for a delta chain
> that is already in pack (which is limited to its previous
> max_depth).  The end result is almost the same -- a thin pack
> recipient would have deeper delta than it asked. The difference
> is that the earlier code had implicit 2*max_depth limit,

Ah.  Indeed.  Didn't realize that.  I can restore that behavior quite 
easily if necessary.

> but this one makes the chain length unbounded, which I do not think it 
> is necessarily a bad change.

Well as long as the thin pack doesn't carry too many revisions it should 
be fine since, as the comment in the code sais, those packs are always 
unpacked.

Initially I had a bug where the delta depth was completely ignored.  I 
was pretty excited when repacking the kernel produced a pack 20% smaller 
although I didn't know why at that time.  But when attempting another 
git-repack -a -f then the initial object counting was sooooooo 
slooooooooow.

> > -	/*
> > -	 * NOTE!
> > -	 *
> > -	 * We always delta from the bigger to the smaller, since that's
> > -	 * more space-efficient (deletes don't have to say _what_ they
> > -	 * delete).
> > -	 */
> 
> This comment by Linus still applies, even though the scan order
> is now reversed; no need to remove it.

This is not exactly true.  In general it is so, but as we fixed the 
deltification of objects with the same name but in different directories 
it is well possible to go from smaller to larger and leaving that 
comment there is misleading.

This is also why I changed the sizediff rule such that:

	sizediff = src_size < size ? size - src_size : 0;

Since the src buffer already has its delta index computed, it costs 
almost nothing to attempt matching much smaller objects against it.  
However if we go from small to larger then the previous logic still 
applies.

> > +	if (trg_entry->delta) {
> > +		/*
> > +		 * The target object already has a delta base but we just
> > +		 * found a better one.  Remove it from its former base
> > +		 * childhood and redetermine the base delta_limit (if used).
> > +		 */
> 
> And you are making the delta chain unbound for thin case, you
> can probably omit this with the same if() here; the
> recomputation seems rather expensive.

Ah right.  I was doing so partly, but I can skip any tree maintenance 
altogether in that case as well.

> > +		if (!size)
> > +			continue;
> > +		delta_index = create_delta_index(n->data, size);
> > +		if (!delta_index)
> > +			die("out of memory");
> 
> It might be worth saying "if (size < 50)" here as well; no point
> wasting the delta window for small sources.

Good point.  No real effect on the pack size though.

> > -#if 0
> > -		/* if we made n a delta, and if n is already at max
> > -		 * depth, leaving it in the window is pointless.  we
> > -		 * should evict it first.
> > -		 * ... in theory only; somehow this makes things worse.
> > -		 */
> > -		if (entry->delta && depth <= entry->depth)
> > -			continue;
> > -#endif
> 
> I was almost tempted to suggest that the degradation you are
> seeing might be related to this mystery I did not get around to
> solve.  By allowing to give chance to try delta against less
> optimum candidates, it appeared that we ended up making the
> final pack size bigger than otherwise, which suggests that our
> choice between plain undeltified and a delta half its size might
> be favoring delta too much.  But it does not appear to be
> related to the inflation you are seeing.

Certainly not, since git-repack -a may only delta _more_ and the pack 
size actualy goes down a lot in my case.

The mystery I'm facing is why would a second pass with git-repack -a fix 
things?  It has a different window behavior since objects already 
deltified do not occupy window space. Hmmm.  That would certainly 
explain why doing a git-repack -a after a git-repack -a -f produces a 
smaller pack even currently.

> BTW, have you tried it without --no-reuse-pack on an object list
> that is not thin?  It appears you are busting the depth limit.
> 
> Using the same "git rev-list --objects v1.2.3..v1.3.0" as input,
> git-pack-objects without --no-reuse-pack gives this
> distribution:
> 
> chain length = 1: 364 objects
> chain length = 2: 269 objects
> chain length = 3: 198 objects
> chain length = 4: 164 objects
> chain length = 5: 148 objects
> chain length = 6: 123 objects
> chain length = 7: 122 objects
> chain length = 8: 103 objects
> chain length = 9: 92 objects
> chain length = 10: 234 objects
> chain length = 11: 12 objects
> chain length = 12: 1 object
> chain length = 13: 2 objects

Oops.  OK fixed.

> So it _might_ be that the depth limiting code is subtly broken
> which is causing you throw away a perfectly good delta base
> which in turn results in a bad pack.

Actually no.  That bug instead allowed each given base to deltify more 
targets than it should have.


Nicolas
