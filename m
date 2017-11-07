Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD8D202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 19:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757368AbdKGTcT (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 14:32:19 -0500
Received: from kitenet.net ([66.228.36.95]:51458 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753696AbdKGTcS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 14:32:18 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Nov 2017 14:32:18 EST
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1510082559; bh=l3Z/ePAWb6X2v5uJXtOyiWnBRFDJpgV/RXnK2rEswmo=;
        h=Date:From:To:Subject:From;
        b=iu7jO3mIeOkDa5lVI6bnmm3HYaeOsv1IoUFmUZ9/Z53Ci+PrLyWHahe60UP/iZqD7
         X+uNajij3r1nmpJtwNA9rVZIpE18AcDQqkhChdTm0W1rfwVhiw2ROB6z0qb1RC1pA2
         L7+WifdTdZpLE4KcN82l8c9u6TXQ5vg/S1Pf5/+k=
Date:   Tue, 7 Nov 2017 15:22:39 -0400
From:   Joey Hess <id@joeyh.name>
To:     Git Mailing List <git@vger.kernel.org>
Subject: use of PWD
Message-ID: <20171107192239.6hinu235hfpwqpv6@kitenet.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hveq7faqybwllkif"
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hveq7faqybwllkif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In strbuf_add_absolute_path, git uses PWD if set when making relative
paths absolute, otherwise it falls back to getcwd(3). Using PWD may not
be a good idea. Here's one case where it confuses git badly:

joey@darkstar:/>sudo ln -s /media/hd/repo hd
joey@darkstar:/>cd /hd/repo
joey@darkstar:/hd/repo>git --git-dir=3D../../../home/joey/tmp/repo/.git cat=
-file -t HEAD
fatal: unable to normalize object directory: /hd/repo/../../../home/joey/tm=
p/repo/.git/objects
joey@darkstar:/hd/repo>ls -d ../../../home/joey/tmp/repo/.git
=2E./../../home/joey/tmp/repo/.git/

In that situation where cd has followed a symlink to a different
depth, there seems to be no way to give git a relative path that works.
Other numbers of ../ also don't work.

What does work is to unset PWD:

joey@darkstar:/hd/repo>PWD=3D git --git-dir=3D../../../home/joey/tmp/repo/.=
git cat-file -t HEAD
commit

So why does git use PWD at all? Some shell code used pwd earlier
(leading to similar bugs like the one fixed in v1.5.1.5), but in
the C code, it was first introduced in commit
1b9a9467f8b9a8da2fe58d10ae16779492aa7737, which speaks of the "user's
view of the current directory", which is what PWD is. The use of PWD in
that commit may be ok.

Then in commit 10c4c881c4d2cb0ece0508e7142e189e68445257,=20
the limited use of PWD broadened a lot, seemingly without
intending to look at the "user's view of the current directory"
anymore, due to reusing the code from the earlier commit.

--=20
see shy jo

--hveq7faqybwllkif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAloCB/0ACgkQ2xLbD/Bf
jzj8sw/8D8MQzKBltD0xueJjC2ORBbWROHC9RmrkqwIsPagT9ilgI9ecgllYEYqd
MR5nr86ibTIkpP14MFX9ZnZLN0rRGqMsozDqu0U+0lLMbQuGAlgG2PwB0AFoA/eu
3Kske9J+OS/DsdfbwYtGJta6Hm8KZW3yzJFdH0yKjG5SfIU0gVMMX5ztkyTUGSEp
WB280F+7Xt4ECUTclhflLo7ttU1HyMaMAjZNlBa6GAmczzRMvMHQio1AVR7TJiPe
wPbOiefNgMhYqVzilsBhxjU6wcRMuIM4OTpezEpPYh6VYXiLhK+nfMHZCnrXoMLy
LDA3NdXrZCkZpIdEq7amo6WBdz3oh6GepCInPiJbtKufj2MMWI4+mOETrarLzMbT
qfcAtNZgkwMNADzQcl2zKvi23Lu3X+oLPCRz9rVZ6iqPkrqXygwOujv+3lRKh13L
O3S/nyAyYEh1uJEDJyCIK+WLz2OTvuE8f0xxxufl8LsBvHtxdjkEZKO2fZ5XqucN
tuQ3LikY+6peey4j9jAvSBOCpAad04IfgfwY3HShnISFgUHtZNTJ9frPR1t3vG9R
02UmJrQvd2JS75xp9cTEs6WEKYZFyLKu+zsbyNLYrLVU2uGEUHTvTSPo19H7Jz5b
Nn3rlJ863MPcAXDG/UXxuyzzbjBEkMS9H3FWH1Qtm2lkfjhcB2c=
=/bnl
-----END PGP SIGNATURE-----

--hveq7faqybwllkif--
