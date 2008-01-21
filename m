From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: pack-objects: Fix segfault when object count is less than
	thread count
Date: Mon, 21 Jan 2008 20:40:52 +0300
Message-ID: <20080121174052.GA4627@atlas.home>
References: <1200926145-14625-1-git-send-email-vsu@altlinux.ru> <alpine.LFD.1.00.0801211103480.20753@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 18:41:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH0eI-0003jV-JL
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 18:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbYAURk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 12:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbYAURk5
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 12:40:57 -0500
Received: from master.altlinux.org ([62.118.250.235]:4161 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbYAURk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 12:40:56 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id CD971E31C5; Mon, 21 Jan 2008 20:40:54 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801211103480.20753@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71298>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2008 at 11:07:15AM -0500, Nicolas Pitre wrote:
> On Mon, 21 Jan 2008, Sergey Vlasov wrote:
>=20
> > When partitioning the work amongst threads, dividing the number of
> > objects by the number of threads may return 0 when there are less
> > objects than threads; this will cause the subsequent code to segfault
> > when accessing list[sub_size-1].  Fix this by ensuring that sub_size
> > is not zero if there is at least one object to process.
>=20
> No.  Forcing one object in a thread is counter productive since it won't=
=20
> have anything to delta against.  Instead, the thread should be allowed=20
> to have zero objects and let the other threads have more.
>=20
> This patch would be a proper fix:
>=20
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index ec10238..d3efeff 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1672,7 +1672,8 @@ static void ll_find_deltas(struct object_entry **li=
st, unsigned list_size,
>  		p[i].data_ready =3D 0;
> =20
>  		/* try to split chunks on "path" boundaries */
> -		while (sub_size < list_size && list[sub_size]->hash &&
> +		while (sub_size && sub_size < list_size &&
> +		       list[sub_size]->hash &&
>  		       list[sub_size]->hash =3D=3D list[sub_size-1]->hash)
>  			sub_size++;

Actually there will not be any significant differences - with my patch
the object distribution between threads will be 1, 1, ..., 0, 0...,
and with your patch it would be 0, 0, ..., 1, 1, ... (unless the
objects had the same hash, in which case they would be passed to a
single thread in both cases).

We could even introduce some limit on the number of objects below
which multithreaded packing is not attempted, so that packing a small
number of objects would be more efficient.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHlNkkW82GfkQfsqIRAqkJAJ0Z1SNzzaqzSjqgRjYAzJ3785D3bgCfTUDv
TFuTTGvJj89YD1fSUf+6aUg=
=C1bG
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
