From: Sam Vilain <sam@vilain.net>
Subject: Re: GTP/0.1 terminology 101: commit reels and references
Date: Tue, 29 Jul 2008 07:26:06 +1200
Message-ID: <1217273166.25690.20.camel@maia.lan>
References: <488D42B6.4030701@gmail.com> <1217228570.6750.24.camel@maia.lan>
	 <7vk5f6tqsj.fsf@gitster.siamese.dyndns.org>
	 <1217239419.6750.73.camel@maia.lan>
	 <alpine.DEB.1.00.0807281350590.2725@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Roys <roysjosh@gmail.com>, gittorrent@lists.utsl.gen.nz,
	git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:27:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNYNS-0007O0-LI
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 21:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbYG1T00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 15:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYG1T00
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 15:26:26 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:36726 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbYG1T0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 15:26:25 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id A18D621C977; Tue, 29 Jul 2008 07:26:23 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RDNS_DYNAMIC
	autolearn=no version=3.2.3
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 4A18F21C973;
	Tue, 29 Jul 2008 07:26:08 +1200 (NZST)
In-Reply-To: <alpine.DEB.1.00.0807281350590.2725@eeepc-johanness>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90491>

On Mon, 2008-07-28 at 14:01 +0200, Johannes Schindelin wrote:
> >   - the reel has a defined object order (which as I hoped to demonstrate
> >     in the test cases, is just a refinement of rev-list --date-order)
> 
> Do you mean that the commit reel is a list pointing to bundles that can be 
> sorted topologically by their contained commits?

Yes, but it is more defined than that.  There are still ambiguities with
topological sort, so the gittorrent spec specified exactly how all ties
are broken.  They happen to be a further refinement of --date-order,
with respect to the ordering of commits.

> >   - deltas always point in one direction, to objects "earlier" on
> >     the reel, so that slices of the reel sent on the network can be made
> >     thin without resulting in unresolvable deltas (which should be
> >     possible to do on commit boundaries using rev-list --objects-edge)
> That is exactly what bundles do.  They are thin, as they assume that a few 
> "preconditions", i.e. refs, are present.

Ok.  I think there are also some other trivial differences such as
bundles containing refs (which in the context of gittorrent will be
useless).

> >   - the behaviour at the beginning of the reel is precisely defined
> >     (although as I said, I think that the decision might be worth
> >     revisiting - perhaps getting just the latest reel is a useful
> >     'shallow clone')
> 
> If you want to allow shallow clones, you must make the bundles non-thin.  
> That would be a major bandwidth penalty.
> 
> I'd rather not allow shallow clones with Gitorrent.

By "Shallow" I think I mean a different thing to you.  I mean something
akin to just the last pack's worth of commits.

> > It's the lack of guarantees which is the issue, really.
> 
> It should not be too difficult to provide a rev-list option (which is 
> inherited by git-bundle, then) to pay an extra time to make sure that the 
> bundle is minimal.

Ok.  But from the current implementation's perspective, this is not yet
needed, we are just using the existing API.

Actually what would be useful would be for the thin pack generation to
also allow any object to be specified as its input list, not just
commits... then we wouldn't have to break blocks on commit boundaries
(see http://gittorrent.utsl.gen.nz/rfc.html#org-blocks).

> > In order to take the download work of the entire pack and distribute it 
> > over multiple peers, you need a way to carve the bundle up.  This has to 
> > happen in such a way that the fragments that you get back will actually 
> > fit together at the end, and also in such a way that you don't lose the 
> > benefits of delta compression.
> 
> That should be relatively easy.
> 
> > The way I thought would be best to do that would be to line up all the 
> > objects in an exactly defined way - hence, the "reel" concept - and then 
> > chop that up.
> 
> What exactly is that exact definition?

http://gittorrent.utsl.gen.nz/rfc.html#org-reels

> Is it the output of "rev-list --all --objects", chopped into equal chunks 
> at commit boundaries?  If so, it should probably be equal in terms of 
> size, right?

No.  It's chopped by uncompressed size.

http://gittorrent.utsl.gen.nz/rfc.html#org-blocks

> The tricky thing, of course, is to make that thing incremental, i.e. 
> replace only a minimal amount of items in the "commit reel" (if I 
> understood correctly, and the commit reel refers to a list of sets of 
> commits with their objects) when a branch was modified.

You would make a new reel to cover a new bunch of updates.  It's
important that the reels don't change too often for reasons I describe
in the RFC.

> Hmm.  Maybe it would be time for you to draw a tiny diagram for all the 
> people too lazy like me, which shows roughly how the communication between 
> the peers should look like, and how the reel fits in.

As I said in my recent message to the list, I wrote another top level
overview here:

http://gittorrent.utsl.gen.nz/rfc.html#org-blocks

Cheers,
Sam.
