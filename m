Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FEEC001DE
	for <git@archiver.kernel.org>; Sun, 23 Jul 2023 15:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGWPDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jul 2023 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGWPDX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2023 11:03:23 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CC9D1
        for <git@vger.kernel.org>; Sun, 23 Jul 2023 08:03:22 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id CEDE85B01B;
        Sun, 23 Jul 2023 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1690124601;
        bh=WKwo87iRg3UgY+6iF7S/Fur3+nOKDSapQooE9Ds5Y6I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vQlIu5uj27xfohBrd5ElfdzUbu+1RJT0/8TXO7uhGNu1owlEf8ehZOsHds5i3aSeU
         g9zCYcIROueKH5vN/8i10UPRW9HV4jq+dfFFD7MaV6vSsTdwRR7txSg8tRESyoUZvE
         5Wrxa/sUihO87+3187qsieQf04Imt74+1YnbXadYus+2sNhKOZ5f45d15GQVwpTRKX
         AscrT08xASUlTeMM+6potkCFr3Q2KST3WYVAo09x02RaHjRNBH3tRJk4436gNPWQ2K
         yHuh2U7ZuvW/gwjYaxOoW/rmk59geOBtF/EJyh+DIYiRPJrDY9wcuxXngXZ9G1uzkh
         AxuKZoLn0qJNJS6fzpnjD5J51CCVHRYbPs3XjP+nzxi/RgbUY+Sm6q1lndg5nMz0if
         cXXdaAvc9ASFmydW61GEEvX8NncTmXbQ76TMGM0aGLWqoa5ogY3ExevSdhXWfxEuXS
         oPsb7VyumeXzYIBPRHGQyV2UOBq8STp4yMuAepkLtX3HJsi2LlB
Date:   Sun, 23 Jul 2023 15:03:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "brian m. carlson" <bk2204@github.com>
Subject: Re: [PATCH] rerere: match the hash algorithm with its length
Message-ID: <ZL1BNxVWKGx0Gi1b@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <bk2204@github.com>
References: <xmqqa5vou9ar.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="baTzPvc2KKPxDBu0"
Content-Disposition: inline
In-Reply-To: <xmqqa5vou9ar.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--baTzPvc2KKPxDBu0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-21 at 23:36:12, Junio C Hamano wrote:
> The "conflict ID" used by "git rerere" to identify past conflicts we
> saw has been a SHA-1 hash of the normalized text taken from the
> conflicted region.  0d7c419a (rerere: convert to use the_hash_algo,
> 2018-10-15) updated the rerere machinery to use more general "hash"
> instead of hardcoded SHA-1 by using the_hash_algo, GIT_MAX_RAWSZ and
> their friends, but the code that read from the MERGE_RR records were
> left unconverted to still use get_sha1_hex(), possibly breaking the
> operation in SHA-256 repositories.

I agree consistency here is a good idea.  However, I should point out
the definition of `get_sha1_hex`:

int get_sha1_hex(const char *hex, unsigned char *sha1)
{
	return get_hash_hex_algop(hex, sha1, the_hash_algo);
}

Thus `get_sha1_hex` uses `the_hash_algo`, and therefore your change is
equivalent to what was there before, I believe.  That's because during
the SHA-256 code work, we could either send a bunch of patches to fix
all of the instance of `get_sha1_hex` or we could just patch that
function to use the default hash algorithm, and I, for better or for
worse, made the decision to avoid the churn.

I still firmly agree that your change is better, because it is easier to
read and less confusing, and that is a major improvement in itself.
However, I would suggest that the commit message be updated to reflect
that if possible.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--baTzPvc2KKPxDBu0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZL1BNwAKCRB8DEliiIei
gclCAP4+a07gvHUJfgD5jLieQVymW0TTrVhA2GwsuUpDmNZrIgD+IPjl1mCFJfph
LugX9m+khJudKxu9aPYT5U0HypvnPw0=
=yaLU
-----END PGP SIGNATURE-----

--baTzPvc2KKPxDBu0--
