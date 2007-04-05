From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-{repack,pack-objects} accept --{pack,blob}-limit to control pack size
Date: Thu, 5 Apr 2007 03:15:12 -0400
Message-ID: <20070405071511.GE5436@spearce.org>
References: <56b7f5510704041340l5997b04dp853e8270a644ab28@mail.gmail.com> <alpine.LFD.0.98.0704041750030.28181@xanadu.home> <56b7f5510704041555q4e735961ra9ee8008be0d33db@mail.gmail.com> <alpine.LFD.0.98.0704042203160.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 09:15:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZMBs-0006iq-5C
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 09:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbXDEHPZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 03:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752204AbXDEHPY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 03:15:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54922 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbXDEHPX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 03:15:23 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZMBe-0006xD-27; Thu, 05 Apr 2007 03:15:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9399720FBAE; Thu,  5 Apr 2007 03:15:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704042203160.28181@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43803>

Nicolas Pitre <nico@cam.org> wrote:
> But let's take a moment to talk about your "newbie submission".  This 
> patch is _way_ too large and covers too many things at once.  You'll 
> have to split it in many smaller logical units pretty please.

Yes, absolutely!  If I was doing this series I'd probably have this
broken into at least 5, maybe even 8 patches.  There's a lot of
stuff here, and some of it was completely unrelated to each other.
Like a fix for lseek arguments?  Uhh, that's so not what this patch
was about, but is still a good fix.  Nice catch.  Lets get it in,
but properly please.

I also noticed a lot of "/* and here we could do... */" markers.
I think these belong more in the commit message than in the code
itself, as the code gets really cluttered after a while with the
todo markers that nobody has done yet.  Odds are, if you don't do
it in this series, it won't get done for quite a while, if ever.
Mention it in your commit message, so others are aware of it,
and leave it at that.

> On Wed, 4 Apr 2007, Dana How wrote:
> > I have a similar but much weaker reaction, but Linus specifically asked for
> > this combination to work.
> 
> Linus is a total imcompetent who knows nothing about programming or good 
> taste.  So never ever listen to what he says.  He is wrong, always.

Now now, I wouldn't go that far...
 
> And in this case he's more wrong than usual.

But yes, in this case I certainly I agree with you Nico.  ;-)
 
> The appropriate location for the splitting of packs in a fetch 
> context is really within index-pack not in pack-objects.  And it is 
> probably so much easier to do in index-pack anyway.

Or in a push context.  I have started down the road of doing the
pack splitting in index-pack, but never was able to finish it.
It is totally doable in index-pack, but it turned out to be more
work than I had time for when I started it.

I still have the topic laying in my repository, and it is pushed
to my fastimport.git fork on repo.or.cz, if someone wants to take
a look at it.  The patch is far from complete, hence no patch to
mailing list.

> > But blobs even close to the packfile limit don't seem all that useful
> > to pack either (this of course is a weaker argument).
> 
> So you still have to convince me this is a useful feature.

Me too.  Nico's right.  And lets just assume we are in a bad case
where we need to put one (and only one) such blob into each packfile.
The packfile on disk will be an additional 32 bytes larger than if
it were to stay a loose file, and that's assuming the loose file was
created using the newer-style loose file format.  This is unlikely
to cause a large disk space overhead.

Yea, we to have an extra SHA-1 we have to compute when we created
the file, but then we also have another SHA-1 to verify that the
zlib stream is not corrupt, *without* unpacking the zlib stream.
That in and of itself could be useful for an fsck, we could do a
faster rule that says "if there's only a couple of blobs in this
packfile, and the thing is *big*, just do a check of the packfile
SHA-1 and assume the blobs are OK".  So there actually might be
value to that extra SHA-1 after all.
 
-- 
Shawn.
