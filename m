Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6266DC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 11:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347044AbiAGLOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347035AbiAGLOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 06:14:40 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3EAC061245
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 03:14:39 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C82325B252;
        Fri,  7 Jan 2022 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641554078;
        bh=TJpD4cM384ieybVuzAnQ4AqkCRP9q+O6dKFQ9Sq/zP8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uX/D3jjXntbxQhyjAZKPtOPsGHobvMorWc9P7EwstZ67ltqtlDfpX5oQJZY4y6opa
         u5u7d8flGVrh+mTIq75VfrFMpeRueeWqQKCKdS11IAhEgFL3sqGbQ8uy5AD0tf2Awa
         Z8gmfwDKOL26SoOqCRZ9OJZatv9JVS0J63MjqrCJXoelJp99y+9/rCvxVWdK2RAKna
         c1tI+spK7Tgjy82YOrv0BQZexe3jwt8JafLN+8F0FVKY9WiDmZG7EY10EqMkcXQaod
         3JbGTDdAdpkiYssQu3gMutZitSl5HgTOA5eH1g4gaxZPXVsApoMf8XTtHE4yEDR0v5
         atGDdZ52L+nZj0NbtzEWwUcjoPl64sVk0eiwDYa5DJowjY5KnTTHWSovMFeLV+d3oX
         dd8NrzdWmQ0JAxQ34V9/hfXTSkzVvI/RNyfEn1dDNXsgKcZmfWf32/aFhVhwWlb9Ny
         HOMQNdZTKQgaI0r4L9NF5gDcGPwTpwTxbI0GIucJZvShAPjaE+X
Date:   Fri, 7 Jan 2022 11:14:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, iwiedler@gitlab.com
Subject: Re: [PATCH 1/1] fetch: fix deadlock when cleaning up lockfiles in
 async signals
Message-ID: <YdggneOlWXf2Z+gf@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        iwiedler@gitlab.com
References: <cover.1641552500.git.ps@pks.im>
 <555ec6717ecab0fe6ef5660bcf0d61d59f84ef8b.1641552500.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KfZDtAT6E1dLKmJE"
Content-Disposition: inline
In-Reply-To: <555ec6717ecab0fe6ef5660bcf0d61d59f84ef8b.1641552500.git.ps@pks.im>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KfZDtAT6E1dLKmJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-07 at 10:55:47, Patrick Steinhardt wrote:
> [Resend with the correct In-Reply-To header set to fix threading]
>=20
> When fetching packfiles, we write a bunch of lockfiles for the packfiles
> we're writing into the repository. In order to not leave behind any
> cruft in case we exit or receive a signal, we register both an exit
> handler as well as signal handlers for common signals like SIGINT. These
> handlers will then unlink the locks and free the data structure tracking
> them. We have observed a deadlock in this logic though:
>=20
>     (gdb) bt
>     #0  __lll_lock_wait_private () at ../sysdeps/unix/sysv/linux/x86_64/l=
owlevellock.S:95
>     #1  0x00007f4932bea2cd in _int_free (av=3D0x7f4932f2eb20 <main_arena>=
, p=3D0x3e3e4200, have_lock=3D0) at malloc.c:3969
>     #2  0x00007f4932bee58c in __GI___libc_free (mem=3D<optimized out>) at=
 malloc.c:2975
>     #3  0x0000000000662ab1 in string_list_clear ()
>     #4  0x000000000044f5bc in unlock_pack_on_signal ()
>     #5  <signal handler called>
>     #6  _int_free (av=3D0x7f4932f2eb20 <main_arena>, p=3D<optimized out>,=
 have_lock=3D0) at malloc.c:4024
>     #7  0x00007f4932bee58c in __GI___libc_free (mem=3D<optimized out>) at=
 malloc.c:2975
>     #8  0x000000000065afd5 in strbuf_release ()
>     #9  0x000000000066ddb9 in delete_tempfile ()
>     #10 0x0000000000610d0b in files_transaction_cleanup.isra ()
>     #11 0x0000000000611718 in files_transaction_abort ()
>     #12 0x000000000060d2ef in ref_transaction_abort ()
>     #13 0x000000000060d441 in ref_transaction_prepare ()
>     #14 0x000000000060e0b5 in ref_transaction_commit ()
>     #15 0x00000000004511c2 in fetch_and_consume_refs ()
>     #16 0x000000000045279a in cmd_fetch ()
>     #17 0x0000000000407c48 in handle_builtin ()
>     #18 0x0000000000408df2 in cmd_main ()
>     #19 0x00000000004078b5 in main ()
>=20
> The process was killed with a signal, which caused the signal handler to
> kick in and try free the data structures after we have unlinked the
> locks. It then deadlocks while calling free(3P).
>=20
> The root cause of this is that it is not allowed to call certain
> functions in async-signal handlers, as specified by signal-safety(7).
> Next to most I/O functions, this list of disallowed functions also
> includes memory-handling functions like malloc(3P) and free(3P) because
> they may not be reentrant. As a result, if we execute such functions in
> the signal handler, then they may operate on inconistent state and fail
> in unexpected ways.
>=20
> Fix this bug by not calling non-async-signal-safe functions when running
> in the signal handler. We're about to re-raise the signal anyway and
> will thus exit, so it's not much of a problem to keep the string list of
> lockfiles untouched. Note that it's fine though to call unlink(2), so
> we'll still clean up the lockfiles correctly.

I took a look, and this seems reasonable to me.  I know in the
non-signal case, we'd want to clean up because it means we can check for
leaks, but I don't see the utility of running Git under Valgrind and
then sending it a signal, and I think it's just safe to ignore that
case.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--KfZDtAT6E1dLKmJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYdggnAAKCRB8DEliiIei
gR9sAQC/rsUiVvlnvqIeuZ1zggWd6xLR8TvhCvGEFS519nyKEgEAle6CgKnBLpXU
Xe3Fht5IuEGoZ2EsWO6obYIcQr6KYAs=
=pM6m
-----END PGP SIGNATURE-----

--KfZDtAT6E1dLKmJE--
