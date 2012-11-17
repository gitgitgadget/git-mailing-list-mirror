From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/7] completion: fix expansion issues in __gitcomp_nl()
Date: Sat, 17 Nov 2012 20:08:07 +0100
Message-ID: <CAMP44s2YOshWkM9n2XxxLw79=-VF8U3Q4ta1D1zgHqWH30zOmw@mail.gmail.com>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
	<1353150353-29874-6-git-send-email-szeder@ira.uka.de>
	<CAMP44s1ZgNM1WXPu_-q9aFkz8Ui3czwcUqHWvs7Yspi_p9kuNQ@mail.gmail.com>
	<20121117141422.GI12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 17 20:08:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZnkj-0006RT-1X
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 20:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056Ab2KQTIJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 14:08:09 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63458 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab2KQTII convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 14:08:08 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3783948obb.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 11:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=s93LotZJGQxPHMocqS1BbdBpZBNmKKFFfLcrzSGEsos=;
        b=zSYr7QydpWCUbo+UysskV1EHqRAEnxhPdFeYl5O0apA3qdGQ/DIDGs0BiKu5HVOI0Y
         7o9rkvGZfGQn/2RXG3LjUzBhRF6hXsppztaDF+uysTRj6kWY47e9X4IHMy5sdfGwKWB8
         ZCI48sG3/xTthJwmaDwih0jxrtDS1r+PjRQ55+0y0ndxVrdcd3I1nTr/+vk2ehu5Rute
         nyR2djwnkegTkmiOHbpIpKiSVeK030yd6v+RDT7W8pzB/3X/6mnBMcbVN8g87xekP4l/
         jefsL2m4ObVMKb0Z6LnHn8VNAron7+tdIJWFQGUhXKLnpNDYVJU7YFDbl8wpVidWoJHQ
         VKuw==
Received: by 10.60.20.1 with SMTP id j1mr6896827oee.46.1353179287779; Sat, 17
 Nov 2012 11:08:07 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 17 Nov 2012 11:08:07 -0800 (PST)
In-Reply-To: <20121117141422.GI12052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209968>

On Sat, Nov 17, 2012 at 3:14 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Sat, Nov 17, 2012 at 12:50:39PM +0100, Felipe Contreras wrote:
>> On Sat, Nov 17, 2012 at 12:05 PM, SZEDER G=C3=A1bor <szeder@ira.uka.=
de> wrote:
>>
>> >  __gitcomp_nl ()
>> >  {
>> >         local IFS=3D$'\n'
>> > -       COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "=
${3-$cur}"))
>> > +       COMPREPLY=3D($(awk -v pfx=3D"${2-}" -v sfx=3D"${4- }" -v c=
ur=3D"${3-$cur}" '
>> > +               BEGIN {
>> > +                       FS=3D"\n";
>> > +                       len=3Dlength(cur);
>> > +               }
>> > +               {
>> > +                       if (cur =3D=3D substr($1, 1, len))
>> > +                               print pfx$1sfx;
>> > +               }' <<< "$1" ))
>> >  }
>>
>> Does this really perform better than my alternative?
>>
>> +       for x in $1; do
>> +               if [[ "$x" =3D "$3"* ]]; then
>> +                       COMPREPLY+=3D("$2$x$4")
>> +               fi
>> +       done
>
> It does:
>
>   My version:
>
>     $ refs=3D"$(for i in {0..9999} ; do echo branch$i ; done)"
>     $ time __gitcomp_nl "$refs"
>
>     real    0m0.109s
>     user    0m0.096s
>     sys     0m0.012s
>
>   Yours:
>
>     $ time __gitcomp_nl "$refs"
>
>     real    0m0.321s
>     user    0m0.312s
>     sys     0m0.008s

Yeah, for 10000 refs, which is not the common case:

=3D=3D 1 =3D=3D
SZEDER:
real	0m0.007s
user	0m0.003s
sys	0m0.000s
felipec:
real	0m0.000s
user	0m0.000s
sys	0m0.000s
=3D=3D 10 =3D=3D
SZEDER:
real	0m0.004s
user	0m0.003s
sys	0m0.001s
felipec:
real	0m0.000s
user	0m0.000s
sys	0m0.000s
=3D=3D 100 =3D=3D
SZEDER:
real	0m0.005s
user	0m0.002s
sys	0m0.002s
felipec:
real	0m0.002s
user	0m0.002s
sys	0m0.000s
=3D=3D 1000 =3D=3D
SZEDER:
real	0m0.010s
user	0m0.008s
sys	0m0.001s
felipec:
real	0m0.018s
user	0m0.017s
sys	0m0.001s
=3D=3D 10000 =3D=3D
SZEDER:
real	0m0.062s
user	0m0.060s
sys	0m0.003s
felipec:
real	0m0.175s
user	0m0.174s
sys	0m0.000s
=3D=3D 100000 =3D=3D
SZEDER:
real	0m0.595s
user	0m0.593s
sys	0m0.021s
felipec:
real	0m1.848s
user	0m1.843s
sys	0m0.003s
=3D=3D 1000000 =3D=3D
SZEDER:
real	0m6.258s
user	0m6.241s
sys	0m0.215s
felipec:
real	0m18.191s
user	0m18.115s
sys	0m0.045s

--=20
=46elipe Contreras
