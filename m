From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Fri, 4 Jul 2008 03:03:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807040252490.2849@eeepc-johanness>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net> <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness> <20080704003857.GG6677@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 04 03:04:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEZj5-0008F1-QU
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 03:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbYGDBDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 21:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbYGDBDk
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 21:03:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:33673 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753135AbYGDBDk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 21:03:40 -0400
Received: (qmail invoked by alias); 04 Jul 2008 01:03:38 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp043) with SMTP; 04 Jul 2008 03:03:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//ezk9URP/TwK24Ch/+JCaRLX8SSkz6BkhhH7ybr
	SNG1eggxff2ANY
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080704003857.GG6677@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87351>

Hi,

On Fri, 4 Jul 2008, Stephan Beyer wrote:

> On Fri, Jul 04, 2008 at 01:53:21AM +0200, Johannes Schindelin wrote:
> > On Thu, 3 Jul 2008, Stephan Beyer wrote:
> > > Btw, another root commit problem is btw that it's not possible to 
> > > cherry-pick root commits.
> > 
> > That is a problem to be fixed in cherry-pick, not in sequencer.  Care 
> > to take care of that?
> 
> Not at the moment but that's one of the things I note down for later ;-)

Well, logically, it should come _before_ you use it in sequencer.  And you 
should use it in sequencer.

> And btw, somehow it is still open for me if builtin sequencer should be 
> a git-cherry-pick user (for pick) or if git-cherry-pick should be a 
> sequencer user (which would result in a change of usage on cherry-pick 
> conflicts).

The thing is, sequencer and cherry-pick _both_ use the same underlying 
functionality: cherry-picking a single commit.

So, logically, that part should be moved into libgit.a, and cherry-pick 
should use the to-be-introduced sequencer() function.

> > > Johannes Schindelin wrote:
> > > > > > +# Usage: pick_one (cherry-pick|revert) [-*|--edit] sha1
> > > > > > +pick_one () {
> > > > > > +	what="$1"
> > > > > > +	# we just assume that this is either cherry-pick or revert
> > > > > > +	shift
> > > > > > +
> > > > > > +	# check for fast-forward if no options are given
> > > > > > +	if expr "x$1" : 'x[^-]' >/dev/null
> > > > > > +	then
> > > > > > +		test "$(git rev-parse --verify "$1^")" = \
> > > > > > +			"$(git rev-parse --verify HEAD)" &&
> > > > > > +			output git reset --hard "$1" &&
> > > > > > +			return
> > > > > > +	fi
> > > > > > +	test "$1" != '--edit' -a "$what" = 'revert' &&
> > > > > > +		what='revert --no-edit'
> > > > > 
> > > > > This looks somewhat wrong.
> > > > > 
> > > > > When the history looks like ---A---B and we are at A, 
> > > > > cherry-picking B can be optimized to just advancing to B, but 
> > > > > that optimization has a slight difference (or two) in the 
> > > > > semantics.
> > > > > 
> > > > >  (1) The committer information would not record the user and 
> > > > >      time of the sequencer operation, which actually may be a 
> > > > >      good thing.
> > > > 
> > > > This is debatable.  But I think you are correct, for all the same 
> > > > reasons why a merge can result in a fast-forward.
> > > 
> > > Dscho, you mean me by referring to 'you' here, right?
> > 
> > Nope.
> > 
> > > Otherwise I'm a bit confused: "For the same reasons why a merge can 
> > > result in a fast-forward we should not do fast forward here" ;-)
> > 
> > What I meant: there is no use here to redo it.  It has already be 
> > done, and redoing just pretends that the girl calling sequencer tried 
> > to pretend that she did it.
> > 
> > If the merge has been done already, it should not be redone.
> > 
> > Only if the user _explicitely_ specified a merge strategy, there _might_ 
> > be a reason to redo the merge, but I still doubt it.
> 
> I don't get the light bulb.  You're talking about "the merge", I am
> talking about fast-forward on picks.

Ooops.  I think I was talking about a later comment of Junio's.

The thing is, if you try to pick a commit, and the current revision is 
already the parent of that commit, I think it would be wrong to redo the 
commit, pretending that the current time and committer were applying that 
commit.

> I try a simple example just to go sure that we're talking about the 
> same.
> 
> We have commits
> 
>   A ---- B ---- C ---- D
>        HEAD
> 
> A is parent of B, B of C, C of D.
> 
> Now we do:
> 	pick C
> 	pick --signoff D
> (Assume that the Signed-off-by: line is missing on D)
> 
> Without fast-forward, we get
> 
>   A ---- B ---- C ---- D
>           \
>            `--- C'---- D'
>                      HEAD
> 
> C' differs in C only in the committer data, perhaps only committer date.
> 
> With fast-forward, we get:
> 
>   A ---- B ---- C ---- D
>                  \
>                   `--- D'
>                      HEAD

IMO the --signoff should check if the sign off is present (must be the 
last one, as if we redid that commit), and if it is, fast-forward.

If it is missing, we need to redo the commit.

> > > Johannes Schindelin wrote:
> > > > I'd not check in sequencer for the strategy.  Especially given 
> > > > that we want to support user-written strategies in the future.
> > > 
> > > I don't know how this is planned to look like, but perhaps 
> > > --list-strategies may make sense here, too.
> > 
> > No.  You just do not check for strategies.  Period.  git-merge does 
> > that, and you can easily abort a rebase if you explicitely asked for 
> > an invalid strategy.
> 
> Hmm, my dream of the "robust sequencing after sanity check passed" is
> dead with your "period".
>
> So I'll have to check what happens, when e.g. "--strategy=hours" is 
> used.

Wow.  Is that the CVS/SVN merge strategy?

Do not care too much about the rare use cases.  Only experts will use -s.

But experts are known to shoot themselves, or inflict other pain on their 
bodies, so it is okay to let them suffer from a typo.

Ciao,
Dscho
