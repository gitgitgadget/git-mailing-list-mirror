From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Thu, 15 Aug 2013 09:53:08 +0200
Message-ID: <520C88E4.2040107@googlemail.com>
References: <520BAF9F.70105@googlemail.com> <1376497661-30714-1-git-send-email-stefanbeller@googlemail.com> <7vli44td9k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF349A667EC6B5779321277BE"
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	pclouds@gmail.com, iveqy@iveqy.com, apelisse@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 09:53:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9sMp-0000VX-NS
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 09:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760482Ab3HOHxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 03:53:06 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35064 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab3HOHxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 03:53:04 -0400
Received: by mail-wi0-f173.google.com with SMTP id en1so2838127wid.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 00:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=lWVO2NGZG9uTIGOOh86Y2grHyMKmzNAIze/tfylBquY=;
        b=uyhdRluAQUH2yNkeBSGKiOQ1ZYjIlxfWlHv8JcubqSqQhPi1vcY7Nrk4X5neTHmJcA
         MHikSSy13ipi9BxkF1qkuHJygtl7008EUcJt/AVT90aQW/LEy/buvovfn1sNTjfrDzmC
         MuA8s+rzw3fkjy9KJlJvezc0YuxPAeiWFSrLPEKLfvGIzDZiW+ScHND0/LZvLXm+BpDh
         zS/xj7PWXWczPFq6z8tKvONkXdsLM8yI9UYp5QkVPRIX+yfXVAzoHLksqDz1MYrR540m
         KCYho75oZ3bVVmHXEPWZz7zWbj9yJTmTDx4mUYERHw4EQUJTCH25R746ywVb3y4GXozl
         569g==
X-Received: by 10.194.48.74 with SMTP id j10mr34614wjn.41.1376553182477;
        Thu, 15 Aug 2013 00:53:02 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id li9sm1348047wic.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 00:53:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <7vli44td9k.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232336>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF349A667EC6B5779321277BE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/14/2013 07:04 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> diff --git a/builtin/repack.c b/builtin/repack.c
>> new file mode 100644
>> index 0000000..d39c34e
>> --- /dev/null
>> +++ b/builtin/repack.c
>> @@ -0,0 +1,410 @@
>> +/*
>> + * The shell version was written by Linus Torvalds (2005) and many ot=
hers.
>> + * This is a translation into C by Stefan Beller (2013)
>> + */
>> +
>> +#include "builtin.h"
>> +#include "cache.h"
>> +#include "dir.h"
>> +#include "parse-options.h"
>> +#include "run-command.h"
>> +#include "sigchain.h"
>> +#include "strbuf.h"
>> +#include "string-list.h"
>> +
>> +#include <sys/types.h>
>> +#include <unistd.h>
>> +#include <stdio.h>
>> +#include <dirent.h>
>=20
> If you need these system-includes here, it means that our own
> platform-portability layer "git-compat-util.h" is broken.  On
> various systems, often some system header files are missing, need a
> few feature macros to be defined before including, and/or need to be
> included in certain order, etc., and "git-compat-util.h" is meant to
> hide all such details from the programmers.
>=20
> I do not think the above four needs to be included in *.c, as long
> as you include either builtin.h or cache.h, both of which includes
> the compat-util header.
>=20

Thanks. It works without these includes as well. I think I got those
includes before I realized there is so much infrastructure already
available and I forgot to remove these includes once I added the
others.




--------------enigF349A667EC6B5779321277BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSDIjkAAoJEJQCPTzLflhqE+cQAO6kkqO6BD6uXMukL7cG3R8L
d6S52RQAkbhWEHxVu9b8ftVY3HC7upL0PeeFkkFMPt0uUnVoDka/+tLfKdEJjqnv
iIxFBar9aNDspl3PWBxt1mZVAZIlMmeuWtgTU0OWpFTR2KnH3v8g0JkigI6/rz1b
qdsBndDITg9bpBGRQYRDHUVLWCQXACFk9jnVTiXf3PfXO/QhnR+CzIrBRu3VqVXn
I9G0hGuwGqFXL2C82wfWcU1bZC+DiQ77Ty5uY67kQl/w0bgPbo3n1+lmF8ibm+vB
clQ3i40WrtAA7hh9eDWT64P47fa5KKlB3OkNk2uSOrzKDdDDvaqwHHwMO8Hn7qIq
RUWm5t8esAHyq7tWIQDyh2P2Re7sJEeY7t5dojbUIW2ydbEwa4L0t4aMNGP9TLdy
yHIQfVQiSaf+aiU9TFfaBw4mdOEo93ZjLl1AM6lu7EzlRjQ2YXQDI2ntFCVPCD8p
BWQnM/DQsnIqE4vfMRL4i4Q+fha14eNZ5ASdastK/Bt4Y8P7YtPTZR1NUtAWdtmr
stdEEL/3j1zC6RBw6ZhoW91/Oh4e4EV0aXtQ83vT0d7Ol9PDkeQKxjPiOLkoKZO/
ZhjOTnw8B20oxERpm40eUr2wFmw44Q4UUXsn/NL+tTsiwWnbiupkg5q/NEAleLaJ
yBYrgE9A6GaxqqL9RPea
=NCfA
-----END PGP SIGNATURE-----

--------------enigF349A667EC6B5779321277BE--
