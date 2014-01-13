From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Tight submodule bindings
Date: Mon, 13 Jan 2014 20:37:37 +0100
Message-ID: <52D44081.7070504@web.de>
References: <20140112010847.GJ29954@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Jan 13 20:37:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2nKT-0004V6-QB
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 20:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbaAMThm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jan 2014 14:37:42 -0500
Received: from mout.web.de ([212.227.15.3]:51395 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbaAMThk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 14:37:40 -0500
Received: from [192.168.178.41] ([84.132.157.68]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MQvkQ-1Vvcsu1sq6-00UGBb for <git@vger.kernel.org>;
 Mon, 13 Jan 2014 20:37:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140112010847.GJ29954@odin.tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:Fnmb2heXmTuFPnRZvY+lYaQNHbUKd93omJ/26IidLBM9oepyIBB
 LmKHDW5feP87yXAjDzXCb90Qf63Qytiq0P/w2mLH8GRY60HS7eVnPWPmj2hI5hGBPjcgsYG
 7g0kMbLCnvbGKzgShyVGH7jPdnhLTW9pZ64kRyWJ4nJ6HYFWTwwaaFzcKpJpp/cTh6mhpKj
 +lgSjO59lXAWd1he/r7+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240368>

Thanks for the writeup, comments below.

Am 12.01.2014 02:08, schrieb W. Trevor King:
> Gitlinked commit hash
> ---------------------
>=20
> The submodule model revolves around links to commits (=E2=80=9Cgitlin=
ks=E2=80=9D):
>=20
>   $ git ls-tree HEAD
>   100644 blob 189fc359d3dc1ed5019b9834b93f0dfb49c5851f    .gitmodules
>   160000 commit fbfa124c29362f180026bf0074630e8bd0ff4550  submod
>=20
> These are effectively switchable trees.  The tree referenced by commi=
t
> fbfa124 is 492781c:
>=20
>   $ (cd submod/ && git cat-file commit fbfa124)
>   tree 492781c581d4dec380a61ef5ec69a104de448a74
>   =E2=80=A6
>=20
> If you init the submodule, subsequent checkouts will check out that
> tree, just like 'git checkout' would do if you'd had a superproject
> tree like:
>=20
>   $ git ls-tree HEAD
>   100644 blob 189fc359d3dc1ed5019b9834b93f0dfb49c5851f    .gitmodules
>   040000 tree 492781c581d4dec380a61ef5ec69a104de448a74    submod
>=20
> For folks who treat the submodule as a black box (and do no local
> development), switchable trees are all they care about.  They can
> easily checkout (or not, with deinit), the submodule tree at a
> gitlinked hash, and everything is nice and reproducible.  The fact
> that 'submod' is stored as a commit object and not a tree, is just a
> convenient marker for optional init/deinit/remote-update-integration
> functionality.

But there are users (like me) who do not treat submodules as
black boxes and nonetheless do development in them with update
set to checkout (after creating a feature branch of course ;-).

> Additional metadata, the initial checkout, and syncing down
> -----------------------------------------------------------
>=20
> However, folks who do local submodule development will care about
> which submodule commit is responsible for that tree, because that's
> going to be the base of their local development.  They also care abou=
t
> additional out-of-tree information, including the branch that commit
> is on.  For already-initialized submodules, there are existing places
> in the submodule config to store this configuration:
>=20
> 1. HEAD for the checked-out branch,
> 2. branch.<name>.remote =E2=86=92 remote.<name>.url for the upstream
>    subproject URL,
> 4. branch.<name>.rebase (or pull.rebase) to prefer rebase over merge
>    for integration,
> 5. =E2=80=A6
>=20
> You need somewhere in-tree to store this destined-to-be-out-of-tree
> information, so that superproject developers that have not yet
> initialized the submodule will know what values are suggested by the
> superproject maintainers.  That's where .gitmodules comes in, because
> storing all of this fairly static, locally overridable information in
> the gitlink itself would be nonsensical (said Linus in 2007 [1]).
> When you checkout a submodule for the first time, Git should take the
> default information from .gitmodules and file it away in the
> submodule's appropriate out-of-tree config locations.

I disagree, that only makes sense for the URL setting (and this
currently only happens with the update setting, which I intend to
change). Everything else should be taken from .gitmodules unless
the user wants to override it. The only setting I'm not so sure
about is the local branch setting, as that might have to propagate
into the submodule.

>  The out-of-tree
> data listed above should be stored in:
>=20
> 1. submodule.<name>.local-branch
> 2. submodule.<name>.url
> 4. submodule.<name>.update
> 5. =E2=80=A6
>=20
> Once you have an in-tree way to specify defaults for this out-of-tree
> information, you're going to have developers like me that just want t=
o
> stick with the defaults, following them through changes.  That means
> you'd like to have the =E2=80=9Ccopy .gitmodules defaults into your
> submodule's config=E2=80=9D functionality that usually happens on the=
 initial
> submodule checkout happen on *every superproject-initiated checkout*.

You don't need to copy it every time when you simply use the
=2Egitmodules file as fallback, no?

> In fact, I think life is easier for everyone if this is the default,
> and we add a new option (submodule.<name>.sync =3D false) that says
> =E2=80=9Cdon't overwrite optional settings in my submodule's out-of-t=
ree
> config on checkout=E2=80=9D for for folks who want to opt out.  Don't=
 worry,
> this is not going to clobber people, because we'll be syncing the
> other way too.

Yet another flag to make peoples life easier? I don't think so ;-)

> Syncing up
> ----------
>=20
> In the previous section I explained how data should flow from
> .gitmodules into out-of-tree configs.  What about the other direction=
?
> We currently let folks handle this by hand, but I'd prefer a tighter
> integration between the submodule config and the superproject tree to
> avoid losing work.  That means changes to tracked submodule status
> (checked-out hash, checked-out branch, upstream URL, upstream branch,
> default integration strategy, =E2=80=A6) should trigger dirty-tree st=
atus just
> like uncommitted changes to in-tree files.  'git add' (or stash) on
> the dirty submodule would store changed commit hashes in the index,
> pull changed out-of-tree configs back into the in-tree .gitmodules,
> and add the new .gitmodules to the index.  If the working .gitmodules
> was already dirty (vs. the index), the add/stash should die without
> making any changes.  If the user has disabled syncing between
> .gitmodules and the submodule's out-of-tree configs, then don't worry
> about optional settings.  Always sync the required settings, which at
> this point would just be submodule.<name>.local-branch.

Such a logic might make sense. And without copying stuff from
=2Egitmodules someplace else it becomes even easier ;-)

> Purely local metadata
> ---------------------
>=20
> Some metadata does not make sense in the superproject tree.  For
> example, whether a submodule is interesting enough to checkout
> (init/deinit) or whether you want to auto-sync optional metadata
> .gitmodules defaults.  This metadata should live in the superproject'=
s
> out-of-tree config, and should not be stored in the in-tree
> .gitmodules.

Not always. It makes a lot of sense to let upstream mark a
submodule as "too big and you won't need it anyway" in the
=2Egitmodules file.

>  Since you *will* want to share the upstream URL, I
> proposed using an explicit submodule.<name>.active setting to store
> the =E2=80=9Cdo I care=E2=80=9D information [2], instead of overloadi=
ng
> submodule.<name>.url (I'd auto-sync the .gitmodule's
> submodule.<name>.url with the subproject's remote.origin.url unless
> the user opted out of .gitmodules syncing).

That is wrong as it would break horribly when you check out an
old commit with a now dead submodule URL and that gets automatically
synced.

> Subsequent checkouts
> --------------------
>=20
> Now that we have strict linking between the submodule state (both
> in-tree and out-of-tree configs) and the superproject tree (gitlink
> and .gitmodules), changing between superproject branches is really
> easy:
>=20
> 1. Make sure the working tree is not dirty.  If it is, ask the user t=
o
>    either add-and-commit or stash, and then die to let them do so.

This condition is too hard, relax that to "a trivial merge can
switch from current state to target state" and make it behave just
like branch switching in the superproject. After all submodules
should behave as much as possible like content of the superproject.

> 2. Checkout the new superproject branch.
>=20
>    2.1. For each old submodule that doesn't exist in the new branch,
>         blow away the submodule directory (assuming a new-style
>         .git/modules/=E2=80=A6 layout, and not an old-style submod/.g=
it/=E2=80=A6
>         layout).

Yep.

>    2.2. For each gitlinked submodule that didn't exist in the old
>         branch, setup the submodule as if you were doing the initial
>         cloning checkout (forcing a new local-branch to point at the
>         gitlinked commit).  If you find local out-of-tree
>         *superproject* configs that conflict with the .gitmodules
>         values, prefer the superproject configs.

Yup, our working title for that is "autoinit".

>  Clobber submodule
>         configs and local branches at will (modulo
>         submodule.<name>.sync), because any submodule configs that th=
e
>         user wanted to keep should have been added to the superprojec=
t
>         branch earlier (or stashed).

I don't think I like this part, but I admit I do not fully understand
what you mean here. Clobbering stuff the user did doesn't sound very
nice.

> Integrating other branches
> --------------------------
>=20
> Merges and rebases can alter the submodule's in-tree configs (and
> create and remove submodules).  The existing logic for merging
> .gitmodules and gitlinks works well, so stick with that.  In the even=
t
> that there are unresolvable conflicts, bail out and let the user
> resolve the conflicts and use 'git commit' to finish checking out the
> resolved state.

Agreed.

> Issues
> ------
>=20
> I like the current submodule integration configuration:
>=20
> * submodule.<name>.branch (specify the remote branch to integrate, bu=
t
>   I'd prefer submodule.<name>.integration-ref for clarity).
> * submodule.<name>.update (specify how to integrate it, but I'd prefe=
r
>   submodule.<name>.integration-mode for clarity).

But we won't rename those now.

> more than the current core integration configuration:
>=20
> * branch.<name>.merge (with branch.<name>.remote, the branch to remot=
e
>   branch to integrate via merging).
> * branch.<name>.rebase (override branch.<name>.merge to integrate via
>   rebasing).
>=20
> These seem to mix the orthogonal concepts of integration target and
> integration mode, and the divergence from the .gitmodules
> representation makes syncing awkward.

I'm still hoping we might come up with a solution that doesn't need
the syncing.

> Summary
> -------
>=20
> New .gitmodules options:
>=20
> * submodule.<name>.local-branch, store the submodule's HEAD, must sta=
y
>   in sync for checkouts.

I'm still not convinced that the current branch setting couldn't be
extended to carry that information, but no objections against
configuring such a branch. But what do you mean with "must stay in
sync for checkouts"?

> New .git/config options:
>=20
> * submodule.<name>.active, for init/deinit.

I understand an option for automatic init (autoinit), but not for
automatic deinit. Is the latter really useful?

> * submodule.<name>.sync, for whether you want to automatically sync
>   the submodule's out-of-tree configs up to .gitmodules before
>   checkout operations, and sync back from .gitmodules (possibly
>   altered on the new branch) into the submodule's out-of-tree configs
>   during checkout.

Not needed if you use .gitmodules as fallback.

> With this tighter binding, submodule information is either tracked in
> the superproject, or explicitly not touched by the superproject.  Tha=
t
> makes it much harder to break things or clobber a user's work, and
> also much easier to keep submodules up to date with superproject
> changes.  Users shouldn't have to explicitly manage their submodules
> to carry out routine core tasks like checking out other branches.

Agreed.

> I see no reason to add --recurse-submodule flags to 'git checkout'
> (and merge, =E2=80=A6).  Anything that happens post-clone should recu=
rse
> through submodules automatically, and use the submodule.<name>.active
> setting to decide when recursion is desired.

Backwards compatibility and testing. Let's first implement that and
provide a config option to enable it for real world testing, and then
let's discuss changing the default later.

> I think the ideal submodule-specific interface would be just:
>=20
> * git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <nam=
e>]
>                 [--reference <repository>] [--] <repository> [<path>]
> * git submodule [--quiet] init [--] [<path>...]
> * git submodule [--quiet] deinit [-f|--force] [--] <path>...
> * git submodule [--quiet] foreach [--recursive] <command>

Ok.

> The current 'git submodule update --remote' would just be:
>=20
>   $ git submodule foreach 'git pull'
>=20
> because all of the local-branch checkouts would have already been
> handled.

Nope, that does different things to submodules where "branch" isn't
configured, right?

>  Similarly, a global push would be just:
>=20
>   $ git submodule foreach 'git push'

What's wrong with:

$ git push --recurse-submodules=3Don-demand

And it'll push the superproject at the same time. Extra points for
already being implemented ;-)

> You get all the per-submodule configuration (for triangular workflows=
,
> etc.) for free, with no submodule-specific confusion.
>=20
> So, is this:
>=20
> * Interesting enough to be worth pursuing?
> * Simple enough to be easily understood?

The thoughts about the branch workflow are really interesting. Some
other proposals overshoot a bit in my opinion ;-)

> I'd be happy to mock this up in shell, but only if anyone else would
> be interested enough to review the implementation ;).  Then I'll look
> into integrating the preferred model (this tightly bound proposal, or
> v3's looser bindings, or <your idea here>) in C, building on Jens and
> Jonathan's work.

The update modes (cleaning removed submodules and creating new ones)
are better handled in my recursive checkout series. But I believe we
can at least prototype the branch handling in shell.
