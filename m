From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v7 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 15:44:52 +0100
Message-ID: <20130331144452.GF2286@serenity.lan>
References: <20130331133332.GD2286@serenity.lan>
 <cover.1364738348.git.jaseg@physik-pool.tu-berlin.de>
 <51584955.40007@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, trast@inf.ethz.ch
To: Sebastian =?iso-8859-1?Q?G=F6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Sun Mar 31 16:45:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMJVm-0003uj-6N
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 16:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab3CaOpD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 10:45:03 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:53331 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294Ab3CaOpC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 10:45:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id B87F16064EA;
	Sun, 31 Mar 2013 15:45:00 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nDNdVMZ3MMRS; Sun, 31 Mar 2013 15:45:00 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 91C3B6064E6;
	Sun, 31 Mar 2013 15:44:54 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <51584955.40007@physik.tu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219628>

On Sun, Mar 31, 2013 at 04:33:57PM +0200, Sebastian G=F6tte wrote:
> When --verify-signatures is specified, abort the merge in case a good
> GPG signature from an untrusted key is encountered.
>=20
> Signed-off-by: Sebastian G=F6tte <jaseg@physik-pool.tu-berlin.de>
> ---
>  Documentation/merge-options.txt    |   4 ++--
>  builtin/merge.c                    |   2 ++
>  commit.c                           |  13 ++++++++-----
>  commit.h                           |  10 +++++-----
>  gpg-interface.h                    |   1 +
>  t/lib-gpg/pubring.gpg              | Bin 1164 -> 2359 bytes
>  t/lib-gpg/random_seed              | Bin 600 -> 600 bytes
>  t/lib-gpg/secring.gpg              | Bin 1237 -> 3734 bytes
>  t/lib-gpg/trustdb.gpg              | Bin 1280 -> 1360 bytes
>  t/t7612-merge-verify-signatures.sh |   9 +++++++++
>  10 files changed, 27 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-op=
tions.txt
> index 31f1067..a0f022b 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -85,8 +85,8 @@ option can be used to override --squash.
> =20
>  --verify-signatures::
>  --no-verify-signatures::
> -	Verify that the commits being merged have good GPG signatures and a=
bort the
> -	merge in case they do not.
> +	Verify that the commits being merged have good and trusted GPG sign=
atures
> +	and abort the merge in case they do not.
> =20
>  --summary::
>  --no-summary::
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 7a33d03..752e3a9 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1248,6 +1248,8 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
>  			switch(signature_check.result){
>  				case 'G':
>  					break;
> +				case 'U':
> +					die(_("Commit %s has a good, untrusted GPG signature allegedly =
by %s."), hex, signature_check.signer);
>  				case 'B':
>  					die(_("Commit %s has a bad GPG signature allegedly by %s."), he=
x, signature_check.signer);
>  				default: /* 'N' */
> diff --git a/commit.c b/commit.c
> index eda7f90..bb2d9ad 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1029,6 +1029,8 @@ static struct {
>  } sigcheck_gpg_status[] =3D {
>  	{ 'G', "[GNUPG:] GOODSIG " },
>  	{ 'B', "[GNUPG:] BADSIG " },
> +	{ 'U', "[GNUPG:] TRUST_NEVER" },
> +	{ 'U', "[GNUPG:] TRUST_UNDEFINED" },
>  };
> =20
>  static void parse_gpg_output(struct signature_check *sigc)
> @@ -1050,11 +1052,12 @@ static void parse_gpg_output(struct signature=
_check *sigc)
>  			found +=3D strlen(sigcheck_gpg_status[i].check);
>  		}
>  		sigc->result =3D sigcheck_gpg_status[i].result;
> -		sigc->key =3D xmemdupz(found, 16);
> -		found +=3D 17;
> -		next =3D strchrnul(found, '\n');
> -		sigc->signer =3D xmemdupz(found, next - found);
> -		break;
> +		if (sigc->result !=3D 'U') {

This could use a comment; we know now that only GOODSIG and BADSIG
are followed by a signature, but someone looking at this code in the
future will probably appreciate an explanation.

> +			sigc->key =3D xmemdupz(found, 16);
> +			found +=3D 17;
> +			next =3D strchrnul(found, '\n');
> +			sigc->signer =3D xmemdupz(found, next - found);
> +		}
>  	}
>  }
> =20
