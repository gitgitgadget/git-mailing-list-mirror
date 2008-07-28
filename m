From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GTP/0.1 terminology 101: commit reels and references
Date: Tue, 29 Jul 2008 00:30:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807290014110.2725@eeepc-johanness>
References: <488D42B6.4030701@gmail.com> <1217228570.6750.24.camel@maia.lan>  <7vk5f6tqsj.fsf@gitster.siamese.dyndns.org>  <1217239419.6750.73.camel@maia.lan>  <alpine.DEB.1.00.0807281350590.2725@eeepc-johanness> <1217273166.25690.20.camel@maia.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Roys <roysjosh@gmail.com>, gittorrent@lists.utsl.gen.nz,
	git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 00:30:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNbEs-00038p-0N
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 00:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbYG1W3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 18:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbYG1W3p
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 18:29:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:44804 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752144AbYG1W3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 18:29:44 -0400
Received: (qmail invoked by alias); 28 Jul 2008 22:29:42 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp055) with SMTP; 29 Jul 2008 00:29:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6njByrXS6wgfwfowuNFJGH7fKLYhOdqMoVWPGvv
	cfe4OFpZqqXdIL
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1217273166.25690.20.camel@maia.lan>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90514>

Hi,

On Tue, 29 Jul 2008, Sam Vilain wrote:

> On Mon, 2008-07-28 at 14:01 +0200, Johannes Schindelin wrote:
> > >   - the reel has a defined object order (which as I hoped to 
> > >     demonstrate in the test cases, is just a refinement of rev-list 
> > >     --date-order)
> > 
> > Do you mean that the commit reel is a list pointing to bundles that 
> > can be sorted topologically by their contained commits?
> 
> Yes, but it is more defined than that.  There are still ambiguities with 
> topological sort, so the gittorrent spec specified exactly how all ties 
> are broken.  They happen to be a further refinement of --date-order, 
> with respect to the ordering of commits.

But does that not mean that any new ref branching off of an ancient commit 
changes all the pack boundaries?

I'd rather have an intelligent incremental updater, and keep most of the 
existing bundles immutable.  That way, a new ref, or a changed one, can be 
mostly served from peers, not exclusively from the seeders.

> > >   - deltas always point in one direction, to objects "earlier" on 
> > >     the reel, so that slices of the reel sent on the network can be 
> > >     made thin without resulting in unresolvable deltas (which should 
> > >     be possible to do on commit boundaries using rev-list 
> > >     --objects-edge)
> >
> > That is exactly what bundles do.  They are thin, as they assume that a 
> > few "preconditions", i.e. refs, are present.
> 
> Ok.  I think there are also some other trivial differences such as 
> bundles containing refs (which in the context of gittorrent will be 
> useless).

Yeah, I think that bundles themselves are pretty useless in gitorrent.  
But what they _contain_ is pretty much what you need as blocks.

> > >   - the behaviour at the beginning of the reel is precisely defined 
> > >     (although as I said, I think that the decision might be worth 
> > >     revisiting - perhaps getting just the latest reel is a useful 
> > >     'shallow clone')
> > 
> > If you want to allow shallow clones, you must make the bundles 
> > non-thin.  That would be a major bandwidth penalty.
> > 
> > I'd rather not allow shallow clones with Gitorrent.
> 
> By "Shallow" I think I mean a different thing to you.  I mean something 
> akin to just the last pack's worth of commits.

That _is_ a shallow clone.  And that is exactly what I meant.  If you want 
to have all objects of the commits in the same pack, then you are 
basically making fat packs.  Which come with a hefty bandwidth penalty.

That is why I would suggest not allowing shallow clones; if you want to 
allow them, I have to ask myself why bother with a torrent at all...  It 
is not like the shallow clones are large, or that the people fetching them 
will stay around long to seed anything, and the packs would change 
frequently, making the whole torrent business pretty inefficient.

> > > It's the lack of guarantees which is the issue, really.
> > 
> > It should not be too difficult to provide a rev-list option (which is 
> > inherited by git-bundle, then) to pay an extra time to make sure that 
> > the bundle is minimal.
> 
> Ok.  But from the current implementation's perspective, this is not yet 
> needed, we are just using the existing API.

Why make it hard?  We have a lively community with brilliant people, and 
they frequently have fun solving puzzles like this: what is the best 
strategy to make equally sized, rarely (or maybe never?) changing packs 
from a set of given refs.

> Actually what would be useful would be for the thin pack generation to 
> also allow any object to be specified as its input list, not just 
> commits... then we wouldn't have to break blocks on commit boundaries 
> (see http://gittorrent.utsl.gen.nz/rfc.html#org-blocks).

That should be easy, but I think that it would be _even better_ if we ask 
pack-objects to generate several packs from the needed objects.  Ooops.  
That already exists: 

	$ git pack-objects --max-pack-size=<n>

Storing the packs in a second GIT_OBJECT_DIRECTORY that has the 
original as an alternate, together with the --local flag, should help even 
further: You can mark the last pack (which does not reach max-pack-size, 
most likely), remove it and just rerun the packing.

Of course, this needs some thought when large chunks of the object 
database become stale when a long branch was just deleted.  Not a major 
obstacle, though.

Ciao,
Dscho
