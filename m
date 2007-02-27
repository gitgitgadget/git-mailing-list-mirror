From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Tue, 27 Feb 2007 12:03:56 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702271150050.29426@xanadu.home>
References: <200702261540.27080.ttelford.groups@gmail.com>
 <20070226235510.GF1639@spearce.org>
 <alpine.LRH.0.82.0702261916560.29426@xanadu.home>
 <20070227003118.GH1639@spearce.org>
 <alpine.LRH.0.82.0702262306100.29426@xanadu.home>
 <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com>
 <alpine.LRH.0.82.0702270002100.29426@xanadu.home>
 <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 18:04:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM5kH-00088T-3k
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 18:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbXB0REA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 12:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbXB0REA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 12:04:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34499 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbXB0RD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 12:03:59 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE4002M5SQM10H2@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 12:03:59 -0500 (EST)
In-reply-to: <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40761>

On Tue, 27 Feb 2007, Geert Bosch wrote:

> 
> On Feb 27, 2007, at 00:11, Nicolas Pitre wrote:
> 
> > > BTW, here are a few issues with the current pack file format:
> > > - The final SHA1 consists of the count of objects in the file
> > >   and all compressed data. Why? This is horrible for streaming
> > >   applications where you only know the count of objects at the
> > >   end, then you need to access *all* data to compute the SHA-1.
> > >   Much better to just use compute a SHA1 over the SHA1's of each
> > >   object. That way at least the data streamed can be streamed to
> > >   disk. Buffering one SHA1 per object is probably going to be OK.
> > 
> > We always know the number of objects before actually constructing or
> > streaming a pack.  Finding best delta matches require that we sort the
> > object list by type, but for good locality we need to re-sort that list
> > by recency.  So we always know the number of objects before starting to
> > write since we need to have the list of objects in memory anyway.
> 
> When I import a large code-base (such as a *.tar.gz), I don't know
> beforehand how many objects I'm going to create. Ideally, I'd like
> to stream them directly into a new pack without ever having to write
> the expanded source to the filesystem.

Have a look at git-fast-import and contrib/fast-import/import-tars.perl.

Regardless, you cannot produce a decent pack without knowing in advance 
how many objects you have.  Thisis why git-fast-import produces a 
suboptimal pack that needs to be repacked in the end.

> The object-count at the beginning of the pack is a little strange for
> local on-disk pack files, as it is data that can easily be derived.
> The *index* would seem to be the proper place for this.

The index is _not_ sent over the network protocol by design.  But like I 
said the receiving end wants to know up front how many objects it'll 
have to parse.

> Also, it is not possible to write a dummy 0 in the count and then fill in
> the correct count at the end, because the final SHA1 at the end of the pack
> file is a checksum over the count followed by all the pack data.
> So for creating a large pack from a stream of data, you have to do the
> following:
>  1. write out a temporary pack file to disk without correct count
>  2. fix-up the count
>  3. read the entire temporary pack file to compute the final SHA-1
>  4. fix-up the SHA1 at the end of the file
>  5. construct and write out the index

Sure.  That's in fact what index-pack does when it has to fix up a thin 
pack. But did you find any _real_ issue with this?  Resolving deltas and 
recomputing the index is far more costly than simply redoing the whole 
pack checksum.

> There are a few ways to fixing this:
>  - Have a count of 0xffffffff mean: look in the index for the count.
>    Pulling/pushing would still use regular counted pack files.
>  - Have the pack file checksum be the SHA1 of (the count followed
>    by the SHA1 of the compressed data of each object). This would allow 3.
>    to be done without reading back all data.

Well we _could_ exclude the object count (or even the entire pack 
header for that matter) from the pack checksum.  This way a streamed 
pack streamed to disk could be seeked back to have its object number 
fixed up once it is known without needing to start the checksum all 
over.  Maybe something to consider for pack v4.  But in practice I don't 
see that as a big issue.


Nicolas
