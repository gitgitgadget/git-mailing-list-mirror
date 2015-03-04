From: John Keeping <john@keeping.me.uk>
Subject: Re: Unexpected/unexplained difference between git pull --rebase and
 git rebase
Date: Wed, 4 Mar 2015 09:35:54 +0000
Message-ID: <20150304093554.GT890@serenity.lan>
References: <CAPfvZp6oNnM=M-9BAVqAE052jQApH-O_t3gEoq6JWC2kQrR8gg@mail.gmail.com>
 <20150303210900.GP890@serenity.lan>
 <CAPfvZp5KmEwY_903aUJE0p7qKMUbABYpC3Y8JvPSc_Dmd0ppGA@mail.gmail.com>
 <20150303214653.GQ890@serenity.lan>
 <xmqq61ahad18.fsf@gitster.dls.corp.google.com>
 <CAPfvZp5jTTbWVL0QuZTP83=SWvsvyZWX0BG_q7jPLK5wNNvCgg@mail.gmail.com>
 <20150303234057.GR890@serenity.lan>
 <CAPfvZp5VCd+Q2LHczqTQ08ZR+yvkGHhubRHgBSCznGQJgekadg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Botsko <botsko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 10:42:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT5p3-0008OJ-0b
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 10:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759056AbbCDJm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 04:42:26 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:57761 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774AbbCDJmX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 04:42:23 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2015 04:42:22 EST
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C2E8ACDA5F3;
	Wed,  4 Mar 2015 09:36:10 +0000 (GMT)
X-Quarantine-ID: <NfDGWFIZ-2CA>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NfDGWFIZ-2CA; Wed,  4 Mar 2015 09:36:04 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 460BACDA57E;
	Wed,  4 Mar 2015 09:35:56 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAPfvZp5VCd+Q2LHczqTQ08ZR+yvkGHhubRHgBSCznGQJgekadg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264737>

On Tue, Mar 03, 2015 at 03:54:05PM -0800, Mike Botsko wrote:
> Thanks, that clarifies a lot.
> 
> I only have two follow-up questions:
> 
> In your branch example, how does git determine that C/D have been
> rewritten and need to be "replaced" with their current versions
> existing upstream? In this scenario I've encountered, the commit hash
> and the patch ID of those commits changed because the contents of the
> patches had to be modified slightly due to merge conflicts which
> occurred when the upstream branch was rebased.

It uses the reflog.  There's some discussion in git-merge-base(1) [0],
although IIRC it steers away from being too explicit in case anyone
comes up with a way to make it more intelligent in the future.

Note that this means it will only work if you are performing the rebase
in the same repository as you originally created the branch, since in
other repositories the original branch point may not appear in the
reflog of the upstream.

[0] http://git-scm.com/docs/git-merge-base#_discussion_on_fork_point_mode

> Also, you mentioned "not building off of upstream branches which might
> be rewritten". We generally try to avoid this but I don't see any
> alternative with the way we do things.
> 
> upstream/master <- An always-clean copy of what's fully approved and live
> upstreamfeature-A
> upstreamfeature-B, etc <- Feature branches designed to organized
> long-term new feature work
> 
> Individual developers will then create local development branches
> based on those feature branches. If three people are responsible for
> tasks for feature-A, they'll create development branches for each
> task, do their work, and(via github enterprise) submit a pull request
> so we can properly review their work, test it, etc.
> 
> The problem I have today stems from situations where a feature branch
> has been merged with master. If feature-B is merged with master, and
> someone rebases feature-A, there may be merge conflicts. If they fix
> the conflicts, that may alter the commit history of the feature
> branch, which then impacts all branches developers have based on it.
> 
> Part of me feels like we should be able to never rebase feature
> branches, they should exist outside of new work merged to master.
> However, it's much easier to resolve merge conflicts in small doses,
> and we're in a much better position to know that we're fully updated
> and can catch other problems early.
> 
> Is there a better way to do this, so that we never risk rewriting the
> "middle tier"?

Having two tiers of feature branches seems a bit weird to me (although I
do know of another group that does something similar).

Perhaps a throwaway integration branch would help, which will allow you
to let git-rerere(1) remember resolutions to merge conflicts.  The idea
is that you periodically (say once a day or every few days) do something
like this:

	$ git checkout integration
	$ git reset --keep master
	$ git merge feature-A
	$ git merge feature-B
	...

Then you can test the features together and get an early view of any
conflicts that might hit when you merge them to master.

<shameless-plug>
I wrote a tool to help manage integration branches [1].

[1] http://johnkeeping.github.io/git-integration/
</shameless-plug>

There's quite a lot of discussion on branch management in
git-workflows(7).

> On Tue, Mar 3, 2015 at 3:40 PM, John Keeping <john@keeping.me.uk> wrote:
> > On Tue, Mar 03, 2015 at 03:20:48PM -0800, Mike Botsko wrote:
> >> Maybe I'm lacking the distinction regarding what I'm being specific about.
> >>
> >> In both examples, I'm asking it specifically to rebase in changes from
> >> the remote "upstream" and a named branch at that location. I'm giving
> >> git the same information, it's just interpreting it differently - and
> >> I'm not understanding why.
> >
> > Not quite.  If you say:
> >
> >         git rebase $sha1
> >
> > then you're telling git-rebase to apply the commits $sha1..HEAD onto
> > $sha1.
> >
> > If you say:
> >
> >         git rebase
> >
> > then it will be re-written as:
> >
> >         git rebase --fork-point @{upstream}
> >
> > in which case Git will apply more complicated logic so that you can
> > recover from the case where @{upstream} has been re-written.
> >
> > Consider the following scenario:
> >
> >                       F                 branch
> >                      /
> >                C -- D                   master@{1}
> >               /
> >         A -- B -- C' -- D' -- E         master
> >
> > where C' and D' are rewritten versions of C and D.
> >
> > In this case, imagine you are at F on "branch", "git rebase master" will
> > replace C, D and F onto E because you have explicitly selected to replay
> > master..branch onto master.
> >
> > "git rebase" will apply the fork-point logic and realise that D is a
> > previous version of master, so it will only replay F onto E.
> >
> > In general if you just want to rebase onto your upstream it is simpler
> > to just call "git rebase" which will do the right thing; it's also
> > shorter to type ;-)
> >
> >> My local branch would have been created from the
> >> upstream/feature-branch, and will eventually be merged back into it.
> >> Until I'm ready for that, I regularly rebase the work done on
> >> upstream/feature-branch so that my local work is always clean and
> >> above anything else.
> >
> > In this case the problem stems from the fact that
> > upstream/feature-branch has been rewritten.  Building on top of branches
> > that will be rewritten is not advisable unless you have a really good
> > reason to do so.
> >
> >> On Tue, Mar 3, 2015 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> > John Keeping <john@keeping.me.uk> writes:
> >> >
> >> >> git-rebase assumes that if you give an explicit upstream then you want
> >> >> precisely what you asked for.  From git-rebase(1):
> >> >>
> >> >>       If either <upstream> or --root is given on the command line,
> >> >>       then the default is `--no-fork-point`, otherwise the default is
> >> >>       `--fork-point`.
> >> >
> >> > Correct.
> >> >
> >> > You ask it to rebase the history without guessing by being explicit;
> >> > the command guesses when you are not explicit and being lazy ;-).
> 
> 
> 
> -- 
> Mike Botsko
> Lead Dev @ Helion3
> Ph: 1-(503)-897-0155
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
