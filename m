From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 22:39:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704172154160.4504@xanadu.home>
References: <200704171041.46176.andyparkins@gmail.com>
 <"200704171803.58940.a n dyparkins"@gmail.com>
 <200704172012.31280.andyparkins@gmail.com>
 <alpine.LFD.0.98.0704171530220.4504@xanadu.home>
 <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171624190.4504@xanadu.home>
 <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171708360.4504@xanadu.home>
 <7vy7kqlj5r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 04:40:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He05a-0007Nr-GG
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 04:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965271AbXDRCjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 22:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965301AbXDRCjo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 22:39:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25794 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965084AbXDRCjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 22:39:42 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGO00KNOA25Y7A0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Apr 2007 22:39:41 -0400 (EDT)
In-reply-to: <7vy7kqlj5r.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44854>

On Tue, 17 Apr 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> >> I would like to, however this doesn't currently integrate
> >> well with git. I've been told in the past that once
> >> .gitattributes is in place then the hooks for the crlf stuff
> >> can be generalized to allow for calls out to custom code to
> >> do this sort of thing.
> >
> > And I agree that this is a perfectly sensible thing to do.  The facility 
> > should be there for you to apply any kind of transformation with 
> > external tools on data going in or out from Git.  There are good and bad 
> > things you can do with such a facility, but at least it becomes your 
> > responsibility to screw^H^H^H^Hfilter your data and not something that 
> > is enforced by Git itself.
> 
> You have to be careful, though.  Depending on what kind of
> transformation you implement with the external tools, you would
> end up having to slow down everything we would do.

So what?  

We provide a rope with proper caveat emptor.  Up to others to hang 
themselves with it if they so desire.  It is not our problem anymore.

> It boils down to this statement from Andy:
> 
>     ..., keywords (in other VCSs, and so why not in git) are
>     only updated when a file is checked out.  There is no need
>     to touch every file.  It's actually beneficial, because the
>     keyword in the file is the state of the file at the time it
>     was checked in - which is actually more useful than updating
>     it to the latest commit every time.
> 
>     That means you're only ever expanding in a file that your
>     changing anyway - so it's effectively free.  git-checkout
>     would still be immediate and instantaneous.
> 
> Back up a bit and think what "when a file is checked out" means.
> His argument assumes the current behaviour of not checking out
> when the underlying blob objects before munging are the same.

And I think that should remain.  If someone really wants full 
transformation aka keyword expansion or whatever then he'd just need to 
force a full read-tree after switching branch.

> But with keyword expansion and fancier "external tools" whose
> semantics are not well defined (iow, defined to be "do whatever
> they please"), does it still make sense to consider two blobs
> that appear in totally different context "the same" and omit
> checking out (and causing the external tools hook not getting
> run)?

I think so.  At least by default.  And if we really want to be kind we 
could provide a special attribute just for disabling such optimization 
i.e. to force a checkout of everything marked with such an attribute 
everytime.  But we might as well wait to see if someone actually ask 
about that.

But for many other cases having such a facility would be just nice 
especially for those cases that don't depend on the branch/commit but 
only on the content itself.  For example it was pointed out that Open 
Office documents are gzipped XML files.  In that case it would be 
extremely advantageous to have the ability to specify an input filter as
"gzip -d" and an output filter as "gzip -c" so Git has a chance to 
actually perform some kind of delta compression.

I'm sure there might be other type of filters for situation we've not 
thought about yet, and that we might not want to carry as a builtin 
feature.  Who knows, maybe someone might want to port Git to the 
System/360 and will need an EBCDIC filter on checked out text files.  Or 
maybe a byte swapping filter for some kind of binary files when on a 
system with a different endianness.

> I already pointed out to Andy that the branch name the
> file was taken from, if it were to take part of the keyword
> expansion, would come out incorrectly in his printed svg
> drawing.

Tough.

> If you want somebody's earlier example of "giving a file with
> embedded keyword to somebody, who modifies and sends the result
> back in full, now you would want to incorporate the change by
> identifying the origin" to work, you would want "$Source$" (I am
> looking at CVS documentation, "Keyword substitution/Keyword
> List") to identify where that file came from (after all, a
> source tree could have duplicated files) so that you can tell
> which file the update is about, and this keyword would expand
> differently depending on where in the project tree the blob
> appears.

Like we don't record renames, I don't think we should record such thing 
in checked out files either.  Using a search for the closest match (like 
we do for rename detection) is probably a better avenue than trusting 
that the ID embedded in the file wasn't messed with.  Linus already 
provided a small script that would do that with pretty good results.

> It is not just the checkout codepath.  We omit diffs when we
> know from SHA-1 that the blobs are the same before decoration.
> We even omit diffs when we know from SHA-1 that two trees are
> the same without taking possible decorations that can be applied
> differently to the blobs they contain into account.  Earlier,
> Andy said he wanted to grep for the expanded text if he is
> grepping in the working tree, and I think that makes sense, but
> that means git-grep cannot do the same "borrow from working tree
> when expanding from blob object is more expensive" optimization
> we have for diff.  We also need to disable that optimization
> from the diff, regardless of what the correct semantics for
> grepping in working trees should be.
> 
> I suspect that you would have to play safe and say "when
> external tools are involved, we need to disable the existing
> content SHA-1 based optimization for all paths that ask for
> them" to keep your sanity.

Maybe.  If that is what's really needed then so be it.  People who 
really want to do strange things will have the flexibility to do so, but 
they'll have to pay the price in loss of performance.


Nicolas
