From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: fetch and bundle don't work in (semi-)broken repo
Date: Wed, 20 Oct 2010 09:41:22 +0200
Message-ID: <20101020074122.GC28166@pengutronix.de>
References: <20101019160957.GK11713@pengutronix.de> <20101019183925.GF25139@burratino> <20101019201139.GB28166@pengutronix.de> <alpine.LFD.2.00.1010191635030.2764@xanadu.home> <20101019210233.GA32029@burratino> <alpine.LFD.2.00.1010192154200.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 20 09:41:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8TIi-0005PT-6d
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 09:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299Ab0JTHlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 03:41:25 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57179 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162Ab0JTHlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 03:41:25 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P8TIZ-0006ZS-Ry; Wed, 20 Oct 2010 09:41:23 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P8TIY-0002oI-35; Wed, 20 Oct 2010 09:41:22 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010192154200.2764@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159398>

Hello Nico,

On Tue, Oct 19, 2010 at 11:06:50PM -0400, Nicolas Pitre wrote:
> On Tue, 19 Oct 2010, Jonathan Nieder wrote:
>=20
> > Nicolas Pitre wrote:
> >=20
> > >                                 But ideally you should simply fin=
d a=20
> > > pack that contains the problematic object in another repository a=
nd=20
> > > copy it with its index file into the broken repository.
> >=20
> > I assume the object is gone for good, but if you have it in another
> > repo that would be interesting, too.
> >=20
> > To be clear: I think the important data has been recovered from the
> > broken repo already in the form of patches (right?) so the question
> > at hand is whether it would be possible to teach git to do better a=
t
> > recovering automatically.  Which might depend on the nature of the
> > missing objects.
>=20
> Sure.  Given that it is possible to create a patch series, that means=
=20
> that all the important objects are still available.  Therefore Git=20
> should be able to produce the pack for the equivalent fetch/bundle as=
=20
> well.
>=20
> So the following patch should help.  I hope that Uwe still has a copy=
 of=20
> the broken repo to test this patch with.
>=20
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index f8eba53..691c2f1 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1299,6 +1299,15 @@ static int try_delta(struct unpacked *trg, str=
uct unpacked *src,
>  		src->data =3D read_sha1_file(src_entry->idx.sha1, &type, &sz);
>  		read_unlock();
>  		if (!src->data)
> +			if (src_entry->preferred_base) {
> +				/*=20
> +				 * Those objects are not included in the
> +				 * resulting pack.  Be resilient and ignore
> +				 * them, in case the pack could be created
> +				 * nevertheless.
> +				 */
> +				return 0;
> +			}
>  			die("object %s cannot be read",
>  			    sha1_to_hex(src_entry->idx.sha1));
>  		if (sz !=3D src_size)
Doesn't help :-(  I added a warning(...) before your return 0, and I
don't see it.  Probably this means this is not the problematic code
path.

The output with your patch applied is:
	user@hostname:~/path/linux-2.6$ ~/gsrc/git/bin-wrappers/git bundle cre=
ate tra linus/master..sectionmismatches
	Counting objects: 118, done.
	error: unable to find 40aaeb204dc04d3cf15c060133f65538b43b13b0
	Delta compression using up to 8 threads.
	fatal: object 3cf4fa25ab3d078a49e9488effaebf571fa128da cannot be read
	error: pack-objects died

If you want I can provide you the broken repo.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
