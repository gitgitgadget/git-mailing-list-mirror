From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-{repack,pack-objects} accept --{pack,blob}-limit to
 control pack size
Date: Wed, 04 Apr 2007 23:17:45 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704042203160.28181@xanadu.home>
References: <56b7f5510704041340l5997b04dp853e8270a644ab28@mail.gmail.com>
 <alpine.LFD.0.98.0704041750030.28181@xanadu.home>
 <56b7f5510704041555q4e735961ra9ee8008be0d33db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 05:18:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZIUE-00008Z-1P
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 05:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbXDEDSG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 23:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbXDEDSG
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 23:18:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14104 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161094AbXDEDSE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 23:18:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG000ENK95NFR51@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 Apr 2007 23:17:48 -0400 (EDT)
In-reply-to: <56b7f5510704041555q4e735961ra9ee8008be0d33db@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43790>

On Wed, 4 Apr 2007, Dana How wrote:

> On 4/4/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Wed, 4 Apr 2007, Dana How wrote:
> > > The motivations are to better support portable media,
> > > older filesystems,  and larger repositories without
> > > awkward enormous packfiles.
> > 
> > I wouldn't qualify "enormous" pack files as "awkward".
> > 
> > It will always be more efficient to have only one pack to deal with
> > (when possible of course).
> Yes.  "(when possible of course)" refers to the remaining motivations
> I didn't explicitly mention: the 32b offset limit in .idx files,
> and keeping the mmap code working on a 32b system.
> I realize there are better solutions in the pipeline,
> but I'd like to address this now (for my own use) and hopefully
> also create something useful for 4GB-limited filesystems,
> USB sticks, etc.

I think this is a valid feature to have, no problem there.

> > > When --pack-limit[=N] is specified and --stdout is not,
> > > all bytes in the resulting packfile(s) appear at offsets
> > > less than N (which defaults to 1<<31).  The default
> > > guarantees mmap(2) on 32b systems never sees signed off_t's.
> > > The object stream may be broken into multiple packfiles
> > > as a result,  each properly and conventionally built.
> > >
> > 
> > This sounds fine.  *However* how do you ensure that the second pack (or
> > subsequent packs) is self contained with regards to delta base objects
> > when it is _not_ meant to be a thin pack?
> Good question.  Search for "int usable_delta" in the patch.
> With --pack-limit (offset_limit in C), you can use a delta if the base
> is in the same pack and already written out.  The first condition
> addresses your concern, and the second handles the case
> where the base object gets pushed to the next pack.
> These restrictions should be loosened for --thin-pack
> but I didn't do that yet.

OK.

> Also, --pack-limit turns on --no-reuse-delta.
> This is not necessary, but not doing it would have meant
> hacking up even more conditions which I didn't want to do
> on a newbie submission.

Thing is delta reusing is one of the most important feature for good 
performances so it has to work.

But let's take a moment to talk about your "newbie submission".  This 
patch is _way_ too large and covers too many things at once.  You'll 
have to split it in many smaller logical units pretty please.  For 
example, if you have to borrow code from fast-import then make a patch 
that perform that code movement _only_.  Then you can have another patch 
that move code around within builtin-pack-objects.c without changing any 
functionality just to prepare the way for the next patch which would 
concentrate on the new feature only.  Then make sure you have the 
addition of the new capability separate from the patch that let other 
part of GIT use it.  Etc.

That would be much easier for us to comment on smaller patches, and 
especially easier for you to rework one of the smaller patches than the 
big one if need be.

I looked at your patch and there are things I like and other things I 
don't like at all.  Because it is a single large patch I may only NAK 
the whole of it.

> > > When --stdout is also specified,  all objects in the
> > 
> > Please scrap that.  There is simply no point making --pack-limit and
> > --stdout work together.  If the amount of data to send over the GIT
> > protocol exceeds 4G (or whatever) it is the receiving end's business to
> > split it up _if_ it wants/has to.  The alternative is just too ugly.
> I have a similar but much weaker reaction, but Linus specifically asked for
> this combination to work.

Linus is a total imcompetent who knows nothing about programming or good 
taste.  So never ever listen to what he says.  He is wrong, always.

And in this case he's more wrong than usual.

;-)

> So I made it work as well as possible
> given no seeking.

The fact is that there is no point in imposing split packs on the 
receiving end if it can accept a single pack just fine.  Pack layout is 
and must remain a local policy, not something that the remote end felt 
was good for the peer.  This is true for the treshold value to decide 
whether fetched packs are kept as is or unpacked as loose objects.  This 
is the same issue for pack size limit.

And as you discovered yourself, it is quite messy to implement in 
pack-objects when the output is a stream because you don't know in 
advance how many objects will be sent so you have to invent special 
markers to indicate the end of pack.  This in turn doesn't let 
index-pack know how much to expect and provide some progress report at 
all.  The appropriate location for the splitting of packs in a fetch 
context is really within index-pack not in pack-objects.  And it is 
probably so much easier to do in index-pack anyway.

> > > When --blob-limit=N is specified,  blobs whose uncompressed
> > > size is greater than or equal to N are omitted from the pack(s).
> > > If --pack-limit is specified, --blob-limit is not, and
> > > --stdout is not,  then --blob-limit defaults to 1/4
> > > of the --pack-limit.
> > Is this really useful?
> > 
> > If you have a pack size limit and a blob cannot make it even in a 
> > pack of its own then you're screwed anyway.  It is much better to 
> > simply fail the operation than leaving some blobs behind.  IOW I 
> > don't see the usefulness of this feature.
> I agree if --stdout is specified.  This is why --pack-limit && --stdout
> DON'T turn on --blob-limit if not specified.

Let's forget about --stdout.  I hope I convinced you that it doesn't 
make sense.

> However, if I'm building packs inside a non-(web-)published
> repository, I find this useful. First of all, if there's some blob bigger
> than the --pack-limit I must drop it anyway -- it's not clear to me that
> the mmap window code works on 32b systems
> with >2GB-sized objects in packs.  An "all-or-nothing" limitation
> wouldn't be helpful to me.

But do you realize that if you drop even a single object you are 
screwed?  The fetching of a repo that is missing objects is a corrupt 
fetch.  You cannot just sent a bunch of objects and leave a couple 
behind in the hope that the peer will never need them.  For one the peer 
would never be able to perform a successful git-fsck.

If you care about your local usage only then this feature is bogus as 
well.  The blob _has_ to exist as a loose object before ever being 
packed.  If you have blobs larger than 2GB or 4GB and your filesystem is 
unable to cope with that then you're screwed already.  You won't be able 
to check them out, etc.

> But blobs even close to the packfile limit don't seem all that useful
> to pack either (this of course is a weaker argument).

In the extreme case where you have a blob that is near the pack size 
limit then you'll end up with one pack per blob. No problem there.  If 
you're lucky then you might have 10 big blobs which size is near the 
pack size limit, but because they delta well against each other you 
might be able to stuff them all in a single pack.

And if a blob is larger than the pack limit then either you should 
increase your pack size limit, or if the pack limit is already near the 
filesystem capacity for a single file then the blob cannot exist on that 
filesystem in the first place.

So you still have to convince me this is a useful feature.

> Packing plays two roles: archive storage (long life) and
> transmission (possibly short life).

Packing is also a _huge_ performance boost.  Don't underestimate that.


Nicolas
