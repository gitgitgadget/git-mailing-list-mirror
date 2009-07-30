From: Fabian Emmes <emmes@informatik.rwth-aachen.de>
Subject: Re: [PATCH] post-receive-email: Set content-type and encoding in
	generated mail
Date: Thu, 30 Jul 2009 10:02:06 +0200
Message-ID: <20090730080206.GR31428@hebe.informatik.RWTH-Aachen.DE>
References: <1248875304-13167-1-git-send-email-emmes@informatik.rwth-aachen.de>
 <20090729144610.GA5060@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=qxmd2aOE9n9J83EO
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 10:02:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWQah-0004Ts-Gy
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 10:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbZG3ICK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 04:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbZG3ICK
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 04:02:10 -0400
Received: from mta-2.ms.rz.RWTH-Aachen.DE ([134.130.7.73]:61161 "EHLO
	mta-2.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750938AbZG3ICI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2009 04:02:08 -0400
Received: from ironport-out-2.rz.rwth-aachen.de ([134.130.5.41])
 by mta-2.ms.rz.RWTH-Aachen.de
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008))
 with ESMTP id <0KNL00I8H4ZJJSC0@mta-2.ms.rz.RWTH-Aachen.de> for
 git@vger.kernel.org; Thu, 30 Jul 2009 10:02:07 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="4.43,293,1246831200";
 d="asc'?scan'208";a="11335481"
Received: from relay-auth-2.ms.rz.rwth-aachen.de (HELO relay-auth-2)
 ([134.130.7.79]) by ironport-in-2.rz.rwth-aachen.de with ESMTP; Thu,
 30 Jul 2009 10:02:07 +0200
Received: from hebe.informatik.RWTH-Aachen.DE ([unknown] [137.226.194.45])
 by relay-auth-2.ms.rz.rwth-aachen.de
 (Sun Java(tm) System Messaging Server 7.0-3.01 64bit (built Dec  9 2008))
 with ESMTPA id <0KNL00IL14ZIO110@relay-auth-2.ms.rz.rwth-aachen.de> for
 git@vger.kernel.org; Thu, 30 Jul 2009 10:02:07 +0200 (CEST)
Content-disposition: inline
In-reply-to: <20090729144610.GA5060@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124451>


--qxmd2aOE9n9J83EO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

thanks Teemu and Jeff for correcting the errors. Indeed I assumed that
git log would always output UTF-8 and a "Content-Type" header would be
valid on its own. The patch of Jeff solves my problem. I tested the
results in mutt, kmail and thunderbird.

Regards,
Fabian

On 29. Jul, 10:46, Jeff King wrote:
> On Wed, Jul 29, 2009 at 03:48:24PM +0200, Fabian Emmes wrote:
>=20
> > --- a/contrib/hooks/post-receive-email
> > +++ b/contrib/hooks/post-receive-email
> > @@ -197,6 +197,7 @@ generate_email_header()
> >  	cat <<-EOF
> >  	To: $recipients
> >  	Subject: ${emailprefix}$projectdesc $refname_type, $short_refname, ${=
change_type}d. $describe
> > +	Content-Type: text/plain; charset=3Dutf-8
> >  	X-Git-Refname: $refname
> >  	X-Git-Reftype: $refname_type
> >  	X-Git-Oldrev: $oldrev
>=20
> Shouldn't this be $(git config i18n.logOutputEncoding), since you will
> be inserting the output of git rev-list into the mail?
>=20
> And as Teemu mentioned, you need a mime-version and a transfer-encoding
> header, as well.
>=20
> So maybe (totally untested):
>=20
> ---
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receiv=
e-email
> index 2a66063..0c1c6ad 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -192,11 +192,16 @@ generate_email()
> =20
>  generate_email_header()
>  {
> +	encoding=3D`git config i18n.logOutputEncoding`
> +	test -z "$encoding" && encoding=3Dutf-8
>  	# --- Email (all stdout will be the email)
>  	# Generate header
>  	cat <<-EOF
>  	To: $recipients
>  	Subject: ${emailprefix}$projectdesc $refname_type, $short_refname, ${ch=
ange_type}d. $describe
> +	MIME-Version: 1.0
> +	Content-Type: text/plain; charset=3D$encoding
> +	Content-Transfer-Encoding: 8bit
>  	X-Git-Refname: $refname
>  	X-Git-Reftype: $refname_type
>  	X-Git-Oldrev: $oldrev

--=20
Fabian Emmes           mailto:emmes@informatik.rwth-aachen.de
LuFG Informatik 2      http://verify.rwth-aachen.de/emmes/
RWTH Aachen            phone: +49 241 80-21241

--qxmd2aOE9n9J83EO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpxU34ACgkQBjKu4DiOXtyLYwCfR4tZKq3OpRU7iwxzNXGVHcMG
LUwAoL3KNT6KxwjX+o5sogg5+iuMaWEf
=5+Zc
-----END PGP SIGNATURE-----

--qxmd2aOE9n9J83EO--
