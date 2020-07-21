Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA11C433E3
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262362077D
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YtFFBUCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbgGUXms (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:42:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40464 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbgGUXmq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Jul 2020 19:42:46 -0400
Received: from crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B7ED26044F;
        Tue, 21 Jul 2020 23:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595374935;
        bh=n/js7hPx8iyyauksBkHaiGzu1CHKMrrxRKNv8fanX9U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YtFFBUCMYtNy6AXk3izfNXW8gLQC1vmqgbqLRQGDLkUe4KZcuUat09PgS05T+sZsd
         YZr1YqTCcryigo6VEkHfxrK0SUjWcMihy9akXNHwvR72sb0Y93pwgB6ZarwG4g5Z4L
         iLUJMNTbzflNQXBnPZDqCMQ6en9feiBEZk7dhDdVnv51zrllTwW2B9k3qG3LnsLiEb
         znE0+3KvZj4Thq6tgo7mGJd0zFFh0q9BzIz/w8R5uBTYDXNigVIBpvXWB9SVMwARZd
         nKkmfksqhygtksfwYwdMcRk1hmmAJ5icAQ9bmIpjYGbM+cMRhN/SQiacpDxpAC8+r6
         MCiGmYKl+MU828iGYbtSPhnSbLjuz6zuPRt8ENTG3QFBhcthErGo95hlBgjcpHrlSg
         RLLR87dH5RONDYeo//WFd6hsLSh8KY3g+DjJvRQhEiUvw3XgJEphqBejB2TyFpHfzo
         VJTiojbU5wSaLvD9UwJ0BEfb2fFDVfkdEWv9y37XTSQG+tYKjGI
Date:   Tue, 21 Jul 2020 23:42:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Matt Parnell <mparnell@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Disclosure - Git Packs (zlib) Allows for Zipbomb Style Attacks
Message-ID: <20200721234210.GB1667453@crustytoothpaste.net>
References: <eafc4ebc-47dd-8f7a-d201-74e5369014d1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <eafc4ebc-47dd-8f7a-d201-74e5369014d1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-21 at 19:31:48, Matt Parnell wrote:
> Description:
>=20
> Using compression friendly files, in this case, multiple 99MB zero byte
> filled files, a prankster or malicious actor in control of a popular
> repository can cause all who clone or pull a given branch to take up far
> more storage locally than displayed remotely on the git host - this is
> not limited to GitHub, but would apply to literally any git host,
> including just git+ssh.
> My Example Repo: https://github.com/ilikenwf/git-zlib-bomb
>=20
> The size of the repo on GitHub and my local git server is 744K, while
> the non-mirrored, cloned version with extracted objects is around 101GB.
>=20
> I argue this is a bit different than the "git bomb" by GitHub user
> Katee, as hers was more focused on recursion and segfaults. In this
> case, the attack focuses on git's use of zlib to compress the packs,
> especially since it will store only one compressed copy of an
> object/file in the repo, even if multiple copies of it exist.
>=20
> While Github does already abort pushes when it detects files over 100MB,
> and warn for files below that size, it doesn't seem to investigate
> cumulative size of the extracted pack on disk. Even so, this doesn't
> really help with git itself, the application, as it means that hosts and
> users elsewhere are still in danger and the only way to mitigate that I
> can think of would be to have git store a cumulative size value that can
> be used for warnings, or perhaps some logic that detects zero or
> repetitively filled files that compress in a deceptive manner.
> Steps To Reproduce:
>=20
> (Add details for how we can reproduce the issue)
>=20
> =C2=A0=C2=A0=C2=A0 Create a new repo locally.
> =C2=A0=C2=A0=C2=A0 Create multiple 1MB to 99MB zero filled files in the r=
epo to get a
> total in the tens or hundreds of gigabytes, or beyond. I just used
>=20
> for i in $(seq 1 1035); do dd if=3D/dev/zero of=3Dtest$i bs=3D99M count=
=3D1; done
>=20
> =C2=A0=C2=A0=C2=A0 Add them all to the repo and commit.
> =C2=A0=C2=A0=C2=A0 Push them to a remote git server, or clone them as onl=
y a mirror.
> =C2=A0=C2=A0=C2=A0 Compare the disk space utilized between the original r=
epo, and the
> mirrored repo.
>=20
> Impact
>=20
> While this does not give unauthorized access to an attacker, it could be
> used to easily consume a large amount of any given developer's time and
> storage space. I personally would be very angry if I took the time to
> clone a repo, only to have it crash when it ran out of space, or occupy
> hundreds or thousands of gigabytes.

I agree this is inconvenient, but it's a problem that occurs with all
compression.  Literally any zip file or tarball can have this problem as
well, and those are other formats customarily used for software
interchange.

I don't think this is a security problem because it's a known attribute
of compression which is endemic to all compressed data.  We don't
consider the zip, gzip, and xz programs to have security vulnerabilities
because they don't limit the size of the data they uncompress.

There are cases where this _is_ a vulnerability, usually where some
larger system fails because an attacker can feed it data and make it run
out of resources.  If you're developing such a system, then you
definitely need to use a dedicated user with quotas or a limited-size
overly (e.g., Docker) to restrict against exhausting resources, but you
need to do that anyway, independent of whether you're using Git.  So I
don't consider this to intrinsically be a security problem in Git any
more than it is in other general-purpose tools that uncompress data.
--=20
brian m. carlson: Houston, Texas, US
