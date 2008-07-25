From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Fri, 25 Jul 2008 12:20:59 -0500
Message-ID: <20080725172059.GD21117@spearce.org>
References: <alpine.DEB.1.00.0807251513240.11976@eeepc-johanness> <20080725171315.GA27285@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Bjjjrn Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 19:22:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQzQ-0007Sg-SZ
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 19:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbYGYRVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 13:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYGYRVA
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 13:21:00 -0400
Received: from george.spearce.org ([209.20.77.23]:36233 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYGYRU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 13:20:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 25AA1383A5; Fri, 25 Jul 2008 17:20:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080725171315.GA27285@atjola.homenet>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90077>

Bjjjrn Steinbrink <B.Steinbrink@gmx.de> wrote:
> When index-pack completes a thin pack it appends objects to the pack.
> Since the commit 92392b4(index-pack: Honor core.deltaBaseCacheLimit w=
hen
> resolving deltas) such an object can be pruned in case of memory pres=
sure.
>=20
> To be able to re-read the object later, a few more fields have to be =
set.
>=20
> Noticed by Pierre Habouzit.
>=20
> Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
> Acked-by: Nicolas Pitre <nico@cam.org>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

>     On 2008.07.25 15:15:48 +0200, Johannes Schindelin wrote:
>     > So, let's add the comment as Nico suggested, and set real_type,
>     > too?
>=20
>     OK, I hope the comment is what was expected. My lack of knowledge
>     made we wonder what to write... :-/

The commit message makes sense to me.  :)
=20
>     > (And it would be smashing if you could verify that the type is
>     > indeed correctly set to non-delta...)
>=20
>     Hm, we get the object via read_sha1_file, can that return a delta=
? I
>     would not expect it to.  Sorry, never looked at those code paths
>     (and don't have the time to investigate at the moment).

read_sha1_file() _never_ returns a delta.  It always reutrns the
whole object, even if the object was stored as a delta in a pack
somewhere.  The function is widely used within git to read an object
for processing, without the caller needing to worry about the types
of compression used to store the object.


> diff --git a/index-pack.c b/index-pack.c
> index ac20a46..d757b07 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -699,6 +699,12 @@ static struct object_entry *append_obj_to_pack(
>  	write_or_die(output_fd, header, n);
>  	obj[0].idx.crc32 =3D crc32(0, Z_NULL, 0);
>  	obj[0].idx.crc32 =3D crc32(obj[0].idx.crc32, header, n);
> +	// This object comes from outside the thin pack, so we need to
> +	// initialize the size and type fields
> +	obj[0].hdr_size =3D n;
> +	obj[0].size =3D size;
> +	obj[0].type =3D type;
> +	obj[0].real_type =3D type;
>  	obj[1].idx.offset =3D obj[0].idx.offset + n;
>  	obj[1].idx.offset +=3D write_compressed(output_fd, buf, size, &obj[=
0].idx.crc32);
>  	hashcpy(obj->idx.sha1, sha1);

--=20
Shawn.
