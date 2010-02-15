From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 23:16:37 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002142252020.1946@xanadu.home>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
 <20100214024259.GB9704@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>
 <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com>
 <32541b131002141513m29f9a796ma8fb5855a45f91e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 05:20:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgsRb-0002uD-I1
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 05:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab0BOEQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 23:16:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52425 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab0BOEQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 23:16:38 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXV003BO7VPV500@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 14 Feb 2010 23:16:37 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <32541b131002141513m29f9a796ma8fb5855a45f91e9@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139965>

On Sun, 14 Feb 2010, Avery Pennarun wrote:

> On Sun, Feb 14, 2010 at 2:06 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> > BTW, probably, it is not difficult to stream a large file in chunks (and
> > it may be even much faster, because we work on CPU cache), but I suspect
> > it will not resolve all issues with huge files, because eventually we
> > need to store them in a pack file. So we need to develop some strategy
> > how to deal with them.
> 
> It definitely doesn't resolve all the issues.  There are different
> ways of looking at this; one is to not bother make git-add work
> smoothly with large files, because calculating the deltas will later
> cause a disastrous meltdown anyway.

We have that core.bigFileThreshold configuration variable now.  It is 
currently only used by fast-import.  But the idea is to apply it across 
the board when that makes sense.  And one of those places is to skip 
over those files when it comes to delta compression.

> In fact, arguably you should prevent git-add from adding large files 
> at all, because at least then you don't get the repository into a 
> hard-to-recover-from state with huge files.  (This happened at work a 
> few months ago; most people have no idea what to do in such a 
> situation.)

Git needs to be fixed in that case, not be crippled.

> The other way to look at it is that if we want git to *eventually*
> work with huge files, we have to fix each bug one at a time, and we
> can't go making things worse.

Obviously.

> For my own situation, I think I'm more likely to (and I know people
> who are more likely to) try storing huge files in git than I am likely
> to modify a file *while* I'm trying to store it in git.

And fancy operations on huge files are pretty unlikely.  Blame, diff, 
etc, are suited for text file which are by nature relatively small.  
And if your source code is all pasted in one single huge file that Git 
can't handle right now, then the compiler is unlikely to cope either.

> > One way to deal with them is to stream directly into a separate pack.
> > Still, it does not resolve all problems, because each pack file should
> > be mapped into a memory, and this may be a problem for 32-bit system
> > (or even 64-bit systems where a sysadmin set limit on amount virtual
> > memory available a single program).

This is not a problem at all.  Git already deals with packs bigger than 
the available memory by not mapping them whole -- see documentation for 
core.packedGitWindowSize.

> > The other way to handle huge files is to split them into chunks.
> > http://article.gmane.org/gmane.comp.version-control.git/120112

No.  The chunk idea doesn't fit the Git model well enough without many 
corner cases all over the place which is a major drawback.  I think that 
was discussed in that thread already.

> I have a bit of experience splitting files into chunks:
> http://groups.google.com/group/bup-list/browse_thread/thread/812031efd4c5f7e4
> 
> It works.  Also note that the speed gain from mmap'ing packs appears
> to be much less than the gain from mmap'ing indexes.  You could
> probably sacrifice most or all of the former and never really notice.
> Caching expanded deltas can be pretty valuable, though.  (bup
> presently avoids that whole question by not using deltas.)

We do have a cache of expanded deltas already.

> I can also confirm that streaming objects directly into packs is a
> massive performance increase when dealing with big files.  However,
> you then start to run into git's heuristics that often assume (for
> example) that if an object is in a pack, it should never (or rarely)
> be pruned.  This is normally a fine assumption, because if it was
> likely to get pruned, it probably never would have been put into a
> pack in the first place.

Would you please for my own sanity tell me where we do such thing.  I 
thought I had a firm grip on the pack model but you're casting a shadow 
of doubts on some code I might have written myself.


Nicolas
