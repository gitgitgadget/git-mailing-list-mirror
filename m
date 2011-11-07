From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum member
Date: Mon, 7 Nov 2011 13:42:39 +0100
Message-ID: <CACBZZX6CRm1W5i43=LeXPJFdcWFgVTkD8cGntHoKsPoWGx_hNg@mail.gmail.com>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
 <1320581184-4557-4-git-send-email-avarab@gmail.com> <m2pqh5nvic.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 13:43:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNOXn-0000hG-2y
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 13:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350Ab1KGMnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 07:43:11 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46176 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322Ab1KGMnB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 07:43:01 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so3537283bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 04:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Wk4XBLeYgZ7RCF5NKIHThMLAP16wl1SdjMz9qW/CFVU=;
        b=VCAgpti/zvYabx0TTrCkAv9hasMVwqAmIEyxqVs/sfpOQhwjACk7vZcbmjzh/NKzBX
         OAPkyxFg3TBpcaBbC05ZXOiH4IrX2WhYpECCoGVJ+zSZgtCTlAErYadbDrXD+/sEWHXa
         E61faJKBwwnyCwr6jWp3AAMeutQNgtGFEcTTs=
Received: by 10.204.140.129 with SMTP id i1mr19059563bku.19.1320669780406;
 Mon, 07 Nov 2011 04:43:00 -0800 (PST)
Received: by 10.204.118.67 with HTTP; Mon, 7 Nov 2011 04:42:39 -0800 (PST)
In-Reply-To: <m2pqh5nvic.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184980>

On Sun, Nov 6, 2011 at 16:03, Andreas Schwab <schwab@linux-m68k.org> wr=
ote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Remove an "p->field < 0" comparison in grep.c that'll always be
>> false. In this case "p" is a "grep_pat" where "field" is defined as:
>>
>> =C2=A0 =C2=A0 =C2=A0 enum grep_header_field field;
>>
>> And grep_header_field is in turn defined as:
>>
>> =C2=A0 =C2=A0 enum grep_header_field {
>> =C2=A0 =C2=A0 =C2=A0 GREP_HEADER_AUTHOR =3D 0,
>> =C2=A0 =C2=A0 =C2=A0 GREP_HEADER_COMMITTER
>> =C2=A0 =C2=A0 };
>>
>> Meaning that this comparison will always be false.
>
> The underlying integer type is implementation-defined, and can be any
> signed or unsigned integer type that can represent all enumerations.

Yes, but as far as I can tell since we've done "=3D 0" there that
doesn't apply to us. To quote the ANSI C Standard (ANSI X3J11/88-090):

    3.5.2.2 Enumeration specifiers

    Syntax

              enum-specifier:
                      enum  identifier<opt> { enumerator-list }
                      enum  identifier

              enumerator-list:
                      enumerator
                      enumerator-list , enumerator

              enumerator:
                      enumeration-constant
                      enumeration-constant =3D constant-expression

    Constraints

       The expression that defines the value of an enumeration constant
    shall be an integral constant expression that has a value
    representable as an int.

    Semantics

       The identifiers in an enumerator list are declared as constants
    that have type int and may appear wherever such are permitted./52/ =
An
    enumerator with =3D defines its enumeration constant as the value o=
f the
    constant expression.  If the first enumerator has no =3D , the valu=
e of
    its enumeration constant is 0.  Each subsequent enumerator with no =
=3D
    defines its enumeration constant as the value of the constant
    expression obtained by adding 1 to the value of the previous
    enumeration constant.  (A combination of both forms of enumerators =
may
    produce enumeration constants with values that duplicate other valu=
es
    in the same enumeration.) The enumerators of an enumeration are als=
o
    known as its members.

       Each enumerated type shall be compatible with an integer type; t=
he
    choice of type is implementation-defined.

    Example

             enum hue { chartreuse, burgundy, claret=3D20, winedark };
             /*...*/
             enum hue col, *cp;
             /*...*/
             col =3D claret;
             cp =3D &col;
             /*...*/
             /*...*/ (*cp !=3D burgundy) /*...*/

    makes hue the tag of an enumeration, and then declares col as an
    object that has that type and cp as a pointer to an object that has
    that type.  The enumerated values are in the set {0, 1, 20, 21}.

I.e. we'll always have GREP_HEADER_AUTHOR =3D 0 and
GREP_HEADER_COMMITTER =3D 1, we'll never have GREP_HEADER_AUTHOR =3D an=
d
GREP_HEADER_COMMITTER =3D <some int>.
