From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] send-email: Don't leak To: headers between patches
Date: Mon, 4 Oct 2010 07:25:47 +0000
Message-ID: <AANLkTinnd-ZTqfKvEaDQ6o-gR2oAmvEChSpDps5T0Xsu@mail.gmail.com>
References: <a9b17bd454e57abb75f6cd2a7da63ec7738f5e7b.1286170305.git.viresh.kumar@st.com>
	<1286175924-15761-1-git-send-email-bebarino@gmail.com>
	<AANLkTimuP8Myj-PAU76hjtWdOkbzg2WrZwaFNOxRqfsM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Viresh Kumar <viresh.kumar@st.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Joe Perches <joe@perches.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:25:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fQn-0003qI-KG
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114Ab0JDHZs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 03:25:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54221 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab0JDHZr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 03:25:47 -0400
Received: by iwn5 with SMTP id 5so6566562iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 00:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bs1DGUDUxVAZzeu1p79KCf7aumbwjbJEF3gZ9vrkDx0=;
        b=LxZ74yriJrvWUKVxqjzmiSq0bBWVjx8z8nspqVHVFmxen9qe0eOl9CgAd7vg9BQn5V
         iLAoK7wWxsG80HhhuRNgaWGqVccAdm7xQv+FI4CQmR0/Myd8Q1wRgfr4sMfrISYxITgE
         S7xcJK3PxZlRiuLgkGQqurM0ngIlPG/xtPFAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pkAPlj407BNm57nyyGP6MAc2E1XFzWaLV1r4Vtt8n0WOT7eIDLk6yyyajSN4yehdQt
         CIe8CYz8/0ORN8GEXafMRzvvi6ajnSYUFfyMSoJaoQpToJwejQ/lwNQeoVMdAOhjWb8V
         Pihj51CP5tTPVT+7Hi5BAGQ3PPWmcXrjakqkI=
Received: by 10.231.162.13 with SMTP id t13mr9674831ibx.160.1286177147359;
 Mon, 04 Oct 2010 00:25:47 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 4 Oct 2010 00:25:47 -0700 (PDT)
In-Reply-To: <AANLkTimuP8Myj-PAU76hjtWdOkbzg2WrZwaFNOxRqfsM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157998>

On Mon, Oct 4, 2010 at 07:15, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On Mon, Oct 4, 2010 at 07:05, Stephen Boyd <bebarino@gmail.com> wrote=
:
>> If the first patch in a series has a To: header in the file and the
>> second patch in the series doesn't the address from the first patch =
will
>> be part of the To: addresses in the second patch. Fix this by treati=
ng the
>> to list like the cc list. Have an initial to list come from the comm=
and
>> line, user input and config options. Then build up a to list from ea=
ch
>> patch and concatenate the two together before sending the patch. Fin=
ally,
>> reset the list after sending each patch so the To: headers from a pa=
tch
>> don't get used for the next one.
>
> Couldn't this whole thing be done by:
>
>> =C2=A0# Variables we fill in automatically, or via prompting:
>> -my (@to,$no_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
>> +my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,=
@xh,
>
> Changing this to an "our" variable instead of a "my".
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0my $body_encoding;
>> + =C2=A0 =C2=A0 =C2=A0 @to =3D ();
>
> Then doing:
>
> =C2=A0 =C2=A0local @to =3D @to;
>
>> + =C2=A0 =C2=A0 =C2=A0 @to =3D (@initial_to, @to);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0@cc =3D (@initial_cc, @cc);

Small brainfart, you don't have to change it to an "our" and use
"local", you can just use "my" in that for-loop:

    $ perl -E 'my @a =3D qw(a b); { my @a =3D (@a, "c"); say "@a" } say=
 "@a"'
    a b c
    a b

That's a much better solution IMO than the C-like usage of two
variables. Lexical shadowing is exactly for this sort of thing.
