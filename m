Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D184BC32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 23:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6F020700
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 23:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgATXxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 18:53:30 -0500
Received: from mail6.webfaction.com ([31.170.123.134]:50422 "EHLO
        smtp.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgATXxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 18:53:30 -0500
Received: from localhost (82-64-139-178.subs.proxad.net [82.64.139.178])
        by smtp.webfaction.com (Postfix) with ESMTPSA id 7F1BB60027D32;
        Mon, 20 Jan 2020 23:53:21 +0000 (UTC)
From:   Christoph Groth <christoph@grothesque.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Stat cache in .git/index hinders syncing of repositories
References: <87v9p9skjz.fsf@drac> <xmqq7e1od41x.fsf@gitster-ct.c.googlers.com>
        <87pnfgshxu.fsf@drac>
        <20200118194204.GC6570@camp.crustytoothpaste.net>
        <87d0bgs9o4.fsf@drac>
        <nycvar.QRO.7.76.6.2001201248480.46@tvgsbejvaqbjf.bet>
Date:   Tue, 21 Jan 2020 00:53:22 +0100
In-Reply-To: <nycvar.QRO.7.76.6.2001201248480.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 20 Jan 2020 13:01:54 +0100 (CET)")
Message-ID: <87ftg9n0r1.fsf@drac>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
>
> On Sat, 18 Jan 2020, Christoph Groth wrote:
>
> > OK, I see.  But please consider (one day) to split up the index file
> > to separate the local stat cache from the globally valid data.
>
> I am sure that this has been considered even before Git was publicly
> announced,

I would be very interested to hear the rationale for keeping the
information about what is staged and the stat cache together in the same
file.  I, or someone else, might actually work on a patch one day, but
before starting, it would be good to understand the reasoning behind the
current design.

> and I would wager a guess that it was determined that it would be
> better to keep all of Git's private data in one place.

My point is that it=E2=80=99s not just private data: When I excluded .git/i=
ndex
from synchronization, staging files for a commit was no longer
synchronized.

> > (By the way, even after 12 years of using Git intensely I am
> > confused about what actually is the index.  I believed that it is
> > the "staging area", like in "git-add - Add file contents to the
> > index".  But then the .git/index file reflects all the tracked
> > files, and not just staged ones.  This usage is also reflected by
> > the command "git update-index".)
>
> The concept of the Git index is slightly different from what is
> actually stored inside `.git/index`. You should consider the latter to
> be an implementation detail that is of concern only if you want to
> work on internals. Otherwise the description of the index as a staging
> area is a pretty good image.

To me, it does not seem to be a mere implementation detail.  For example
the command =E2=80=99git update-index --refresh=E2=80=99 is part of the "pu=
blic API" and
its action is to update the stat cache.  It does not modify what is
staged or not.

> > Still, this is a workaround, and the price is reduced robustness of
> > file modification detection.
>
> You misunderstand how Git detects whether a file is modified or not.
>
> A file is re-hashed if its mtime is newer than, _or equal to_, the
> mtime of `.git/index`.

You must mean "the mtime in =E2=80=99.git/index=E2=80=99", but OK, I see.  =
Makes sense
of course.  So setting core.trustctime to false and core.checkstat to
minimal only means that some avoidable rehashings may be made.  But this
would require two modifications of a file in the same second, without
a change to the file size.

> In general, I am not sure that you are using the right tool for
> synchronizing. If you cannot guarantee that a snapshot of the
> directory is copied, you will always run the risk of inconsistent
> data, which is worse than not having a backup at all: at least without
> a backup you do not have a false sense of security.

I do not understand what makes you think so.

Unison is very robust software, I never had any problems with it and
never heard of anyone having any.  Moreover, as I noted in the opening
message of this thread, it recently gained an option to treat chosen
directories as atomic.  I=E2=80=99m using this for ".git" subdirectories.

Christoph

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUimQV/rXmWU8TwiKw/FH9ZgPNTUFAl4mPXIACgkQw/FH9ZgP
NTVXPA//Zxld9bSbRpWU9R6xrRmaRuYStWdlDBA1XJvuzPd79HoRO1ZBAR3tg3Tx
xTAlAap77/WHPC22lHT0TVXTwJVel9R/lKy/VqM0uJzH/HZMvDRy3FDBbCfXqZUY
j43PqNnI/oU/6IYYGnOK+8g1p57V9sUefUEft7HBnDjE7t3o6iXg3HSnUqNWatbu
f+RQ+btiEfYxQzPcBfyJZi6IF2pSYay6Iqjnx1Q6Qauocw/4VqUgdThAwGg2rXDS
HFZDTj2xERat7yzgLWqsCoI9gMEeGtAhgRqPH6xm2a8okHAZ4ag8FMyRmIT6LDmQ
Ef5ydKNSm1ALiRy8zV4Z2CgsiNoey8+cE1WpqhqhZN7q8ytt+V/Gb4CAgy2YBo4/
Gmo4NaM0SbX3kmSifW8rPP4D9mA+wB/GmA2SLlwfyeo+x/LnZ/Z6gS6CgfJx9kEo
O4j43AxUMcX7NWML97e5DwR2GAKe4MuHPhuusrF6yrRdirqiD3oE4xFWCjfXae14
4qI9khgDEQ2voBNJ9AwSixFdUCzye/x8I8wYeigKkw3GPwhfO7oZzMPpOd+XXAR8
MaTBIDslGhyghHQGbpWwyjOtkg8iqAvL7dBSJt39sTQ/BfezZ8wg8abyLrECMVk7
6zKBVDN3FUi2wqtXVOfgCWvo5YCLIVGXbNuuDpwMz8c7vnw+md4=
=rvEk
-----END PGP SIGNATURE-----
--=-=-=--
