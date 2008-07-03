From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Fri, 4 Jul 2008 01:53:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 04 01:54:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEYdC-0002iJ-Dc
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 01:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbYGCXxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 19:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbYGCXxd
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 19:53:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:55793 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754047AbYGCXxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 19:53:32 -0400
Received: (qmail invoked by alias); 03 Jul 2008 23:53:30 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp057) with SMTP; 04 Jul 2008 01:53:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xUZYCITQxPVAPrJ6MYeAJ8QbmNTbTwigsXgnExa
	zVMhRaLIEicmWe
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080703210950.GC6677@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87338>

Hi,

On Thu, 3 Jul 2008, Stephan Beyer wrote:

> On Thu, Jul 03, 2008 at 12:03:49PM +0100, Johannes Schindelin wrote:
> 
> > On Wed, 2 Jul 2008, Junio C Hamano wrote:
> > > Stephan Beyer <s-beyer@gmx.net> writes:
> > > 
> > > > git sequencer is planned as a backend for user scripts that 
> > > > execute a sequence of git instructions and perhaps need manual 
> > > > intervention, for example git-rebase or git-am.
> > > 
> > > ...
> > > > +output () {
> > > > +	case "$VERBOSE" in
> > > > +	0)
> > > > +		"$@" >/dev/null
> > > > +		;;
> > > > +	1)
> > > > +		output=$("$@" 2>&1 )
> > > > +		status=$?
> > > > +		test $status -ne 0 && printf '%s\n' "$output"
> > > > +		return $status
> > > > +		;;
> > > > +	2)
> > > > +		"$@"
> > > > +		;;
> > > > +	esac
> > > > +}
> > > 
> > > Perhaps misnamed?  This feels more like "do" or "perform" or "run".
> > 
> > My fault.  I like "perform".
> 
> Right, the "output" name puts a wrong behavior in mind. "perform" (or 
> "do" or "run") won't exactly say that this function "adjusts" the output 
> somehow, but I'm nonetheless fine with taking "perform".

Actually, it does not even "adjust" the output.  It just performs the 
action, and _if_ there was an error and "verbose" was set to 1, it shows 
the output.  If "verbose" was set to 2, it always shows the output.  
Otherwise, the output is suppressed.

So, the use of the function really is in the output, but that is either 
shown or not shown, never modified.

> Btw, another root commit problem is btw that it's not possible to 
> cherry-pick root commits.

That is a problem to be fixed in cherry-pick, not in sequencer.  Care to 
take care of that?

> Johannes Schindelin wrote:
> > > > +# Usage: pick_one (cherry-pick|revert) [-*|--edit] sha1
> > > > +pick_one () {
> > > > +	what="$1"
> > > > +	# we just assume that this is either cherry-pick or revert
> > > > +	shift
> > > > +
> > > > +	# check for fast-forward if no options are given
> > > > +	if expr "x$1" : 'x[^-]' >/dev/null
> > > > +	then
> > > > +		test "$(git rev-parse --verify "$1^")" = \
> > > > +			"$(git rev-parse --verify HEAD)" &&
> > > > +			output git reset --hard "$1" &&
> > > > +			return
> > > > +	fi
> > > > +	test "$1" != '--edit' -a "$what" = 'revert' &&
> > > > +		what='revert --no-edit'
> > > 
> > > This looks somewhat wrong.
> > > 
> > > When the history looks like ---A---B and we are at A, cherry-picking B can
> > > be optimized to just advancing to B, but that optimization has a slight
> > > difference (or two) in the semantics.
> > > 
> > >  (1) The committer information would not record the user and time of the
> > >      sequencer operation, which actually may be a good thing.
> > 
> > This is debatable.  But I think you are correct, for all the same reasons 
> > why a merge can result in a fast-forward.
> 
> Dscho, you mean me by referring to 'you' here, right?

Nope.

> Otherwise I'm a bit confused: "For the same reasons why a merge can 
> result in a fast-forward we should not do fast forward here" ;-)

What I meant: there is no use here to redo it.  It has already be done, 
and redoing just pretends that the girl calling sequencer tried to pretend 
that she did it.

If the merge has been done already, it should not be redone.

Only if the user _explicitely_ specified a merge strategy, there _might_ 
be a reason to redo the merge, but I still doubt it.

> > >  (2) When $what is revert, this codepath shouldn't be exercised, 
> > >  should it?
> > 
> > Yes.
> 
> I haven't done a check intentionally, but there was a stupid thinko.
> So you're right.
> 
> But: this will only be a bug if the commit that _comes next in the
> original history_ is to be reverted.

Does not matter.  It's a bug.

A bug is almost always in the details, a corner-case, but it almost always 
needs fixing nevertheless.

> Nonetheless, purely tested:

"Nevertheless", maybe?  "untested", maybe?

> Johannes Schindelin wrote:
> > I'd not check in sequencer for the strategy.  Especially given that we 
> > want to support user-written strategies in the future.
> 
> I don't know how this is planned to look like, but perhaps 
> --list-strategies may make sense here, too.

No.  You just do not check for strategies.  Period.  git-merge does that, 
and you can easily abort a rebase if you explicitely asked for an invalid 
strategy.

BTW your coalescing multiple replies into one mail was a major pain in the 
donkey.  Should you do that again, I will not even bother reading that 
mail.

Ciao,
Dscho
