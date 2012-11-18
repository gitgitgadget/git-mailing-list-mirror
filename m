From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/7] completion: fix expansion issues in __gitcomp_nl()
Date: Sun, 18 Nov 2012 01:55:26 +0100
Message-ID: <CAMP44s22aG65Tvg3y7ZSEKqJy+Xuvwt_1BjSBV7vqOz+vgzg3g@mail.gmail.com>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
	<1353150353-29874-6-git-send-email-szeder@ira.uka.de>
	<CAMP44s1ZgNM1WXPu_-q9aFkz8Ui3czwcUqHWvs7Yspi_p9kuNQ@mail.gmail.com>
	<20121117141422.GI12052@goldbirke>
	<CAMP44s2YOshWkM9n2XxxLw79=-VF8U3Q4ta1D1zgHqWH30zOmw@mail.gmail.com>
	<CAMP44s1zaxey7TQxGaLtaMUwPTVTmRBn1w6=Zqefy7FJzEepBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 01:55:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZtAj-0003wQ-14
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 01:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab2KRAz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 19:55:27 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35659 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab2KRAz1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 19:55:27 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3885420oag.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 16:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=59bzBxI4iF6w34Gyjmkebz+HrvVuXOfN2U0H/ms5OKI=;
        b=aGn0lorBVmiVXDE9/txXxExrM5p17KhTT3TS9fQvl4J+/fSdPY0d5A4VBmB3Pdxqhk
         YrWuDjT6uinl8dRCW3WYpMY68ppoPyneelkfDmqYWVpio9R2BLiJvDnuzqeR3mS/SyTf
         wh7mE13sUJyDIP3biVN14FEVEQQbKHBvaOz+vJn9jv4LGpJ6CNjNBpJ5D2hKIobNmAD0
         TJ3CMLEZJ6JmEsJW0SjuFtULtOiq1IdFOAg6r/Yx0yii6wAflMENpvd/CnSauiUyDOee
         xFbk41+OIz4oWrcFoHdIEoTH2HteXHzlGUiwEGEWyIZu9zSjCtZynZH/mYipu/OPUMJB
         8wsg==
Received: by 10.182.52.105 with SMTP id s9mr7391739obo.25.1353200126537; Sat,
 17 Nov 2012 16:55:26 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 17 Nov 2012 16:55:26 -0800 (PST)
In-Reply-To: <CAMP44s1zaxey7TQxGaLtaMUwPTVTmRBn1w6=Zqefy7FJzEepBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209988>

On Sat, Nov 17, 2012 at 8:28 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Nov 17, 2012 at 8:08 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sat, Nov 17, 2012 at 3:14 PM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:
>>> On Sat, Nov 17, 2012 at 12:50:39PM +0100, Felipe Contreras wrote:
>>>> On Sat, Nov 17, 2012 at 12:05 PM, SZEDER G=C3=A1bor <szeder@ira.uk=
a.de> wrote:
>>>>
>>>> >  __gitcomp_nl ()
>>>> >  {
>>>> >         local IFS=3D$'\n'
>>>> > -       COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" --=
 "${3-$cur}"))
>>>> > +       COMPREPLY=3D($(awk -v pfx=3D"${2-}" -v sfx=3D"${4- }" -v=
 cur=3D"${3-$cur}" '
>>>> > +               BEGIN {
>>>> > +                       FS=3D"\n";
>>>> > +                       len=3Dlength(cur);
>>>> > +               }
>>>> > +               {
>>>> > +                       if (cur =3D=3D substr($1, 1, len))
>>>> > +                               print pfx$1sfx;
>>>> > +               }' <<< "$1" ))
>>>> >  }
>>>>
>>>> Does this really perform better than my alternative?
>>>>
>>>> +       for x in $1; do
>>>> +               if [[ "$x" =3D "$3"* ]]; then
>>>> +                       COMPREPLY+=3D("$2$x$4")
>>>> +               fi
>>>> +       done
>>>
>>> It does:
>>>
>>>   My version:
>>>
>>>     $ refs=3D"$(for i in {0..9999} ; do echo branch$i ; done)"
>>>     $ time __gitcomp_nl "$refs"
>>>
>>>     real    0m0.109s
>>>     user    0m0.096s
>>>     sys     0m0.012s
>>>
>>>   Yours:
>>>
>>>     $ time __gitcomp_nl "$refs"
>>>
>>>     real    0m0.321s
>>>     user    0m0.312s
>>>     sys     0m0.008s
>>
>> Yeah, for 10000 refs, which is not the common case:
>
> And this beats both in every case:
>
> while read -r x; do
>         if [[ "$x" =3D=3D "$3"* ]]; then
>                 COMPREPLY+=3D("$2$x$4")
>         fi
> done <<< $1

Nevermind that.

Here's another:

	local IFS=3D$'\n'
	COMPREPLY=3D($(printf -- "$2%s$4\n" $1 | grep "^$2$3"))

--=20
=46elipe Contreras
