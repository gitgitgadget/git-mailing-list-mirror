From: Grant Olson <kgo@grant-olson.net>
Subject: Re: PATCH:  Less fragile lookup of gpg key
Date: Sun, 02 May 2010 22:09:25 -0400
Message-ID: <4BDE3055.9010602@grant-olson.net>
References: <4BDC45EB.8090305@grant-olson.net>	<4BDC561B.4030307@gmail.com>	<7vhbmr5ym4.fsf@alter.siamese.dyndns.org>	<4BDC63FB.7060202@grant-olson.net>	<7v7hnn4cun.fsf@alter.siamese.dyndns.org> <m1O8k0Z-000kndC@most.weird.com>
Reply-To: kgo@grant-olson.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDE286DE3A2328A18A2947A47"
Cc: "Greg A. Woods" <woods@planix.com>
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 03 04:10:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8l6l-000433-P5
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 04:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664Ab0ECCJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 22:09:57 -0400
Received: from mail-qy0-f189.google.com ([209.85.221.189]:36912 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab0ECCJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 22:09:57 -0400
Received: by qyk27 with SMTP id 27so5263717qyk.23
        for <git@vger.kernel.org>; Sun, 02 May 2010 19:09:56 -0700 (PDT)
Received: by 10.224.113.34 with SMTP id y34mr2702567qap.173.1272852595860;
        Sun, 02 May 2010 19:09:55 -0700 (PDT)
Received: from [192.168.1.182] (pool-71-182-218-69.pitbpa.east.verizon.net [71.182.218.69])
        by mx.google.com with ESMTPS id 23sm2824382qyk.11.2010.05.02.19.09.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 19:09:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <m1O8k0Z-000kndC@most.weird.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146214>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE286DE3A2328A18A2947A47
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 5/2/2010 8:59 PM, Greg A. Woods wrote:
> At Sat, 01 May 2010 12:54:24 -0700, Junio C Hamano <gitster@pobox.com> =
wrote:
> Subject: Re: PATCH:  Less fragile lookup of gpg key
>>
>> If I have two keys like these:
>>
>>     Junio C Hamano <gitster@pobox.com>
>>     Junio Hamano <gitster@pobox.com>
>=20
> I'm not an expert on PGP internals or such, but I think that's a really=

> bad thing to do.  I'm surprised you were able to get gpg to do it in th=
e
> first place.  I would have hoped it wouldn't allow it.  As far as I can=

> tell it's _not_ compatible with other implementations of PGP.
>=20
> PGP keys normally are searched by the e-mail portion only.  All the
> other stuff (comments and the display name, etc.) is for decoration
> only.  This is just as it is in e-mail routing too of course.
>=20
> You can of course have more than one e-mail address per key, but you
> should NEVER have more than one key per e-mail.
>=20
> I.e. it's less reliable in the first place to have two different keys
> which can be found using the same e-mail address.
>=20

This might be getting a little off-topic for the git list, but...

It's a weird thing to do, which is why I didn't account for it in the
original patch, but the RFC doesn't have any specific requirements
regarding what a UID is:

5.11. User ID Packet (Tag 13)

   A User ID packet consists of UTF-8 text that is intended to represent
   the name and email address of the key holder.  By convention, it
   includes an RFC 2822 [RFC2822] mail name-addr, but there are no
   restrictions on its content.  The packet length in the header
   specifies the length of the User ID.

Ultimately the key ID is the unique identifier, so there's nothing
technically wrong with creating multiple keys with the same email.  It
will cause some email clients to flip out, but that's a non-issue with
git tags.

But if someone is a regular user of OpenPGP, and they get two signatures
from the same email address with different keys, the assumption is going
to be that at least one of them is a forgery.  Maybe the keys are
cross-signed if, for example, someone is phasing out an old 1024-bit key
with a new 2048-bit one.  But that's still going to raise a few
eyebrows.  And even in that case, you still probably want to sign
everything with the same key.

If you look at any day-to-day usage of gpg, or examples posted around,
they're almost always going to just pass an email address only with the
-u flag, if they use the -u flag at all.  I don't think you're going to
find any examples or tutorials that suggest you type:

gpg -u "Junio Hamano <gitster@pobox.com>" --armor --sign file.txt

they'll all use:

gpg -u gitster@pobox.com --armor --sign file.txt

And normally a user wouldn't even use the -u flag to begin with.  They
would just go with the default secret key on your keyring.  But that
might have a different email address than your git settings, so it does
make sense to use -u within git.

I personally think that using multiple keys with the same UID falls into
the 'advanced user' category, where you can expect the advanced user to
figure out how to deal with the exceptional usage, and have the defaults
set out to cover the general case.

But all that being said, I don't have a problem with the proposed
solution of falling back to a straight email search after the username +
email search fails.

--=20
Grant

"Can you construct some sort of rudimentary lathe?"


--------------enigDE286DE3A2328A18A2947A47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJL3jBcAAoJEP5F5V2hilTWmuQH/R/9wBXs2aRkdqKcHEAPohkx
d7iJr3hHa8dHfmfLnTKfUwrz7fz72mVbjnjeNaGuh+T6yZZVxlCZ1Vqscx1t2UoE
uwP7QbCqJ1mooyZ7Vrx+OKp41DJzdIeMMvOtUEGm6V3EksOYeRKDLWRLZSACk8x+
KQmvEhNFLFWMmX+DRSSDr4DQ2U8YFT1g4XSyuSielBA6F1uMSApGJkFE7qt+Vhs9
fBq4dwUrv8zhxu8XW11ZGoURDUdy9Pz7pUlIjhV/+Zv10LHKml74Hh8jd7hcI2Gy
W7XR9uzYQwtIqk5nlVlEuxGqAgbnuo0eqldPCS1D8LZXNPnwHnhlIA4MwGOZvOs=
=ZOiJ
-----END PGP SIGNATURE-----

--------------enigDE286DE3A2328A18A2947A47--
