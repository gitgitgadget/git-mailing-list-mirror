From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Zero padded file modes...
Date: Thu, 05 Sep 2013 12:56:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309051244160.14472@syhkavp.arg>
References: <CAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com>
 <20130905153646.GA12372@sigill.intra.peff.net>
 <CACsJy8C4PN4n1W71ajnoyFjaWCsxQjbXMbT-tcfgpXeoJKyXyA@mail.gmail.com>
 <20130905163318.GA14338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Duy Nguyen <pclouds@gmail.com>,
	John Szakmeister <john@szakmeister.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 18:56:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHcrG-0008IC-0N
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 18:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab3IEQ4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 12:56:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26692 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab3IEQ4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 12:56:33 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00LJ9WE5YKC0@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 12:56:30 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id A1CE12DA0547; Thu, 05 Sep 2013 12:56:29 -0400 (EDT)
In-reply-to: <20130905163318.GA14338@sigill.intra.peff.net>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233969>

On Thu, 5 Sep 2013, Jeff King wrote:

> On Thu, Sep 05, 2013 at 11:18:24PM +0700, Nguyen Thai Ngoc Duy wrote:
> 
> > > There are basically two solutions:
> > >
> > >   1. Add a single-bit flag for "I am 0-padded in the real data". We
> > >      could probably even squeeze it into the same integer.
> > >
> > >   2. Have a "classic" section of the pack that stores the raw object
> > >      bytes. For objects which do not match our expectations, store them
> > >      raw instead of in v4 format. They will not get the benefit of v4
> > >      optimizations, but if they are the minority of objects, that will
> > >      only end up with a slight slow-down.
> > 
> > 3. Detect this situation and fall back to v2.
> > 
> > 4. Update v4 to allow storing raw tree entries mixing with v4-encoded
> > tree entries. This is something between (1) and (2)
> 
> I wouldn't want to do (3). At some point pack v4 may become the standard
> format, but there will be some repositories which will never be allowed
> to adopt it.
> 
> For (4), yes, that could work. But like (1), it only solves problems in
> tree entries. What happens if we have a quirky commit object that needs
> the same treatment (e.g., a timezone that does not fit into the commit
> name dictionary properly)?
> 
> > I think (4) fits better in v4 design and probably not hard to do. Nico
> > recently added a code to embed a tree entry inline, but the mode must
> > be encoded (and can't contain leading zeros). We could have another
> > code to store mode in ascii. This also makes me wonder if we might
> > have similar problems with timezones, which are also specially encoded
> > in v4..
> 
> Yeah, that might be more elegant.
> 
> > (3) is probably easiest. We need to scan through all tree entries
> > first when creating v4 anyway. If we detect any anomalies, just switch
> > back to v2 generation. The user will be force to rewrite history in
> > order to take full advantage of v4 (they can have a pack of weird
> > trees in v2 and the rest in v4 pack, but that's not optimal).
> 
> Splitting across two packs isn't great, though. What if v4 eventually
> becomes the normal on-the-wire format? I'd rather have some method for
> just embedding what are essentially v2 objects into the v4 pack, which
> would give us future room for handling these sorts of things.
> 
> But like I said, I haven't looked closely yet, so maybe there are
> complications with that. In the meantime, I'll defer to the judgement of
> people who know what they are talking about. :)

None of the above is particularly appealing to me.

Pack v4 has to enforce some standardization in the object encoding to be 
efficient.  Some compromizes have been applied to accommodate the fixing 
of a thin pack, although I was initially tempted to simply dodge the 
issue and allow thin packs in a repository.

On this particular mode issue, I remember making a fuss at the time when 
this was discovered because the github implementation did generate such 
tree objects at the time.

So instead of compromizing the pack v4 object encoding further, I'd 
simply suggest adding a special object type which is in fact simply the 
pack v2 representation i.e. the canonical object version, deflated.  
Right now pack v4 encodes only 5 object types: commit, tree, blob, delta 
and tag.  Only the commit and tree objects have their representation 
transcoded.  So that means we only need to add native_commit and 
native_tree object types.

Then, anything that doesn't fit the strict expectation for transcoding a 
tree or a commit object is simply included as is without transcoding 
just like in pack v2.


Nicolas
