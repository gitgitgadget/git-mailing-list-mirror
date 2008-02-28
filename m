From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Thu, 28 Feb 2008 10:53:18 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802281026030.19665@iabervon.org>
References: <200802102007.38838.lenb@kernel.org> <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org> <200802261438.17014.lenb@kernel.org> <7vir0byoc2.fsf@gitster.siamese.dyndns.org> <7voda2yksf.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802271411280.19665@iabervon.org> <7vskzeruit.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802271605540.19665@iabervon.org> <7voda1nbzc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Len Brown <lenb@kernel.org>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 16:54:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUl56-0002Rm-Of
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 16:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759929AbYB1PxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 10:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759988AbYB1PxW
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 10:53:22 -0500
Received: from iabervon.org ([66.92.72.58]:51313 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757620AbYB1PxV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 10:53:21 -0500
Received: (qmail 3351 invoked by uid 1000); 28 Feb 2008 15:53:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Feb 2008 15:53:18 -0000
In-Reply-To: <7voda1nbzc.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75415>

On Wed, 27 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Wed, 27 Feb 2008, Junio C Hamano wrote:
> >
> >> Daniel Barkalow <barkalow@iabervon.org> writes:
> >> 
> >> > Correcting the transport code is important (and should
> >> > probably be done...
> 
> I thought about discarding the cached refs upon disconnect, but didn't do
> that, because presumably a caller might want to:
> 
>     transport_get_remote_refs() to find what they have
>     decide what it wants
>     transport_fetch_refs() to ask for them
>     do stuff about the refs obtained
>     transport_disconnect() to finish the transfer
>     still do stuff about the refs obtained
> 
> and such a change would forbid the last step.  But the only reason I
> avoided to break such a potential caller was because I did not bother to
> check if such a caller exists, and not because I thought the above
> sequence is sane, so if you think it is saner to clean up the stale
> information upon disconnect, please do so.

Actually, I just realized something which should have been obvious: when 
we reconnect, we get a list of the remote's refs, which we currently 
discard immediately. We should actually pass this list to fetch_pack() if 
we just reconnected, so that the client side always does the interaction 
with the right idea of the server's refs, and discard it afterwards. The 
fact that the user of transport_*() doesn't find out that the server 
side's refs change in the middle of the life cycle and can't find out in 
any way doesn't matter too much, so long as each actual connection is 
internally consistant. (And the situation is no different from how it used 
to be with git-fetch.sh: if you get a different mirror later, you may 
discover that the server now doesn't have refs that it seemed to 
advertize, but nothing weird happens.)

> >> You won't know if you need only one object, so seeing that you
> >> have T^{} and asking _only_ for T is _wrong_.  Think of a tag
> >> that points at another tag that points at the commit.  You need
> >> to tell the other end "I have T^{}, please give me T", and that
> >> is exactly what the autofollowing does.
> >
> > I don't see that. If the situation is:
> >
> >       T - tag     master
> >      /           /
> > O - A - O - O - B
> > ...
> > The issue is that our starting set for our side of the negotiation is our 
> > current refs, which doesn't include A. I'm suggesting that, for the 
> > purposes of autofollow, A should be included.
> 
> By telling the other end that we have B, we are implicitly telling that we
> have A as well.  Under normal situation, telling the other end we have A
> does not help nor hurt anything.

I think it could be slightly less server load if it doesn't have to walk 
from B to A, and I could make up something about cache locality.

> Under abnormal situation (e.g. DNS round
> robin switching the other end in the middle), the other end may say "I
> dunno about B", but the protocol is designed to negotiate and find that
> both ends have A, by following the ancestry chain down, so I do not think
> telling the other end that we have A helps that much.

I remember your tests that didn't quite show the problem leading to the 
autofollow connection getting ~100 objects, which is better than 700000 
but worse than the correct 1 for that case; I think it had found a commit 
commit not too far away, but not the perfect one.

> I however think
> that such a change would help sweeping potential bugs under the rug by
> making them harder to trigger.
> 
> By the way, the situation I said your logic would break is this:
> 
>     ---o---A---o---o---B
>             \
>              T---S
> 
> Both T and S are annotated tags, pointing at A and T respectively, and
> they both peel to A.  As long as you ask for both T and S you may be Ok,
> but it feels still wrong.  Commit walkers may grab S, die before grabbing
> T (git-native protocol is atomic with respect to objects transfer, so it
> won't have such an issue).

They wouldn't write a ref for S, though, so the result would be consistant 
still. If you ask for T and S and say you have A, everything should work.

	-Daniel
*This .sig left intentionally blank*
