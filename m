From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: [RFC v2] submodule: Respect requested branch on all
 clones
Date: Mon, 6 Jan 2014 16:47:39 +0100
Message-ID: <20140106154739.GD27265@t2784.greatnet.de>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <20140105194850.GA2994@book.hvoigt.net>
 <20140105212458.GG3156@odin.tremily.us>
 <20140105225733.GB4660@book.hvoigt.net>
 <20140105233943.GJ3156@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Jan 06 16:47:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0CP9-0003Jw-53
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 16:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbaAFPrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 10:47:47 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:46222 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbaAFPrq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 10:47:46 -0500
Received: from [83.133.105.219] (helo=t2784.greatnet.de)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W0COy-0006gU-Jh; Mon, 06 Jan 2014 16:47:40 +0100
Content-Disposition: inline
In-Reply-To: <20140105233943.GJ3156@odin.tremily.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240018>

On Sun, Jan 05, 2014 at 03:39:43PM -0800, W. Trevor King wrote:
> On Sun, Jan 05, 2014 at 11:57:33PM +0100, Heiko Voigt wrote:
> > On Sun, Jan 05, 2014 at 01:24:58PM -0800, W. Trevor King wrote:
> > > If submodule.<name>.branch is set, it *always* creates a new local
> > > branch of that name pointing to the exact sha1.  If
> > > submodule.<name>.branch is not set, we still create a
> > > detached-HEAD checkout of the exact sha1.
> > 
> > Thanks for this clarification. Since the usual usage with --remote
> > is with a remote-tracking branch, I confused this here. I am not
> > sure whether blindly creating a local branch from the recorded sha1
> > is the right thing to do. In what situations would that be helpful?
> 
> In any situation where your going to develop the submodule locally,
> you're going to want a branch to develop in.  Starting local-submodule
> developers off on a branch seems useful, even if we can only use
> submodule.<name>.branch to guess at their preferred local branch name.
> Sometimes (often?) the guess will be right.  However, A detached HEAD
> will never be right for local development, so being right sometimes is
> still an improvement ;).

Starting developers at a local submodule branch makes sense. But lets
think further. What happens after the initial update? Most times the
submodule will already be initialized and cloned. Then developers will
still get a detached HEAD even with your local branch feature.

If there are no changes on it should we advance the local branch
somehow on update? If it does not exist anymore should we recreate it?

> > At $dayjob we usually use feature branches for our work. So if
> > someone wants to work in a submodule you simply create a branch at
> > the current sha1 which you then send out for review.
> 
> I'm all for named feature branches for development, and in this case
> submodule.<name>.branch is likely to be the wrong choice.  However,
> it's still safer to develop in that branch and then rename the branch
> to match your feature than it would be to develop your fix with a
> detached HEAD.  If your developers have enough discipline to always
> checkout their feature branch before starting development, my patch
> won't affect them.  However, I know a number of folks who go into
> fight-or-flight mode when they have a detached HEAD :p.

I agree having an initial branch makes it less likely to loose committed
changes. Thats good. Also starting on some local branch name and then
renaming the branch sounds quite practical. Then we could recreate the
default local branch on update (like described above).

> > The reason why one would set a branch option here is to share the
> > superproject branch with colleagues. He can make sure they can
> > always fetch and checkout the submodule even though the branch there
> > is still under cleanup and thus will be rebased often. The commit
> > referenced by sha1 would not be available to a developer fetching
> > after a rebase.
> 
> Yeah, floating gitlinks are something else.  I'd be happy to have that
> functionality (gitlinks pointing to references) should be built into
> gitlinks themselves, not added as an additional layer in the submodule
> script.  This "gitlinked sha1 rebased out of existence" scenario is
> the first I've heard where I think gitlinked references would be
> useful.

Yeah I have been thinking about this for quite a while now, but have not
yet found the time to really think it through and come up with a good
solution that does not put you in danger of unprecise revisions. The
only solution I can think of is a similar approach as
submodule.<name>.branch gives us now but possibly enabled by some
option (i.e.: submodule.<name>.remote = true).
This way you always get the current tip of development but still see the
differences (which you can choose to commit) in git status.

> > > Thinking through this more, perhaps the logic should be:
> > > 
> > > * If submodule.<name>.update (defaulting to checkout) is checkout,
> > >   create a detached HEAD.
> > > * Otherwise, create a new branch submodule.<name>.branch
> > >   (defaulting to master).
> > 
> > Why not trigger the attached state with the submodule.<name>.branch
> > configuration option? If there is a local branch available use that,
> > if not the tracking branch (as it is currently). Then a developer
> > can start working on the branch with:
> > 
> > 	cd submodule; git checkout -t origin/<branchname>
> > 
> > assuming that submodule update learns some more support for this.
> 
> Isn't that already what 'git update --remote <submodule>' already
> does?

Does it? As far as I understood (not using the branch option yet) it
only does

	git checkout origin/<branchname>

so there is no local branch created that tracks the remote branch (-t).
What I was thinking is that when submodule.<name>.branch is set a

	git submodule update

will:

1. if no local branch with that name exists:

   checkout the remote/<branch>

2. If a local branch with that name exists:

   checkout the local branch and possibly advance it according to its
   setting.

Thinking further: Maybe submodule.<name>.update = pull could denote that
a user wants to have a branch ready for work in a submodule. submodule
update will then

1. if no local branch with that name exists:

   - automatically create the branch based on the referenced sha1
   - set up that its tracking remote/<branch>
   - issue a git pull in the submodule

2. if a local branch with that name exists:

   - issue a git pull in the submodule

The superproject will still show if there are any changes in the
submodule (i.e. the sha1 does not match anymore). Even though the user
can disable it with submodule.<name>.ignore=all I would advise against
it.

> > > > > -				update_module= ;;
> > > > > +				if test -n "$config_branch"; then
> > > > > +					update_module="!git reset --hard -q"
> > > > 
> > > > If we get here the checkout has already been done. Shouldn't
> > > > this rather specify a noop. I.E. like
> > > > 
> > > > 	update_module="!true"
> > > 
> > > We are on a local branch at this point, but not neccessarily
> > > pointing at the gitlinked sha1.  The reset here ensures that the
> > > new local branch does indeed point at the gitlinked sha1.
> > 
> > But isn't this a fresh clone? Why should the branch point at
> > anything else?
> 
> We don't pass $sha1 to module_clone().  Before my patch, we don't even
> pass $branch to module_clone().  That means that module_clone() will
> only checkout the gitlinked sha1 when the upstream HEAD (or $branch
> with my patch) happens to point to the gitlinked sha1.  For example,
> if Alice adds Charie's repo as a submodule (gitlinking his current
> master d2dbd39), then Charlie pushes a new commit d0de817 to his
> master, and then Bob clones Alice's superproject.  Post-clone,
> Charlie's submodule will have checked out Charlie's new d0de817, and
> we need update's additional:
> 
>   git reset --hard -q d2dbd39
> 
> to rewind to Alice's gitlinked sha1.

Ah yeah, sorry I was confusing this with the checkout of remote/<branch>
here again. Since I have done that twice already maybe we should be
careful about not confusing users with this as well...

After wrapping my head around the fact that you want to simply create a
local branch on the referenced sha1 (and hopefully remembering it) I
still would like to think a little more about it and let it settle a
bit.

Cheers Heiko
