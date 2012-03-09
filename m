From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Fri, 09 Mar 2012 11:25:15 +0100
Message-ID: <1331288715.21444.38.camel@beez.lab.cmartin.tk>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-pOPkZWxwZKprv0A9wo0B"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Mar 09 11:25:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5x0n-0002AR-3j
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 11:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab2CIKZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 05:25:20 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:55747 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224Ab2CIKZS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 05:25:18 -0500
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id A9DB046057;
	Fri,  9 Mar 2012 11:25:08 +0100 (CET)
In-Reply-To: <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192708>


--=-pOPkZWxwZKprv0A9wo0B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-03-09 at 09:31 +0100, Matthieu Moy wrote:
> More inexperienced users will often push right after committing, and at
> that time they're still very much in the "working-on-one-branch" state of
> mind.  "upstream" would be a safer default mode of operation for 'git pus=
h'
> for them even when they have their personal publishing repository (also i=
n
> a shared public repository settings, "matching" is rarely the right
> default mode).
>=20
> In preparation for flipping the default to the "upstream" mode from the
> "matching" mode that is the upstream default, start warning users when th=
ey
> rely on unconfigured "git push" to default to the "matching" mode.
>=20
> Original patch and commit message by: Junio C Hamano <gitster@pobox.com>
>=20
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>=20
> This patch prepares a transition to 'upstream', unlike the previous
> version which was advertizing 'current'. In most case, this would be
> the same, but 'upstream' is probably more sensible in case it points
> to a branch other than 'current'. I don't care much either way.
>=20

For people using git as VCS that happens to have local history rather
than taking full advantage of the distributed nature (or who aren't
aware of it or don't get it), 'matching' is bound to be confusing.
However, IMO 'current' makes more sense. Consider

    git clone ../foo; cd foo;
    git checkout -b topic origin/develop
    ed main.c
    git push

With upstream I've just updated origin's dev branch, even though I might
have meant to create a new 'topic' branch. Alternatively, I might have
run

    git checkout -b topic

in which case I certainly want 'current'. I don't see that workflow
where the upstream branch is named differently from the local one should
be that big a consideration when trying to determine a default to help
people unfamiliar as they'd be certainly more likely to consider branch
names to be binding. Maybe you have seen this differently in your
students, but that's the impression I get from #git.

They also seem to expect 'git pull' to be magic, but that's a different
story.

> I've kept the wording from the original patch, which commits to a
> future change. We may instead relax this commitment and just say "the
> default is likely to change in a future version", or so.
>=20
>  builtin/push.c |   22 ++++++++++++++++++++++
>  cache.h        |    1 +
>  environment.c  |    2 +-
>  3 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/push.c b/builtin/push.c
> index d315475..03545c0 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -91,10 +91,32 @@ static void setup_push_upstream(struct remote *remote=
)
>  	add_refspec(refspec.buf);
>  }
> =20
> +static void warn_unspecified_push_default_configuration(void)
> +{
> +	static int warn_once;
> +
> +	if (warn_once++)
> +		return;
> +	warning(_("push.default is unset; its implicit value is changing in 1.8=
.0 from\n"
> +		  "'matching' to 'upstream'. To squelch this message and maintain the =
current\n"
> +		  "behavior post-1.8.0, use:\n"
> +		  "\n"
> +		  "  git config --global push.default matching\n"
> +		  "\n"
> +		  "To squelch this message and adopt the 1.8.0 behavior now, use:\n"
> +		  "\n"
> +		  "  git config --global push.default upstream\n"
> +		  "\n"
> +		  "See 'git help config' and search for 'push.default' for further inf=
ormation.\n"));
> +}
> +
>  static void setup_default_push_refspecs(struct remote *remote)
>  {
>  	switch (push_default) {
>  	default:
> +	case PUSH_DEFAULT_UNSPECIFIED:
> +		warn_unspecified_push_default_configuration();
> +		/* fallthru */
>  	case PUSH_DEFAULT_MATCHING:
>  		add_refspec(":");
>  		break;
> diff --git a/cache.h b/cache.h
> index e12b15f..e5c3f26 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -622,6 +622,7 @@ enum rebase_setup_type {
>  };
> =20
>  enum push_default_type {
> +	PUSH_DEFAULT_UNSPECIFIED =3D -1,
>  	PUSH_DEFAULT_NOTHING =3D 0,
>  	PUSH_DEFAULT_MATCHING,
>  	PUSH_DEFAULT_UPSTREAM,
> diff --git a/environment.c b/environment.c
> index c93b8f4..d7e6c65 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -52,7 +52,7 @@ enum safe_crlf safe_crlf =3D SAFE_CRLF_WARN;
>  unsigned whitespace_rule_cfg =3D WS_DEFAULT_RULE;
>  enum branch_track git_branch_track =3D BRANCH_TRACK_REMOTE;
>  enum rebase_setup_type autorebase =3D AUTOREBASE_NEVER;
> -enum push_default_type push_default =3D PUSH_DEFAULT_MATCHING;
> +enum push_default_type push_default =3D PUSH_DEFAULT_UNSPECIFIED;
>  #ifndef OBJECT_CREATION_MODE
>  #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
>  #endif



--=-pOPkZWxwZKprv0A9wo0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJPWdqLAAoJEHKRP1jG7ZzTiLsH/RY5pCXQlk6yAv8FzkJxEQxB
O2HbWIYTuJgvozlrJ5qosyJcoet0cfDHU1vEsyooJrB110tfuqITd4ZzlouZSb6O
ego+LlKTUunZgmf+UfgYr1H9zkSt5tYbQXXBDd727NHN89uy62vT8pOlwcIOGHEg
QiHHr/1ZHUXOR0BR+VSxxLlbEpXx3UrmV+XPk0RI8hsudHPoZSZb8J5A2dJjL2J9
jPJEoHXRfnmmiOzlu/MLs03qEge18R2gLb8j5WLKT4XGn3Alcj6MAPyGKEixRU6+
x8pgXxQn1zTWqFLFUq/31l+sRVULmBn8ow29E8oa6W2044F8IqXj/Z+q/oHbaUA=
=kUlR
-----END PGP SIGNATURE-----

--=-pOPkZWxwZKprv0A9wo0B--
