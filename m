Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7105020193
	for <e@80x24.org>; Wed, 26 Oct 2016 09:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbcJZJlG (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 05:41:06 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:50273 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752198AbcJZJlF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 05:41:05 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Oct 2016 05:41:05 EDT
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Wed, 26 Oct 2016 11:35:59 +0200
  id 00000000000000A0.00000000581078FF.000045D4
Date:   Wed, 26 Oct 2016 11:35:58 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
Message-ID: <20161026093558.drsdwn2hm7bbcktt@ruderich.org>
References: <20161022233225.8883-1-sbeller@google.com>
 <20161022233225.8883-28-sbeller@google.com>
 <alpine.DEB.2.20.1610261049470.3264@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="=_zucker.schokokeks.org-17876-1477474559-0001-2"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610261049470.3264@virtualbox>
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-17876-1477474559-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 26, 2016 at 10:52:23AM +0200, Johannes Schindelin wrote:
> diff --git a/attr.c b/attr.c
> index d5a6aa9..6933504 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -50,7 +50,16 @@ static struct git_attr *(git_attr_hash[HASHSIZE]);
>  #ifndef NO_PTHREADS
>
>  static pthread_mutex_t attr_mutex;
> -#define attr_lock()pthread_mutex_lock(&attr_mutex)
> +static inline void attr_lock(void)
> +{
> +	static int initialized;
> +
> +	if (!initialized) {
> +		pthread_mutex_init(&attr_mutex, NULL);
> +		initialized =3D 1;
> +	}
> +	pthread_mutex_lock(&attr_mutex);
> +}

This may initialize the mutex multiple times during the first
lock (which may happen in parallel).

pthread provides static initializers. To quote the man page:

    Variables of type pthread_mutex_t can also be initialized
    statically, using the constants PTHREAD_MUTEX_INITIALIZER
    (for fast mutexes), PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
    (for recursive mutexes), and
    PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP (for error checking
    mutexes).

Regards
Simon
--=20
+ Privatsph=E4re ist notwendig
+ Ich verwende GnuPG http://gnupg.org
+ =D6ffentlicher Schl=FCssel: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-17876-1477474559-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYEHj+AAoJEJL+/bfkTDL55CIP/2dABUdOoEH45vP8BFUTLNPc
OJJsbLFQiAD8dw+GiLDHqnxVaAwgIU9X0d88ozKqdqQIi7cnZn0ONX6GS7bb6IjN
1C4Zdn4WJvQFcx4LiXxJRtWYLfYUe19V3D/4jaVj5Mldmo6eL+4STS+BIUP4XPxj
3KxA9Nq4Qf3crU/aDnixOdwmxx/TpIFIfnTMkkB7ddsv69SPtJRPUcgIrGsFqAGm
MBAHN10yQFccMmzl7ZFaNbM+0ElNEcSsrJ8M2Tgy+PCj0f0TK917ccj86/bUHCiw
mIkHQeF6EUP4fNztQ9insWLfc4iH+cUj9sHzZX/N/nBPFIjoKuSAZhTeW3XeMFBl
X0CJ1YqeuuGY/kTRQYfoPpvE1xtzzsF0QqwHgg/2Ft2oothQotjnasdAZGsJ4pFW
8rKro0JbBm9abmbJ6/by6CZT+j9wZbvZLZgW0KXdzWQfsEQNUE4sxPwGeOIesE6f
3SMMiFqiqUOGR2dkxTcPoQX8V1/R1mtiAhHjAiRGT9APY8WHZ8V8xRxDY1mKrYZF
/SPI30soeO7NFgb45MJLsoTyPLplCvCQ5rThz+33vG4iRBF/8vIIc20WX/U0bmuE
QSxXdNv1qNyFZCa9Ygi706RAzf+gyHI8vpYLbhbiRpxHSYJtO9X+Xpy1YA053KAZ
IteKrJGMGUSgB1C0E2Z1
=ly3M
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-17876-1477474559-0001-2--
