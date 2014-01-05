From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Sun, 5 Jan 2014 23:57:33 +0100
Message-ID: <20140105225733.GB4660@book.hvoigt.net>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com> <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us> <20140105194850.GA2994@book.hvoigt.net> <20140105212458.GG3156@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Jan 05 23:57:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzwdh-0004yL-PD
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 23:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbaAEW5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jan 2014 17:57:40 -0500
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:51491 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaAEW5j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 17:57:39 -0500
Received: from [77.20.146.74] (helo=book.hvoigt.net)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VzwdT-00065w-Ja; Sun, 05 Jan 2014 23:57:35 +0100
Content-Disposition: inline
In-Reply-To: <20140105212458.GG3156@odin.tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239978>

On Sun, Jan 05, 2014 at 01:24:58PM -0800, W. Trevor King wrote:
> On Sun, Jan 05, 2014 at 08:48:50PM +0100, Heiko Voigt wrote:
> > On Sun, Jan 05, 2014 at 08:17:00AM -0800, W. Trevor King wrote:
> > > It's not clear if this refers to the initial-clone update, future
> > > post-clone updates, or both.  Ideally, the behavior should be the
> > > same, but in the initial-clone case we don't have an existing
> > > checked-out branch to work with.
> >=20
> > I do not think that its actually important to end up with a detache=
d
> > HEAD. The documentation just states it because in most cases there
> > is no other option. But I do not think anything will break if a
> > branch points to the exact sha1 we would checkout and we checkout
> > the branch instead.
>=20
> There's no "if the remote-tracking branch points to the exact sha1"
> logic in my patch.

I know I was more referring to the discussion whether detached HEAD for
submodules is important or not.

> If submodule.<name>.branch is set, it *always*
> creates a new local branch of that name pointing to the exact sha1.
> If submodule.<name>.branch is not set, we still create a detached-HEA=
D
> checkout of the exact sha1.

Thanks for this clarification. Since the usual usage with --remote is
with a remote-tracking branch, I confused this here. I am not sure
whether blindly creating a local branch from the recorded sha1 is the
right thing to do. In what situations would that be helpful?

At $dayjob we usually use feature branches for our work. So if someone
wants to work in a submodule you simply create a branch at the current
sha1 which you then send out for review.

The reason why one would set a branch option here is to share the
superproject branch with colleagues. He can make sure they can always
fetch and checkout the submodule even though the branch there is still
under cleanup and thus will be rebased often. The commit referenced by
sha1 would not be available to a developer fetching after a rebase.

> Thinking through this more, perhaps the
> logic should be:
>=20
> * If submodule.<name>.update (defaulting to checkout) is checkout,
>   create a detached HEAD.
> * Otherwise, create a new branch submodule.<name>.branch (defaulting
>   to master).

Why not trigger the attached state with the submodule.<name>.branch
configuration option? If there is a local branch available use that, if
not the tracking branch (as it is currently). Then a developer can star=
t
working on the branch with:

	cd submodule; git checkout -t origin/<branchname>

assuming that submodule update learns some more support for this.

> The motivation is that if submodule.<name>.update is checkout, the
> user is unlikely to be developing locally in the submodule, as
> subsequent updates would clobber their local commits.  Having a
> detached HEAD is a helpful "don't develop here" reminder ;).  If
> submodule.<name>.update is set, the user is likely to be developing
> locally, and will probably want a local branch already checked out to
> facilitate that.
>=20
> > > -			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" =
|| exit
> > > +			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" =
"$config_branch" || exit
> >=20
> > In the simple case (update=3Dcheckout, no branch specified) with th=
e
> > new checkout branch stuff in module_clone() this code here ends up
> > calling checkout twice.  First for master and then here later with
> > the sha1.  This feels a little bit double.
>=20
> There is no guarantee that the remote master and the exact sha1 point
> at the same commit.  Ideally we'd just clone the exact sha1 in this
> case.
>=20
> > I would prefer if we skip the checkout in module_clone() if its not
> > necessary.
>=20
> When I tried to drop the '' case here:
>=20
> > > @@ -306,7 +307,15 @@ module_clone()
> > >  	echo "gitdir: $rel/$a" >"$sm_path/.git"
> > > =20
> > >  	rel=3D$(echo $a | sed -e 's|[^/][^/]*|..|g')
> > > -	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=3D. git co=
nfig core.worktree "$rel/$b")
> > > +	(
> > > +		clear_local_git_env
> > > +		cd "$sm_path" &&
> > > +		GIT_WORK_TREE=3D. git config core.worktree "$rel/$b" &&
> > > +		case "$branch" in
> > > +		'') git checkout -f -q ;;
> > > +		?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> > > +		esac
> > > +	) || die "$(eval_gettext "Unable to setup cloned submodule '\$s=
m_path'")"
> > >  }
>=20
> I got test-suite errors that I didn't get to the bottom of.  However=E2=
=80=A6
>=20
> > How about we move the whole "what to checkout"-decision into one pl=
ace
> > instead of having it in update() and moving it from add() into
> > module_clone() ?
>=20
> =E2=80=A6this sounds like a good idea to me.  However, it would be a =
more
> intrusive change, and there may be conflicts with Francesco's propose=
d
> attach/detach functionality.  I'll wait until we have a clearer idea
> of where that is headed before I attempt a more complete
> consolidation.

I agree, that would be good.

> > > -				update_module=3D ;;
> > > +				if test -n "$config_branch"; then
> > > +					update_module=3D"!git reset --hard -q"
> >=20
> > If we get here the checkout has already been done. Shouldn't this
> > rather specify a noop. I.E. like
> >=20
> > 	update_module=3D"!true"
>=20
> We are on a local branch at this point, but not neccessarily pointing
> at the gitlinked sha1.  The reset here ensures that the new local
> branch does indeed point at the gitlinked sha1.

But isn't this a fresh clone? Why should the branch point at anything
else?

Cheers Heiko
