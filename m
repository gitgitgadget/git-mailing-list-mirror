From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH WIP 0/4] Special code path for large blobs
Date: Tue, 02 Jun 2009 13:22:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906021235100.3906@xanadu.home>
References: <1243488550-15357-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.00.0905281349320.3906@xanadu.home>
 <fcaeb9bf0906012146t7eab8dafm2b2b58aa96fb6220@mail.gmail.com>
 <20090602144555.GH30527@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 19:22:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBXh8-0007ow-1r
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 19:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948AbZFBRWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 13:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757155AbZFBRWV
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 13:22:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16342 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbZFBRWS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 13:22:18 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKM00KCRG92YRJ0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Jun 2009 13:22:15 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090602144555.GH30527@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120529>

On Tue, 2 Jun 2009, Shawn O. Pearce wrote:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > 2009/5/29 Nicolas Pitre <nico@cam.org>:
> > > However, like I said previously, I'd encapsulate large blobs in a pack
> > > right away instead of storing them as loose objects. ??The reason is that
> > > you can effortlessly repack/fetch/push them afterwards by simply
> > > triggering the pack data reuse code path for them. ??Extracting large and
> > > undeltified blobs from a pack is just as easy as from a loose object.
> > 
> > Makes sense. And the code looks nice too.
> > 
> > > To accomplish that, you only need to copy write_pack_file() from
> > > builtin-pack-objects.c and strip it to the bone with only one object to
> > > write.
> > 
> > write_pack_file() is too scary to me, I ripped from fast-import.c
> > instead. BTW, how does git handle hundreds of single object packs? I
> > don't know if prepare_packed_git scales in such cases.
> 
> Yea, its not going to do that great.

Well... remember that we're talking about huge objects here.  You're not 
likely to have so many of them.  And if you do have that many huge 
objects, then any operation you do is likely to access one of them 
anyway and then the pack lookup overhead will be lost in the noise.

> We may be able to improve that code path by sorting any pack whose
> index is really small and pack file is really big to the end of
> the list, where its least likely to be matched, so we don't even
> bother to load the index into memory during normal commit traversal.
> 
> But even with that sorting, its still going to suck.

I don't agree with that statement.  Supposing the sorting you propose 
above which I consider a pretty good idea doesn't provide any 
improvement, we already do pretty well with many packs since commit 
f7c22cc6.

> Lookup for a large binary is O(N), where N is the number of large 
> binary *revisions*.  Yuck.

It is almost like loose object lookups, except that you don't have a 256 
entry fanout.  But since the IO corresponding to such objects is 
expected to be much more significant than 256 times the IO for a tree or 
commit object, then again this shouldn't matter much in practice.

> Really, objects in the 200MB+ range probably should just be in a lone
> file named by its SHA-1... aka, a loose object.  Combining them into
> a pack is going to be potentially expensive disk IO wise, and may
> not gain you very much (its over 200 MB compressed with deflate, its
> likely already compressed binary content that may not delta well).

I must disagree again.  The above notwithstanding, the idea is _not_ to 
keep those large blobs into their own packs.  The idea is mainly to make 
a future repack much much easier with the current repack-objects code.  
And yes, we should repack even those large blobs eventually just like we 
do for loose objects.  Really there is no point keeping even large blobs 
in their own files.  If you do care about object lookup efficiency, 
having large objects into their own pack or loose does not make such a 
huge difference.  Sure a factor of 256 might be considered significant, 
but this is only a linear cost improvement while object lookup within a 
pack gets an exponential cost improvement.

There are ways already to enforce some size policies on pack files if 
you don't want to keep all your objects into a single pack, but even a 
single huge pack should work just fine as well and you may .keep it 
afterward not to repack it anymore, or until a monthly or quarterly 
repository maintenance.  So in practice you shouldn't be accumulating 
_that_ many single object packs anyway.

> Way back we had that pack-style loose object format, for exactly
> these sorts of files, and exactly to avoid having many packs of
> just 1 object, but that didn't go anywhere... indeed, Nico deleted
> the code that creates that format.

And the rational was exactly the one above: large blobs have no reason 
what so ever to _remain_ alone into a file, be it a loose object or a 
single object pack.  And just like for loose objects, you don't have to 
repack large blobs right away so the IO cost can be postponed for when 
that doesn't matter.


Nicolas
