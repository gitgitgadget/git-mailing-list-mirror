From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: reset reports file as modified when it's in fact deleted
Date: Fri, 11 Nov 2011 15:08:34 +0100
Message-ID: <20111111140834.GA10025@beez.lab.cmartin.tk>
References: <20111107094330.GB10936@beez.lab.cmartin.tk>
 <20111107162642.GA27055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 11 15:08:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROrmt-0002Pc-9J
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 15:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab1KKOIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 09:08:51 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:57474 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039Ab1KKOIu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 09:08:50 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id C45E046191;
	Fri, 11 Nov 2011 15:08:13 +0100 (CET)
Received: (nullmailer pid 20585 invoked by uid 1000);
	Fri, 11 Nov 2011 14:08:34 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20111107162642.GA27055@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185269>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2011 at 11:26:42AM -0500, Jeff King wrote:
> On Mon, Nov 07, 2011 at 10:43:30AM +0100, Carlos Mart=EDn Nieto wrote:
>=20
> > When I delete a file (git rm) and then reset so it exists in the index
> > again, the message tells me 'M file.txt' even though the file doesn't
> > exist in the worktree anymore. Running git status afterwards does give
> > the correct output. So, here's the minimal steps to reproduce:
> >=20
> >     $ git init
> >     Initialized empty Git repository in /home/carlos/test/reset-err/.gi=
t/
> >     $ touch file.txt
> >     $ git add file.txt
> >     $ git ci file.txt -m initial
> >     [master (root-commit) a536393] initial
> >      0 files changed, 0 insertions(+), 0 deletions(-)
> >      create mode 100644 file.txt
> >     $ git rm file.txt
> >     rm 'file.txt'
> >     $ git reset -- file.txt
> >     Unstaged changes after reset:
> >     M		 file.txt
> >     $ git status -b -s
> >     ## master
> >      D file.txt
>=20
> You can simplify this even further by not touching the index at all:
>=20
>   git init -q &&
>   >file && git add file && git commit -q -m initial &&
>   rm file &&
>   git reset
>=20
> produces:
>=20
>   Unstaged changes after reset:
>   M       file

Ah, I see. I got the previous sequence because that's what we have in
an instruction manual and where we saw it.

>=20
> > I'd expect the output after "Unstaged changes after reset" to tell me
> > file.txt has been deleted instead of modified. This happens with
> > 1.7.8-rc0, 1.7.7 and 1.7.4.1 and I expect with many more that I don't
> > have here.
> >=20
> > I thought the index diff code might have been checking the index at the
> > wrong time, but I can run 'git reset HEAD -- file.txt' as many times
> > as I want, and it will still say 'M', so now I'm not sure.
>=20
> The index diff code isn't running at all. Those messages are produced by
> refresh_index, which outputs only two flags: modified or unmerged. I
> think the reason for this is somewhat historical. You would run
> "update-index --refresh", and it would helpfully say "by the way, when
> refreshing this entry, I noticed that it is in need of being updated in
> the index". The text was "file.txt: needs update".
>=20
> Later, many porcelain commands started to refresh the index themselves,
> and the "needs update" message was very confusing. So it was switched to
> the more familiar "M file.txt" (though you can still see the original
> plumbing message if you run update-index yourself).
>=20
> I think it is a little more friendly to distinguish deletion from just
> modification. And there's shouldn't be any compatibility questions, as
> these are explicitly porcelain output (plumbing will still say "needs
> update").
>=20
> There are a few other cases users might expect to see. We'll never show
> copies or renames, of course, because we aren't actually doing a diff
> with copy detection. We won't see an "A"dded file, because such a file
> would be in the working tree but not the index, meaning it is not
> tracked.
>=20
> We could see a "T"ypechange, but the distinction between that and a
> modified file is lost by the time we get to refresh_index. We could pass
> it up, but I wonder if it's really worth it.

That's probably overkill. The issue with reporting 'M' for a deleted
file is that it conflicts with what the status output would say, even
though it's in the same format.

>=20
> The patch to do "D"eleted is pretty simple:
>=20
> diff --git a/read-cache.c b/read-cache.c
> index dea7cd8..cc1ebdf 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1103,9 +1103,11 @@ int refresh_index(struct index_state *istate, unsi=
gned int flags, const char **p
>  	int in_porcelain =3D (flags & REFRESH_IN_PORCELAIN);
>  	unsigned int options =3D really ? CE_MATCH_IGNORE_VALID : 0;
>  	const char *needs_update_fmt;
> +	const char *needs_rm_fmt;
>  	const char *needs_merge_fmt;
> =20
>  	needs_update_fmt =3D (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
> +	needs_rm_fmt =3D (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
>  	needs_merge_fmt =3D (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");

While the name fits in with the rest of the variables, it's kind of
the wrong way around, isn't it? It doesn't need an 'rm', it /was/
rm'd. Other than that stupid thing, the patch works great, thanks. Can
we get it into git?

>  	for (i =3D 0; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce, *new;
> @@ -1145,7 +1147,10 @@ int refresh_index(struct index_state *istate, unsi=
gned int flags, const char **p
>  			}
>  			if (quiet)
>  				continue;
> -			show_file(needs_update_fmt, ce->name, in_porcelain, &first, header_ms=
g);
> +			if (cache_errno =3D=3D ENOENT)
> +				show_file(needs_rm_fmt, ce->name, in_porcelain, &first, header_msg);
> +			else
> +				show_file(needs_update_fmt, ce->name, in_porcelain, &first, header_m=
sg);
>  			has_errors =3D 1;
>  			continue;
>  		}
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOvSxiAAoJEHKRP1jG7ZzTtI4H/3v+tUC/XDdMTxr773lcVhil
oiAp5TIOlXWaVV6w2I2MwYBtp7ucQD1UrQpkx/V72D9f7C0HHuWx26tApFJ9iglD
wJKZ3HOueHX3lTwA2eqPrvHPM6/vN7D+3vbQZ+IazUBC5MYHMwktqfROY0PaTBtK
dp+OXKf6kq4EXVrm2O0w+E9TAK40wZkaSSsISkZoLE74XZn1LFNoUrXbfF77wQct
rRBmUqBpSFLUX/6OQFc0Q1wm89hc+EkolKouaRwk+odbnnN6WB9ZiUPLUTW/jOxy
I2HD9OqWlO6LeLi5CbBPhvMJHa4WC7H9oYIVtlnc/ylg0WqbXvZNMxU5mT2QxZY=
=XOfR
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
