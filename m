From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 1/7] revision-cache: define revision cache as simple
 list of revisions
Date: Sun, 07 Jun 2009 15:49:35 +1200
Message-ID: <1244346575.9843.41.camel@maia.lan>
References: <cover.1244125127.git.sam@vilain.net>
	 <b054cddea58213268b872cf43c725960e6e2dc5b.1244125127.git.sam@vilain.net>
	 <alpine.LFD.2.00.0906051406330.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 05:52:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD9QO-0001r7-6s
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 05:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbZFGDs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 23:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754033AbZFGDsz
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 23:48:55 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:35978 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020AbZFGDsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 23:48:54 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 1918213C010; Sun,  7 Jun 2009 15:48:40 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.182] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 04CB021C3D9;
	Sun,  7 Jun 2009 15:48:34 +1200 (NZST)
In-Reply-To: <alpine.LFD.2.00.0906051406330.3906@xanadu.home>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120951>

On Fri, 2009-06-05 at 15:28 -0400, Nicolas Pitre wrote:
> > +  - A list of objects which are referred to by the 'start' object
> > +
> > +    * position when sorted in --date-order
> > +
> > +    * object ID
> 
> Does the object ID contain the object type or just the SHA1?  Having the 
> object type quickly retrievable would be a significant gain as well.

Well, one of the things I'm trying to avoid is adding information which
isn't clearly supported by a use case.  But now that you mention it I
guess the type is quite useful and also quite small.  What I could do is
have 4 bitmaps, one for each object type.  That should be quite small
and re-use the bitmap infrastructure used later.

  [...]
> > +Use Cases
> > +---------
> > +In this section, the key functions and operations that this index is
> > +designed to answer are explored.  For each, their efficiency is
> > +considered in terms of what must be carried out to calculate the
> > +answer.
> > +
> > +
> > +Determining Cache Suitability - rev_cache_suitable()
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +This is an auxiliary function used by the other use cases, when 
> 
> when what?

Whoops.  When deciding whether or not a revision cache is going to be
useful to help the current operation.  This needs to be quick because we
need to identify whether to use a cache or keep going.

> > +The function is:
> > +
> > +  rev_cache_suitable( rev_cache, object )
> > +
> > +The check is simple and fast - it just compares the object to the
> > +'start' object in the revision cache.
> > +
> > +
  [...]
> > +Returning objects
> > +^^^^^^^^^^^^^^^^^
> > +
> > +The 'rev_cache_fetch()' iterator returns entries from the topological
> > +list.
> > +
> > +  rev_cache_fetch() : oid
> > +
> > +If returning objects from a single revision cache, it opens the 
> 
> opens what?

Again sorry this got lost when I was re-arranging the document.  It
opens the revision cache and returns objects in the order they appear in
the cache's object list.


  [...]
> > +receive-pack/pack-objects
> > +~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +pack-objects when called from pack-objects is a special user of the
>                ^
> Are you missing some punctuation here?

It should probably say "when called from receive-pack".

> > +revision cache; it has the extra requirements of wanting to know;
> > +
> > +* how many objects are between 'interesting' and 'uninteresting'
> > +  objects, at the beginning of the run, to emit the pack header
> > +
> > +* for checking re-usability of deltas, whether the delta base object
> > +  in the pack is in the received set of objects.
> > +
> > +* for 'thin' pack generation, whether the delta base object is in the
> > +  received set of objects, -or- reachable from any 'uninteresting'
> > +  objects
> > +
> > +* for 'shallow' clone, whether the delta base object is reachable
> > +  without passing any of the 'uninteresting' objects
> > +
> > +The aim is for 'pack-objects' to be able to start returning objects
> > +immediately in the case where a suitable revision cache is returned,
> > +without waiting for revision counting or repacking.
> 
> Everything that was said so far made lots of sense to me, up to this 
> section.  I think that you should really limit the scope of the problem 
> to object enumeration only and not dive so deep into pack-objects' 
> operation.



>   Having an efficient object enumeration cache that is 1) 
> fast, 2) doesn't use up too much disk space and 3) keep itself up to 
> date automatically and transparently [...]

Like the rest of git - the object graph, packs, etc - this design is
based around the concept of "immutable data".  That is, the revision
cache is defined by the objects it was computed from.  Once the later
stages of it are reached, the "revision cache stacking" comes into play
to achieve automatic and transparent 'updating'.  I considered designs
which were not immutable data but decided that the update performance
would be too poor or suffer from locking issues.

> > +Re-using deltas
> > +^^^^^^^^^^^^^^^
> > +
> > +This applies to the 'Compressing Objects' phase, previously known as
> > +the 'Deltafying Objects' phase.  Instead of searching for deltas, if
> > +we can be sure that the existing delta can be resolved on the remote,
> > +then we can re-use it.
> 
> I don't see how the reachability cache could have anything to do with 
> this.  Sure the criteria for reusing some delta data is for the base to 
> be part of the object set, or in the thin pack case, when the base is 
> known to be available on the remote side.  But the delta and base has to 
> already exist locally in the _same_ pack, otherwise it simply doesn't 
> exist and has to be computed.  It is a common situation for a repository 
> to have multiple packs for which deltas can be produced when crossing 
> source pack boundaries, and that fact simply cannot fit within an object 
> enumeration cache.
> 
> > +For the initial clone, this operation is simple - as objects are
> > +emitted, the delta from the packfile is re-used.  If a loop is
> > +detected or the delta base is not in the returned set of objects, then
> > +the delta is first resolved.
> 
> How do you know you have a loop?  A lot of thoughts went into the 
> current code to never get into a situation where loops could be 
> possible.  And that can only be inferred from the actual content of used 
> object packs.  Again the enumeration cache cannot and should not be 
> concerned by such considerations as they will change on every repack.
> 
> > +This implies that the list of objects is first loaded into a hash
> > +table prior to returning any objects; however this is probably
> > +acceptable as the entire list is in one stream and will load quickly.
> 
> Again this is duplication of already existing code.

There's no code to be duplicate yet.  A lot of the above text is trying
to summarise what happens in pack-objects, for the purposes of
considering whether the revision cache can help with it.  Delta loop
detection I'd considered, but decided not to discuss in the already
quite long document.

> Please don't mess up the layers of abstractions.  Creating a list of 
> objects is currently the biggest bottleneck for big clones.  It is not 
> the object compression (delta) phase, it is not the pack creation 
> either.
  [...]
> In other words, you should really concentrate on making 'git rev-list 
> --objects' and 'git rev-list --objects-edge' instantaneous without 
> having to parse any commit nor tree objects (at least for the part 
> already covered by the cache).  And as new objects are added through 
> 'git add' and 'git commit' or 'git fetch' then the traditional object 
> parsing would have to take place only up to the point where the cache 
> could take over, and update the cache for the non covered objects while 
> at it.  I think this is already quite a difficult problem already.

It's a good thing, then, that this is exactly what the first milestones
in the project are covering.  

What I don't understand though is that during initial clone the object
compression phase does take a lot of time, and that there have been
reports that large initial clones use a lot of VM for the packfile to be
sent.  So what I'm doing is trying to answer the question about why we
can't just start streaming the pack as soon as we know how many objects
will be in it.  All those other stages can happen in parallel - for
instance I would wager that it's far more efficient to detect loops as
we're streaming, as the packfile is accessed, rather than having to read
seek object header in the packfile up front.

In summary, I'm trying to make sure that the revision cache contains
whatever information might help with making it start as soon as
possible, where putting the information in is trivial.

If pack-objects integration is as small a win as you say - and I have no
hard facts to dispute this - then when we come to that part and
investigate I'm sure with the facts in hand we will agree on what
approach to take.

> What pack-objects would greatly benefit from is a facility that could 
> provide a list of objects with their SHA1, type, size

Which size?  compressed, uncompressed?  What does that win us?  Again
I'm trying to support all information with a use case.

> and the 32-bit 
> object path hash

I'm not sure what this means, can you refer me to some docs or relevant
source?

>  given a list of "have" and "want" kind of refs.  And so 
> in a way that doesn't suck, which could mean in less than, say, 5 
> seconds per million objects.  That's it, but that's hard.  All the rest 
> is already done and quite well optimized.

Thanks for your detailed commentary,
Sam.
