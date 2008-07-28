From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GTP/0.1 terminology 101: commit reels and references
Date: Mon, 28 Jul 2008 14:01:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281350590.2725@eeepc-johanness>
References: <488D42B6.4030701@gmail.com> <1217228570.6750.24.camel@maia.lan>  <7vk5f6tqsj.fsf@gitster.siamese.dyndns.org> <1217239419.6750.73.camel@maia.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Roys <roysjosh@gmail.com>, gittorrent@lists.utsl.gen.nz,
	git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Jul 28 14:01:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNRPy-0006Pc-ME
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 14:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbYG1MAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 08:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbYG1MAc
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 08:00:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:45364 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751640AbYG1MAc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 08:00:32 -0400
Received: (qmail invoked by alias); 28 Jul 2008 12:00:29 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp060) with SMTP; 28 Jul 2008 14:00:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wi/oVIFTw0yhva0b9lUWSae8UrJCH8zpHF5equ5
	Fdkcu0zvkN/aD8
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1217239419.6750.73.camel@maia.lan>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90448>

Hi,

On Mon, 28 Jul 2008, Sam Vilain wrote:

> On Mon, 2008-07-28 at 00:24 -0700, Junio C Hamano wrote:
>
> >
> > >
> > >> Commit reels can also, and generally do, include the objects 
> > >> required for a specific commit.
> > >
> > > Yes.  The only times where they wouldn't contain all the objects 
> > > required for the commits within the reel, is when those objects 
> > > happened to be contained by a previous reel.
> > 
> > What do you mean by "previous" reel?  It is not quite defined in your 
> > message but perhaps defined elsewhere?
> > 
> > How is this different from a bundle?  Does a reel, unlike a bundle, 
> > contain the full tree for the bottom commits?

AFAICT no, the reel should not contain the full tree for the bottom 
commit.

> They are almost identical, both being defined by a set of starting and 
> ending refs.  And now that you mention it, I feel slightly embarrassed 
> for not spotting the connection before.  I only really compared reels to 
> packs, which is what the original specification tried to chop up bitwise 
> and distribute chunk by chunk.
> 
> The differences are:
> 
>   - the reel has a defined object order (which as I hoped to demonstrate
>     in the test cases, is just a refinement of rev-list --date-order)

Do you mean that the commit reel is a list pointing to bundles that can be 
sorted topologically by their contained commits?

>   - deltas always point in one direction, to objects "earlier" on
>     the reel, so that slices of the reel sent on the network can be made
>     thin without resulting in unresolvable deltas (which should be
>     possible to do on commit boundaries using rev-list --objects-edge)

That is exactly what bundles do.  They are thin, as they assume that a few 
"preconditions", i.e. refs, are present.

>   - the behaviour at the beginning of the reel is precisely defined
>     (although as I said, I think that the decision might be worth
>     revisiting - perhaps getting just the latest reel is a useful
>     'shallow clone')

If you want to allow shallow clones, you must make the bundles non-thin.  
That would be a major bandwidth penalty.

I'd rather not allow shallow clones with Gitorrent.

> > > This is one of the design decisions which I think may be a mistake; 
> > > a less expensive to calculate definition of a reel would be *all* 
> > > objects between the starting and ending Reference objects.
> > 
> > Do you mean all such objects and nothing else?  That would imply that 
> > a reel is quite similar to a bundle (but neither rev-list 
> > --objects-edge nor bundle guarantees that the result is minimal).
> 
> It's the lack of guarantees which is the issue, really.

It should not be too difficult to provide a rev-list option (which is 
inherited by git-bundle, then) to pay an extra time to make sure that the 
bundle is minimal.

BTW this is a good example how communication on the Git mailing list can 
help a GSoC project.

> In order to take the download work of the entire pack and distribute it 
> over multiple peers, you need a way to carve the bundle up.  This has to 
> happen in such a way that the fragments that you get back will actually 
> fit together at the end, and also in such a way that you don't lose the 
> benefits of delta compression.

That should be relatively easy.

> The way I thought would be best to do that would be to line up all the 
> objects in an exactly defined way - hence, the "reel" concept - and then 
> chop that up.

What exactly is that exact definition?

Is it the output of "rev-list --all --objects", chopped into equal chunks 
at commit boundaries?  If so, it should probably be equal in terms of 
size, right?

The tricky thing, of course, is to make that thing incremental, i.e. 
replace only a minimal amount of items in the "commit reel" (if I 
understood correctly, and the commit reel refers to a list of sets of 
commits with their objects) when a branch was modified.

Hmm.  Maybe it would be time for you to draw a tiny diagram for all the 
people too lazy like me, which shows roughly how the communication between 
the peers should look like, and how the reel fits in.

Ciao,
Dscho
