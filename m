From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Mon, 21 Aug 2006 11:46:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608211036150.3851@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
 <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com>
 <Pine.LNX.4.64.0608181057440.11359@localhost.localdomain>
 <20060821070609.GC24054@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 17:52:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFBzi-0001AO-8i
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 17:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbWHUPrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 11:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbWHUPrF
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 11:47:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13765 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751889AbWHUPrE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 11:47:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4C000SSUHU0YH0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 21 Aug 2006 11:46:42 -0400 (EDT)
In-reply-to: <20060821070609.GC24054@spearce.org>
X-X-Sender: nico@localhost.localdomain
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25799>

On Mon, 21 Aug 2006, Shawn Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Fri, 18 Aug 2006, Jon Smirl wrote:
> > 
> > > On 8/18/06, Nicolas Pitre <nico@cam.org> wrote:
> > > > A better way to get such a size saving is to increase the window and
> > > > depth parameters.  For example, a window of 20 and depth of 20 can
> > > > usually provide a pack size saving greater than 11% with none of the
> > > > disadvantages mentioned above.
> > > 
> > > Our window size is effectively infinite. I am handing him all of the
> > > revisions from a single file in optimal order. This includes branches.
> > 
> > In GIT packing terms this is infinite delta _depth_ not _window_.
> 
> We're not using infinite anything.
> 
> fast-import is basically doing window=1 and depth=10.

Yes, that is what I figured out looking at the code.

> We only examine the last blob to see if we can get a delta against
> it.  If we do we write that delta out; otherwise we reset our delta
> chain and write the complete object.  We also reset our chain after
> writing out 10 deltas, each of which used the immediately prior
> object as its base.

I think this is a perfectly sensible thing to do for the initial import 
pass.  This will get the data in GIT format quickly and save disk space 
over no deltas at all.  No need to seek for optimal packing at that 
point but only lay things out for a faster git-repack pass to complete 
the import.

Also, like I said before, you cannot get a nice object layout from your 
import process since all revisions of each file end up next to each 
other while in practice what you want is all objects for each _commit_ 
to be next to each other.  Otherwise checking out a commit will seek all 
over the pack like mad.  A final repack using git-repack will create 
that nice object layout for you and that is something you cannot do 
on the fly.

The git-pack-objects code is also where all the accumulated knowledge 
for best delta packing heuristics has been created over the last year.  
It would be counter productive to cut yourself from its value.  If 
anything more clever can be done with packing it probably should be done 
there.

Finally, I don't see how you could create nice deltas for tree objects 
on the fly like you do with blobs without making your code significantly 
more complex and use more memory due to the recursive nature of 
directory information.  This is no a problem for git-pack-objects since 
tree objects are no different from blob objects when deltifying them.

Again this is why I think you should focus on the quickest generation of 
a reasonable intermediate pack and let git-repack make it optimal.

> Since I just found out that in some cases the Mozilla repository has
> 1000s of revisions per file[*1*] and in others only 1 revision per
> file we probably should be adjusting this depth to have a maximum
> of 500 while also having the frontend send us a "I'm switching
> files now" marker so we know to not even bother trying to delta
> the new blob against the last blob as they are likely to not
> delta well[*2*].

No please don't do that.  A deep delta chain won't produce a dramatic 
size difference but it _will_ make it really costly to read objects back 
from the pack later on.  For example it might make the next git-repack 
many times longer but the size saving will not be more than 20%.  If you 
agree with me that a final git-repack is the best thing to do then the 
intermediate pack doesn't have to be that small.

> Although complex the aggressive and grouped deltas appears to
> have saved you 18.2% on this repository.  That's not something
> to ignore.

But the aggressive delta alone saved 13% already.  The remaining saving 
is questionable since, like I said, it prevents the delta data reuse 
optimization which is so nice in order to reduce the load on servers to 
nearly zero.

> A reasonably optimal local pack dictionary could save
> at least 4%[*3*].  Whacking 22% off a 400 MB pack is saving 88 MB.

This is still speculations though.  The separate dictionary is certainly 
a good idea to try out and it is way more flexible than the grouped 
deltas.  But I doubt the combined concepts will all add up size 
savings linearly.

> Transferring that over the network on an initial clone is like
> downloading all of Eclipse.  Or an uncompressed kernel tarball...

... something that most people can afford these days.  Plus, not using 
grouped objects would make future shallow clones much less costly on the 
server as well, while this is something that most people will be most 
interested in with such large repos and which has much higher bandwidth 
saver value.


Of course this is a trade-off.  Tighter packs are likely to be more 
costly to use.  So far we've contained that cost to the _initial_ 
generation of the pack (using -a -f with git-repack) while subsequent 
repacking for network transfer were basically free on CPU.  The grouped 
object concept saves around 7 to 11% on pack size in my tests, but it 
impose a non negligible cost on any further repacking as well as an 
additional cost on the fetching of objects out of the pack.

> [*3*] I wrote a brain-dead simple local dictionary selecter in Perl.
>       Its horribly far from being ideal.  But it is consistently
>       saving us 4% on the GIT and the Mozilla repository and its
> 	  pretty darn fast.  Shockingly the C keywords didn't gain
> 	  us very much here; its project specific text that's the
> 	  real win.
> 
> 	  Looking at chunks which are frequently copied in deltas
> 	  from base objects and breaking those chunks up into
> 	  smaller common chunks, then loading those most frequent
> 	  common chunks into the pack dictionary would most likely
> 	  produce far better results.

I think such a global dictionary per pack is something that could be 
really nice.  Again it limits the cost to the initial repack process 
while having no cost impact neither on the delta reuse optimization nor 
on the object checkout which is not the case for object grouping.  
Certainly worth experimenting ... but independently from any import 
process I think.


Nicolas
