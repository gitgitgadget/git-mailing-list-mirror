Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9408FC2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733232075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgAXJQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:16:33 -0500
Received: from mail6.webfaction.com ([31.170.123.134]:58728 "EHLO
        smtp.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgAXJQd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 04:16:33 -0500
Received: from localhost (82-64-139-178.subs.proxad.net [82.64.139.178])
        by smtp.webfaction.com (Postfix) with ESMTPSA id 09D39600432E0;
        Fri, 24 Jan 2020 09:16:23 +0000 (UTC)
From:   Christoph Groth <christoph@grothesque.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Stat cache in .git/index hinders syncing of repositories
References: <87v9p9skjz.fsf@drac> <xmqq7e1od41x.fsf@gitster-ct.c.googlers.com>
        <87pnfgshxu.fsf@drac>
        <20200118194204.GC6570@camp.crustytoothpaste.net>
        <87d0bgs9o4.fsf@drac>
        <nycvar.QRO.7.76.6.2001201248480.46@tvgsbejvaqbjf.bet>
        <87ftg9n0r1.fsf@drac>
        <20200121025311.GA4113372@camp.crustytoothpaste.net>
Date:   Fri, 24 Jan 2020 10:16:18 +0100
In-Reply-To: <20200121025311.GA4113372@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 21 Jan 2020 02:53:11 +0000")
Message-ID: <8736c5tdst.fsf@drac>
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

brian m. carlson wrote:
> On 2020-01-20 at 23:53:22, Christoph Groth wrote:

> > My point is that it=E2=80=99s not just private data: When I excluded
> > .git/index from synchronization, staging files for a commit was no
> > longer synchronized.
>
> (...)
>
> Storing all of this data in one file means that only one file need be
> mapped into memory and rewritten.  Git writes to the index by
> atomically creating a lock file along side of it and writing the new
> contents into it, and then doing an atomic replace.  This approach
> wouldn't be possible with multiple files, and any update to it
> wouldn't be atomic.

Thanks a lot for the explanation.  To me, it still seems less
satisfying, from a design point of view, to mix state (=3Dwhat changes
have been staged) with an ephemeral cache that is specific to
a particular file system.  Without having thought deeply about it,
I have the impression that it wouldn=E2=80=99t matter if the stat cache and=
 the
=E2=80=9Cstaging state=E2=80=9D of the repository would be atomic each on t=
heir own.

But I understand now that all of this hardly matters in practice (see
below), so I=E2=80=99m not motivated to work on this, and probably no one e=
lse
is. :-)

> However, having said that, nobody has provided a compelling case for
> using multiple files for storing different types of working tree
> state.  The existing options are available for cases like yours and
> others', and they work.  Since there are clear benefits to the current
> model, including simplicity and robustness, and few downsides, nobody
> has decided to change it.

Indeed, I do see hardly any disadvantages of globally setting

	trustctime =3D false
	checkstat =3D minimal

as I do now.  In fact, I wonder what is the purpose of caching the
subsecond part of mtime and the ctime in the first place.  Perhaps it
matters for scripted use of git where several operations can occur in
the same second, but even then only changes that keep file sizes
constant would be affected.

> I should add that even if, for some reason, we did add support for
> splitting this data out, I'm not sure if we'd support syncing only
> part of the repository state and blowing away other state.  We don't
> really support that now (other than through tools like fetch and
> clone) and I don't think we'd want to encourage that behavior in the
> future.

The stat cache file would not be really part of the state of the
repository, since deleting it would not change anything, but only slow
down the next operation.  (That=E2=80=99s at least my understanding current=
ly,
perhaps I=E2=80=99m still overseeing something.)

Brian, Johannes, Junio, thanks a lot for taking the time to clarify this
issue.

Christoph

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEP6x58QAOdlLG0jena2rszJGp28QFAl4qteIACgkQa2rszJGp
28TBiA/+KWTobHLD4+XDIWWo+6WfqXd+SOgURvbL6lwLQWjtFcPtyASjUTVgoomg
Oec1CPY5heSMhxu7VWztped+P6eH0+39IVlodQMFEiDxTCJDKiUITkDFSbZIred1
CJ/p0ASCVc8z3WlYI6p8WIDeDke8WFbMfHvebu5+2xSoXosurR0Ry7RdMVWnT6ZF
24Cn+4tl4G8Lj/kPAQza+uaPHPbybRentWRB/dt7lkw0opWmV9Kvww80n6Pbg/tp
tiCj8MFbgh1s/6lcli6hjpLxHO6R5PjXy+Z9eVTpCdCxtp2AGbbkm0Ngrpv5Bozo
eshVuT7Aei8BHYHHtTpbNGZdTG6IswT3N7dugb11n5XWr0i4o2Ad6dHFRAmksLgu
Rzu2TkdgNzKms8DrzQtErHssWJs08liI2X+QcIOVpvryahGd83ENm4jbtHmA3/S6
riSNwqybrUQdR/QIv8jHfYTS10YEDpc9J71/clOBoyICpTfz4gdT9u+STWgOksVu
zryDjK5JoK/p2cbz7mnCH/T1MtwtWoLfDM+EzH5PkxisycS98fVfkxvQkxvVAmSB
/1wdfv6CyJ2eALFhv3bS+mj4JiyeHttRanXlfHDpFlc9U/dj3syA0yFjWcAC0P9a
0rXHqkNhqJJ3ZuRIrYSVsaKOtFQAgl/NLj5RYh2xCh6dO7VDjM0=
=ZxqA
-----END PGP SIGNATURE-----
--=-=-=--
