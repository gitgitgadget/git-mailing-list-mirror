From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 12:30:18 +0200
Message-ID: <CAMP44s2PsSj=mTZMtkteHnycqEXgO7YQeJzSuH9T734pFQiJMQ@mail.gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-2-git-send-email-felipe.contreras@gmail.com>
	<7v8vkperli.fsf@alter.siamese.dyndns.org>
	<7v4nvdeo23.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 11:30:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RroVF-0008IC-9T
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 11:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742Ab2A3KaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 05:30:20 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39227 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751097Ab2A3KaT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 05:30:19 -0500
Received: by lagu2 with SMTP id u2so2089886lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 02:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=H7ZIaXGy1OY0NgMqS/cFXyH04DKLQe7nbqEWZWxoYpY=;
        b=WgEPDTMf9ZUgX2f6uU+bBWIAh90a4dBC3pYOi7fjgezUSzkNyrKDAbj6wMbDOLAJPZ
         gK7s72MQcUxepB8tnWw68S7n8uic57YID7GdYum/m6+Nr/ntiHdChm/xJugSo0QcXYjM
         C5wz2r6JNcQe2PfDecXz8cT2+hw6tNI8iHom8=
Received: by 10.152.147.103 with SMTP id tj7mr8909319lab.3.1327919418284; Mon,
 30 Jan 2012 02:30:18 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 02:30:18 -0800 (PST)
In-Reply-To: <7v4nvdeo23.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189335>

On Mon, Jan 30, 2012 at 7:50 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Avoiding zsh's bug that cannot use conditional assignment on the no-=
op
>> colon command (if the bug is really that; it is somewhat hard to ima=
gine
>> if the bug exists only for colon command, though) *is* by itself a g=
ood
>> justification for this change, even though the resulting code is har=
der to
>> read for people who are used to read shell scripts.
>
> Just from my curiosity, I am wondering what zsh does when given these=
:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bar () { echo "frotz nitfol xyzzy" }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unset foo; : ${foo:=3D$(bar)}; echo "<$?,$=
foo>"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unset foo; true ${foo:=3D$(bar)}; echo "<$=
?,$foo>"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unset foo; echo >/dev/null ${foo:=3D$(bar)=
}; echo "<$?,$foo>"

<0,frotz nitfol xyzzy>
<0,frotz nitfol xyzzy>
<0,frotz nitfol xyzzy>

And that's _without_ bash emulation.

BTW. That code didn't work for me in bash (though it did in zsh), I
had to add a semicolon:

 bar () { echo "frotz nitfol xyzzy" ;}

> The first one is exactly your "And yet another bug in zsh[1] causes a
> mismatch; zsh seems to have problem emulating wordspliting, but only =
when
> the ':' command is involved.", so we already know it "seems to have
> problem emulating word-splitting" (by the way, can we replace that wi=
th
> exact description of faulty symptom? e.g. "does not split words at $I=
=46S"
> might be what you meant but still when we are assigning the result to=
 a
> single variable, it is unclear how that matters).

That's not the problem, the problem is that this doesn't work in zsh:

array=3D"a b c"
for i in $array; do
 echo $i
done

The result is "a b c". Unless sh emulation is on. This is the correct
way in zsh:

array=3D"a b c"
for i in ${=3Darray}; do
 echo $i
done

But this behavior can be controlled with SH_WORD_SPLIT.

Anyway, as I said, the problem is that the ':' have some problems, and
sh emulation seems to be turned off inside such command, or at least
SH_WORD_SPLIT was reset in my tests.

--=20
=46elipe Contreras
