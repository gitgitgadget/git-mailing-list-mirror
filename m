Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5946EC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 19:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F1F61157
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 19:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhKDTLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:11:12 -0400
Received: from kitenet.net ([66.228.36.95]:46712 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232340AbhKDTLL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 15:11:11 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 15:11:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1636052365; bh=BS68msn+Io0r4eXUG9ytLrCJJHOuSnkZkjWBS3syw50=;
        h=Date:From:To:Subject:From;
        b=M3/pdQ/3Ttehswixxk08f6lUNSibEjb4XjWxvaGZZFNZ6jh2SpzmpDnjr8quMPOvQ
         ZHaSMc0aLQtC5XBoxVgaZot1HZt8sn+MaJSb4QCL25FxGvnZfqCV9FUs8hY7yyYeTz
         XbP0blF6f/JzYBvUgKWd7EU5sl/UcCh8h5Iw/Dyk=
X-Question: 42
Date:   Thu, 4 Nov 2021 14:59:25 -0400
From:   Joey Hess <id@joeyh.name>
To:     git@vger.kernel.org
Subject: surprising value of LARGE_PACKET_MAX
Message-ID: <YYQtjWSb+z4taphX@kitenet.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hRnK3tS2H7RP7zLy"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hRnK3tS2H7RP7zLy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I implemented a git-filter-server using the long-running process
protocol, and was surprised to discover in testing that git rejected
a maximally sized pkt-line starting with "ffff" as having an invalid
size.

The docs don't say what the maximum size is, so I assumed I could make
it as large as the length header allows, which I think is a natural
conclusion to draw from the documentation. But looking in git's source,
fff0 is the maximum:

#define LARGE_PACKET_MAX 65520
#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)

Which dates back to commit d47f3db75c58139cdcbca5cc63b17bf5db293b6a in
2006, which does not give a rationalle for the slightly small
size. Whatever the reason, it seems likely that changing that would be
likely to break interoperability with older versions of git.

Perhaps the best thing to do would be to document it in
Documentation/technical/protocol-common.txt

--=20
see shy jo

--hRnK3tS2H7RP7zLy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAmGELYwACgkQ2xLbD/Bf
jzhx+A/9FHKs4JOGE9F0XYsVRGiFEtfXzyAVVUCS+MJHDG5UHnQwFlHre1p3YBgm
Hiy5HS232Bz0oG96h6WXsVc76XmtrIlq5Nr9A0Q/wqAaBHQjHgSyTVD7Yr6KxSO4
7JuoDanMJI47pfqPB+cdmR9rYg8++DM+mJhOG+SG6Tz3TafqROZxDGRT4C0Tl4eR
LprGjjbHv0Q9pEEFRoI31h5R7LiUwsC7DalTrNpNpg9Z9QGOR8nxSFPYvPOZjH65
yehSGrVWEDwfadexxBS0rvAAQjMkwcKy1sKow04CP28yNaJd+FMRHdS0dBa2rC+M
lqitSctQbvsJrAoKJdp+qYEANPm3M5sptABEpJRwBShiO7fFZKLHV5ktw71CstIW
H4nuRPLKEN8GI4To+VqM4D/5gx9R5s4T2+QmJwuZJ2AlAEdzcEdGoVtgpqWLrzsX
kRAxkDrdgeMFF7fgzo8hbTHnzAuzxmB4oD078xpXWdVmPoEcToMeenqiCTUiy5AJ
FvoKJt995skvEas84jWzdXw8QaomdtIMdS2xUw8bRxjv0hKe0QtTxkfcDE0EzMWy
jKG2P5MYM5QHmQfmRbUdFBNtAhhtaapv2R9I3bWGYKM0+t0gWl0H3TJXkCf9CIDo
DNCZpMg69yJm2C9qld2KSUJ3lQgGRZysztjI1jXhlAV2DeYkYaU=
=tmFQ
-----END PGP SIGNATURE-----

--hRnK3tS2H7RP7zLy--
