From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] write_sha1_file(): Perform Z_FULL_FLUSH between header and data
Date: Wed, 8 Mar 2006 17:17:09 +0300
Message-ID: <20060308141709.GB9555@procyon.home>
References: <7vpslc8oni.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602241613030.31162@localhost.localdomain> <Pine.LNX.4.64.0602241637480.22647@g5.osdl.org> <Pine.LNX.4.64.0602242130030.31162@localhost.localdomain> <Pine.LNX.4.64.0602241952140.22647@g5.osdl.org> <Pine.LNX.4.64.0602242326381.31162@localhost.localdomain> <Pine.LNX.4.64.0602250012230.31162@localhost.localdomain> <7vzmk1izpa.fsf_-_@assigned-by-dhcp.cox.net> <20060308134519.78ea313d.vsu@altlinux.ru> <7vhd69i4ep.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 15:17:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGzTd-0000YK-4n
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 15:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWCHORS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 09:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWCHORS
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 09:17:18 -0500
Received: from master.altlinux.org ([62.118.250.235]:57862 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1030206AbWCHORR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Mar 2006 09:17:17 -0500
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id 3EE64E338A; Wed,  8 Mar 2006 17:17:16 +0300 (MSK)
Received: by procyon.home (Postfix, from userid 500)
	id 2A7BCE3668D; Wed,  8 Mar 2006 17:17:09 +0300 (MSK)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd69i4ep.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17372>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2006 at 03:04:14AM -0800, Junio C Hamano wrote:
> Sergey Vlasov <vsu@altlinux.ru> writes:
> > However, a straight reuse still will not be possible, because
> > sha1write_compressed() uses deflateInit(&stream, Z_DEFAULT_COMPRESSION),
> > which writes zlib headers around the deflate stream, and the zlib footer
> > contains adler32 checksum.  So, as a minimum, you will need to
> > decompress the object data, calculate its adler32 checksum and write the
> > zlib header yourself.
>=20
> Hmph.  Thanks for helping, but it sounds like my original plan
> was not useful at all.  Probably inflating would be still
> cheaper than inflating and then deflating, but it would not be
> as cool as a straight copy.  Sigh...

Actually you can calculate adler32 checksum of object data from
adler32(header+data) (available at the end of the loose object file),
adler32(header) (which you will need to calculate) and len(data)
(which is available in the header):

#define ADLER32_BASE	65521UL

unsigned int adler32_split(unsigned int adler_full, unsigned int adler_1,
			   unsigned long len_2)
{
	unsigned long s1_1 =3D adler_1 & 0xffff;
	unsigned long s1_2 =3D (adler_1 >> 16) & 0xffff;
	unsigned long rem =3D len_2 % ADLER32_BASE;
	unsigned long s_1_offset =3D (s1_1 + ADLER32_BASE - 1) % ADLER32_BASE;
	unsigned long s_2_offset =3D (s1_2 + s_1_offset*rem) % ADLER32_BASE;
	unsigned long sf_1 =3D adler_full & 0xffff;
	unsigned long sf_2 =3D (adler_full >> 16) & 0xffff;
	unsigned long s2_1 =3D (sf_1 + ADLER32_BASE - s_1_offset) % ADLER32_BASE;
	unsigned long s2_2 =3D (sf_2 + ADLER32_BASE - s_2_offset) % ADLER32_BASE;
	return (s2_2 << 16) | s2_1;
}

However, the resulting code probably won't be pretty...

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEDudlW82GfkQfsqIRAifRAJ4oduFUPuQtFyLYXtDEf/QX5XhcvwCfZDiU
6v0nQbauLYH5rBYV0lAqs5s=
=17wS
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
