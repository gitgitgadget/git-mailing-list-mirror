From: martin f krafft <madduck@madduck.net>
Subject: Re: Storing additional information in commit headers
Date: Mon, 1 Aug 2011 23:11:04 +0200
Message-ID: <20110801211104.GC15401@fishbowl.rw.madduck.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
To: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Aug 01 23:11:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnzlk-00084K-Px
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 23:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab1HAVLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 17:11:20 -0400
Received: from seamus.madduck.net ([213.203.238.82]:52890 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab1HAVLT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 17:11:19 -0400
Received: from fishbowl.rw.madduck.net (70-204.79-83.cust.bluewin.ch [83.79.204.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id D7D3B407D24;
	Mon,  1 Aug 2011 23:11:05 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 8F5B01FFE2; Mon,  1 Aug 2011 23:11:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110801201301.GA17111@sigill.intra.peff.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.1 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178415>


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Jeff King <peff@peff.net> [2011.08.01.2213 +0200]:
> This topic has come up several times in the past few years.

I am sorry that I am bothering the list again. I tried hard to find
whatever I could, but after 2=E2=80=933 hours of web searching, I came here=
=E2=80=A6

Thank you for taking the time to answer!

> I think some
> of the relevant questions to consider about your new data are:
>=20
>   1. Does git actually care about your data? E.g., would it want to use
>      it for reachability analysis in git-fsck?
>=20
>   2. Is it an immutable property of a commit, or can it be changed after
>      the fact?

Excellent points, and I have answers to both:

  1. Ideally, I would like to point to another blob containing
     information. Right now, in order to prevent gc from pruning
     it, that would have to be a commit pointed to with a parent
     pointer, which is just not right (it's not a parent) and causes
     the commit to show up in the history (which it should not, as
     it's an implementation detail).

     I'll return to this point further down=E2=80=A6

  2. It is immutable. Ideally, I would like to store extra
     information for a ref in ref/heads/*, but there seems to be no
     way of doing this. Hence, I need to store it in commits and
     backtrack for it. Or so I think, at least=E2=80=A6

> Otherwise, if (1) is yes, then a commit header makes sense. But
> then, it should also be something that git is taught about, and
> your commit header should not be some topgit-specific thing, but
> a header showing the generalized form.

I agree entirely and would be all too excited to see this happening.
I already had ideas too:

  In addition to the standard tree and parent pointers, there could
  be *-ref and x-*-ref headers, which take a single ref argument,
  presumably to a blob containing more data.

  While I cannot conceive a *-ref example, I think it's obvious that
  x-*-ref should be introduced at the same time to keep the *-ref
  namespace clear for future, "official" Git use.

  In terms of gc and fsck and the like, all *-ref and x-*-ref
  headers would contribute to reachability tests and hence prevent
  pruning of those blobs.

> Otherwise, the usual recommendation is to use a pseudo-header
> within the body of the commit message (i.e., "Topgit-Base: ..." at
> the end of the commit message). The upside is that it's easy to
> create, manipulate, and examine using existing git tools. The
> downside is that it is something that the user is more likely to
> see in "git log" or when editing a rebased commit message.

=E2=80=A6 to see *and to accidentally mess up*. And while that may even be
unlikely, it does expose information that really ought to be hidden.

> Just about every discussion on this topic ends with the
> pseudo-header recommendation. The only exceptions AFAIK are
> "encoding" (which git itself needs to care about), and
> "generation" (which, as you noted, raises other questions).

I can see how it's arguable too why one would want to give git
commit objects the ability to reference arbitrary blobs containing
additional information. I suppose the answer to this question is
related to the answer to the question of whether Git is
a contained/complete tool as-is, or also serves as
a "framework"/"toolkit" for advanced/creative use.

The availability of the porcelain commands seems to suggest that
extensible/flexible additional features should be welcome! ;)

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
http://www.transnationalrepublic.org/
=20
spamtraps: madduck.bogus@madduck.net

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJONxZowBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xCEV
D/9UFxE6XwyoyKVQybB6AWfswoc0uBf1o9F/NSXO58gPrPPWT0SVefptzrmOzauK
fhqabs+mVOmAvKj88r4iacJCHvZqIDPjxvriA1mOUlYYqyIEV3fELkG4ORYxIoJW
dWMcrayfboA8+k9cpEzijvEy+VY2ul3XqHhbDqPl2SA7Ow7o0AVxZTBG5PPdifGi
xIHAOQLOBHIuQM+8/PshzH1eAp+7otkF7Rr3GJMtQP4Ab3QfDUM6r6USECaZlvIK
KZ19miGN9fK79Hg2yTw10Fq8DR92iwx07wETEeaJEXahMr6T50agTqnN+oOzM7kJ
/tnYzoZILq2vEG0hRz9FUj6Ckq0nALMKhnUl2SIAN7J3EmJsD03gjy0GZFyA/LKy
idBJIvKdUUj1B+a2BMPLE+G1YklZ7PvN4YxCwafuhVn+yqF0sHETiVl71DlA77UY
XINaNf/dICfFIaqDGVH+zfz8l/eIIhMs7TDFfDfWlj8T9yP1ktSJ5gYPEsXpSV4Q
e4WGRq12IGIfBLC6QKDE3mo3CDPDx0zL7WRmY24WiHfnmTFbLYhr6LK8HmjzY5+9
/VbXRAmtcmWdyXDlOuteiMvduzUL60Rk0p4I6zbjVyNZlvuPcZEggpP55dZX/4UG
Lx7kr9yJNgYtH7aREK2QgmDLWrB5PlLT7vjbZW6MD8rgQA==
=VYRI
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
