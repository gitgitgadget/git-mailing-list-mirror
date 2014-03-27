From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Possible regression in master? (submodules without a
 "master" branch)
Date: Thu, 27 Mar 2014 21:27:02 +0100
Message-ID: <20140327202702.GA3984@sandbox-ub>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
 <xmqqob0ref3v.fsf@gitster.dls.corp.google.com>
 <5334606F.5010109@web.de>
 <20140327185405.GS4008@odin.tremily.us>
 <xmqqwqffctyg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 21:27:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTGtV-0005mp-FF
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 21:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757281AbaC0U1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 16:27:15 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:58895 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757057AbaC0U1O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 16:27:14 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WTGtH-0004rc-Bv; Thu, 27 Mar 2014 21:27:07 +0100
Content-Disposition: inline
In-Reply-To: <xmqqwqffctyg.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245324>

On Thu, Mar 27, 2014 at 12:39:03PM -0700, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> 
> > On Thu, Mar 27, 2014 at 06:31:27PM +0100, Jens Lehmann wrote:
> >> Am 27.03.2014 18:16, schrieb Junio C Hamano:
> >> > Johan Herland <johan@herland.net> writes:
> >> > 
> >> >> I just found a failure to checkout a project with submodules where
> >> >> there is no explicit submodule branch configuration, and the
> >> >> submodules happen to not have a "master" branch:
> >> >>
> >> >>   git clone git://gitorious.org/qt/qt5.git qt5
> >> >>   cd qt5
> >> >>   git submodule init qtbase
> >> >>   git submodule update
> >> >>
> >> >> In current master, the last command fails with the following output:
> >> > 
> >> > ... and with a bug-free system, what does it do instead?  Just clone
> >> > 'qtbase' and make a detached-head checkout at the commit recorded in
> >> > the superproject's tree, or something else?
> >> 
> >> After reverting 23d25e48f5ead73 on current master it clones 'qtbase'
> >> nicely with a detached HEAD.
> >
> > Fixing this for initial update clone is pretty easy, we just need to
> > unset start_point before calling module_clone if
> > submodule.<name>.branch is not set. 
> 
> There is this bit for "update" in git-submodule.txt:
> 
>   For updates that clone missing submodules, checkout-mode updates
>   will create submodules with detached HEADs; all other modes will
>   create submodules with a local branch named after
>   submodule.<path>.branch.
> 
>   [side note] Isn't that a typo of submodule.<name>.branch?

Yep, thats is a typo. Trevor will you fix that as well? Or how should be
do that? Since its just such a small change.

> So the proposed change is to make the part before semicolon true?
> If we are not newly cloning (because we already have it), if the
> submodule.<name>.branch is not set *OR* refers to a branch that does
> not even exist, shouldn't we either (1) abort as an error, or (2) do
> the same and detach?

I would expect "(1) abort as an error" since the user is not getting what
he would expect.

> > However, that's just going to
> > push remote branch ambiguity problems back to the --remote update
> > functionality.  What should happen when submodule.<name>.branch is not
> > set and you run a --remote update, which has used:
> >
> >     git rev-parse "${remote_name}/${branch}"
> >
> > since the submodule.<name>.branch setting was introduced in 06b1abb
> > (submodule update: add --remote for submodule's upstream changes,
> > 2012-12-19)?
> 
> Isn't --remote about following one specific branch the user who
> issues that command has in mind?  If you as the end user did not
> give any indication which branch you meant, e.g. by leaving the
> submodule.<name>.branch empty, shouldn't that be diagnosed as an
> error?

Well to simplify things there was this fallback to origin/master
(similar to the master branch we create on init) since that is a branch
which many projects have. E.g. for the users that share one central
server and just directly commit, push and pull to/from master. They
would have an easy way to start working in a submodule, by simply saying
--remote and then committing to master. At least that is what I
imagine.

> > gitmodules(5) is pretty clear that 'submodule.<name>.branch' defaults
> > to master (and not upstream's HEAD), do we want to adjust this at the
> > same time?
> 
> That may be likely.  If the value set to a configuration variable
> causes an established behaviour of a program change a lot, silently
> defaulting that variable to something many people are expected to
> have (e.g. 'master') would likely to cause a usability regression.

IMO this branch configuration should completely ignored in the default,
non --remote, usage. Since we simply checkout a specific SHA1 in this
case, that should be possible.

Cheers Heiko
