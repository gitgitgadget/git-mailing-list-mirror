From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 3/3] branch: suggest how to undo a --set-upstream when
 given one branch
Date: Wed, 22 Aug 2012 03:26:46 +0200
Message-ID: <1345598806.14938.30.camel@centaur.cmartin.tk>
References: <1345470460-28734-1-git-send-email-cmn@elego.de>
	 <1345470460-28734-4-git-send-email-cmn@elego.de>
	 <7vk3wtjt3o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 03:27:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3zil-0005b9-4C
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 03:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab2HVB0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 21:26:52 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:49587 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754737Ab2HVB0v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 21:26:51 -0400
Received: from [192.168.1.5] (p57A1F6BF.dip.t-dialin.net [87.161.246.191])
	by hessy.dwim.me (Postfix) with ESMTPSA id 64690802C6;
	Wed, 22 Aug 2012 03:26:45 +0200 (CEST)
In-Reply-To: <7vk3wtjt3o.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204004>

On Mon, 2012-08-20 at 11:50 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > This interface is error prone, and a better one (--set-upstream-to)
> > exists. Suggest how to fix a --set-upstream invocation in case the
> > user only gives one argument, which makes it likely that he meant t=
o
> > do the opposite, like with
> >
> >     git branch --set-upstream origin/master
> >
> > when they meant one of
> >
> >     git branch --set-upstream origin/master master
> >     git branch --set-upstream-to origin/master
>=20
> In "git branch --set-upstream $A", if $A did not exist (i.e. we
> ended up creating $A that is forked from the current branch), and if
> refs/remotes/$A exists, I agree it is very likely that the user
> wanted to set the upstream of the current branch to remotes/$A
> instead.
>=20
> But I am not sure about other cases.  If $A already existed, it is
> equally likely that "git branch --set-upstream $A" wanted to make
> the existing $A track our current branch, or make our branch track
> that existing $A, isn't it?  We would end up giving unwanted advice
> that is *wrong* for the user's situation 50% of the time, which does
> not sound like an acceptable thing to do.
>=20
> So I would really prefer to see the condition this advice is offered
> limited to very specific cases (namely, only one parameter $A was
> given to cause us use "HEAD" as the other branch, refs/heads/$A did
> not exist and refs/remotes/$A did; there may be others but I think
> this is the one we most care about) in which we know the advice is
> correct with certainty.

I'm not sure about the 50%, I've personally never used the one-argument
version (correctly), but the restriction does make sense as
--set-upstream origin/master is the main thing we want to "protect"
against.

>=20
> > While we're at it, add a notice that the --set-upstream flag is
> > deprecated and will be removed at some point.
>=20
> This part is unquestionably good.
>=20
> > Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> >
> > ---
> >
> > This produces suboptimal output in case that A tracks B and we do
> >
> >     git checkout B
> >     git branch --set-upstream A
> >
> > as it will suggest
> >
> >     git branch --set-upstream A B
> >
> > as a way of undoing what we just did.
>=20
> The literal meaning of what the user did was to create B and then
> made A that existed (and used to build upon B) to build upon B,
> which is a no-op.  And undoing can be done with the same command.
>=20
> Which is funny.
>=20
> I am sure you will get complaint from the real users.  To avoid it,
> you would need to know what the old value was (if any), and skip the
> "undo" part, but I think it is probably worth it.  You already have
> code to learn what the old value was anyway, so the ideal is just a
> single comparison away, no?

Yes, but this comparison is already two or three levels deep in ifs,
which is why I didn't put it in this version, as it was unlikely to be
triggered anyway. As per the next paragraph, this probably won't be an
issue.

>=20
> By the way, are you assuming that what the user wanted to do was to
> make B build on top of A (i.e. set branch.B.up to A) in this
> example?  For that setting to make sense, perhaps B should already
> be a descendant of A, shouldn't it?  If that is the case, that is
> another clue you can use in your logic to decide if you want to tell
> the user "you told me to make $A build on the current branch, but I
> think you meant the other way around" with more confidence.

I am pretty much assuming that every use of --set-upstream with a singl=
e
argument was meant to use the --set-upstream-to semantics. This
particular examples is an edge-case I found when trying to figure out
the possible combinations, not a sane one I expect to see in the wild.

>=20
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > index 08068f7..33641d9 100644
> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -707,6 +707,21 @@ static int edit_branch_description(const char =
*branch_name)
> >  	return status;
> >  }
> > =20
> > +static void print_set_upstream_warning(const char *branch, int bra=
nch_existed, const char *old_upstream)
> > +{
> > +	fprintf(stderr, _("If you wanted to make '%s' track '%s', do this=
:\n\n"), head, branch);
>=20
> I would suggest strongly against using the verb "track" here, as it
> is overused and has caused confusion "is it tracking branch, remote
> tracking branch, do I merge in one but fetch to update the other?".
>=20
> Regardless of the verb, I think there should be a line _before_ the
> above to tell the user what the command actually _did_, to make the
> distinction stand out to help the user decide.

I don't like the word either, but that's what 'branch --set-upstream'
and 'checkout -t' use (or anything that ends up calling
install_branch_config()). There is such a message (see below) and that'=
s
how it says it. I worry that changing the wording might be even more
confusing, but I'll play with some wording (unless you want to change
the message in install_branch_config()).

>=20
> That is, tell the user "I set upstream for that other branch to the
> current branch, making that other branch build on top of the current
> branch.  If that was a mistake, and what you really wanted to do was
> to make the current branch build on top of the other branch, here
> are the things you need to do to recover".  Without saying anything
> before "If that was a mistake, " part and giving "to do X, do Y"
> would leave the user confused why he is being given a way to do X in
> the first place, whether what he really wanted to do was X or
> something else.

This message is always printed as a result of create_branch() at the
bottom of cmd_branch() and it's printed to stdout. The rest is printed
to stderr and that's what the tests are interested in checking, so you
can't really tell from there. The whole output looks like
       =20
    % ./bin-wrappers/git branch --set-upstream master
    The --set-upstream flag is deprecated and will be removed. Consider=
 using --track or --set-upstream-to
    Branch master set up to track local branch set-upstream-to.
    If you wanted to make 'set-upstream-to' track 'master', do this:
   =20
        git branch --set-upstream master set-upstream-to
        git branch --set-upstream-to master

It may need an extra LF after the deprecation warning for readability.

>=20
> > +	if (branch_existed) {
> > +		if (old_upstream)
> > +			fprintf(stderr, _("    git branch --set-upstream %s %s\n"), old=
_upstream, branch);
> > +		else
> > +			fprintf(stderr, _("    git branch --unset-upstream %s\n"), bran=
ch);
> > +	} else {
> > +		fprintf(stderr, _("    git branch -d %s\n"), branch);
> > +	}
> > +
> > +	fprintf(stderr, _("    git branch --set-upstream-to %s\n"), branc=
h);
> > +}
>=20
> And I suspect the logic to call into this function needs to be
> tightened a lot.  It may even turn out that we may not need messages
> when "branch_existed" is true.

Without that check, this function will be much simpler, yeah. I'll go
for showing the help only for a new branch in the next iteration and
then we can see if we want to check how existing branches relate.

>=20
> >  int cmd_branch(int argc, const char **argv, const char *prefix)
> >  {
> >  	int delete =3D 0, rename =3D 0, force_create =3D 0, list =3D 0;
> > @@ -877,10 +892,30 @@ int cmd_branch(int argc, const char **argv, c=
onst char *prefix)
> >  		git_config_set_multivar(buf.buf, NULL, NULL, 1);
> >  		strbuf_release(&buf);
> >  	} else if (argc > 0 && argc <=3D 2) {
> > +		struct branch *branch =3D branch_get(argv[0]);
> > +		const char *old_upstream =3D NULL;
> > +		int branch_existed =3D 0;
> > +
> >  		if (kinds !=3D REF_LOCAL_BRANCH)
> >  			die(_("-a and -r options to 'git branch' do not make sense with=
 a branch name"));
> > +
> > +		if (track =3D=3D BRANCH_TRACK_OVERRIDE)
> > +			fprintf(stderr, _("The --set-upstream flag is deprecated and wi=
ll be removed. Consider using --track or --set-upstream-to\n"));
> > +
> > +		/*
> > +		 * Save what argv[0] was pointing to so we can give
> > +		 * the --set-upstream-to hint
> > +		 */
> > +		if (branch_has_merge_config(branch))
> > +			old_upstream =3D shorten_unambiguous_ref(branch->merge[0]->dst,=
 0);
> > +
> > +		branch_existed =3D ref_exists(branch->refname);
> >  		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
> >  			      force_create, reflog, 0, quiet, track);
> > +
> > +		if (argc =3D=3D 1 && track =3D=3D BRANCH_TRACK_OVERRIDE)
> > +			print_set_upstream_warning(argv[0], branch_existed, old_upstrea=
m);
> > +
>=20
