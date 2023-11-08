Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823E315B6
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIixvjYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA34C433C8;
	Wed,  8 Nov 2023 21:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699477381;
	bh=+ngrnC6V2ukB68tXJGKPmc+lAXWxEJxwdgmHT2QftGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIixvjYxwmLmotafBwwIrr830rtqILdSj13ppre1Pt1+e+zkIlSLDX+e4bJxBY/Ku
	 /pJCkjSUAo8pyifuSl1jZTytrSDyzHOjkNXH22/OAg5VW6dmQqwnzq5zu/rkZTZtfL
	 5HyCpB03uQvvIsLifRkYgx+jg+w41GBJmiFq5ji+bg2nMWENXTjA/KsfVtUvWDt8MM
	 pUN2QJ6INK/u3wxP0d4SqgnnT/H/DRNNXygqqz3Mls4r5pmB3rw7F7Rg8S5rOjnmTf
	 6hNDbLvSoO2M4nIAFNROqgMUObXz8nOW3iMvoG353EqH6TGpDOq3nUzLzTsnqSI0Zf
	 56LZ9vSyvNx4A==
Date: Wed, 8 Nov 2023 22:02:52 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <ZUv3gjjmuqvCaJEd@debian>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
 <20231107201655.GA507701@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J/o1rRFQLxyXxXl4"
Content-Disposition: inline
In-Reply-To: <20231107201655.GA507701@coredump.intra.peff.net>


--J/o1rRFQLxyXxXl4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 8 Nov 2023 22:02:52 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)

Hi Jeff!

On Tue, Nov 07, 2023 at 03:16:55PM -0500, Jeff King wrote:
> > I had been thinking these days that it would be useful to have
> > format-patch generate those.  How about adding a --signed-off-by-cc to
> > format-patch?
>=20
> That seems like a reasonable feature. Probably it should be
> --cc-from-trailer=3Dsigned-off-by, and then you could do the same with
> other trailers.

That would work for me.  I only suggested the other one because it's
aleady in send-email in that form.  But yeah, it might be useful to have
finer control.  In my case, something that CCs every mail in the trailer
would work (Reviewed-by, Suggested-by, ...  I want them all, always).

>=20
> It feels like you could _almost_ do it with the existing
> --format=3D'%(trailers)' functionality, but there's no way to say "do the
> regular --format=3Demail output, but also stick this extra format in the
> headers section". Plus there are probably some niceties you'd get from
> Git knowing that you're adding headers (like de-duping addresses).
>=20
> That feature might end up somewhat hairy, though, as then you get into
> questions of parsing address lists, etc. We do all that now in perl with
> send-email, where we can lean on some parsing libraries. So I dunno.

Hmmm.

>=20
> > > If you're sending a long series, it's helpful to pre-populate various
> > > headers in the format-patch command with "--to", etc. I usually do so=
 by
> > > sending the cover letter directly via mutt, and then using some perl
> > > hackery to convert those headers into format-patch args. The script I
> >=20
> > Indeed, that hackery is what send-email already does, so how about
> > moving those features a bit upstream so that format-patch can do them
> > too?
>=20
> Yeah, if they existed in format-patch I might be able to reuse them. I
> am hesitant, though, just because handling all the corner cases on
> parsing is going to be a bit of new C code.
>=20
> > Although then, maybe it's simpler to teach send-email to learn to use
> > mutt(1) under the hood for the actual send.
>=20
> I think you will find some corner cases in trying to make mutt act just
> like an mta accepting delivery. Two I can think of:
>=20
>   1. It will take a body on stdin, but not a whole message. We can hack
>      around that with some postponed-folder magic, though.
>=20
>   2. Bcc headers are stripped before sendmail sees the message (but
>      those addresses appear on the command-line). Converting that back
>      to bcc so that mutt can then re-strip them would be annoying but
>      possible. If you don't use bcc, it probably makes sense to just
>      punt on this.

Meh, I can live with no Bcc feature; I never used it before.  :)

>=20
> So maybe a script like this:
>=20
> -- >8 --
> #!/bin/sh
>=20
> # ignore arguments; mutt will parse them itself
> # from to/cc headers. Note that we'll miss bcc this
> # way, but handling that would probably be kind of
> # tricky; we'd need to re-add those recipients as actual
> # bcc headers so that mutt knows how to handle them.
>=20
> # spool the message to a fake mbox; we need to add
> # a "From" line to make it look legit
> trap 'rm -f to-send' 0 &&
> {
>   echo "From whatever Mon Sep 17 00:00:00 2001" &&
>   cat
> } >to-send &&

Would a named pipe work?  Or maybe we could use $(mktemp)?

>=20
> # and then have mutt "resume" it. We have to redirect
> # stdin back from the terminal, since ours is a pipe
> # with the message contents.
> mutt -p \
>   -e 'set postponed=3Dto-send' \
>   -e 'set edit_headers=3Dyes' \
>   </dev/tty
> -- 8< --

Huh, this is magic sauce!  Works perfect for what I need.  This would
need to be packaged to the masses.  :-)

I found a minor problem: If I ctrl+C within mutt(1), I expect it to
cancel the last action, but this script intercepts the signal and exits.
We would probably need to ignore SIGINT from mutt-as-mta.

Other than that, this fulfills all of my needs.

Would you mind adding this as part of git?  Or should we suggest the
mutt project adding this script?


Thanks a lot!

Cheers,
Alex

>=20
> and then in your git config:
>=20
>   [sendemail]
>   sendmailcmd =3D /path/to/mutt-as-mta.sh
>=20
> There are mutt-specific bits there that I don't think send-email should
> have to know about. Perhaps there are generic options that send-email
> could learn, but it really feels like you'd do better teaching mutt to
> be more ready to handle this (like taking a whole message on stdin,
> headers and all, rather than just a body).
>=20
> -Peff

--=20
<https://www.alejandro-colomar.es/>

--J/o1rRFQLxyXxXl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmVL93wACgkQnowa+77/
2zI28w//d6GFL86uPrJvccV7vtGSgoCv3fZf3ukAUYjAKQ80JtQWYI1BQ5BYb7FR
4xZxoTyMxbWbqypA0J53ppzfvOEPFiqiESbVgJ5nW7VgDD0N7fVnHFSB65i0Sx8+
c/SMK7pG/wtQsawPyzMUBDWCBa4r5E3EJch9kabxL0lyRQwkiNTJbri5IhlK/VTZ
XW23XyUQdMJyW9905ZmYHW8W6i4mNze+NItxY5MuZfsE/64nRPsBN/NE/bukXlJ4
gVJtFID6kQup62Kfk8tpgq3oD423zdqiI/0gRvaHD3xc19SG73NW0fdDjrVjnR3+
twZJKbCo6vf/DGBzb+xXKWRWoAmSFKZL6PKVAgA8/JhIoR4Tpw8UZgcHiwM68OKE
pHLt4rwRPXeMf6Cdkyj1py7H3SXZo6gCo2aBxRHrL7YHJrBXHVp3T2HFJ4SqxjCE
hp77DgWMmeaChmqhUAngAaWT1Xr1IVDwJ0iXU5YvYjIVeTXnRpZp3ENWyEcxulXB
Sh+4//WmernbvA1KrycXe8zCWLpAscmVUSo/gqCCYvsPr474O9lLzr1h4JlS+75L
U7zrIfbyoCNNzVUxG1KHbtnmP6cPWmxZwC7i1asBUzlqSMrkIIQ70zQZNeiWU8rL
CbCtxGbGV8wMIrfIpJopgf8VvKOP4/enT0u5z3Xm11EIR3yoFlw=
=a8+0
-----END PGP SIGNATURE-----

--J/o1rRFQLxyXxXl4--
