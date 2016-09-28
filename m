Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3291F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 19:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932389AbcI1TSh (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 15:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932306AbcI1TSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 15:18:36 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E28D431A349;
        Wed, 28 Sep 2016 19:18:35 +0000 (UTC)
Received: from [10.34.4.182] (unused-4-182.brq.redhat.com [10.34.4.182])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8SIJvcj011032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 28 Sep 2016 14:19:58 -0400
Subject: Re: [PATCH] http: Control GSSAPI credential delegation.
To:     Jeff King <peff@peff.net>
References: <1475078752-31195-1-git-send-email-pstodulk@redhat.com>
 <20160928171610.pbghg4sk23vm4xnp@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Petr Stodulka <pstodulk@redhat.com>
Message-ID: <9c9e9949-cfe0-5465-6ae1-3e8254ff055b@redhat.com>
Date:   Wed, 28 Sep 2016 20:19:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160928171610.pbghg4sk23vm4xnp@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Kq9aiEn4Nk8Cf16AL7HWTstVXI8pPdTF8"
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 28 Sep 2016 19:18:36 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kq9aiEn4Nk8Cf16AL7HWTstVXI8pPdTF8
Content-Type: multipart/mixed; boundary="8wjjRsJpPMCSaeRmioiBX5w68mfQMCREB";
 protected-headers="v1"
From: Petr Stodulka <pstodulk@redhat.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Message-ID: <9c9e9949-cfe0-5465-6ae1-3e8254ff055b@redhat.com>
Subject: Re: [PATCH] http: Control GSSAPI credential delegation.
References: <1475078752-31195-1-git-send-email-pstodulk@redhat.com>
 <20160928171610.pbghg4sk23vm4xnp@sigill.intra.peff.net>
In-Reply-To: <20160928171610.pbghg4sk23vm4xnp@sigill.intra.peff.net>

--8wjjRsJpPMCSaeRmioiBX5w68mfQMCREB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 28.9.2016 19:16, Jeff King wrote:
> On Wed, Sep 28, 2016 at 06:05:52PM +0200, Petr Stodulka wrote:
>=20
>> Delegation of credentials is disabled by default in libcurl since
>> version 7.21.7 due to security vulnerability CVE-2011-2192. Which
>> makes troubles with GSS/kerberos authentication where delegation
>> of credentials is required. This can be changed with option
>> CURLOPT_GSSAPI_DELEGATION in libcurl with set expected parameter
>> since libcurl version 7.22.0.
>=20
> I don't have any real knowledge of GSSAPI, so I'll refrain from
> commenting on that aspect. But I did notice one mechanical issue:
>=20

Me neither. I have just basic knowledge and I am not able to configure
virtual machine, which really need set delegation in libcurl (I need
just negotiation, which is in git possible, I guess since v2.8.0).

However, I discuss it with libcurl maintainer and he confirm that this
option can be required in some cases and this is what I need to do.
this already. I tested just setting of parameter in libcurl according
to description and nothing else seems broken. So anyone else who will
be able to test complete behaviour, where delegation is needed, is welcom=
ed.

[snip]
> We only declare the curl_deleg variable if we have a new-enough curl.
> But...
>=20
>> @@ -323,6 +335,10 @@ static int http_options(const char *var, const ch=
ar *value, void *cb)
>>  		return 0;
>>  	}
>> =20
>> +	if (!strcmp("http.delegation", var)) {
>> +		return git_config_string(&curl_deleg, var, value);
>> +	}
>> +
>=20
> ...here we try to use it regardless. I think you want another #ifdef,
> and probably to warn the user in the #else block (similar to what the
> http.pinnedpubkey code does).
>=20
> -Peff
>=20

You are right. Thanks. I sent new version of patch with fix.

Petr


--8wjjRsJpPMCSaeRmioiBX5w68mfQMCREB--

--Kq9aiEn4Nk8Cf16AL7HWTstVXI8pPdTF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX7AnDAAoJEPiGu5hNgNqPN6QP/2olXNmiCmOpFIffwEHVfLg0
wOT0TyUKcj22LA+zF4RAucnatPCx3zI1q+QqlDK+3RMGKgCeMqJa7Ff3DmWO6RZy
HhYdoZ52CHxK69X2SPFvFVGXtZuhxmQgsXFQKAjDPYERHMOdE/XAqKe+7ND6o+x1
1+/KaBOqnTutXaxrdyhAvrdPWNFSi6H/4q0D70DP/uVhLaOzBNbpRcT0K5l9ja02
tsdIlQR7QMY6ic1cWtbnmbQpkSu8ngXh5mZHu+3R4kSwUB9rG5jnSxBo5aTXmK1R
009b/0BPPsMmxSpCS1EJnupkyQDyEIWNosbjpWKfOuDGrKxEL+UA968D1vIRYGz0
dzW/FN1UPTQcXMhWzKIKcPFjSf7kwdAhabuKSKyyhDie86i9dHjY/gM3WP6AzjcY
iaGBP1iMkZ+stVUpf34Pm5lIM4fIoVJif7WeNNpZMlQrnoYmJ2rQROXO795WLsvz
LLWzQ4cg1GWVnJMjB6Y3BTxL9fSsDVee0+dDHkko59s798zgn2PS1jI2yhlADIpL
tAaQPGtR9iQy1hbt3MkzVs8rSYHk1OuObEn/xd0HH/mcULzqgYHqEeY7fXa965h/
2SEyBIRd7MN036j0qOOnXNhnAkkemR5IG41nelHbxe5YU9qDfuhXOnyuet9GNfA0
amjhAIS6B+/QqtrtGxld
=BZ2P
-----END PGP SIGNATURE-----

--Kq9aiEn4Nk8Cf16AL7HWTstVXI8pPdTF8--
