From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v7 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 16:26:37 +0100
Message-ID: <20130331152637.GH2286@serenity.lan>
References: <20130331133332.GD2286@serenity.lan>
 <cover.1364738348.git.jaseg@physik-pool.tu-berlin.de>
 <51584955.40007@physik.tu-berlin.de>
 <20130331144452.GF2286@serenity.lan>
 <87mwtjwqzz.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian =?iso-8859-1?Q?G=F6tte?= <jaseg@physik.tu-berlin.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Mar 31 17:27:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMKAH-00037w-6O
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 17:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599Ab3CaP0z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 11:26:55 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:42337 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563Ab3CaP0z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 11:26:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 9769D161E393;
	Sun, 31 Mar 2013 16:26:54 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rv4A175DiZhO; Sun, 31 Mar 2013 16:26:45 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 6BB2C161E2EE;
	Sun, 31 Mar 2013 16:26:38 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <87mwtjwqzz.fsf@linux-k42r.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219631>

On Sun, Mar 31, 2013 at 05:03:44PM +0200, Thomas Rast wrote:
> John Keeping <john@keeping.me.uk> writes:
>=20
> > On Sun, Mar 31, 2013 at 04:33:57PM +0200, Sebastian G=F6tte wrote:
> >> diff --git a/commit.c b/commit.c
> >> index eda7f90..bb2d9ad 100644
> >> --- a/commit.c
> >> +++ b/commit.c
> >> @@ -1029,6 +1029,8 @@ static struct {
> >>  } sigcheck_gpg_status[] =3D {
> >>  	{ 'G', "[GNUPG:] GOODSIG " },
> >>  	{ 'B', "[GNUPG:] BADSIG " },
> >> +	{ 'U', "[GNUPG:] TRUST_NEVER" },
> >> +	{ 'U', "[GNUPG:] TRUST_UNDEFINED" },
> >>  };
> >> =20
> >>  static void parse_gpg_output(struct signature_check *sigc)
> >> @@ -1050,11 +1052,12 @@ static void parse_gpg_output(struct signat=
ure_check *sigc)
> >>  			found +=3D strlen(sigcheck_gpg_status[i].check);
> >>  		}
> >>  		sigc->result =3D sigcheck_gpg_status[i].result;
> >> -		sigc->key =3D xmemdupz(found, 16);
> >> -		found +=3D 17;
> >> -		next =3D strchrnul(found, '\n');
> >> -		sigc->signer =3D xmemdupz(found, next - found);
> >> -		break;
> >> +		if (sigc->result !=3D 'U') {
> >
> > This could use a comment; we know now that only GOODSIG and BADSIG
> > are followed by a signature, but someone looking at this code in th=
e
> > future will probably appreciate an explanation.
>=20
> Wouldn't it be even less magical if there was an explicit field in th=
e
> struct that says whether we need to read a sig from such a line?

Yeah, that would be even better.

> And furthermore, to use an enum instead of a char so that you can eas=
ily
> spell out the details in the code?  This also has the advantage that =
the
> compiler can check that your 'switch'es cover all cases.
>
> That's of course assuming that I interpret the logic right; my curren=
t
> understanding is that:
>=20
> * U means untrusted, which is bettern than B but worse than G;

Yes, although I wonder if we should split TRUST_NEVER and
TRUST_UNDEFINED (and maybe handle TRUST_MARGINAL as well) and print
different messages in each case.

> * GPG guarantees that the last line matching any of the patterns is t=
he
>   one we care about, so we can blindly override one with the other

The DETAILS file in GPG says:

    For each signature only one of the codes GOODSIG, BADSIG, EXPSIG,
    EXPKEYSIG, REVKEYSIG or ERRSIG will be emitted.

so we should be OK here.
