From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 1/3] rebase: learn to rebase root commit
Date: Fri, 2 Jan 2009 23:20:02 +0100
Message-ID: <200901022320.14055.trast@student.ethz.ch>
References: <200812301323.30550.trast@student.ethz.ch> <7b2902d36a4790670f20f786d4ea2e26052a6e71.1230639970.git.trast@student.ethz.ch> <7v4p0iivwh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4596742.vGsYUpv57M";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 23:21:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIsOT-0005yd-O2
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624AbZABWUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbZABWUD
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:20:03 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:56961 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbZABWUB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 17:20:01 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:19:58 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:19:58 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7v4p0iivwh.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 02 Jan 2009 22:19:58.0342 (UTC) FILETIME=[3F366A60:01C96D28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104429>

--nextPart4596742.vGsYUpv57M
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > The main use-case is with git-svn: [...]
>=20
> I like what this series tries to do.  Using the --root option is probably
> a more natural way to do what people often do with the "add graft and
> filter-branch the whole history once" procedure.

Their uses are somewhat disjoint, as grafting only works if the
grafted parent has an empty tree.  Otherwise the grafted child will
appear to revert the entire history leading to it.  Rebase OTOH
changes the committers.

> But it somewhat feels sad if the "main" use-case for this is to start your
> project in git and then migrate away by feeding your history to subversion
> ;-).

You can remove that paragraph if you don't want to "support" SVN in
git.git ;-)

> >  # Make sure the branch to rebase onto is valid.
> >  onto_name=3D${newbase-"$upstream_name"}
> >  onto=3D$(git rev-parse --verify "${onto_name}^0") || exit
> > =20
> >  # If a hook exists, give it a chance to interrupt
> > -run_pre_rebase_hook ${1+"$@"}
> > +run_pre_rebase_hook ${upstream_name+"$upstream_name"} "$@"
>=20
> I do not think ${upstream_name+"$upstream_name"} is a good check to begin
> with, because presense of it does not necessarily mean the command was
> invoked without --root; it could have come from the environment of the
> invoker (hence the suggestion to unset the variable explicitly).

Good catch, thanks.

I'm still not sure what ${1+"$@"} was about by the way.  The most
authoritative reference I can find is

  http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#t=
ag_02_05_02

which says

  If there are no positional parameters, the expansion of '@' shall
  generate zero fields, even when '@' is double-quoted.

('man bash' agrees.)

> And I do not think this is a good way to extend the calling convention of
> the hook, either.  pre-rebase-hook used to always take upstream and
> optionally the explicit branch name.  When --root is given, your code will
> give the hook a single parameter which is the explicit branch name
> (i.e. "we will switch to this branch and rebase it, are you Ok with it?"),
> but the hook will mistakenly think you are feeding the fork-point commit.
>=20
> Because an old pre-rebase-hook cannot verify --root case correctly anyway
> and needs to be updated, how about doing 'run_pre_rebase_hook --root "$@"'
> when --root was given?

True.  I noticed that I had to fix the positionals, but forgot about
the hook afterwards.  v3 implements this as you suggested.

> > +if test ! -z "$rebase_root"; then
> > +	revisions=3D"$orig_head"
> > +	fp_flag=3D"--root"
> > +else
> > +	revisions=3D"$upstream..$orig_head"
> > +	fp_flag=3D"--ignore-if-in-upstream"
> > +fi
>=20
> Hmph, the reason why --ignore-if-in-upstream is irrelevant when --root is
> given is because...?

Well, originally because format-patch didn't like the argument.
Thanks for prodding however, $onto..$head makes sort of makes sense
here and I discovered that even $onto...$head works, which is used in
'rebase -i'.

However, it's still a change of semantics: With --root we now ignore
patches that are already contained in $onto, as opposed to patches
that were already in $upstream in normal operation.  It seems sensible
to do it this way, and perhaps even normal rebase should do it the
same way... if only format-patch would support it.

Thanks for the review! v3 upcoming.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart4596742.vGsYUpv57M
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklekx4ACgkQqUud07tmzP1DcQCfWLbyKoW/GO0fDEK0rUUkxo73
3+MAn0Ch/Jl/Ev/n7Yn5I7/S8Zb92TT8
=2Q03
-----END PGP SIGNATURE-----

--nextPart4596742.vGsYUpv57M--
