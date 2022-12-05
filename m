Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9CCC47089
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 22:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiLEWNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 17:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiLEWNs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 17:13:48 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624FF1A4
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 14:13:47 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 78C405A201;
        Mon,  5 Dec 2022 22:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1670278426;
        bh=0Ie1uS9Nt0+dIjx25HARgn9tofG+41hwYR0+agMqJl0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Gj2rMrojiSWo6DquYfbD8KyStMA6r8mVe1f5JJsalK+pPdWThvPNBH2GzZm5oJiMr
         O0iUE9PawozKp7FGizjPDcsL6tIYheiytGDRXHdjsRbNhgp+XPc5edws6vh3Rs4y+1
         byCc58MhGEicTwI1NPB5KQBukNUPBe7kehHXGwussMf2AWaYPVa5NMZj9nweP2LK9k
         RqlCB9FWa7PNetJbyEaY/vO/4Y8LlpV4Ubnk8u5vHkDPMLmyGdC0JC70fu67ehgFqi
         EJMRvzYM5kt3aONZVflITVGYQK3o11tSaLuAbWdpafPFIDXfArFNR/nwMGoeIETCa9
         /9SSERq1fmONU1alyRfJN/wfzPIQ3lC/SUqUu0WbztDazgQLTV3TdaapB8lbbOHyY7
         mTtsK+ITMYts+lvNuxI3mJSZrHRoX6zSW68qKKsPxluQKq9h19KrbeuWVmlSJIRbjF
         wIsYEU5F6S3s4OZikLjpr0ljbve7T1FepR5s8UyE9Ekk07VBYlu
Date:   Mon, 5 Dec 2022 22:13:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] setup: avoid unconditional open with write flags
Message-ID: <Y45tGLaJwg3Lt5uJ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>,
        git@vger.kernel.org
References: <20221205190019.52829-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ClJfHlpcdopNTl9"
Content-Disposition: inline
In-Reply-To: <20221205190019.52829-1-cgzones@googlemail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3ClJfHlpcdopNTl9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-12-05 at 19:00:19, Christian G=C3=B6ttsche wrote:
> Commit 57f5d52a942 ("common-main: call sanitize_stdfds()") added the
> sanitization for standard file descriptors (stdin, stdout, stderr) to
> all binaries.  The lead to all binaries unconditionally opening
> /dev/null with the flag O_RDWR (read and write).  Most of the time the
> standard file descriptors should be set up properly and the sanitization
> ends up doing nothing.
>=20
> There are many non modifying git operations, like `git status` or `git
> stash list`, which might be called by a parent to gather information
> about the repository.  That parent might run under a seccomp filter to
> avoid accidental modification or unwanted command execution on memory
> corruptions.  As part of that seccomp filter open(2) and openat(2) might
> be only allowed in read-only mode (O_RDONLY), thus preventing git's
> sanitation and stopping the application.
>=20
> Check before opening /dev/null to populate a possible non-present
> standard file descriptor if actually any is missing.

I don't think this patch makes anything worse, and so I think it should
be fine as it is.

_However_, I will say that `git status` is not a read-only command
because it can write the index, and we aren't, in general, going to be
able to promise that any portion of Git will work with only O_RDONLY
file descriptors.  I suspect such a sandbox is going to result in a
highly broken Git in general, and so it wouldn't be a good idea.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--3ClJfHlpcdopNTl9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY45tGAAKCRB8DEliiIei
gYKXAP46/6ep5dG9QaU9uksl0SnFryImEpIkxflU5sERyHw2ggEAw9Zf5pN2cyP+
Uo7tDX1rm/vCLUySte87MiwkMI4AwgE=
=Lf4Q
-----END PGP SIGNATURE-----

--3ClJfHlpcdopNTl9--
