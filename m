From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Mon, 6 Jan 2014 15:47:08 +0100
Message-ID: <20140106144708.GC27265@t2784.greatnet.de>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <CALas-ijwb+20dArOGCnZJSqEwU8+ufUpOEktUJ2hAOW_BLpgxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 15:47:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0BSa-00008G-H3
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 15:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbaAFOrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 09:47:16 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.103]:41121 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649AbaAFOrP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 09:47:15 -0500
Received: from [83.133.105.219] (helo=t2784.greatnet.de)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W0BSP-0006E9-Vz; Mon, 06 Jan 2014 15:47:10 +0100
Content-Disposition: inline
In-Reply-To: <CALas-ijwb+20dArOGCnZJSqEwU8+ufUpOEktUJ2hAOW_BLpgxw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240013>

On Sun, Jan 05, 2014 at 10:27:19PM +0100, Francesco Pretto wrote:
> 2014/1/5 W. Trevor King <wking@tremily.us>:
> > On Sun, Jan 05, 2014 at 04:53:12AM +0100, Francesco Pretto wrote:
> >> Also it could break some users that rely on the current behavior.
> >
> > The current code always has a detached HEAD after an initial-clone
> > update, regardless of submodule.<name>.update, which doesn't match
> > those docs either.
> 
> I perfectly agree with you that the documentation is a bit
> contradictory with regard to "update" command and detached HEAD.
> That's why it's so hard to add a feature and keep the same spirit of
> those that coded submodules at first. Also, I think that submodules
> didn't get much feedback with regards to these pitfalls because many
> people try to setup them, they see that "update" detaches the HEAD and
> they think "hmmm, maybe submodules are not what I was looking for".

I am not so sure about that. Why should detached HEAD make you think
like that? For us at $dayjob we have a pre-commit hook that denies you
to commit on a detached HEAD and asks you to create a branch first.

You then work on that branch and send it out for review. If the reviewer
is happy he merges it into a stable branch (master most times) of the
submodule. Only revisions that are on a stable branch in a submodule are
allowed to be linked in a superprojects branch that should be merged.

Before the submodule's branch gets merged we usually track the
development branches sha1 of the submodule in the superproject. For
cleanup in the submodule I currently use fixup! commits most times so
the referenced sha1 is not lost. In the very end when everyone is happy
with the submodule change I rebase, change the referenced sha1 in the
superproject and send the final branch out for review another time.

> > Adding a check to only checkout
> > submodule.<name>.branch if submodule.<name>.update was 'rebase',
> > 'merge', or 'none' would be easy, but I don't think that makes much
> > sense.  I can't see any reason for folks who specify
> > submodule.<name>.branch to prefer a detached HEAD over a local branch
> > matching the remote branch's name.
> 
> I think the reason is that it still matches the original use case of
> submodules devs:
> - the maintainer decides the specific commit developers should have;

Nope. We usually do not have a maintainer. We use a review based
workflow. Everyone is allowed to review. If you develop you need to send
you changes to a reviewer first who then merges when he is ok with it.

> - developers checkout that commit and don't pull (you can't do "git
> pull" in a detached HEAD);

Exactly. We consider pull evil ;-) Seriously: To update we only do fast
forward merges of local stable branches. Only reviewers or maintainers
are allowed to merge and push into stable branches. Direct commits to
stable branches are forbidden.

To review we have a shortcut to update the stable branch in git gui
for which the code can be found on my github[1].

> - they optionally get the upstream commit from the specified
> "submodule.<name>.branch" with "--remote". They are still in a
> detached HEAD and can't do "git pull".

Yes, why would you do a git pull in a submodule? Don't you want to do
something like

	git checkout -t -b dev/my-topic origin/master

to start your development?

> Maybe who coded submodules at first was thinking that the best way to
> contribute to a project is to checkout that repository, and not work
> in the submodule. As said, this works well when the submodule
> repository is a full project, and not a bunch of shared code.

Why not work in the submodule? See explanation above.

Cheers Heiko


[1] https://github.com/hvoigt/git/commits/hv/gui-improvements
