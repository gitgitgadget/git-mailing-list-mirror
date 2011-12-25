From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] add post-fetch hook
Date: Sun, 25 Dec 2011 13:54:24 -0400
Message-ID: <20111225175424.GA32626@gnu.kitenet.net>
References: <20111224234212.GA21533@gnu.kitenet.net>
 <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
 <20111225035059.GA29852@gnu.kitenet.net>
 <7vsjk99exw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 18:54:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ResHc-0005hY-Gr
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 18:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613Ab1LYRyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Dec 2011 12:54:33 -0500
Received: from wren.kitenet.net ([80.68.85.49]:53742 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462Ab1LYRyc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2011 12:54:32 -0500
Received: from gnu.kitenet.net (dialup-4.153.2.217.Dial1.Atlanta1.Level3.net [4.153.2.217])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 445651180EC
	for <git@vger.kernel.org>; Sun, 25 Dec 2011 12:54:29 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id C350744979; Sun, 25 Dec 2011 12:54:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vsjk99exw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187685>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> So if we were to allow the hook to lie what commits were fetched and store
> something different from what we fetched in the remote tracking refs, I
> think the correct place to do so would be in store_updated_refs(),
> immediately before we call check_everything_connected().
>=20
>  - Feed the contents of the ref_map to the hook. For each entry, the hook
>    would get (at least):
>    . the object name;
>    . the refname at the remote;
>    . the refname at the local (which could be empty when we are not
>      copying it to any of our local ref); and
>    . if the entry is to be used for merge.
>=20
>  - The hook must read _everything_ from its standard input, and then
>    return the
>    re-written result in the same format as its input. The hook could
>    . update the object name (i.e. re-point the remote tracking ref);
>    . update the local refname (i.e. use different remote tracking ref);
>    . change "merge" flag between true/false; and/or
>    . add or remove entries
>=20
>  - You read from the hook and replace the ref_map list that is fed to
>    check_everything_connected(). This ref_map list is what is used in the
>    next for() loop that calls update_local_ref() to update the remote
>    tracking ref, records the entry in FETCH_HEAD, and produces the report.
>=20
> This way, the hook cannot screw up, as what it tells us will consistently
> be written by us to where it should go.

This is a good plan, the only problem I see with it is that
store_updated_refs is potentially called twice in a fetch, when the
automated tag following is done. I don't see that as a large problem,
perhaps it could even be optimised away.

The format of .git/FETCH_HEAD does not seem appropriate for this hook
to use (it's not documented, and it doesn't quite have all the necessary
fields, particularly missing the local refname). Instead, how about this,
for the hook's input/output format?

<sha1> SP <not-for-merge|merge> SP <remote-refname> SP <local-refname> LF

Example:

5d6dfc7cb140a6eb90138334fab2245b69bc8bc4 merge refs/heads/master refs/remot=
es/origin/master
f95247ea15bc62a2dab0f6ae3cd247267a0639b8 not-for-merge refs/heads/pu refs/r=
emotes/origin/pu
2ce0edcd786b790fed580e7df56291619834d276 not-for-merge refs/tags/v1.7.8.1 r=
efs/tags/v1.7.8.1

Allowing the hook to change the merge flag does open up some other
interesting uses of the hook. I can now think of three use cases for it:

1. Only accepting tags that meet some criteria, such as being signed
   by a trusted signature.
2. Causing branches that would not normally be merged to get merged.
   For example, a hook could set the merge flag on a branch when it was
   pulled from a remote other than branch.master.remote. This could be usef=
ul
   when using git without a single central origin and with a number of
   repositories that are always wanted to be kept merged.
3. My git annex merge case.

--=20
see shy jo

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTvdjUMkQ2SIlEuPHAQh5tQ//bmucepc3zx51mYcRHi/DBfxS6Kkrqipd
lt2g23TrGS1sFwvjpjdz887wGthaYCmMcwSSu49rePFCv2ReaxxayGDBfe7UBmBz
+WSxXutmgfP56q/RY2vfLNzgLBHZrb7M/mPDnOSo0U4ZMxNtmApc5tk0Xs/XXzF5
gYyQm0XxfS9FuvFXN5ze3vuRrWH2sM7RMFMUmk9u8sDvRDl97WuY4kKOkd8klCOJ
r8BKlwCtjY0SHNfcfq9Unu8hLNgap31TI17aUsQhU+k0BmJg6eJn3VNAvIAQbykd
UTxyb4g/Z9HvVnlK3lHB8KyrqTk6+Sbafg4rVD7TO0mD7v1e8uMIYE7lOdQqeVPK
qn5TKeMKJxWlWmpdgEemyCF9pkCxNreGBD6G/7MDpuzd4mGsXjDSUoiwF5HLQZDC
MBUORp06od1oEXnLJ1eO1NgL4S0WKum9shvq6+2zI/s1pkYubuSdlPhj4jwK3kB8
LP2zLkcOseKf9pSJIwuI5OQ0KsjLuou2PBK4MzszQQ5CginK26eMQFwA1ec9P1v+
98OwdMI7WNm5m+T0STjwCQHaXgsVFIHJd1pqhfVlKC/ICwEAfu+VE0lkPxP5FTTL
8laC3sEssasjTj0TKAQmE5DCRs3cnD7mxcWAWrKtfBVImsejjn2m0xF6ydK71i7U
OKmvNC6WBv8=
=OLA9
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
