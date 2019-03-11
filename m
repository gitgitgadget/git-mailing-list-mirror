Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071F020248
	for <e@80x24.org>; Mon, 11 Mar 2019 22:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfCKWRw (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 18:17:52 -0400
Received: from kwanyin.sergiodj.net ([158.69.185.54]:55532 "EHLO
        kwanyin.sergiodj.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfCKWRw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 18:17:52 -0400
X-Greylist: delayed 2336 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2019 18:17:51 EDT
From:   Sergio Durigan Junior <sergiodj@sergiodj.net>
To:     git@vger.kernel.org
Subject: Possible race condition with git-rebase + .git/index.lock
X-URL:  http://blog.sergiodj.net
Date:   Mon, 11 Mar 2019 17:38:51 -0400
Message-ID: <87k1h55bx0.fsf@sergiodj.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi there,

I've been bit by this bug many times, and always forget to report it
here, but this time I finally remembered.

The scenario is this:

=2D I have a local repository which tracks the upstream of the project.

=2D I have 120+ local commits.

=2D Every week or so, I have to rebase my local commits on top of
  upstream's origin/master.

The workflow is simple:

  # git fetch origin && git rebase origin/master

This works without problems most of the time (well, usually there are
conflicts and all, but that's a burden I have to carry).  However,
sometimes I notice that git fails with:

  # git rebase origin/master
  ...
  Applying: commitX
  Applying: commitY
  Applying: commitZ
  fatal: Unable to create '/home/xyz/dir1/dir2/.git/index.lock': File exist=
s.

The first thing I did was to check whether the index.lock file existed,
but it doesn't.

I also I thought it might have something to do with "commitZ", but after
I ran "git rebase --abort" and tried rebasing again, I noticed that it
would stop at another commit.

This seems like a race condition, but after inspecting builtin/rebase.c
it doesn't seem like the "git am" commands are run in parallel (and it
wouldn't make sense if they did, anyway).

I tried using GIT_TRACE, but haven't seen any useful information in the
logs.  I tried using the "next" branch, and found that the problem
exists there as well.  I wonder if anyone else has seen this problem.

Thanks,

=2D-=20
Sergio
GPG key ID: 237A 54B1 0287 28BF 00EF  31F4 D0EB 7628 65FC 5E36
Please send encrypted e-mail if possible
http://sergiodj.net/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEI3pUsQKHKL8A7zH00Ot2KGX8XjYFAlyG1WsACgkQ0Ot2KGX8
Xjba7A/+PFJcQWH8ebLm3dhAbzLiheYPNDw9p0O6/b8dLgPmH6BiHSsNtwcdOaZ2
sSyT1QIevAJN5ozsOU7Tv2nVuG+54kv1IHRTviWO4aIk/YUcxKmnydy4/BMBB4v5
zeq+be3EHetNGC706oTLOyzBo9VPObAd7crhmnbMrmcK+oJvpLXy3VEO7e75xQFE
soSKigLBh+PGI7fmyrCc8wIuLpcJDT+pRMkiZv8JwbTJr68sY3uyJ7KTVGUK5dD+
dInR4QgV5C6JOF1FRUOjW4NyTdU0Pxyf2xYkP+Wat4DDfbgyMeiKEbWLp+KCJUky
ucvnYPacy/uYMhAbgouH8cCcayilCa1V+oURt2bKPW2vvMf9vYuVU92jQXHDy4m8
LVGF4ROWrAxIVwkneGIy1vmpsnkzcUuOoukOoUbbGfRuCY0GHNTnJqDqe16tLfRg
ZuP8/DGVhh9M2b1p5S+8DpGwneEtn0GzYlmKqbnMQ6KLSe687xJa9IUL4Lhmorw8
ros7coBpXJ+2G0maWsC9kEaWMmXYpwiGLWI5B+zgkAb3LaX+alFYtIdC1sWEkSLX
X/Latz51f/6/ZoLcqMVxCUyTMAyU94aDUqgTQ6rASeY5Ren7TFRtPOjzxlckBbjw
ZI9/Pzn40g3PqAyKclgTP1WGn2W1rB23llbeLGi6GnuOGbIt1O0=
=INJb
-----END PGP SIGNATURE-----
--=-=-=--
