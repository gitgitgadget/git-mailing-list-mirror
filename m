From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] submodule: Respect reqested branch on all clones
Date: Sun, 5 Jan 2014 01:39:22 +0100
Message-ID: <20140105003922.GA21772@sandbox-ub>
References: <CALas-iiF7Og8qjWoYeop3GofG_kR7w5DDcNkA1y3eQhu1Srxkw@mail.gmail.com>
 <dad947caba9e1c49d691ffccc868cfdce7d04e82.1388772192.git.wking@tremily.us>
 <20140104220915.GA5697@book-mint>
 <20140104225401.GA3156@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Jan 05 01:39:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzbkf-0006SB-5F
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 01:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbaAEAjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jan 2014 19:39:33 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.102]:52853 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974AbaAEAjd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jan 2014 19:39:33 -0500
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VzbkV-0000S5-8q; Sun, 05 Jan 2014 01:39:27 +0100
Content-Disposition: inline
In-Reply-To: <20140104225401.GA3156@odin.tremily.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239952>

On Sat, Jan 04, 2014 at 02:54:01PM -0800, W. Trevor King wrote:
> On Sat, Jan 04, 2014 at 11:09:15PM +0100, Heiko Voigt wrote:
> > On Fri, Jan 03, 2014 at 10:06:11AM -0800, W. Trevor King wrote:
> > > @@ -306,7 +307,14 @@ module_clone()
> > >  	echo "gitdir: $rel/$a" >"$sm_path/.git"
> > >  
> > >  	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
> > > -	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
> > 
> > Why should this line be removed? Is it not needed for correct
> > worktree <-> repo linking of submodules?
> > 
> > > +	(
> > > +		clear_local_git_env
> > > +		cd "$sm_path" &&
> > > +		GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
> > > +		if test -n "$branch"; then
> > > +			git checkout -f -q -B "$branch" "origin/$branch" && echo "checked out $branch"
> > > +		fi
> > > +	) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
> > >  }
> 
> It's not removed, just merged with the branch manipulation that also
> happens in a clean local environment in $sm_path.  Spawning two
> sequential subshells with the same setup seemed like overkill.

Ah ok, thanks. For some reason I overlooked that.

> > > @@ -861,7 +860,12 @@ Maybe you want to use 'update --init'?")"
> > >  			case ";$cloned_modules;" in
> > >  			*";$name;"*)
> > >  				# then there is no local change to integrate
> > > -				update_module= ;;
> > > +				if test -n "$branch"; then
> > > +					update_module="!git reset --hard -q"
> > 
> > Does that not put the user in danger of loosing changes?
> 
> No, because this is only happens for just-cloned modules.  The user
> hasn't had time to make local changes yet.

Ah ok I see. But why the reset then? Doesn't the earlier git checkout in your
patch take care of checking out the branch and thus update to the right
revision?

> > If submodule.<name>.branch is configured:
> > 
> > 	git submodule update
> > 
> > will checkout the configured branch instead of the sha1?
> 
> The use case described by Francesco, a submodule maintainer Alice sets
> up the submodule, which downstream developer Bob want to checkout to a
> branch.  I think that matching the exact commit specified by Alice in
> Bob's checkout is important, even if the upstream developer Charlie
> has advanced the referenced branch in the meantime.  Shifting the
> referenced submodule commit should be an explicit decision made by
> Alice, not a clone-time accident for Bob.

But from what I understand of this part of Francesco's use-case description:

> # Developer
> $ git pull
> $ git submodule init
> $ git submodule update --remote
> $ cd <path>
> $ branch="$(git config -f ..\.gitmodules submodule.common.branch)"; git checkout $branch

Is that he wants to allow the developer to switch to following a branch instead
of an exact sha1 while some extension in the common module is still under
development. That makes it easier to develop in parallel in the submodule and
the superproject because you do not need to update the sha1 all the time.

E.g. its likely that changes have to be reviewed and cleaned up in the
submodule first until they can be merged to the master branch there. During
this time the developer follows the branch.
Once the submodule review is finished the superproject branch can switch back
to the exact model again (because the submodule will not change anymore) and
finish its implementation there.

Matching the exact commit and checking out the branch only if it points to that
exact commit does not really help the developer in this use-case. But I am only
guessing from my experience with development of features in submodule.

Cheers Heiko
