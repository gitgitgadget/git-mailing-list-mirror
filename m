From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] branch: add -u as a shortcut for --set-upstream
Date: Sun, 08 Jul 2012 07:48:15 +0200
Message-ID: <1341726495.10752.78.camel@flaca.cmartin.tk>
References: <1341475035-14310-1-git-send-email-cmn@elego.de>
	 <20120706153239.GA29362@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 12:49:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Snp2u-0004Yc-Bc
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 12:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab2GHKsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jul 2012 06:48:15 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:43683 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272Ab2GHKsO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 06:48:14 -0400
Received: from [141.23.102.101] (unknown [141.23.102.101])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 09F8746149;
	Sun,  8 Jul 2012 12:48:10 +0200 (CEST)
In-Reply-To: <20120706153239.GA29362@burratino>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201172>

On Fri, 2012-07-06 at 10:32 -0500, Jonathan Nieder wrote:
> Hi Carlos,
>=20
> Carlos Mart=C3=ADn Nieto wrote:
>=20
> > Add this shortcut just like git-push has it.
> [...]
> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -724,7 +724,7 @@ int cmd_branch(int argc, const char **argv, con=
st char *prefix)
> >  		OPT__QUIET(&quiet, "suppress informational messages"),
> >  		OPT_SET_INT('t', "track",  &track, "set up tracking mode (see gi=
t-pull(1))",
> >  			BRANCH_TRACK_EXPLICIT),
> > -		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
> > +		OPT_SET_INT('u', "set-upstream",  &track, "change upstream info"=
,
> >  			BRANCH_TRACK_OVERRIDE),
>=20
> I think this is a bad idea.  The --set-upstream option is confusing:
>=20
> 	$ git branch --set-upstream=3Dfoo
> 	error: option 'set-upstream' takes no value
> 	$ ???

It is confusing, see the other thread (about making --set-upstream
behave more sanely) for the second part of this. I wanted to add a hack
so

    git branch --set-upstream foo

would set the current branch to track foo.

>=20
> -u to set the corresponding upstream branch at the same time as
> creating a branch, analagous to "git push -u" might seem intuitive:
>=20
> 	# create foo branch, setting its upstream at the same time
> 	git branch -u foo origin/foo
>=20
> But that is what --track does and is not what --set-upstream is for.

Right, it's for altering the configuration after the branch has already
been created. I wasn't thinking about creating the branch. That usage o=
f
--set-upstream seems unintuitive to me, but changing the upstream for a
branch that already exists is quite intuitive and what push -u does.

>=20
> Unlike --track, I don't think --set-upstream is a common enough
> operation to deserve a one-letter synonym.

I find myself using it surprisingly often, though it's certainly still
not in the top-10.

>=20
> Instead, I'd suggest the following changes:
>=20
>  1) Add support for
>=20
> 	# change upstream info
> 	git branch --set-upstream=3Dorigin/foo foo
>=20
>     for existing branches only.

I submitted the patch I mentioned above which changes --set-upstream to
something closer to what the user probably expects, which behaves mostl=
y
like this, except that you'd have to omit the '=3D' as it still expecte=
d
the branch as an argument to the command. Not the cleanest wrt how
options should take arguments, but it got the job done without much cod=
e
churn.

However, Junio doesn't like that it changes existing behaviour which is
even consistent (as long as you know that --set-upstream is a flag,
rather than an option with an argument) and some people might depend on
it behaving like it does with a single argument. He'd accept a
--set-upstream-to that behaves just like you describe. This could do
with having a short alias, as the name is quite long-winded. Another
reason for adding -u is that it would add confusion if --set-upstream
has the short alias -u in push, but it means something else in branch,
even though they have the same option (though it would be
--set-upstream-to here, but we'll end up deprecating --set-upstream, so
it works out in the long run).

>=20
>  2) Introduce an --unset-upstream option which removes the
>     "corresponding upstream branch" configuration for an existing
>     branch.

This is a good idea. I'll add it to the patch series.

>=20
>  3) Warn on
>=20
> 	# acts just like --track
> 	git branch --set-upstream foo origin/foo
>=20
>     for branches that do not exist yet.  Plan to make this a hard
>     error in the future.
>=20
>  4) Warn on
>=20
> 	# sets upstream for "foo" to the current branch
> 	git branch --set-upstream foo
>=20
>     and plan to make it a hard error in the future.
>=20
>  5) Warn on
>=20
> 	git branch --set-upstream origin/foo foo
>=20
>   which is almost certainly a typo for
>=20
> 	git branch --set-upstream=3Dorigin/foo foo

This is roughly what Junio suggested. His proposal was to also show how
to undo the --set-upstream if it was invoked the wrong way.

>=20
>  6) Perhaps, make -u a synonym for -t for consistency with "git push"=
=2E

I don't really see -u and -t being consistent with push -u. The push
might create a branch, but that would be in another repository. I look
at it as modifying the upstream information for an existing branch in
the local repository, and -t does not do that, --set-upstream(-to) does
that. It can also create a new local branch, but that's another bug in
the interface.

   cmn
