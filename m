Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A9FC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09976142A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhKRWTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:19:32 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:44150 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhKRWTb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 17:19:31 -0500
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 515965B462;
        Thu, 18 Nov 2021 22:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637273790;
        bh=gGZMBdMObMpQSWG2nqkCjVohunoRAQrnl2Y4u5YbMsE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YJC9/oXoUgjp+tCeb/WlmqsjUiijMLEWWBy7aB3c+2cpH46AlwWLE01DhuBsAzdpY
         8SFlh5kFfpn+DGLfAe2yChKea5tvL+AtZQc4KxVVn59qQmVSt2RrIxvrNZZpTSVjEv
         ZzHyPHrUW3uUyv6fZMkS7AHrqoZHTOQQXtG3tcatFcTe+gIcLKYrZsoW4c8nLvMoO3
         slHk2FwuxR3RjknrVaLUhfBMMGj0UFmDYBAX04G1gnnxYRJTRt9UInkWa8cFDyw734
         lx+4yvYczVICUH82UWscLipeUv91XR49hgd8PgqQH/rQgFVS8fkAE9golWO3Yev2uI
         m9DOY7NH8IXT3c5G/Oe7QdVwQ0nVKLyvRZfiAtMyGWTShIlEWgkjQgiq+ON1d4k867
         spC1wOxkA4iTb2GF3jefvscVdGDxboTD2AquYDybTIrzRKRnXLeXfsPuV73hBpRUPF
         VaJqYoJtgkOxN8HQvpHGhaau6vGmcaHzhdTl661MbO2URWfatI9
Date:   Thu, 18 Nov 2021 22:16:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Message-ID: <YZbQu3fwfRsdEeXR@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-2-sandals@crustytoothpaste.net>
 <xmqq1r3f5izn.fsf@gitster.g>
 <YZWJy16Emrkr6qVL@camp.crustytoothpaste.net>
 <xmqqv90qx76b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pqjfp+9ZOi8FxmXF"
Content-Disposition: inline
In-Reply-To: <xmqqv90qx76b.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Pqjfp+9ZOi8FxmXF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-18 at 07:19:08, Junio C Hamano wrote:
> Presumably csprn_bytes() grabs bytes from underlying mechanism in
> smaller chunk, but would not return until it fills the buffer---ah,
> your "make sure our buffer handling is correct" is primarily about
> the check that we get full 1k bytes in the loop?  We ask 1k chunk 64
> times and we must get full 1k chunk every time?

Yes, that's what we'd expect to happen.

> What I was wondering about was the other half of the check, ensuring
> all buckets[] are painted that gave us the cute 10^-100 math.

Say the buffer handling is incorrect and we read only a few bytes
instead of the full 1 KiB.  Then we'll end up filling only some of the
buckets, and the check will fail much of the time, because we won't get
sufficient number of random bytes to fill all the buckets.

The check is that we got enough data that looks like random bytes over
the course of our requests.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Pqjfp+9ZOi8FxmXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZbQuQAKCRB8DEliiIei
gTW+AP0RN7uJCv5VaBOYE9x9h/LnB/3Y9irA0bFuRYt7eXsjFwEA3bWpRszKG74I
sGv2w/4/9V3jk0adAyO6zwPZ1EuIDA4=
=yfpn
-----END PGP SIGNATURE-----

--Pqjfp+9ZOi8FxmXF--
