Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB52C32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 22:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E512469D
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 22:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgARWFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 17:05:10 -0500
Received: from mail6.webfaction.com ([31.170.123.134]:54878 "EHLO
        smtp.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgARWFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 17:05:10 -0500
Received: from localhost (82-64-139-178.subs.proxad.net [82.64.139.178])
        by smtp.webfaction.com (Postfix) with ESMTPSA id 1CD71600B27AC;
        Sat, 18 Jan 2020 22:05:01 +0000 (UTC)
From:   Christoph Groth <christoph@grothesque.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Stat cache in .git/index hinders syncing of repositories
References: <87v9p9skjz.fsf@drac> <xmqq7e1od41x.fsf@gitster-ct.c.googlers.com>
        <87pnfgshxu.fsf@drac>
        <20200118194204.GC6570@camp.crustytoothpaste.net>
Date:   Sat, 18 Jan 2020 23:04:59 +0100
In-Reply-To: <20200118194204.GC6570@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 18 Jan 2020 19:42:04 +0000")
Message-ID: <87d0bgs9o4.fsf@drac>
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
> On 2020-01-18 at 19:06:21, Christoph Groth wrote:
> > But if the above is not feasible for some reason, would it be
> > possible to provide a switch for disabling stat caching
> > optimization?
>
> Git is going to perform really terribly on repositories of any size if
> you disable stat caching, so we're not very likely to implement such
> a feature.  Even if we did implement it, you probably wouldn't want to
> use it.

OK, I see.  But please consider (one day) to split up the index file to
separate the local stat cache from the globally valid data.

(By the way, even after 12 years of using Git intensely I am confused
about what actually is the index.  I believed that it is the "staging
area", like in "git-add - Add file contents to the index".  But then the
.git/index file reflects all the tracked files, and not just staged
ones.  This usage is also reflected by the command "git update-index".)

> However, there are the core.checkStat and core.trustctime options
> which can control which information is used in the stat caching.  You
> can restrict it to the whole second part of mtime and the file size if
> you want.  See git-config(1) for more details.

Thanks a lot, that did the trick!  I=E2=80=99ve been already syncing mtimes.
Setting both core.checkStat and core.trustctime to the "weak" values
made the spurious modifications go away.

Still, this is a workaround, and the price is reduced robustness of file
modification detection.  Technically, that wouldn=E2=80=99t be necessary...
I hope that in practice it won=E2=80=99t matter.

> One final word of caution: you probably want to activate your sync
> tool only manually and only when the repository is idle.  Tools like
> Dropbox that automatically sync files one by one have been known to
> corrupt repositories because the way they sync data leaves the
> repository in an inconsistent state and doesn't honor standard POSIX
> file system semantics which Git relies on for integrity.

Yes, that=E2=80=99s why I still prefer Unison to more automatic real-time
tools.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUimQV/rXmWU8TwiKw/FH9ZgPNTUFAl4jgQsACgkQw/FH9ZgP
NTXVsg//essj1Qr/O8H5YUbY9rRB6Ja4lpZgkeygyRhfzNsLBVGmh2WbWr+6qXek
Td/gKkBd7hECzFwP+28WFE244rxXmKLR1hTlyjs3a1HNTrhVApEY7oBD57sd4ndu
S3U4Ph0W5qEAo6wdadRP1bwYA+3qhsyNzn3T4Bv6WHhY1H5QvYEESd+//GEZ58uK
0oPBr5x9d8OYNv2N3HKGHQDX5MlNJWyIGMH/V5gtmZU4VqwLhDRNIlAixuTiWeJ0
1dyqybGLNYdbAHWVpTI1d7o4U+y1XswRPPAYZ+qHqqnnZE7LxFK+cbDkoOdvmYTv
4W7J/Vwwa3Ctk2AiNpnOHOkvThEZKbPUBoMRr47EvN4LA+HipUw+AqaXDapEY6D5
Zp3QafeQm4WZVhYnjH8+NfTftN/J2TgXXB+yXE+vH6vXrBztkGZ46P1Z0g5y+bUF
C/fH9blNbcm5WqeeTuAKHyhGZxtcZ/Rs5uPt4SRv1JgP/QxVKqAa0PTx1CqVT7Bg
ImdNbALlD85EZnIBDRjDNW9QB+brHqZ4vmg1bn9o4p2zaEt9aA0adiVTbtK3k7T+
199cJDofHBqSmIe01dfpLnxtc8nIBcgWgdAfN3cHR5AhDFhr/L+uFWF1ocaTGL5t
mwvHAwKLxTS2d9TRuh12EAb1xmupbMrXjv1S1bDRBQOnQq4hn48=
=XvsH
-----END PGP SIGNATURE-----
--=-=-=--
