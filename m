From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Thu, 19 Oct 2006 12:07:50 -0400
Message-ID: <20061019160750.GS17794@delft.aura.cs.cmu.edu>
References: <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org> <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018214143.GF19194@spearce.org> <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org> <Pine.LNX.4.64.0610181910440.1971@xanadu.home> <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org> <7vac3tx900.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610190747060.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 18:10:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaaSu-0003Gf-7l
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 18:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946166AbWJSQH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 12:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946169AbWJSQH5
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 12:07:57 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:56485 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1946166AbWJSQHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 12:07:55 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.63)
	(envelope-from <jaharkes@cs.cmu.edu>)
	id 1GaaQw-0002P9-TW; Thu, 19 Oct 2006 12:07:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610190747060.3962@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29365>

On Thu, Oct 19, 2006 at 07:55:18AM -0700, Linus Torvalds wrote:
> On Wed, 18 Oct 2006, Junio C Hamano wrote:
> >
> > Linus Torvalds <torvalds@osdl.org> writes:
> > >
> > > Actually, I've hit an impasse.
> > >
> > > So there's _another_ way of fixing a thin pack: it's to expand the objects 
> > > without a base into non-delta objects, and keeping the number of objects 
> > > in the pack the same. But _again_, we don't actually know which ones to 
> > > expand until it's too late.
> > 
> > pack-objects.c::write_one() makes sure that we write out base
> > immediately after delta if we haven't written out its base yet,
> > so I suspect if you buffer one delta you should be Ok, no?
> 
> It doesn't matter. I realized that my bogus patch to unpack-objects was 
> more seriously broken anyway: even the "un-deltify every single object" 
> was broken. And that's despite the fact that I _tested_ it, and verified 
> the end result by hand.
> 
> Why? Because I tested it within one repo, by just piping the output of 
> git-pack-objects --stdout directly to the repacker. That seemed to be a 
> good way to test it without setting up anything bigger. But it turns out 
> that it misses one of the big problems: if you don't unpack the objects in 
> a way that later phases can read, none of the streaming code works at all, 
> and you have to buffer up _everything_ in memory just to be able to read 
> any previous _non_delta objects too.

You are correct that it is not possible to create a pack with all
objects expanded in a single pass. But that doesn't mean that a single
pass conversion to a full pack is impossible.

If we find a delta against a base that is not found in our repository we
can keep it as a delta, the base should show up later on in the
thin-pack. Whenever we find a delta against a base that we haven't seen
in the received part of the thin pack, but is available from the
repository we should expand it because there is a chance we may not see
this base in the remainder of the thin-pack.

> So my patch-series works - but it only works in a repo that already has 
> all the objects in question, because then it can look up the objects in 
> the original database. Which makes it useless. Duh.

About that patch series, is there a simple way to import the series into
a local repository? git-am doesn't like it, even after splitting it into
separate files on the linebreaks. I guess git-mailinfo could be taught
to recognise the git-log headers. Or have I missed some useful git apply
trick.

Jan
