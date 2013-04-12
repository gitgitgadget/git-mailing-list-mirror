From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] pull: fail early if we know we can't merge from upstream
Date: Fri, 12 Apr 2013 12:17:18 +0200
Message-ID: <1365761838.2468.21.camel@flaca.cmartin.tk>
References: <1365686801-17206-1-git-send-email-cmn@elego.de>
	 <7v1uahj7do.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 12:17:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQb2r-0001wd-Qq
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 12:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061Ab3DLKRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 06:17:21 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:51016 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753024Ab3DLKRU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 06:17:20 -0400
Received: from [87.77.57.197] (z39c5.pia.fu-berlin.de [87.77.57.197])
	by hessy.dwim.me (Postfix) with ESMTPSA id 608728065C;
	Fri, 12 Apr 2013 12:17:19 +0200 (CEST)
In-Reply-To: <7v1uahj7do.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220974>

On Thu, 2013-04-11 at 10:37 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > I can't quite decide whether the behaviour of 'git pull' with no
> > upstream configured but a default remote with no fetch refspecs
> > merging the remote's HEAD is a feature, a bug or something in betwe=
en,
> > but it's used by t7409 so maybe someone else is using it and we
> > shouldn't break it.
>=20
> Isn't it the simplest "works without any configuration" from the
> original days?=20

I don't recall remotes not having refspecs when they're int he config,
though I guess it's equivalent to running 'git pull
git://example.org/myrepo.git'.

>=20
> > There's another check that could be made earlier ('git pull
> > someremote' when that's not the branch's upstream remote), but then
> > you have to start figuring out what the flags to fetch are.
>=20
> When the user gave us explicitly the name of the remote, it does not
> sound too bad to fetch from there.  "git pull someremote thatbranch"
> can be given after seeing a failure and succeed without retransfer,
> no?

It's not too bad, though you're paying for connection and ref
advertisement twice which breaks the otherwise quick pace of git
commands.

What I find bad from a UI point of view is that after fetching (which
could even be from the wrong remote for 'git pull' w/o upstream info)
git turns around and says "I was never going to merge/rebase that" for
things that we can know before fetching because they depend solely on
the configuration.

>=20
> I am not sure if it is worth the added complexity and potential to
> introduce new bugs in general by trying to outsmart the for-merge
> logic that kicks in only after we learn what the other side offers
> and fetch from it, but anyway, let's see what we got here...
>=20
> > diff --git a/git-pull.sh b/git-pull.sh
> > index 266e682..b62f5d3 100755
> > --- a/git-pull.sh
> > +++ b/git-pull.sh
> > @@ -43,6 +43,8 @@ log_arg=3D verbosity=3D progress=3D recurse_submo=
dules=3D
> >  merge_args=3D edit=3D
> >  curr_branch=3D$(git symbolic-ref -q HEAD)
> >  curr_branch_short=3D"${curr_branch#refs/heads/}"
> > +upstream=3D$(git config "branch.$curr_branch_short.merge")
> > +remote=3D$(git config "branch.$curr_branch_short.remote")
> >  rebase=3D$(git config --bool branch.$curr_branch_short.rebase)
>=20
> Learning these upfront sounds sensible.
>=20
> >  if test -z "$rebase"
> >  then
> > @@ -138,6 +140,47 @@ do
> >  	esac
> >  	shift
> >  done
> > +if test true =3D "$rebase"
> > +then
> > +    op_type=3Drebase
> > +    op_prep=3Dagainst
> > +else
> > +    op_type=3Dmerge
> > +    op_prep=3Dwith
> > +fi
> > +
> > +check_args_against_config () {
> > +	# If fetch gets user-provided arguments, the user is
> > +	# overriding the upstream configuration, so we have to wait
> > +	# for fetch to do its work to know if we can merge.
> > +	if [ $# -gt 0 ]; then
> > +		return
> > +	fi
>=20
> > +	# Figure out what remote we're going to be fetching from
> > +	use_remote=3Dorigin
> > +	if [ -n "$remote" ]; then
> > +		use_remote=3D"$remote"
> > +	fi
> > +
> > +	# If the remote doesn't have a fetch refspec, then we'll merge
> > +	# whatever fetch marks for-merge, same as above.
>=20
> The "above" in this sentence refers to...?
>=20
> I guess "we have to wait", but it wasn't very clear.
>=20

Yes, it refers to having to wait for fetch to complete before we can
know if we'll be able to merge.

> > +	fetch=3D$(git config --get-all "remote.$use_remote.fetch")
> > +	if [ -z "$fetch" ]; then
> > +		return
> > +	fi
>=20
> Hmm, it is probably correct to punt on this case, but it defeats
> large part of the effect of your effort, doesn't it? We fetch what
> is covered by remote.$name.fetch _and_ what need to complete the
> merge operation (otherwise branch.$name.merge that is not covered by
> remote.$there.fetch will not work).  So
>=20
>     [remote "origin"]
>             url =3D $over_there
>     [branch "master"]
>             remote =3D origin
>             merge =3D refs/heads/master
>=20
> would still fetch refs/heads/master from there and merge it.

If you run 'git pull' in this situation, then everything's fine and the
right thing gets merged.

>=20
> > +	# The typical 'git pull' case where it should merge from the
> > +	# current branch's upstream. We can already check whether we
> > +	# we can do it. If HEAD is detached or there is no upstream
> > +	# branch, complain now.
>=20
> Drop "typical", and rephrase "merge from" to also cover "rebase" (I
> often say "integrate with").

Sounds good.

>=20
> To return to your original description:
>=20
>     A 'git pull' without specifying a remote is asked to take the
>     current branch's upstream as the branch to merge from. This
>     cannot work without an upstream configuration nor with HEAD
>     detached, but we only check for this after fetching.
>=20
> Wouldn't it be sufficient to add something like this before fetch
> happens:
>=20
> 	if test $# !=3D 0 || # args explicitly specified
>            test -n "$curr_branch" || # not detached
> 	   test -n "$upstream" # what to integrate with is known
> 	then
> 		return ;# then no problem
> 	fi
> 	die "underspecified 'git pull'"
>=20
> without changing anything else?  For that matter, $upstream is
> likely to be empty when detached, so the second test may not even be
> necessary.
>=20

I'm not sure if this allows us to print out the help message about
missing upstream configuration in the right case. I'll test.

   cmn
