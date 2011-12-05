From: Joey Hess <joey@kitenet.net>
Subject: hooks that do not consume stdin sometimes crash git with SIGPIPE
Date: Mon, 5 Dec 2011 15:29:30 -0400
Message-ID: <20111205192930.GA32463@gnu.kitenet.net>
References: <20110829203107.GA4946@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Cc: Lars Wirzenius <liw@liw.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 20:29:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXeEQ-0006Sa-6C
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 20:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269Ab1LET3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 14:29:38 -0500
Received: from wren.kitenet.net ([80.68.85.49]:37380 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932126Ab1LET3h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 14:29:37 -0500
Received: from gnu.kitenet.net (dialup-4.88.9.186.Dial1.Atlanta1.Level3.net [4.88.9.186])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 51D3F1182BC;
	Mon,  5 Dec 2011 14:29:35 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id B359743DA9; Mon,  5 Dec 2011 14:29:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20110829203107.GA4946@gnu.kitenet.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186287>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We had a weird problem where, after moving to a new, faster server,
"git push" would sometimes fail like this:

Unpacking objects: 100% (3/3), done.
fatal: The remote end hung up unexpectedly
fatal: The remote end hung up unexpectedly

Turns out that git-receive-pack was dying due to an uncaught SIGPIPE.
The SIGPIPE occurred when it tried to write to the pre-receive hook's
stdin. The pre-receive hook, in this case, was able to do all the checks
it needed to do[1] without the input, and so did exit(0) without
consuming it.

Apparently that causes a race. Most of the time, git forks the hook,
writes output to the hook, and then the hook runs, ignores it, and exits.
But sometimes, on our new faster (and SMP) server, git forked the hook, and
it ran, and exited, before git got around to writing to it, resulting in
the SIGPIPE.

write(7, "c9f98c67d70a1cfeba382ec27d87644a"..., 100) =3D -1 EPIPE (Broken p=
ipe)
--- SIGPIPE (Broken pipe) @ 0 (0) ---

I think git should ignore SIGPIPE when writing to hooks. Otherwise,
hooks may have to go out of their way to consume all input, and as I've
seen, the races when they fail to do this can lurk undiscovered.

Note that I encountered this same sort of problem from another direction
(involving smudge filters) not long ago, and sent a patch, in
<20110829203107.GA4946@gnu.kitenet.net>. That wasn't applied, and is
in different code than the case I outlined above.

--=20
see shy jo

[1] If you're wondering, it only needed to check that the push was
    coming from a trusted UID. With an untrusted UID, it did further
    checks that consumed the stdin.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTt0bl8kQ2SIlEuPHAQgotQ//aw9ypjD8ndjP/q+70jPCK6yyEtlbmrMt
H/4xgQSuyi7kbLHSad6+RbThYQCQIVWZRUcSJwnjnN0Favl2UVJ3HpUOabBQvqX8
a6fDk0sN9qmuyGKfF4ZjOGyrqnWYlj+koGEp6Pq9Kh9p/JHVA2EM5icOTZI+elnu
tvCYVUtLww4Yf0kzNbPuvuWsYLJ6m0IBhqUhNUtM6OV4/+QBE8qoQfL88Y+RpJ5d
yReqqhJskpekTOaRsbsyNYPSb8JO62k3FcQG+i44VPfvwfWvf8x6mmTfu25Tjm77
xYpP/1T/PuByrliKOCt3qa8axFO5yTPBvyMRl0AbZEcj1jIIS0czvbsCKRhHrtMR
9G1U2hgsPZ9zc7adTebrHWcqOgg73VZVVzaZzRpQD+tjdphzxjYOHhEUJwR+I/BY
/+Jll943n65URGW9cTrGuVwv4PQvzSHppj7+Zc+gWcPatZ5oo0oShtZvUnmrZygx
+Frl+XuXiGficXn208dOLnCb1PY/1cNIsHW08Nwk38+ItgwMy8Zcu/Y2km1k+FpW
CqHJt+6CmNqwHB1AKAh/OZqkFKm7dnF14U1+nj//32GzMhB7RlhjgB8+AppJCTBn
KuRG/xpo2fVN5jyGIh+Iss+3jMdXSCCD/5c0O2dYOA8u5yl8q+ISzsG0yoRt3LXD
vVVItvwHUEk=
=tRrY
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
