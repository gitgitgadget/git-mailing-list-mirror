From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull is slow
Date: Sat, 12 Jul 2008 18:05:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807121546590.8950@racer>
References: <g5570s$d5m$1@ger.gmane.org> <g57jkp$ekm$1@ger.gmane.org> <48776169.20705@op5.se> <alpine.DEB.1.00.0807111443280.8950@racer> <4878A442.6020405@arcor.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Stephan Hennig <mailing_list@arcor.de>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jul 12 19:06:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHiY9-0003Ya-Ca
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 19:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbYGLRFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 13:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYGLRFR
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 13:05:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:49366 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751370AbYGLRFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 13:05:16 -0400
Received: (qmail invoked by alias); 12 Jul 2008 17:05:13 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp026) with SMTP; 12 Jul 2008 19:05:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/I39snfCvIo7Un3Flv0/7RwvnSup93UA3L4IJDMA
	R+FtzrGE6m+8UJ
X-X-Sender: gene099@racer
In-Reply-To: <4878A442.6020405@arcor.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88256>

Hi,

On Sat, 12 Jul 2008, Stephan Hennig wrote:

> Johannes Schindelin schrieb:
> > On Fri, 11 Jul 2008, Andreas Ericsson wrote:
> > 
> >> Seems like you're being bitten by a bug we had some months back, 
> >> where the client requested full history for new tag objects.
> > 
> > I do not think so.  I think it is a problem with the pack.  The 
> > slowness is already there in the clone, in the resolving phase.
> 
> Thanks for having a look at this!  What does "problem with the pack" 
> mean?  Do you think it is a Git problem (client or server side?) or just 
> a misconfiguration?

I thought that the blobs in the pack are just too similar.  That makes for 
a good compression, since you get many relatively small deltas.  But it 
also makes for a lot of work to reconstruct the blobs.

I suspected that you run out of space for the cache holding some 
reconstructed blobs (to prevent reconstructing all of them from scratch).

To see what I mean, just look at

$ git -p verify-pack -v \
  .git/objects/pack/pack-563c2d83940c7e2d8c20a35206a390e2e567282f.pack

(or whatever pack you have there).  It has this:

-- snip --
chain length = 40: 7 objects
chain length = 41: 8 objects
chain length = 42: 4 objects
chain length = 43: 8 objects
chain length = 44: 6 objects
chain length = 45: 2 objects
chain length = 46: 6 objects
chain length = 47: 2 objects
chain length = 48: 2 objects
chain length = 49: 2 objects
chain length = 50: 2 objects
-- snap --

... but that could not be the reason, as my current git.git's pack shows 
this:

-- snip --
chain length = 40: 122 objects
chain length = 41: 99 objects
chain length = 42: 77 objects
chain length = 43: 76 objects
chain length = 44: 69 objects
chain length = 45: 72 objects
chain length = 46: 66 objects
chain length = 47: 103 objects
chain length = 48: 77 objects
chain length = 49: 111 objects
chain length = 50: 86 objects
chain length > 50: 60 objects
-- snap --

... which is much worse.

So I tried this:

-- snip --
wortliste$ /usr/bin/time git index-pack -o /dev/null 
.git/objects/pack/pack-563c2d83940c7e2d8c20a35206a390e2e567282f.pack
fatal: unable to create /dev/null: File exists
Command exited with non-zero status 128
27.12user 11.21system 2:51.02elapsed 22%CPU (0avgtext+0avgdata 
0maxresident)k
81848inputs+0outputs (1134major+2042348minor)pagefaults 0swaps
-- snap --

Compare that to git.git:

-- snip --
git$ /usr/bin/time git index-pack -o /dev/null 
.git/objects/pack/pack-355b54f45778b56c00099bf45369f8a4f2704a51.pack
fatal: unable to create /dev/null: File exists
Command exited with non-zero status 128
16.13user 0.38system 0:17.80elapsed 92%CPU (0avgtext+0avgdata 
0maxresident)k
81288inputs+0outputs (38major+51917minor)pagefaults 0swaps
-- snap --

So it seems that the major faults (requiring I/O) occur substantially more 
often with your repository.

BTW the RAM numbers here are obviously bogus, the program trashed the disk 
like there was no tomorrow.

Okay, "valgrind --tool=massif" to the rescue:

-- snip --
MB
555.9^                                                            ,  #
|                                                                 @..#
|                                                             @. :@::#
|                                              ,             @@: :@::#
|                                          ,@. @:.  .:: @: : @@: :@::#
|                                      @: .@@::@:: :::: @: : @@: :@::#
|                                   , .@: :@@::@:: :::: @: : @@: :@::#
|                           .      .@ :@: :@@::@:: :::: @: : @@: :@::#
|                        . :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::#
|                      . : :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::#
|                . ,.: : : :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::# :
|               .: @:: : : :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::# :
|              ::: @:: : : :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::# :
|             :::: @:: : : :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::# :
|          . ::::: @:: : : :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::# :.
|         .: ::::: @:: : : :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::# ::
|        ::: ::::: @:: : : :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::# ::
|      : ::: ::::: @:: : : :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::# ::
|    .:: ::: ::::: @:: : : :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::# ::
| . :::: ::: ::::: @:: : : :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::# ::
0----------------------------------------------------------------------->Gi
                                                                   32.83
-- snap --

Whoa. As you can see, your puny little 3.3 megabyte pack is blown to a 
full 555 megabyte in RAM.

That is bad.

Okay, so what is the reason?

You have a pretty large file there, "wortliste", weighing in with 13 
megabyte.  This file is part of at least one of those 50-strong delta 
chains.

To reconstruct the blobs, we have to store all intermediate versions in 
RAM (since index-pack is called with "--stdin" from receive-pack, which is 
called by clone).  Now, the file was big from the beginning, so you end up 
with ~13*50 megabyte (actually, even 100 megabyte less) while indexing 
one single delta chain.

My tests were performed on a puny little laptop (512MB RAM, to be precise, 
as I am a strong believer that developers with too powerful machines just 
lose touch to reality and write programs that are only useful to 
themselves, but useless for everyone else), where this hurt big time.

Now, I do not know the internals of index-pack enough to know if there is 
a way to cut the memory usage (by throwing out earlier reconstructed 
blobs, for example, and reconstructing them _again_ if need be), so I 
Cc:ed Nico and hand the problem off to him.

I expect this to touch the resolve_delta() function of index-pack.c in a 
major way, though.

Ciao,
Dscho

P.S.: It seems that "git verify-pack -v" only shows the sizes of the 
deltas.  Might be interesting to some to show the unpacked _full_ size, 
too.
