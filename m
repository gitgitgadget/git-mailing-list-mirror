From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/7] revision-cache: define revision cache as simple list
 of revisions
Date: Sun, 07 Jun 2009 01:43:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906070001150.3906@xanadu.home>
References: <cover.1244125127.git.sam@vilain.net>
 <b054cddea58213268b872cf43c725960e6e2dc5b.1244125127.git.sam@vilain.net>
 <alpine.LFD.2.00.0906051406330.3906@xanadu.home>
 <1244346575.9843.41.camel@maia.lan>
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
X-From: git-owner@vger.kernel.org Sun Jun 07 07:45:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDBBk-0003ic-Ia
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 07:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbZFGFoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 01:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbZFGFoH
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 01:44:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27964 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbZFGFoG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 01:44:06 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKU005QZT7BN950@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 07 Jun 2009 01:42:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1244346575.9843.41.camel@maia.lan>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120955>

On Sun, 7 Jun 2009, Sam Vilain wrote:

> On Fri, 2009-06-05 at 15:28 -0400, Nicolas Pitre wrote:
> > Please don't mess up the layers of abstractions.  Creating a list of 
> > objects is currently the biggest bottleneck for big clones.  It is not 
> > the object compression (delta) phase, it is not the pack creation 
> > either.
>   [...]
> > In other words, you should really concentrate on making 'git rev-list 
> > --objects' and 'git rev-list --objects-edge' instantaneous without 
> > having to parse any commit nor tree objects (at least for the part 
> > already covered by the cache).  And as new objects are added through 
> > 'git add' and 'git commit' or 'git fetch' then the traditional object 
> > parsing would have to take place only up to the point where the cache 
> > could take over, and update the cache for the non covered objects while 
> > at it.  I think this is already quite a difficult problem already.
> 
> It's a good thing, then, that this is exactly what the first milestones
> in the project are covering.  
> 
> What I don't understand though is that during initial clone the object
> compression phase does take a lot of time, and that there have been
> reports that large initial clones use a lot of VM for the packfile to be
> sent.

Did you duplicate those results yourself?

Did you also try out the simple bench test I suggested while responding 
to Jakub?

For example, let's take the Linux kernel repository as I have it handy 
here.  For the various phases I get:

Counting objects = 25 seconds
Compressing objects = 2 seconds
Writing objects = 3 seconds

A long compression phase is a sign of a really badly packed repository.
The solution to that is simply to repack.  After that subsequent clones 
as well as further repacks will have much shorter compression phase as 
the work that was performed in the first repack will be directly 
reusable.

> So what I'm doing is trying to answer the question about why we
> can't just start streaming the pack as soon as we know how many objects
> will be in it.  All those other stages can happen in parallel - for
> instance I would wager that it's far more efficient to detect loops as
> we're streaming, as the packfile is accessed, rather than having to read
> seek object header in the packfile up front.

My stance on this is that it is fundamentally impossible to do 
efficiently, if at all.  What we currently do is not loop detection but 
rather loop avoidance.  And because your pack set is not a static thing 
(new packs are created or fetched, and sometimes they're repacked into a 
single pack for a while) then you simply can't have a stable cache of 
object topology based on their storage into packs.  This is simply not 
some immutable data.  Only object names and contents are immutable, 
nothing more.

What I'm telling you is: in order to know how many objects the pack 
which is about to be created will contain, you need to count them.  
This is what takes 25 seconds currently in the above example.  Then a 2 
second compression phase which could be even less if your repository is 
better packed than mine currently is.  At which point the writing phase 
starts and the pack header is streamed.  So trying to stream the pack as 
soon as you know how many objects it contains will save a big whoopee 2 
seconds.  This is nothing to go crazy about, really.

Yet, to be able to stream a pack right away, you still would need to 
know _where_ to pick the pack data from.  And in most cases this is not 
from a nice single pack but rather multiple ones.  And some of those 
packs have objects which are duplicated into other packs.  And yet by 
mixing pack data from multiple source packs, you gain new opportunities 
for delta compression because you're now putting together objects which 
were separated before and therefore couldn't create delta between them 
previously (that's the 2 second phase above).  You still must be careful 
during that phase not to create delta loop, and to do that you must take 
into account all the other deltas from existing source packs that you 
are going to not recompute but just copy straight into the new pack.

And of course there is the delta depth limit to enforce.  This means 
that some rearrangements of deltas forces some objects which were deltas 
previously to become undeltified, or new deltas against a shallower base 
object.  And the only way to know what form each object will take in 
this context is again by going through the full compression phase which 
works on a list of object which ordering is totally different from the 
one that is used to actually store objects in the pack.  In other words, 
you cannot work out delta issues as you stream the pack because you 
don't want to write objects in the pack with the same order used for 
delta processing.

Why a different object ordering for storing in the pack? Because we want 
to create the best data layout possible in the new pack so future 
runtime access to that pack will be optimal.  This often means that 
objects are picked from existing packs in a non linear fashion but 
rather in a seemingly random way.  This is because we want the most 
recent commits to get the best IO patterns in a pack.  However, when the 
repository is updated through fetches or pushes, the newly obtained 
packs usually carry even more recent commits for which the bulk of 
referenced objects are still to be found in older packs (this is why a 
fetch is so quick).  So the more fetches or pushes are performed, the 
less efficient your repository becomes with regard to the most recent 
commits.  This is why a subsequent repack will reshuffle all objects so 
that the most recent commit gets a linear IO pattern again by picking 
objects from the most recent packs as well as from older packs and 
putting them all contiguously in the new pack.  But again you cannot 
know if those objects will be in delta form or not, or against which 
base object before the compression phase is over.

I hope you have a better idea now to answer the question about why we 
can't just start streaming the pack as soon as we know how many objects 
will be in it, and why all those other stages may not happen in 
parallel.

> In summary, I'm trying to make sure that the revision cache contains
> whatever information might help with making it start as soon as
> possible, where putting the information in is trivial.
> 
> If pack-objects integration is as small a win as you say - and I have no
> hard facts to dispute this - then when we come to that part and
> investigate I'm sure with the facts in hand we will agree on what
> approach to take.

Good.  I'm glad you see things that way.  Because, to me, even just the 
notion of a good revision cache is not that simple.

> > What pack-objects would greatly benefit from is a facility that could 
> > provide a list of objects with their SHA1, type, size
> 
> Which size?  compressed, uncompressed?  What does that win us?  Again
> I'm trying to support all information with a use case.

Uncompressed.  That information is used by the delta heuristics, and the 
code currently does its best not to seek all over through delta chains 
to fetch that tiny bit of information if that can be avoided (have a 
look at check_object() in builtin-pack-objects.c).

> > and the 32-bit 
> > object path hash
> 
> I'm not sure what this means, can you refer me to some docs or relevant
> source?

If you don't know what that is, then I'm afraid you might be lacking 
some background on the packing and delta strategy.  I'd suggest you read 
Documentation/technical/pack-heuristics.txt first, and then find out in 
the commit logs for builtin-pack-objects.c (or even within the file 
itself) what has changed since then.


Nicolas
