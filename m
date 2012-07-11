From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 2/3] branch: suggest how to undo a --set-upstream when
 given one branch
Date: Wed, 11 Jul 2012 15:50:06 +0200
Message-ID: <1342014606.6458.7.camel@centaur.cmartin.tk>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
	 <1341939181-8962-3-git-send-email-cmn@elego.de>
	 <vpqpq83mt2g.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 11 15:49:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoxIe-0005AN-01
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 15:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236Ab2GKNtr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jul 2012 09:49:47 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:58071 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755142Ab2GKNtq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 09:49:46 -0400
Received: from [192.168.1.5] (p4FC5CD3B.dip.t-dialin.net [79.197.205.59])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 87C2946149;
	Wed, 11 Jul 2012 15:49:41 +0200 (CEST)
In-Reply-To: <vpqpq83mt2g.fsf@bauges.imag.fr>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201300>

On Tue, 2012-07-10 at 19:20 +0200, Matthieu Moy wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -864,10 +864,32 @@ int cmd_branch(int argc, const char **argv, c=
onst char *prefix)
> >  		   info and making sure new_upstream is correct */
> >  		create_branch(head, branch->name, new_upstream, 0, 0, 0, quiet, =
BRANCH_TRACK_OVERRIDE);
> >  	} else if (argc > 0 && argc <=3D 2) {
> > +		struct branch *branch =3D branch_get(argv[0]);
> > +		const char *old_upstream =3D NULL;
> > +		int branch_existed =3D 0;
> > +
> >  		if (kinds !=3D REF_LOCAL_BRANCH)
> >  			die(_("-a and -r options to 'git branch' do not make sense with=
 a branch name"));
> > +
> > +		/* Save what argv[0] was pointing to so we can give
> > +		   the --set-upstream-to hint */
>=20
> Multi-line comments are usually written in Git as
>=20
> /*
>  * multi-line
>  * comment
>  */

I've seen this style often, but sure.

>=20
> > +		if (branch_has_merge_config(branch))
> > +		  old_upstream =3D shorten_unambiguous_ref(branch->merge[0]->dst=
, 0);
>=20
> Broken indentation.

Yeah, sorry. New laptop, hadn't got the default style fixed in the
config.

>=20
> > +		if (argc =3D=3D 1) {
> > +			printf("If you wanted to make '%s' track '%s', do this:\n", hea=
d, argv[0]);
>=20
> Could be marked for translation with _("...").

Done.

>=20
> > +			if (branch_existed)
> > +				printf(" $ git branch --set-upstream '%s' '%s'\n", argv[0], ol=
d_upstream);
>=20
> old_upstream may be NULL at this point. I guess you want to skip this
> line if old_upsteam is NULL.

We've just set up tracking for it, so we'd want to undo that. Which
means --unset-upstream would have to move earlier in the series so we
can suggest that.

>=20
> The fact that I could find this bug suggests that this lacks a few ne=
w
> tests too ;-).

Indeed :) the next round will have them.

>=20
> > +			else
> > +				printf(" $ git branch -d '%s'\n", argv[0]);
> > +
> > +			printf(" $ git branch --set-upstream-to '%s'\n", argv[0]);
>=20
> For the 3 printf()s: we usually display commands without the "$", and
> separate them from text with a blank line. See for example what "git
> commit" says when you didn't provide authorship:

Yeah, I was going by what Junio wrote in his mail. We should probably
have a double-LF as well, like in the message below.

>=20
> You can suppress this message by setting them explicitly:
>=20
>     git config --global user.name "Your Name"
>     git config --global user.email you@example.com
>=20
> After doing this, you may fix the identity used for this commit with:
>=20
>     git commit --amend --reset-author
>=20
> (the absence of $ sign avoids the temptation to cut-and-paste it)
>=20
