From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Thu, 18 Jul 2013 00:08:24 +0200
Message-ID: <51E715D8.9040307@googlemail.com>
References: <51E431F1.6050002@ramsay1.demon.co.uk> <51E4E0C0.3060604@viscovery.net> <20130716062122.GA4964@sigill.intra.peff.net> <6BDA2E3E7318418BBB2C19B475B2B118@PhilipOakley>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE44D61982B49C6441AA2ECBE"
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Jul 18 00:08:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzZtf-0003Hl-N0
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 00:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406Ab3GQWI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 18:08:27 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:33728 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab3GQWI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 18:08:27 -0400
Received: by mail-ee0-f50.google.com with SMTP id d49so1347979eek.9
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=uk+SuyzBuu8zBFI8h/91r4nODgON9vzjljV01w2u8mQ=;
        b=YI3jgblmJmQ2zuefX3R784l+u970FgamBuZc5mRCWNueqtLFOtVTrTPG0gE1EOS51l
         wbyldi4+8Rmy3nIFwoMnIBrvzDxAn0mXfrXY5bz8tvoQoHcPnbRZiAi3OvsuLD/AVb1e
         /d14RjvJ5IkjaLfSkoGAerjaGDhjVzBtQ+Ixd4CWwEsEgbUSqbTXCce1z1Z4yeqoB9IG
         y2QCT8jA46iRIMG2Q+BX1B6zxcBCutbD5hNObOooGYiYvYvsmUCFUjpbmSpm+dztHGue
         esd1BlFCLTT/TxQUGP9tIzn6jBla+5ftQM/uoq+uGqcw6H5HRF85v4f2IojyhwDt/vb5
         Q98Q==
X-Received: by 10.14.176.68 with SMTP id a44mr8369254eem.31.1374098905570;
        Wed, 17 Jul 2013 15:08:25 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id w43sm14202541eez.6.2013.07.17.15.08.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 15:08:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <6BDA2E3E7318418BBB2C19B475B2B118@PhilipOakley>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230658>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE44D61982B49C6441AA2ECBE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/16/2013 10:53 PM, Philip Oakley wrote:
>=20
> Does anyone run the "new static checker called 'Stack' that precisely
> identifies unstable code"? [though the paper's conclusion says 'All
> Stack source code will be publicly available.' which suggests it's not
> yet available]
>=20

So I started using the clang code analyzer on git. One of the=20
first warnings actually is this:

object.c:241:7: warning: Branch condition evaluates to a garbage value
                if (!eaten)

So that part of object.c lookx like this:
	struct object *parse_object(const unsigned char *sha1)=20
	{
		int eaten;
		...
		obj =3D parse_object_buffer(sha1, type, size, buffer, &eaten);
		if (!eaten)
			free(buffer);
	}

And the parse_object_buffer looks like this with respect to the eaten=20
variable:
	struct object *parse_object_buffer(...)
	{
		int eaten =3D 0;
		if (something)
			return NULL;
		...
		if (something_different)
			eaten=3D1;
		*eaten_p =3D eaten;
	}

So what might happen is, that parse_object_buffer exits early, without
executing=20
=09
	*eaten_p =3D eaten;

Then in the parse_object function eaten was never initialized nor set=20
inside the call to parse_object_buffer. Then it is obvious that the
free(buffer) is executed depending on garbage left on the stack.
Definitely something what we want to change.

The obvious way to repair this would be to just initialize the eaten vari=
able
inside parse_object.
	struct object *parse_object(const unsigned char *sha1)=20
	{
		int eaten=3D0;
		...

However I'd like to propose another solution:
In parse_object_buffer we do not have a local eaten variable, but
directly write to *eaten_p. That would be the following patch.

Was there a particular idea or goal behind first having a local eaten
variable, which later near the correct return of the function was used to=
 set the=20
eaten_p?

Thanks,
Stefan




--------------enigE44D61982B49C6441AA2ECBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR5xXYAAoJEJQCPTzLflhq57cQAJeEcF0iW3Aa770kl60ApcVZ
eJrrjPLokKaaOJ6CD/KLWOZcI88C6apmegJIwLc0G2NPeNY/Zj9wc79bnzrD9pPj
v9i8SyEA7leeZRGEcjqnuH8LEkULR5akgUHDtuwmsofoT7bDy4aprcox+9mMrJU+
fTG/YlAz/A64ruWjyfij6/O6+QOxk+8lcVynL14n/bhIAN5ozpWx3vHBDW3IPXFw
aRT6rvcgllT1brcdMg9LO6c0qpjIyc8qie3QzRMch07LMEy/qT0qKODkMEoXBz2z
FI2Y7hUGMzl2UsPTI4z+18FmKWAQd/sE/lZNlZmrr8bB2sxo3HxiBpE+4C8BzMh3
aFQ2bIk6G2iTNIQAnOaOStU49mjL3I6uDdnoJ96oMvko4t+CLFgKvug8Mpt/IWDU
WwauwZEmiJrRBwXvlwguKXXfmV6mCeIIPUUY8lrqMWu0VbaAajp4S6Lnj0aEn/D1
RPAndQM1AU6RkHH0GTRKO20WQsAlJCYQT+VtMVxi5r6JbhXjMmXGnYlX7K25oN4/
2k0KsECNoqIEgwZeYizBgn9o6UqOvLvWW9q/GY6wJV4Kb1cdnkoN7UAKxDk+9/Bd
w8/NkpxkqMR5RgTwnt+ll7qLnibC3QTaMwgYpbv0fKe3DXWmi2XJdxjty6Qd2/k7
3/W+KC1cfawS0rUTbSsX
=D1Ez
-----END PGP SIGNATURE-----

--------------enigE44D61982B49C6441AA2ECBE--
