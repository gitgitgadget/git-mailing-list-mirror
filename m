Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C950B2022D
	for <e@80x24.org>; Sun, 26 Feb 2017 18:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdBZSSb (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 13:18:31 -0500
Received: from mailer.zib.de ([130.73.108.11]:34463 "EHLO mailer.zib.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbdBZSS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 13:18:29 -0500
X-Greylist: delayed 4274 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Feb 2017 13:18:25 EST
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
        by mailer.zib.de (8.14.5/8.14.5) with ESMTP id v1QH7AZD004446
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 18:07:10 +0100 (CET)
Received: from [192.168.0.15] (ip5f5bf1a5.dynamic.kabel-deutschland.de [95.91.241.165])
        (authenticated bits=0)
        by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id v1QH78uY000891
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 26 Feb 2017 18:07:09 +0100 (CET)
From:   Steffen Prohaska <prohaska@zib.de>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D1277433-54FD-4D8A-A3DB-F85E9D987239";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date:   Sun, 26 Feb 2017 18:07:00 +0100
Subject: git-sha-x: idea for stronger cryptographic verification while keeping
 SHA1 content addresses
Message-Id: <E030EA10-F755-4154-900A-3FCED3ADD1B2@zib.de>
To:     Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3259)
X-Miltered: at mailer.zib.de with ID 58B30B3E.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 58B30B3E.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 58B30B3E.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_D1277433-54FD-4D8A-A3DB-F85E9D987239
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

Related to shattered, the recent discussion,
=
<https://public-inbox.org/git/20170223164306.spg2avxzukkggrpb@kitenet.net>=
, the
past
=
<https://public-inbox.org/git/Pine.LNX.4.58.0504291221250.18901@ppc970.osd=
l.org/>,
and Linus's post =
<https://plus.google.com/+LinusTorvalds/posts/7tp2gYWQugL>,
the idea below might be interesting.

I skimmed through the discussion but haven't read all the details.  I =
also
haven't been following the Git list during the last years, so it might =
very
well be that others have described similar ideas and the general =
approach has
been reject for some reason that I'm not aware of.

git-sha-x illustrates a potential solution for stronger cryptographic =
content
verification in Git while keeping SHA1 content pointers.

git-sha-x is available at <https://github.com/sprohaska/git-sha-x>.

git-sha-x computes a hash tree similar to the SHA1-based Git history but =
using
a different hash function.  The hashes can be added to the commit =
message and
signed with GPG to confirm the tree and the entire history with a =
cryptographic
strength that no longer depends on SHA1 but on the chosen git-sha-x hash =
and
the GPG configuration.  See `git-sha-x --help`.  Examples:

```
git-sha-x commit HEAD
git-sha-x tree HEAD
git-sha-x --sha512 commit HEAD

git-sha-x amend && git-sha-x --sha512 amend && git commit -S --amend -C =
HEAD
```

git-sha-x is only a proof of concept to illustrate the idea.  I do not =
intend
to develop it further.

If a similar approach was chosen for Git, the hashes could be managed by =
Git
and somehow represented in its object store as supplementary =
information.  Git
could incrementally compute additional hashes while it constructs =
history and
verify them when transferring data.

The strength of bare SHA1 ids is obviously not increased.  The strength =
is only
increased if the additional hashes are communicated in a verifiable way, =
too.
GPG signatures are one way.  Another way could be to communicate them =
via
a secure channel and pass them to git fetch for verification.  Assuming =
such an
implementation, a fetch for a commit from this repo could look like:

```bash
git fetch origin \
    =
--sha256=3D8a3c72de658a4797e36bb29fc3bdc2a2863c04455a1b394ed9331f11f65ba80=
2 \
    =
--sha512=3D729de81500ce4ad70716d7641a115bd0a67984acc4d674044b25850e36d940b=
f631f9f6aa881111768743690545ac899888fb54f65840f84853f9a8811aeb9ca \
    ef2a4b7d216ab79630b9cd17e072a86e57f044fa
```

For practical purposes, supplementary hashes in the commit in =
combination with
GPG signatures should provide sufficient protection against attackers =
that try
to manipulate SHA1s.  For convenience, supplementary hashes could be =
stored in
the commit header, similar to `gpgsig`.  A hypothetical commit object =
could
look like:

```
tree 365c7e42fd004a1778c6d79c0437f970397a59b8
parent c2bfff12099b32425a3bcc4d0c7e6e6a169392d8
tree-sha256 =
2f588b9308b5203212d646fb56201608449cb4d83a5ffd6b7e6213d175a8077c
parent-sha256 =
090d9a3e69aa3369efac968abde859a6e42d05b631ece6d533765a35e998336c
tree-sha512 =
12ae91b23733d52fa2f42b8f0bb5aeaeb111335688f387614c3b108a8cb86fa0e2cd6d19bf=
050f8a9308f8c1e991080507c91df53e0fc4cace3f746ec89a789a
parent-sha512 =
d319889a40cf945d8c61dbe6d816e10badd49845c547df85ace4327676275eeb5ba2cd9627=
12ddbb8f08f2db17dbc9eb46b59b5f7b7a7e05eab7df0ef89dec65
author Steffen Prohaska <prohaska@zib.de> 1488122961 +0100
committer Steffen Prohaska <prohaska@zib.de> 1488123452 +0100
gpgsig ...
```

GPG signatures would automatically cover the supplementary hashes.
Verification code paths would have to be added to compute the hashes =
from the
content to confirm that it has not been tampered with.

Since content verification would become independent from the content =
address,
the interpretation of the content address could be changed in the =
future.  The
size of 160 bits could be kept for simplicity.  But the meaning could be
changed.  For example, the first 160 bits of SHA256 could be uses as the
content address.  The remaining bits could be stored in an object =
supplement.
Verification code paths would combine the content address with the =
additional
bits to verify the SHA256.  Content pointers would keep their size.  =
Only the
additional SHA256 bits would be stored and used for verification.

Steffen


--Apple-Mail=_D1277433-54FD-4D8A-A3DB-F85E9D987239
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJYsws3AAoJEM1O8u0TOQUsU7AH/3a+1UFQS9FvCVouQza4cnE9
JlaptgB/O1UbKLkKgPLecbZxJwLeXQHLbuUchtGsXYiF2WgH0IgAG1lOcsEHN2Ti
Q1CReJQ4d0A+0nPd7MUyKNvrOS2TaFE0H5/Evv28WbOKoqThXcDDJxCBNfgTKD6d
U0Kk+D9M8oSb+T4H+F8vx1u8Tmx/6G28ESdwyv0vW4XIxZfTxGRnu2DyxWHjOUX6
hXFOxK6b0YKqdARY9+hDe0jYZkYFKgmIGEm83hts3Ofa8zoAASgOrP/3YU0pt7bc
kBh70+NYO+l4RPxuynotvHiVNqrf/zjA1DkuGduI9D4TgKhq75YdCZTAte9c8gY=
=2JZ2
-----END PGP SIGNATURE-----

--Apple-Mail=_D1277433-54FD-4D8A-A3DB-F85E9D987239--
