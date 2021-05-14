Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD773C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 19:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33BD6144A
	for <git@archiver.kernel.org>; Fri, 14 May 2021 19:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhENTyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 15:54:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47214 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230431AbhENTyY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 May 2021 15:54:24 -0400
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8103760456;
        Fri, 14 May 2021 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621021991;
        bh=KptolAxDZaBEYMRyzwyTOjnvGhKoOLah/RXPHqodV+o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GXrblbjdKpSvEDn82PKE+tNKPN5pmM3ipZrckSNX2lYZTfYTZFsBJB5CwDC1BGphT
         LOeOY1x2G1jqmqu9A5vI076CFfGroXptBzmHZikjR5AAfiLpw7ijB0AcQL+pnWrlZH
         iVqxSQDRmieBaewoIbfzk2vpoBi8yUesLE6TVh170U6APW3/HVoqP2w0veCWpyiSuz
         uy7kKxuSeSgN43G+9YjJPH5iGYiphTfxiwQ6jHr9auBScBCgBaXIZs+yF3Lx/OkNmA
         eDuKZV9PODYCIoMFTlD8cLxi7VTYlb1k/urzoGL9koT08EPh53AaK/tOTTMN6Ct4yM
         131nLZ+/Qu4O26T8yaGQM9z9+L2ZeC8vmQtVeiillhIAw+q8LSxNRWFNtLyFc29h3T
         VAJcKJJIF3s0pl5n44LCF09TVqdc+G0EgqYaKoaKnnCs9gBLDyGUjcoJ6/2Ac7yHmi
         D0OrbfVJMTM1Lva7xveXcYw78m/PeXEduiZxCpacVQYXZsmxkbq
Date:   Fri, 14 May 2021 19:53:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] parallel-checkout: send the new object_id algo field
 to the workers
Message-ID: <YJ7VI5kHAAk126YJ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
References: <a4225bc79d963c5a411105e2b75f9ca4b80de835.1621000916.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DLz+9mSYoJKtCoKe"
Content-Disposition: inline
In-Reply-To: <a4225bc79d963c5a411105e2b75f9ca4b80de835.1621000916.git.matheus.bernardino@usp.br>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DLz+9mSYoJKtCoKe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-14 at 14:36:00, Matheus Tavares wrote:
> An object_id storing a SHA-1 name has some unused bytes at the end of
> the hash array. Since these bytes are not used, they are usually not
> initialized to any value either. However, at
> parallel_checkout.c:send_one_item() the object_id of a cache entry is
> copied into a buffer which is later sent to a checkout worker through a
> pipe write(). This makes Valgrind complain about passing uninitialized
> bytes to a syscall. The worker won't use these uninitialized bytes
> either, but the warning could confuse someone trying to debug this code;
> So instead of using oidcpy(), send_one_item() uses hashcpy() to only
> copy the used/initialized bytes of the object_id, and leave the
> remaining part with zeros.
>=20
> However, since cf0983213c ("hash: add an algo member to struct
> object_id", 2021-04-26), using hashcpy() is no longer sufficient here as
> it won't copy the new algo field from the object_id. Let's add and use a
> new function which meets both our requirements of copying all the
> important object_id data while still avoiding the uninitialized bytes,
> by padding the end of the hash array in the destination object_id. With
> this change, we also no longer need the destination buffer from
> send_one_item() to be initialized with zeros, so let's switch from
> xcalloc() to xmalloc() to make this clear.
>=20
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>=20
> Hi, brian
>=20
> I've read the hash transition plan, but I'm not confident to say that I
> fully understand it yet, so maybe this patch is not exactly what we need
> here. Mainly, I'm not sure I understand in which cases we will have an
> object_id.algo that is not the_hash_algo. Is it for the early transition
> phases, where we have a SHA-256 repo that accepts user input as SHA-1?=20

Yes, that's correct, as well as for interoperability with remotes using
a different hash algorithm.

> Also, the object_id's copied here at send_one_item() always come from a
> `struct cache_entry`. In this case, can they still have different
> `algo`s or do we expect them to be the_hash_algo?

No, things in the index should always use the same algorithm..

The patch looks fine to me.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--DLz+9mSYoJKtCoKe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJ7VIwAKCRB8DEliiIei
gdZNAP9DRlbZhv/uPQGiF2jH7gbvW9orexOLWIOfOIhFYXQ+AgEAtYWs9JeAWaWS
VtXMoL8md/saMYY+vyVEAPKSE3BvpQA=
=o3nh
-----END PGP SIGNATURE-----

--DLz+9mSYoJKtCoKe--
