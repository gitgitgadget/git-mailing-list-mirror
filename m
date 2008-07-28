From: Sam Vilain <sam@vilain.net>
Subject: Re: GTP/0.1 terminology 101: commit reels and references
Date: Mon, 28 Jul 2008 22:03:39 +1200
Message-ID: <1217239419.6750.73.camel@maia.lan>
References: <488D42B6.4030701@gmail.com> <1217228570.6750.24.camel@maia.lan>
	 <7vk5f6tqsj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Joshua Roys <roysjosh@gmail.com>, gittorrent@lists.utsl.gen.nz,
	git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 12:04:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNPay-0004S4-0V
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 12:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbYG1KDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 06:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbYG1KDs
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 06:03:48 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52515 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbYG1KDr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 06:03:47 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 1627F21C916; Mon, 28 Jul 2008 22:03:46 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RDNS_DYNAMIC
	autolearn=no version=3.2.3
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 7473821C916;
	Mon, 28 Jul 2008 22:03:38 +1200 (NZST)
In-Reply-To: <7vk5f6tqsj.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90432>

On Mon, 2008-07-28 at 00:24 -0700, Junio C Hamano wrote:
> >>   Commit reels can also, and generally do, include the objects required
> >>  for a specific commit.
> >
> > Yes.  The only times where they wouldn't contain all the objects
> > required for the commits within the reel, is when those objects happened
> > to be contained by a previous reel.
> 
> What do you mean by "previous" reel?  It is not quite defined in your
> message but perhaps defined elsewhere?
> 
> How is this different from a bundle?  Does a reel, unlike a bundle,
> contain the full tree for the bottom commits? 

They are almost identical, both being defined by a set of starting and
ending refs.  And now that you mention it, I feel slightly embarrassed
for not spotting the connection before.  I only really compared reels to
packs, which is what the original specification tried to chop up bitwise
and distribute chunk by chunk.

The differences are:

  - the reel has a defined object order (which as I hoped to demonstrate
    in the test cases, is just a refinement of rev-list --date-order)

  - deltas always point in one direction, to objects "earlier" on
    the reel, so that slices of the reel sent on the network can be made
    thin without resulting in unresolvable deltas (which should be
    possible to do on commit boundaries using rev-list --objects-edge)

  - the behaviour at the beginning of the reel is precisely defined
    (although as I said, I think that the decision might be worth
    revisiting - perhaps getting just the latest reel is a useful
    'shallow clone')

> > This is one of the design decisions which I think may be a mistake; a
> > less expensive to calculate definition of a reel would be *all* objects
> > between the starting and ending Reference objects.
> 
> Do you mean all such objects and nothing else?  That would imply that a
> reel is quite similar to a bundle (but neither rev-list --objects-edge
> nor bundle guarantees that the result is minimal).

It's the lack of guarantees which is the issue, really.  In order to
take the download work of the entire pack and distribute it over
multiple peers, you need a way to carve the bundle up.  This has to
happen in such a way that the fragments that you get back will actually
fit together at the end, and also in such a way that you don't lose the
benefits of delta compression.

The way I thought would be best to do that would be to line up all the
objects in an exactly defined way - hence, the "reel" concept - and then
chop that up.

If a pack is already arranged to line up with the commit reel's
structure, then it's possible that the amount of work required to answer
a "play" request is as little as looking up in the reel index the local
on-disk location within the local pack, and copying that to the network.

I've certainly wondered how much baggage could be removed from this
whole thing, like replacing the "tracker" with a simple git-daemon
message that holds a register of mirrors/peers, possibly layering things
over git:// instead of the bittorrent-like protocol, dividing up blocks
by the commit graph and not all objects, etc.  But I think that it would
be best to defer that kind of design change until the conclusion of this
prototype experiment.

That being said, anything which does shortcut the distance to the finish
line and can be agreed on wouldn't go amiss.

Sam
