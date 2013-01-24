From: "=?utf-8?q?Jean-No=C3=ABl?= AVILA" <jn.avila@free.fr>
Subject: Re: [PATCH] t9902: Instruct git-completion.bash about a test mode
Date: Thu, 24 Jan 2013 23:04:15 +0100
Message-ID: <201301242304.16078.jn.avila@free.fr>
References: <201301242220.09067.jn.avila@free.fr> <7vtxq68day.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 23:04:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyUuk-0006Fr-HS
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 23:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300Ab3AXWEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 17:04:33 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:59861 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756155Ab3AXWEX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 17:04:23 -0500
X-Greylist: delayed 2649 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2013 17:04:21 EST
Received: from cayenne.localnet (unknown [82.239.31.145])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 77D634B003F;
	Thu, 24 Jan 2013 23:04:14 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.8.0-rc4jna; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vtxq68day.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214463>

Le jeudi 24 janvier 2013 22:46:13, Junio C Hamano a =C3=A9crit :
> "Jean-No=C3=ABl AVILA" <jn.avila@free.fr> writes:
>=20
> > In test mode, git completion should propose commands only if they
> > belong to the list of authorized commands.
> >
> > Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> > ---
> >
> > Better show some code than try to explain. Here is what I mean by
> > "filter the output git help -a".=20
>=20
> Why do you have to make an extra shell function call for each and
> every possible Git subcommand to slow down everybody's work when not
> in testing mode?
>=20

My rational was to be sure to put the environment variable out of the=20
way once the script has been sourced. I can make two alternative=20
definitions of __git_list_all_commands () depending on the presence of=20
$AUTHORIZED_CMD_LIST if you are worried about performance.

> Comparing it with Peff's suggestion, it is fairly clear which one we
> should pick, I think.
>=20
>=20
>=20
> >  contrib/completion/git-completion.bash | 16 +++++++++++++++-
> >  t/t9902-completion.sh                  |  4 ++--
> >  2 files changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/compl=
etion/git-completion.bash
> > index 14dd5e7..6490553 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -531,6 +531,20 @@ __git_complete_strategy ()
> >  	return 1
> >  }
> > =20
> > +if test -z "$AUTHORIZED_CMD_LIST"; then
> > +	__git_cmdlist ()
> > +	{=20
> > +		echo $1;
> > +	}
> > +else
> > +	__git_cmdlist ()
> > +	{=20
> > +		if [[ " $AUTHORIZED_CMD_LIST " =3D~ " $1 " ]] ; then
> > +				echo $1
> > +		fi
> > +	}
> > +fi
> > +
> >  __git_list_all_commands ()
> >  {
> >  	local i IFS=3D" "$'\n'
> > @@ -538,7 +552,7 @@ __git_list_all_commands ()
> >  	do
> >  		case $i in
> >  		*--*)             : helper pattern;;
> > -		*) echo $i;;
> > +		*) __git_cmdlist $i;;
> >  		esac
> >  	done
> >  }
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index 3cd53f8..5e7d81e 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -12,8 +12,8 @@ complete ()
> >  	# do nothing
> >  	return 0
> >  }
> > -
> > -. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
> > +AUTHORIZED_CMD_LIST=3D" checkout show add filter-branch ls-files s=
end-email describe"
> > +. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"=20
> > =20
> >  # We don't need this function to actually join words or do anythin=
g special.
> >  # Also, it's cleaner to avoid touching bash's internal completion =
variables.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
