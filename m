From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/7] revision-cache: define revision cache as simple list
 of revisions
Date: Fri, 05 Jun 2009 15:28:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906051406330.3906@xanadu.home>
References: <cover.1244125127.git.sam@vilain.net>
 <b054cddea58213268b872cf43c725960e6e2dc5b.1244125127.git.sam@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:29:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCf6B-0003nk-As
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 21:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbZFET26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 15:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbZFET25
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 15:28:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25387 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZFET24 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 15:28:56 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKS006MN6436QC0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 05 Jun 2009 15:28:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <b054cddea58213268b872cf43c725960e6e2dc5b.1244125127.git.sam@vilain.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120821>

On Fri, 5 Jun 2009, Sam Vilain wrote:

> The very first thing that we want out of the revision cache is to be
> able to go from a commit to all of its referred objects.  Define a
> revision cache that includes just that.
> 
> Signed-off-by: Sam Vilain <sam@vilain.net>

Comments below.

> ---
>  Documentation/technical/revision-cache.txt |  260 ++++++++++++++++++++++++++++
>  1 files changed, 260 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/technical/revision-cache.txt
> 
> diff --git a/Documentation/technical/revision-cache.txt b/Documentation/technical/revision-cache.txt
> new file mode 100644
> index 0000000..cc18535
> --- /dev/null
> +++ b/Documentation/technical/revision-cache.txt
> @@ -0,0 +1,260 @@
> +Revision Cache Format
> +=====================
> +
> +The revision cache is an on-disk format which allows for certain graph
> +reachability operations to be answered quickly.
> +
> +A revision cache contains;
> +
> +  - A 'start' object (ie, 'interesting' object ID)
> +
> +  - A list of objects which are referred to by the 'start' object
> +
> +    * position when sorted in --date-order
> +
> +    * object ID

Does the object ID contain the object type or just the SHA1?  Having the 
object type quickly retrievable would be a significant gain as well.

> +Start Object
> +------------
> +
> +The 'start' object is the identifying key of the revision cache.
> +
> +
> +Topological contents list
> +-------------------------
> +
> +This list has fixed-length records, so the topological position into
> +the list does not need to be stored in each record - it is implicit
> +from the offset.
> +
> +--date-order is used as it is the strictest sort order available, but
> +this still only specifies an ordering for commit objects.  Other
> +objects will appear after the object which first refers to them.  Tag
> +objects are sorted as if they were commit objects with a single
> +parent, the object they tag.
> +
> +
> +Use Cases
> +---------
> +In this section, the key functions and operations that this index is
> +designed to answer are explored.  For each, their efficiency is
> +considered in terms of what must be carried out to calculate the
> +answer.
> +
> +
> +Determining Cache Suitability - rev_cache_suitable()
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This is an auxiliary function used by the other use cases, when 

when what?

> +The function is:
> +
> +  rev_cache_suitable( rev_cache, object )
> +
> +The check is simple and fast - it just compares the object to the
> +'start' object in the revision cache.
> +
> +
> +Revision Walker
> +~~~~~~~~~~~~~~~
> +
> +The revision walker is the main user of this cache; there is the
> +generic function of revision walking, as well as commands that want
> +specific information which they normally derive from the revision
> +walker output.
> +
> +
> +Setting up the walker
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +The functions for this are (intentionally resembling the current
> +revision walker API):
> +
> +  rev_cache_init()
> +  rev_cache_add( interesting?, oid )
> +
> +As well as this setup, it is necessary to specify which options are
> +required.  Some API exists to do this, and the return value from
> +'rev_cache_ok' is true if suitable caches were found for the
> +information required, and false if it would require a graph traversal:
> +
> +  rev_cache_options( ordered? )
> +  rev_cache_ok( ) : Bool
> +
> +The rev_cache_ok() function must open all available revision caches,
> +and see if their 'interesting' object matches the single 'interesting'
> +object passed to rev_cache_add().  If it matches, it returns true.  If
> +multiple 'interesting' objects were specified and 'ordered' is true,
> +then the function returns false.
> +
> +If the ordering flag was set to false, then all of the 'interesting'
> +objects must be found in separate revision caches.
> +
> +If any 'uninteresting' objects were passed, then the return value is
> +always false.
> +
> +
> +Returning objects
> +^^^^^^^^^^^^^^^^^
> +
> +The 'rev_cache_fetch()' iterator returns entries from the topological
> +list.
> +
> +  rev_cache_fetch() : oid
> +
> +If returning objects from a single revision cache, it opens the 

opens what?

> +Accelerating in-progress walking
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +It is possible that during a revision iteration operation, a revision
> +is discovered that may mean the rest of the revision walking can be
> +achieved faster.
> +
> +In practice, this is likely to be implemented by making in-core cache
> +entries for objects with revision caches prior to walking; then when
> +encountered the special action can be taken.
> +
> +
> +Creating Revision Caches
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Once the revision cache is setup via rev_cache_init() and
> +an 'interesting' object added, then call:
> +
> +  rev_cache_create( )
> +
> +This function will not work, if multiple 'interesting' objects are
> +passed, or any 'uninteresting' objects were passed.
> +
> +This function must revision walk the commit graph, sorting in
> +--date-order along the way, and may emit revisions as they are
> +discovered to the topological object list.
> +
> +
> +receive-pack/pack-objects
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +pack-objects when called from pack-objects is a special user of the
               ^
Are you missing some punctuation here?

> +revision cache; it has the extra requirements of wanting to know;
> +
> +* how many objects are between 'interesting' and 'uninteresting'
> +  objects, at the beginning of the run, to emit the pack header
> +
> +* for checking re-usability of deltas, whether the delta base object
> +  in the pack is in the received set of objects.
> +
> +* for 'thin' pack generation, whether the delta base object is in the
> +  received set of objects, -or- reachable from any 'uninteresting'
> +  objects
> +
> +* for 'shallow' clone, whether the delta base object is reachable
> +  without passing any of the 'uninteresting' objects
> +
> +The aim is for 'pack-objects' to be able to start returning objects
> +immediately in the case where a suitable revision cache is returned,
> +without waiting for revision counting or repacking.

Everything that was said so far made lots of sense to me, up to this 
section.  I think that you should really limit the scope of the problem 
to object enumeration only and not dive so deep into pack-objects' 
operation.  Having an efficient object enumeration cache that is 1) 
fast, 2) doesn't use up too much disk space and 3) keep itself up to 
date automatically and transparently is already quite a challenge 
already.  Mixing pack-objects issues listed above into the mix is, I 
think, a huge mistake and possibly a misunderstanding of the packing 
process.  More comments below.

> +Returning object counts
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +If the revision cache was suitable, eg for a complete fetch, then the
> +number of objects can be obtained by counting the size of the object
> +list.
> +
> +If multiple revision caches were used for multiple 'interesting'
> +objects, then the number of objects can be obtained by building a hash
> +table of all the objects in all of the caches, and returning the
> +number of hash table entries.
> +
> +If 'uninteresting' objects were passed, no cache can be suitable.

Knowing the number of objects early is not that useful.  The only way 
you can know that number is by counting all needed objects, and the 
problem to solve here is really to provide that list of objects _fast_.  
The pack-objects code already deals with building a hash of objects and 
that takes no time compared to actually obtaining that list of objects 
in the first place.

> +Re-using deltas
> +^^^^^^^^^^^^^^^
> +
> +This applies to the 'Compressing Objects' phase, previously known as
> +the 'Deltafying Objects' phase.  Instead of searching for deltas, if
> +we can be sure that the existing delta can be resolved on the remote,
> +then we can re-use it.

I don't see how the reachability cache could have anything to do with 
this.  Sure the criteria for reusing some delta data is for the base to 
be part of the object set, or in the thin pack case, when the base is 
known to be available on the remote side.  But the delta and base has to 
already exist locally in the _same_ pack, otherwise it simply doesn't 
exist and has to be computed.  It is a common situation for a repository 
to have multiple packs for which deltas can be produced when crossing 
source pack boundaries, and that fact simply cannot fit within an object 
enumeration cache.

> +For the initial clone, this operation is simple - as objects are
> +emitted, the delta from the packfile is re-used.  If a loop is
> +detected or the delta base is not in the returned set of objects, then
> +the delta is first resolved.

How do you know you have a loop?  A lot of thoughts went into the 
current code to never get into a situation where loops could be 
possible.  And that can only be inferred from the actual content of used 
object packs.  Again the enumeration cache cannot and should not be 
concerned by such considerations as they will change on every repack.

> +This implies that the list of objects is first loaded into a hash
> +table prior to returning any objects; however this is probably
> +acceptable as the entire list is in one stream and will load quickly.

Again this is duplication of already existing code.

> +For later fetches, the revision cache is not appropriate as they will
> +have 'uninteresting' objects set.
> +
> +
> +Re-using deltas - 'thin' pack
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +This case is much like the normal re-using deltas case, except there
> +is the complete set of objects that the remote has claimed to have to
> +consider.
> +
> +The cache is not yet sophisticated enough to assist with this use
> +case.

And it should not attempt anything in that direction.  This is simply 
not the right level for such considerations.

Please don't mess up the layers of abstractions.  Creating a list of 
objects is currently the biggest bottleneck for big clones.  It is not 
the object compression (delta) phase, it is not the pack creation 
either.  The current code is smart enough not to delta objects it knows 
can be found in source packs already, and it knows how to cull the list 
of deltas that needs to be computed to the strict minimum.  And that 
requires almost no time.  What is really time consuming is to figure out 
the damn object list in the first place.  No need to reinvent what 
already works well.

In other words, you should really concentrate on making 'git rev-list 
--objects' and 'git rev-list --objects-edge' instantaneous without 
having to parse any commit nor tree objects (at least for the part 
already covered by the cache).  And as new objects are added through 
'git add' and 'git commit' or 'git fetch' then the traditional object 
parsing would have to take place only up to the point where the cache 
could take over, and update the cache for the non covered objects while 
at it.  I think this is already quite a difficult problem already.

What pack-objects would greatly benefit from is a facility that could 
provide a list of objects with their SHA1, type, size and the 32-bit 
object path hash given a list of "have" and "want" kind of refs.  And so 
in a way that doesn't suck, which could mean in less than, say, 5 
seconds per million objects.  That's it, but that's hard.  All the rest 
is already done and quite well optimized.


Nicolas
