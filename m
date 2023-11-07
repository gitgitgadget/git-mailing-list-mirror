Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFFA36AE7
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdeSyUGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8C0C433C7;
	Tue,  7 Nov 2023 18:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699382028;
	bh=42eGOVwNQV49v6RyYF9nBaSFCF9UCRqXxEOQy2+vL4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YdeSyUGmxoa5tnv1OBiEQKx0vT0wxG2WXzx29Fq4wVuN2qOiUews1vXGnsiQTvWy6
	 278B/Be3pkq5FQBbdhwxf4UdmgPwmlf3gorQXEzi+E7B7tlylFE60nqqfyIVb9QvmQ
	 jDScNGhWYN3vuiUaDeydaz29CCDxOq7UBLCyJ0O0FxSMNRBR/LeuJHHonFTE+ULgHD
	 XSAVChCoasW0pLXpG7LLZgfdcf0ebYFXaiBxL047vE+ZmEcouU3Alr+8eQtZerpf3e
	 SL43476Cx8ECTAWuOPTiEe3XiH6TnSjuOPnaV0/1cxOxtyQMO4R0jBBKz9wDFzmTzE
	 h0tpMEfuZvnlA==
Date: Tue, 7 Nov 2023 19:36:44 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <ZUqDwnmu9d1dD1tb@devuan>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="USYJdaeNFcEaNerZ"
Content-Disposition: inline
In-Reply-To: <20231107174803.GA507007@coredump.intra.peff.net>


--USYJdaeNFcEaNerZ
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 7 Nov 2023 19:36:44 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)

Hi Jeff,

On Tue, Nov 07, 2023 at 12:48:03PM -0500, Jeff King wrote:
> I think there's a lot of overlap between what git-send-email does and
> what mutt does, to the point that you probably don't need to use
> send-email at all.
>=20
> I assume what you want out of send-email here is the actual generation
> of patch emails. But under the hood that is all done by git-format-patch
> anyway. So for example if you do:

Yeah, most of it is done by format-patch.  There are few things I
actually need from send-email.  One of them is generating the Cc from
the sign-offs and other tags found in the patch.

I had been thinking these days that it would be useful to have
format-patch generate those.  How about adding a --signed-off-by-cc to
format-patch?

>=20
>   git format-patch --stdout origin..HEAD >patches
>   mutt -f patches
>=20
> And then you can use mutt's "resend-message" function to send each one.
> I use config like this:
>=20
>   macro index,pager b ":set edit_headers=3Dyes<enter><resend-message>:set=
 edit_headers=3Dno<enter>"
>=20
> If you're sending a long series, it's helpful to pre-populate various
> headers in the format-patch command with "--to", etc. I usually do so by
> sending the cover letter directly via mutt, and then using some perl
> hackery to convert those headers into format-patch args. The script I

Indeed, that hackery is what send-email already does, so how about
moving those features a bit upstream so that format-patch can do them
too?

Although then, maybe it's simpler to teach send-email to learn to use
mutt(1) under the hood for the actual send.

> use is below (it will also, when run without a terminal, generate the
> patch summary for the cover letter; I use it with "r!my-script" while
> writing the cover letter in vim).
>=20
> (This script is what I use every day, so it should be fairly robust. But
> it is also over 15 years old, so I don't promise there isn't a simpler
> way to do some of what it does ;) ).
>=20
> -- >8 --
> #!/bin/sh
> upstream_branch() {
>   current=3D`git symbolic-ref HEAD`
>   upstream=3D`git for-each-ref --format=3D'%(upstream)' "$current"`
>   if test -n "$upstream"; then
>     echo $upstream
>   else
>     echo origin
>   fi
> }
>=20
> get_reply_headers() {
>   perl -ne '
>     if (defined $opt) {
>       if (/^\s+(.*)/) {
>         $val .=3D " $1";
>         next;
>       }
>       print "--$opt=3D", quotemeta($val), " ";
>       $opt =3D $val =3D undef;
>     }
>     if (/^(cc|to):\s*(.*)/i) {
>       $opt =3D lc($1);
>       $val =3D $2;
>     }
>     elsif (/^message-id:\s*(.*)/i) {
>       $opt =3D "in-reply-to";
>       $val =3D $1;
>     }
>     elsif (/^subject:\s*\[PATCH v(\d+)/i) {
>       print "-v$1 ";
>     }
>     elsif (/^$/) {
>       last;
>     }
>   '
> }
>=20
> format_patch() {
>   git format-patch -s --stdout --from "$@"
> }
>=20
> has_nonoption=3D
> for i in "$@"; do
>   case "$i" in
>     -[0-9]*) has_nonoption=3Dyes ;;
>     -*) ;;
>      *) has_nonoption=3Dyes
>   esac
> done
>=20
> : ${REPLY:=3D$HOME/patch}
> test -e "$REPLY" && eval "set -- `get_reply_headers <\"$REPLY\"` \"\$@\""
> test "$has_nonoption" =3D "yes" || set -- "$@" `upstream_branch`
>=20
> if test -t 1; then
>   format_patch "$@" >.mbox
>   mutt -e 'set sort=3Dmailbox-order' -f .mbox
>   rm -f .mbox
> else
>   format_patch "$@" |
>   perl -lne '
>     if (/^Subject: (.*)/) {
>       $subject =3D $1;
>     }
>     elsif ($subject && /^\s+(.*)/) {
>       $subject .=3D " $1";
>     }
>     elsif ($subject) {
>       print $subject;
>       $subject =3D undef;
>     }
>   ' |
>   sed -e 's/\[PATCH /[/' \
>       -e 's/]/]:/' \
>       -e 's/^/  /'
>   echo
>   format_patch --cover-letter "$@" |
>   sed -ne '/|/,/^$/p; /^-- /q'
> fi

Thanks!  I'll try it.  Although I don't know perl, so I hope I don't
need to tweak it much.  :)

Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--USYJdaeNFcEaNerZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmVKg7wACgkQnowa+77/
2zLmBw//dXptD2I5aIo673g6/jAqud2q0P7qYXTVtLLj9Iq/edmwetK/xlSbiBdg
8JZrRvI+ESJ3jCDCFsCPvsXeKArp+l4PpuBmkkAAajzxbscMlFco098B2DFGjpTy
Yym0QMG+tbLeAG2APN4CgWh0/FlEilala2GG7ajgnx/zSfAftdGHHl3RdR8VgOGP
bLKWMGV1V4jiICZVXYm4HSrEx2RmkqE+/M7hRDSwIcNSOlcKGzJz/02d/RyLiX8K
fdN36XMvvk19kqeMiCMOSPur4Tksr3Icc/72lubfMHpBgToyjRrk/+zdRt6BfSEk
yxCo3ZsEZqswTZ9uN+vhkje65+YYJTKfo/Ja/iZLmDqtFLtMLuOS6MP9bWg7ouoD
OeuXhbyqNVdrsLcPGTUc4vfWmtj1hGW+Wdnyr5LY0KLl5Th1gBOkxVICUOJ7vGuO
4FLR+8BiJ7cFhN7Pa3QjxW99yaMeRa0l8k7zC4mEmWG/lWko/WeAQmMdW4Is1Blu
jQMrBoH+vElB7kI6kCZGBO4I7IQtVjYvuSsKaSDsyodSqEcntETQvX/7a90j7k/4
p8jfnOkdgUKyo/Yk/I0ycPO/1CB18rWPL2Lqq0JmDHyx9RMKr+IRaaxf6NlpBgMt
mtKkDCjdhpu3pqC66qCwgcWbrnSqIx3YVVDO7aIgQx+K3KdP4D8=
=/LWC
-----END PGP SIGNATURE-----

--USYJdaeNFcEaNerZ--
