From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Sat, 13 Jan 2007 00:07:05 +0300
Message-ID: <20070112210705.GB4562@procyon.home>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com> <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com> <7v8xgileza.fsf@assigned-by-dhcp.cox.net> <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com> <20070107163112.GA9336@steel.home> <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net> <20070112184839.9431ddff.vsu@altlinux.ru> <7vr6u0t87q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 22:07:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5TcT-0007TA-2p
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 22:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbXALVHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 16:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbXALVHW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 16:07:22 -0500
Received: from master.altlinux.org ([62.118.250.235]:3952 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030474AbXALVHV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 16:07:21 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id D05D3E350F; Sat, 13 Jan 2007 00:07:19 +0300 (MSK)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6u0t87q.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36711>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2007 at 10:23:37AM -0800, Junio C Hamano wrote:
> Sergey Vlasov <vsu@altlinux.ru> writes:
>=20
> > On Wed, 10 Jan 2007 11:28:14 -0800 Junio C Hamano wrote:
> >
> >> This revamps the merge-recursive implementation following the
> >> outline in:
> >> ...
> > This commit broke t3401-rebase-partial.sh:
> > ...
> > ...and it is still used here - however, after the patch *result is
> > uninitialized at this point.
>=20
> Very true.  This untested patch should fix it.

BTW, the same code does not crash on another (x86_64) machine;
however, valgrind-3.2.1 complains:

=3D=3D20571=3D=3D Use of uninitialised value of size 8
=3D=3D20571=3D=3D    at 0x411FF2: sha1_to_hex (sha1_file.c:125)
=3D=3D20571=3D=3D    by 0x405D90: merge_trees (merge-recursive.c:1071)
=3D=3D20571=3D=3D    by 0x406044: merge (merge-recursive.c:1163)
=3D=3D20571=3D=3D    by 0x40641D: main (merge-recursive.c:1245)

After the patch valgrind does not complain anymore.

> Note that this stops (relative to the older
> version of merge-recursive that always wrote a tree even when it
> was not needed) reporting the tree object name for outermost
> merge, but I think that reporting was primarily meant for people
> who are debugging merge-recursive and did not have a real
> value.  We could even remove the whole printf(), which I tend to
> prefer.

If that printf() is just a debug output, we should definitely remove
it - the merge output is verbose enough already.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 5237021..40c12aa 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1066,15 +1066,17 @@ static int merge_trees(struct tree *head,
>  		path_list_clear(re_head, 0);
>  		path_list_clear(entries, 1);
> =20
> -	} else {
> +	}
> +	else
>  		clean =3D 1;
> +
> +	if (index_only) {
> +		*result =3D git_write_tree();

Hmm, can git_write_tree() return NULL at this point?  Does the code in
the if (unmerged_index()) {...} branch above resolve all unmerged
index entries?  It probably should, if I understand the
merge-recursive logic...

>  		printf("merging of trees %s and %s resulted in %s\n",
>  		       sha1_to_hex(head->object.sha1),
>  		       sha1_to_hex(merge->object.sha1),
>  		       sha1_to_hex((*result)->object.sha1));
>  	}
> -	if (index_only)
> -		*result =3D git_write_tree();
> =20
>  	return clean;
>  }

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFp/h5W82GfkQfsqIRAv97AKCOMaaXU5rJImqMjuyaOto5opwJcgCfYHQr
Y01XpXM6HBljC3GL69mDakI=
=EfY6
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
