From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Reallow git-rebase --interactive --continue if commit
 is unnecessary
Date: Sat, 29 Dec 2007 14:26:28 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712291418360.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <87r6hias5s.fsf@gollum.intra.norang.ca> <20071220071212.GA20534@spearce.org>
 <7vzlw5rg53.fsf@gitster.siamese.dyndns.org> <20071220073113.GJ14735@spearce.org>
 <7vy7bppv3s.fsf@gitster.siamese.dyndns.org> <7vr6h9m2zb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 14:27:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8biO-0001gK-DO
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 14:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbXL2N0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 08:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbXL2N0d
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 08:26:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:48306 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753181AbXL2N0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 08:26:32 -0500
Received: (qmail invoked by alias); 29 Dec 2007 13:26:30 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp021) with SMTP; 29 Dec 2007 14:26:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+tOtlNHZutrlRzo0e6RcTRnkWzxvcVHdazasogWf
	fgSzmInUnVjTRV
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vr6h9m2zb.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69313>

Hi,

On Wed, 26 Dec 2007, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >  		# commit if necessary
> >
> > Ok, the user has prepared the index for us, and we are going to do some
> > tests and conditionally create commit.
> >
> >  		git rev-parse --verify HEAD > /dev/null &&
> >
> > Do we have HEAD commit?  Why check this --- we do not want to rebase
> > from the beginning of time?  No, that's not it.  If this fails, there is
> > something seriously wrong.  This is not about "will we make a commit?"
> > check at all.  This is a basic sanity check and if it fails we must
> > abort, not just skip.

Right.  My intention was to have a "|| die" at the end of the && cascade.

> >
> >  		git update-index --refresh &&
> >  		git diff-files --quiet &&
> >
> > Is the work tree clean with respect to the index?  Why check this --- we
> > want to skip the commit if work tree is dirty?  Or is this trying to
> > enforce the invariant that during the rebase the work tree and index and
> > HEAD should all match?  If the latter, failure from this again is a
> > reason to abort.

Exactly.  I wanted to make sure that the working directory is not 
different from what is in the index.

> >  		! git diff-index --cached --quiet HEAD -- &&
> >
> > Do we have something to commit?  This needs to be checked so that we can
> > skip a commit that results in emptyness, so using this as a check to see
> > if we should commit makes sense.
> >
> >  		. "$DOTEST"/author-script && {
> >  			test ! -f "$DOTEST"/amend || git reset --soft HEAD^
> >  		} &&
> >
> > Find GIT_AUTHOR_* variables and if we are amending rewind the HEAD.  The
> > failure from this is a grave problem and reason to abort, isn't it?
> >
> >  		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> > 		git commit --no-verify -F "$DOTEST"/message -e
> >
> > Then we go on to create commit.  As you said, failure from this is a
> > grave error.
> 
> Any response to this or problems in the clean-up patch?
> 
> > ---
> >  git-rebase--interactive.sh |   29 +++++++++++++++++++----------
> >  1 files changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 090c3e5..7aa4278 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -363,17 +363,26 @@ do
> >  
> >  		test -d "$DOTEST" || die "No interactive rebase running"
> >  
> > -		# commit if necessary
> > -		git rev-parse --verify HEAD > /dev/null &&
> > -		git update-index --refresh &&
> > -		git diff-files --quiet &&
> > -		! git diff-index --cached --quiet HEAD -- &&
> > -		. "$DOTEST"/author-script && {
> > -			test ! -f "$DOTEST"/amend || git reset --soft HEAD^
> > -		} &&
> > -		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> > -		if ! git commit --no-verify -F "$DOTEST"/message -e
> > +		# Sanity check
> > +		git rev-parse --verify HEAD >/dev/null ||
> > +			die "Cannot read HEAD"
> > +		git update-index --refresh && git diff-files --quiet ||
> > +			die "Working tree is dirty"
> > +
> > +		# do we have anything to commit?
> > +		if git diff-index --cached --quiet HEAD --
> >  		then
> > +			: Nothing to commit -- skip this
> > +		else
> > +			. "$DOTEST"/author-script ||
> > +				die "Cannot find the author identity"
> > +			if test -f "$DOTEST"/amend
> > +			then
> > +				git reset --soft HEAD^ ||
> > +				die "Cannot rewind the HEAD"
> > +			fi
> > +			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> > +			git commit --no-verify -F "$DOTEST"/message -e ||
> >  			die "Could not commit staged changes."
> >  		fi

Looks good to me!  And I'm sorry for taking so long to respond.

Ciao,
Dscho
