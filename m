From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: gc --aggressive
Date: Sun, 29 Apr 2012 09:53:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1204290917051.21030@xanadu.home>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
 <20120428122533.GA12098@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
 <20120429113431.GA24254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 15:53:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOUZG-0001v0-AA
	for gcvg-git-2@plane.gmane.org; Sun, 29 Apr 2012 15:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab2D2Nxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 09:53:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58377 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab2D2Nxc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 09:53:32 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M38000BRUL72L90@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 29 Apr 2012 09:53:32 -0400 (EDT)
In-reply-to: <20120429113431.GA24254@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196509>

On Sun, 29 Apr 2012, Jeff King wrote:

> On Sat, Apr 28, 2012 at 01:11:48PM -0400, Nicolas Pitre wrote:
> 
> > > Here's a list of commands and the pack sizes they yield on the repo:
> > > 
> > >   1. `git repack -ad`: 246M
> > >   2. `git repack -ad -f`: 376M
> > >   3. `git repack -ad --window=250`: 246M
> > >   4. `git repack -ad -f --window=250`: 145M
> > > 
> > > The most interesting thing is (4): repacking with a larger window size
> > > yields a 100M (40%) space improvement. The other commands show that it
> > > is not that the current pack is simply bad; command (2) repacks from
> > > scratch and actually ends up with a worse pack. So the increased window
> > > size really is important.
> > 
> > Absolutely.  This doesn't surprises me.
> 
> I was somewhat surprised, because this repo behaves very differently
> from other ones as the window size increases. Our default window of 10
> is somewhat arbitrary, but I think there was a sense from early tests
> that you got diminishing returns from increasing it (this is my vague
> recollection; I didn't actually search for old discussions). 

Yes, your numbers are very interesting.

But my remark was related to the fact that you need to double the 
affected resources to gain marginal improvements at some point.  This is 
true about computing hardware too: eventually you need way more gates 
and spend much more $$$ to gain some performance, and the added 
performance is never linear with the spending.

> But here are some charts showing "repack -adf" with various window 
> sizes on a few repositories. The first column is the window size; the 
> second is the resulting pack size (and its percentage of the window=10 
> case); the third is the number of seconds of CPU time (and again, the 
> percentage of the window=10 case).
> 
> Here's git.git:
> 
>   10 | 31.3M (100%) |   54s (100%)
>   20 | 28.8M ( 92%) |   72s (133%)
>   40 | 27.4M ( 87%) |  101s (187%)
>   80 | 26.3M ( 84%) |  153s (282%)
>  160 | 25.7M ( 82%) |  247s (455%)
>  320 | 25.4M ( 81%) |  415s (763%)
> 
> You can see we get some benefit from increasing window size to 20 or
> even 40, but we hit an asymptote around 80%. Meanwhile, CPU time keeps
> jumping. Something like 20 or 40 seems like it might be a nice
> compromise.
> 
> Here's linux-2.6:
> 
>   10 | 564M (100%) |  990s (100%)
>   20 | 521M ( 92%) | 1323s (134%)
>   40 | 495M ( 88%) | 1855s (187%)
>   80 | 479M ( 85%) | 2743s (277%)
>  160 | 470M ( 83%) | 4284s (432%)
>  320 | 463M ( 82%) | 7064s (713%)
> 
> It's quite similar, asymptotically heading towards ~80%. And the CPU
> numbers look quite similar, too.
> 
> And here's the phpmyadmin repository (the one I linked to earlier):
> 
>   10 | 386M (100%) | 1592s (100%)
>   20 | 280M ( 72%) | 1947s (122%)
>   40 | 209M ( 54%) | 2514s (158%)
>   80 | 169M ( 44%) | 3386s (213%)
>  160 | 151M ( 39%) | 4822s (303%)
>  320 | 142M ( 37%) | 6948s (436%)
> 
> The packfile size improvements go on for much longer as we increase the
> window size. For this repo, a window size of 80-100 is probably a good
> spot.
> 
> That leads me to a few questions:
> 
>   1. Should we bump our default window size? The numbers above show that
>      typical repos would benefit from jumping to 20 or even 40.

I think this might be a good indication that the number of objects is a 
bad metric to size the window, as I mentioned previously.

Given that you have the test repos already, could you re-run it with 
--window=1000 and play with --window-memory instead?  I would be curious 
to see if this provides more predictable results.

>   2. Is there a heuristic or other metric we can figure out to
>      differentiate the first two repositories from the third, and use a
>      larger window size on the latter?

Maybe we could look at the size reduction within the delta search loop.  
If the reduction quickly diminishes as tested objects are further away 
from the target one then the window doesn't have to be very large, 
whereas if the reduction remains more or less constant then it might be 
worth searching further.  That could be used to dynamically size the 
window at run time.

>   3. Does the phpmyadmin case give us any insight into whether we can
>      improve our window sorting algorithm? Looking at the repo, ~55K of
>      the ~75K commits are small changes in the po/ directory (it looks
>      like they were using a web-based tool to let non-committers tweak
>      the translation files). In particular, I see a lot of commits in
>      which most of the changes are simply line number changes as the po
>      files are refreshed from the source. I wonder if that is making the
>      size-sorting heuristics perform poorly, as we end up with many
>      files of the same size, and the good deltas get pushed further
>      along the window.

You could test this theory by commenting out the size comparisons in 
type_size_sort() and re-run the test.  Linus initially introduced that 
criterion thinking that newer files tend to grow and it is cheaper to 
create a delta that removes data than one that adds data.  And given 
that we wanted to prefer delta chains to start from newer objects this 
all made sense.  However the last comparison in that function is meant 
to handling the recency ordering, and therefore the size comparison 
might be skewing things here.

>   4. What is typical? I suspect that git.git and linux-2.6 are typical,
>      and the weird po-files in the phpmyadmin repository are not. But
>      I'd be happy to test more repos if people have suggestions. And the
>      scripts that generated the charts are included below if anybody
>      wants to try it themselves.

I wouldn't give up on "non typical" data sets just yet though.


Nicolas
