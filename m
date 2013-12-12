From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Publishing "filtered branch repositories" - workflow /
 recommendations?
Date: Thu, 12 Dec 2013 14:39:19 +0100
Message-ID: <20131212133919.GB6183@t2784.greatnet.de>
References: <52A0D199.1010403@web.de>
 <CACPiFCKHprB_oO_eXMYkey_CGbT7WOn5VDDjBdHbLRzcDpHnZw@mail.gmail.com>
 <52A0D9F5.3030101@web.de>
 <CACPiFCJ3mkOj=E+siideBpPfgS1tSicVQ46KqPK+Tha0DbkZHw@mail.gmail.com>
 <52A18F69.70002@web.de>
 <CACPiFCJ5hCPvRHB1knvMocN0XdHfSMpbZnqjf7yHAT4mMOSfzw@mail.gmail.com>
 <20131209225950.GG9606@sandbox-ub>
 <xmqqhaahvas2.fsf@gitster.dls.corp.google.com>
 <52A8E124.4000002@web.de>
 <xmqqa9g7t1vb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 14:39:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vr6UJ-0004VY-F2
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 14:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571Ab3LLNjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 08:39:31 -0500
Received: from smtprelay02.ispgateway.de ([80.67.29.24]:42789 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab3LLNja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 08:39:30 -0500
Received: from [83.133.105.219] (helo=t2784.greatnet.de)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vr6U4-0003kp-N6; Thu, 12 Dec 2013 14:39:20 +0100
Content-Disposition: inline
In-Reply-To: <xmqqa9g7t1vb.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239227>

On Wed, Dec 11, 2013 at 03:16:24PM -0800, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
> >> I think this is closely related to Martin's list of wishes we
> >> earlier saw in the thread: remind the user to push necessary
> >> submodule tip before the top-level commit that needs that commit in
> >> the submodule is pushed out.  Giving projects a way to implement
> >> such a policy decision would be good, and having a default policy,
> >> if we can find one that would be reasonable for any submodule users,
> >> would be even better.  Would adding a generic pre-push hook at the
> >> top-level sufficient for that kind of thing, I have to wonder.
> >
> > That could call "git push --dry-run --recurse-submodules=check" to
> > deny the push if the submodule commit isn't on a remote branch.
> > that would only work for a single hardcoded remote, as the remote
> > itself does not seem to be passed to the pre-push hook.
> >
> > So me thinks adding a configuration option for the --recurse-submodule
> > option of push is the best way to achieve that. This could be set to
> > "check" ...
> 
> Yes, that uses only a single hard-coded decision, and making the
> branch name or remote name customizable is not enough, as you are
> still hardcoding "if ... isn't on" part. It is not far-fetched to
> imagine a project wants to add more restrictions to what commit in
> the submodule history can be bound to a tree of a published commit
> in the top-level project (e.g. "must be a tagged release point",
> "must be older at least by more than two weeks", "must be signed by
> one of these developers' keys", etc.).
> 
> So I am not yet convinced that a simple "option" that supplies a few
> parameters to a single hard-coded policy is sufficient in the long
> run.

Well, for the implementation of --recurse-submodules=check on push we
tried to be as dumb as possible and just try to find out whether the
commit is on any remote. The reason is that when someone works on a
branch and pushes it for demonstration/backup/before holiday the most
common mistake is that he forgets to push the submodule when pushing the
superproject. So "some remote" seems to be the most common denominator
for push here. At least its better than no check at all.

For extended rules that answer questions like: "When am I allowed to
merge in master?" we need some kind of workflow definition from which we
can deduct such rules. A pre-push hook would allow to define rules but
how about an approach that is easier for the user and can maybe guide
him to the correct workflow.

I find workflow guidance is a general problem in git and even though we
use hooks at $dayjob they are not always sufficient. E.g. we enforce an
"all commits have to be reviewed first before they enter master" policy
which is correct in most situations. But for more lightweight projects I
would like to loosen this rule. The problem relies in the automatic
distribution of hooks or options for them by project instead of by
installation.

One idea: We could distribute a default set of enabled hooks that
implement several typical workflow options which can then be enabled by
simply choosing one option. The configuration should be distributeable
via the project e.g. a .githookconfig or .gitworkflowconfig ?

The git tools could then adapt their defaults depending on such a
workflow definition. But it also means we would first have to collect
and define some typical workflows.

What do others think? There probably have been other ideas about
workflow definitions already, no?

Cheers Heiko
