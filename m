From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Teach git submodule update to use distributed
	repositories
Date: Thu, 17 Jul 2008 20:22:53 +0200
Message-ID: <20080717182253.GZ32184@machine.or.cz>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com> <alpine.DEB.1.00.0807171311010.8986@racer> <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com> <320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com> <alpine.DEB.1.00.0807171351380.8986@racer> <320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com> <alpine.DEB.1.00.0807171513560.8986@racer> <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 20:24:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJY8x-0006dj-Es
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 20:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757034AbYGQSW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 14:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756666AbYGQSW4
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 14:22:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44106 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756566AbYGQSWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 14:22:55 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4A3793939B56; Thu, 17 Jul 2008 20:22:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88897>

On Thu, Jul 17, 2008 at 04:07:11PM +0100, Nigel Magnay wrote:
> And it works, but
> 
> $ git pull fred
> $ git submodule update
> 
> Can leave you with problems, because if a submodule wasn't pushed to
> origin, you won't have it available. This is because the commands are
> equivalent to
> 
> $ git pull fred
> for each submodule()
>   cd submodule
>   git fetch origin
>   git checkout <sha1>

Oh! So, only after replying to most of your mail, I have realized what
are you talking about all the time - _just_ this particular failure
mode:

	"Someone pushed out a repository repointing submodules to
	invalid commits, and instead of waiting for the person to fix
	this breakage, we want to do a one-off fetch of all submodules
	from a different repository."

There's nothing else you're trying to solve by this, right?


Now, I think that this is a completely wrong problem to solve. Your
gitweb is going to be broken, everyone has to jump through hoops because
of this, and that all just because of a single mistake. It shouldn't
have _happenned_ in the first place.

So the proper solution for this should be to make an update hook that
will simply not _let_ you push out a tree that's broken like this.
Something like this (completely untested):

die() { echo "$@"; exit 1; }
git rev-list ^$2 $3 | while read commit; do
	git show $commit:.gitmodules >/tmp/gm$$
	git config -f /tmp/gm$$ --get-regexp 'submodule\..*\.path' |
		cut -d ' ' -f 1 |
		sed 's/^.*\.//; s/\..*$//;' |
		while read submodule; do
			path=$(git config -f /tmp/gm$$ "submodule.$submodule.path")
			url=$(git config -f /tmp/gm$$ "submodule.$submodule.url")
			entry=$(git ls-tree $commit "$path")
			[ -n "$entry" ] || die "submodule $submodule points at a non-existing path"
			[ "$(echo "$entry" | cut -d ' ' -f 1)" = "160000" ] || die "submodule $submodule does not point to a gitlink entry"
			
			subcommit="$(echo "$entry" | cut -d ' ' -f 2)"
			urlhash="$(echo "$url" | sha1sum | cut -d ' ' -f 1)"
			# We keep local copies of submodule repositories
			# for commit existence checking
			echo "Please wait, updating $url cache..."
			if [ -d /tmp/ucache/$urlhash ]; then
			        (cd /tmp/ucache/$urlhash && git fetch)
			else
			        git clone --bare "$url" /tmp/ucache/$urlhash
			fi
			[ "$(git --git-dir=/tmp/ucache/$urlhash cat-file -t "$subcommit" 2>/dev/null)" = "commit" ] || die "submodule $submodule does not point at an existing commit"
		done
	done

Comments? If it seems good, it might be worth including in
contrib/hooks/. Maybe even in the default update hook, controlled by
a config option.

All the troubles here stem from the fact that normally, Git will not let
you push any invalid state to the server. This is not completely true in
this case, but we should prevent this behaviour instead of inventing
hacks to work it around.

> Unless each submodule had a [remote] specified for "fred", you'd be
> stuffed. But what you could do is either by passing the right URL, or
> looking at the superproject [remote] for "fred" - i.e: If in the
> superproject you have
> 
> [remote "fred"]
>         url = ssh://git@fred.local/pub/scm/git/workspace/thing/.git
> [submodule "module"]
>         url = ssh://git@repo/pub/scm/git/module.git
> 
> Then the submodule "module" on fred, if it's a working-copy, can be calculated
>        ssh://git@fred.local/pub/scm/git/workspace/thing/module/.git
> 
> If it isn't a WC then you'd have to have a [remote "fred"] in that
> submodule, but I'm thinking that'd be a rare case.

This is ultra-evil. I think assuming things like this is extremely dirty
and not reasonable for a universal code, _unless_ we explicitly decide
that this is a new convention you want to introduce as a recommendation.
But you should've been very clear about this upfront.

_If_ you still insist on the one-off fetches for some reason, I think
it's reasonable to provide your own simple script for your users that
will autogenerate these URLs appropriately for your particular setup.
I don't think there is any real need for a more generic solution.

> I'd assumed (possibly wrongly?) that there was resistance to putting
> any of the submodule logic in things other than git-submodules.

Are you following the thread about submodule support for git mv, git rm?

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
