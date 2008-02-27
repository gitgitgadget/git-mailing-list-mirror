From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Wed, 27 Feb 2008 16:26:00 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802271605540.19665@iabervon.org>
References: <200802102007.38838.lenb@kernel.org> <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org> <200802261438.17014.lenb@kernel.org> <7vir0byoc2.fsf@gitster.siamese.dyndns.org> <7voda2yksf.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802271411280.19665@iabervon.org> <7vskzeruit.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Len Brown <lenb@kernel.org>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 22:27:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUTo9-00030j-4Q
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 22:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761914AbYB0V0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 16:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761954AbYB0V0E
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 16:26:04 -0500
Received: from iabervon.org ([66.92.72.58]:43565 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897AbYB0V0D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 16:26:03 -0500
Received: (qmail 5346 invoked by uid 1000); 27 Feb 2008 21:26:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2008 21:26:00 -0000
In-Reply-To: <7vskzeruit.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75304>

On Wed, 27 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Correcting the transport code is important (and should probably be done in 
> > transport.c, if possible), but I think we're being a bit silly in 
> > autofollowing tags anyway. If we decide to fetch T due to having T^{}, we 
> > should tell the remote up front that we have T^{}, before we mention 
> > anything else, because it's obviously true and it's also absolutely 
> > certain to make the remote immediately do the right thing.
> 
> That's correct, and the autofollowing code does so.  You will
> not know if you have T^{} until your primary transfer finishes,
> so you cannot roll autofollow into it.
> 
> I think we can teach the upload-pack side to be more helpful and
> with a protocol extension to send tag objects that are pointing
> at commits that will be included in the result, or something
> like that, though.  But that is outside the scope of 1.5.5; it
> would be a moderate to large protocol surgery, and I suspect it
> might even have to affect pack-objects.

Using a single connection, either by just telling the remote that you want 
to autofollow tags, and it should therefore include any tags that point to 
any objects it includes, or by allowing you to list more refs that you 
want after you've received the pack without disconnecting, would be quite 
nice, but I agree that it's a longer-term issue.

> > It's silly to 
> > decide to fetch T because we will only need that one object, and then not 
> > instantly tell the server we only need that one object. (And, as luck 
> > would have it, yesterday I wrote code to cause for_each_ref return some
> > specific values in addition to and before the actual stored refs.)
> 
> You won't know if you need only one object, so seeing that you
> have T^{} and asking _only_ for T is _wrong_.  Think of a tag
> that points at another tag that points at the commit.  You need
> to tell the other end "I have T^{}, please give me T", and that
> is exactly what the autofollowing does.

I don't see that. If the situation is:

      T - tag     master
     /           /
O - A - O - O - B

the first fetch will see:

tag: T
tag^{}: A
master: B

Only heads are interesting, so we fetch B. When we've fetched B, we find 
that we now have tag^{}. So then we do a new fetch, and (bugs aside) list 
our now-current refs, including origin/master (=B) but not including A, 
because we don't (yet) have any refs for it. I'm suggesting that, while 
autofollowing tags, we should make a point of listing A, because we know 
it's relevant. Furthermore, if the remote doesn't have B (due to mirror 
skew, perhaps), listing B and not listing A (in particular) will lead to 
an inexact search for a common commit, when we know perfectly well that A 
is the closest common commit between what we have and tag.

The issue is that our starting set for our side of the negotiation is our 
current refs, which doesn't include A. I'm suggesting that, for the 
purposes of autofollow, A should be included.

	-Daniel
*This .sig left intentionally blank*
