From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/7] completion: fix expansion issues in __gitcomp_nl()
Date: Sat, 17 Nov 2012 20:28:06 +0100
Message-ID: <CAMP44s1zaxey7TQxGaLtaMUwPTVTmRBn1w6=Zqefy7FJzEepBw@mail.gmail.com>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
	<1353150353-29874-6-git-send-email-szeder@ira.uka.de>
	<CAMP44s1ZgNM1WXPu_-q9aFkz8Ui3czwcUqHWvs7Yspi_p9kuNQ@mail.gmail.com>
	<20121117141422.GI12052@goldbirke>
	<CAMP44s2YOshWkM9n2XxxLw79=-VF8U3Q4ta1D1zgHqWH30zOmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 17 20:33:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZo93-0003T1-H9
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 20:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab2KQT2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 14:28:08 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64216 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab2KQT2H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 14:28:07 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3773364oag.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 11:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7SpLQvNeN7ipiTdsKTMTNALwQsb4RR+12AhiLba5noQ=;
        b=kByBfzURAFI24bo62MWUMoueRrxr0k551ozr/9toc1TfDoni5bgVZs+LJFMxLzkIOj
         q5Uo38v1rya2EsfGk0Dz1mpw4bmD8Xbb6L1DA4dWpanLm3azJHI873xTIdGaY6CPvz7L
         sKtDkbzDE4qVFdAy0fWq7s/jZopnUuHGHDnpndPYlMovD012k+/EgkgtfcRamlBFVKk3
         7tG6U700nOHP2y/xOQGFQz22aM/RorNln8mz3WYukeEUvBR7M6hqHuPbwSWDeOW5mHF9
         7B42ZlP/38/S2dz/PdbaPFsW1KSijw/Xw/Mg35Pmj34eaZzqh8i45qgLHLUfgLvhAYNg
         OmCQ==
Received: by 10.60.1.163 with SMTP id 3mr6848244oen.30.1353180486490; Sat, 17
 Nov 2012 11:28:06 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 17 Nov 2012 11:28:06 -0800 (PST)
In-Reply-To: <CAMP44s2YOshWkM9n2XxxLw79=-VF8U3Q4ta1D1zgHqWH30zOmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209970>

On Sat, Nov 17, 2012 at 8:08 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Nov 17, 2012 at 3:14 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>> On Sat, Nov 17, 2012 at 12:50:39PM +0100, Felipe Contreras wrote:
>>> On Sat, Nov 17, 2012 at 12:05 PM, SZEDER G=C3=A1bor <szeder@ira.uka=
=2Ede> wrote:
>>>
>>> >  __gitcomp_nl ()
>>> >  {
>>> >         local IFS=3D$'\n'
>>> > -       COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- =
"${3-$cur}"))
>>> > +       COMPREPLY=3D($(awk -v pfx=3D"${2-}" -v sfx=3D"${4- }" -v =
cur=3D"${3-$cur}" '
>>> > +               BEGIN {
>>> > +                       FS=3D"\n";
>>> > +                       len=3Dlength(cur);
>>> > +               }
>>> > +               {
>>> > +                       if (cur =3D=3D substr($1, 1, len))
>>> > +                               print pfx$1sfx;
>>> > +               }' <<< "$1" ))
>>> >  }
>>>
>>> Does this really perform better than my alternative?
>>>
>>> +       for x in $1; do
>>> +               if [[ "$x" =3D "$3"* ]]; then
>>> +                       COMPREPLY+=3D("$2$x$4")
>>> +               fi
>>> +       done
>>
>> It does:
>>
>>   My version:
>>
>>     $ refs=3D"$(for i in {0..9999} ; do echo branch$i ; done)"
>>     $ time __gitcomp_nl "$refs"
>>
>>     real    0m0.109s
>>     user    0m0.096s
>>     sys     0m0.012s
>>
>>   Yours:
>>
>>     $ time __gitcomp_nl "$refs"
>>
>>     real    0m0.321s
>>     user    0m0.312s
>>     sys     0m0.008s
>
> Yeah, for 10000 refs, which is not the common case:

And this beats both in every case:

while read -r x; do
	if [[ "$x" =3D=3D "$3"* ]]; then
		COMPREPLY+=3D("$2$x$4")
	fi
done <<< $1

=3D=3D 1 =3D=3D
one:
real	0m0.004s
user	0m0.003s
sys	0m0.000s
two:
real	0m0.000s
user	0m0.000s
sys	0m0.000s
=3D=3D 10 =3D=3D
one:
real	0m0.005s
user	0m0.002s
sys	0m0.002s
two:
real	0m0.000s
user	0m0.000s
sys	0m0.000s
=3D=3D 100 =3D=3D
one:
real	0m0.005s
user	0m0.004s
sys	0m0.000s
two:
real	0m0.001s
user	0m0.000s
sys	0m0.000s
=3D=3D 1000 =3D=3D
one:
real	0m0.010s
user	0m0.008s
sys	0m0.001s
two:
real	0m0.004s
user	0m0.004s
sys	0m0.000s
=3D=3D 10000 =3D=3D
one:
real	0m0.061s
user	0m0.057s
sys	0m0.005s
two:
real	0m0.045s
user	0m0.044s
sys	0m0.000s
=3D=3D 100000 =3D=3D
one:
real	0m0.582s
user	0m0.575s
sys	0m0.022s
two:
real	0m0.487s
user	0m0.482s
sys	0m0.004s
=3D=3D 1000000 =3D=3D
one:
real	0m6.305s
user	0m6.284s
sys	0m0.216s
two:
real	0m5.268s
user	0m5.194s
sys	0m0.065s

--=20
=46elipe Contreras
