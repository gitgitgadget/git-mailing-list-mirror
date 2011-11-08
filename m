From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] Fix code issues spotted by clang
Date: Tue, 8 Nov 2011 09:05:57 -0700
Message-ID: <CABPp-BFm-BYPuGzp4hpH2ub_GBLWcZMKt8=rOR683_-+HFbb5A@mail.gmail.com>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
	<CACBZZX7bzFy_NCr4RTpYXXVmieaV7GrBfJgwdtCT1SwoXV_cGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Martin Waitz <tali@admingilde.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 17:06:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNoBZ-0007zl-3N
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 17:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087Ab1KHQF7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 11:05:59 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53201 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158Ab1KHQF7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2011 11:05:59 -0500
Received: by faan17 with SMTP id n17so660778faa.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 08:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=BoSEP7mnxz1V+maqkgEE3kz32x5onWx/VCl4zA8q8Kc=;
        b=iOmsHKAIHL7C8PY2h7gfkeO0Z4cdVXphQP5Jup8JiUiLVYRLdTCWB86iVSnL2gB85w
         coG7wKkX4f+4UkT5Cgg90sS/8hndnCbjGoBy8FB6e425OGavbzAKBydIWLHKT8T6hXsW
         vphipBMNZRoyI34dstqJoB/cVnzC8vRyN3Zl8=
Received: by 10.223.75.15 with SMTP id w15mr55964528faj.9.1320768357820; Tue,
 08 Nov 2011 08:05:57 -0800 (PST)
Received: by 10.223.88.215 with HTTP; Tue, 8 Nov 2011 08:05:57 -0800 (PST)
In-Reply-To: <CACBZZX7bzFy_NCr4RTpYXXVmieaV7GrBfJgwdtCT1SwoXV_cGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185091>

On Sun, Nov 6, 2011 at 5:33 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> =C2=A0 =C2=A0"builtin/fast-export.c", line 54: warning: enum type mis=
match: op "=3D"
>
> This seems to me to be a legitimate issue we introduced in
> 2d8ad46919213ebbd7bb72eb5b56cca8cc3ae07f, Elijah?
>
> We're defining an enum like this:
>
> =C2=A0 =C2=A0static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_=
mode =3D ABORT;
> =C2=A0 =C2=A0static enum { ERROR, DROP, REWRITE } tag_of_filtered_mod=
e =3D ABORT;
>
> And then doing:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unset || !strcmp(arg, "abort"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tag_of_filtere=
d_mode =3D ABORT; <-- Line 54
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (!strcmp(arg, "drop"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tag_of_filtere=
d_mode =3D DROP;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (!strcmp(arg, "rewrite"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tag_of_filtere=
d_mode =3D REWRITE;
>
> Presumably that assignment should be "=3D ERROR".

Looking back at that patch, "abort" was the word that made the most
sense in the documentation and I was trying to make the code match.
Unfortunately, that would result in "ABORT" being redefined (to the
same value) so to squelch the compiler error I just went with the
quick hack of changing "ABORT" in the enum definition to "ERROR", but
didn't change "ABORT" later since "it had the same value anyway".
Yeah, not the safest programming practice.

I probably should have just used FILTERED_TAG_ABORT and changed the
signed_tag_mode enum to use SIGNED_TAG_ABORT (and then changed all
references to "ABORT" to match one of those two)...or maybe somehow
come up with a combined enum used for both (though WARN would only be
useful fo signed_tag_mode, REWRITE would only be useful for
tag_of_filtered_mode, etc.).
