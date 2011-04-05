From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Value size limits on git config files
Date: Tue, 5 Apr 2011 20:15:02 +0200
Message-ID: <BANLkTikwX4xoeyrskKEC83Wvz5Y8_7ykeA@mail.gmail.com>
References: <BANLkTikknAiYr4y-it3+qZ3dnXE56dQBoQ@mail.gmail.com>
 <BANLkTimLxPdr=mGJfxmdKkeq0zouxz05Uw@mail.gmail.com> <1302024946.17813.57.camel@drew-northup.unet.maine.edu>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff Adamson <jwa@urbancode.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Apr 05 20:15:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Amn-0007Qi-IJ
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 20:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab1DESPY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 14:15:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35119 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618Ab1DESPX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 14:15:23 -0400
Received: by bwz15 with SMTP id 15so524435bwz.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 11:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Wv6bQtz4ojaubqJxvZLLmqPkAT70g26jbWo3u2GkJ1M=;
        b=Ycj/+JW98wdXN0qAfLpaZNpqRVk5sgB1Lw9lWRYI2fRkUUlfob5SuPITReF46zX99F
         LHe7ZHHwRAYE8b80ATQVHYGCUr1NZJMfSH6kRnLMbgT0EXxxtDcaLBOFlmClWin9VEsP
         a11HtTJshr4An2fnmM0BIXUm9jPpacLnHVglU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=pDazcazKW6xyRZIjQWouil47bFZkE5LwZzDVJb73rXi94loT1I0r65mmSuV+FDjHoa
         B3U3JQsaQMLob7aGN3C4Kc7bbV0VQHuAxElSVHESkfGFiJaYdsybDzZCGP73MCvdIiBA
         qrWpiYPIgOXAjXbGM5l6nIbSP8+tbRhVM2s3c=
Received: by 10.204.127.129 with SMTP id g1mr10666bks.39.1302027322059; Tue,
 05 Apr 2011 11:15:22 -0700 (PDT)
Received: by 10.204.172.130 with HTTP; Tue, 5 Apr 2011 11:15:02 -0700 (PDT)
In-Reply-To: <1302024946.17813.57.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170897>

On Tue, Apr 5, 2011 at 7:35 PM, Drew Northup <drew.northup@maine.edu> w=
rote:
>
> On Tue, 2011-04-05 at 19:01 +0200, Erik Faye-Lund wrote:
>> On Tue, Apr 5, 2011 at 6:29 PM, Jeff Adamson <jwa@urbancode.com> wro=
te:
>> I was
>> > able to strip enough comments and such from myscript that it then =
no
>> > longer invalidated the config once the value was less than 1024 ch=
ars.
>
>> It's due to use of a fixed-size buffer. This patch fixes it for me:
>>
>> diff --git a/config.c b/config.c
>> index 0abcada..bc6ea49 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -133,23 +133,20 @@ static int get_next_char(void)
>>
>> =A0static char *parse_value(void)
>> =A0{
>> - =A0 =A0 static char value[1024];
>> - =A0 =A0 int quote =3D 0, comment =3D 0, len =3D 0, space =3D 0;
>> + =A0 =A0 struct strbuf value =3D STRBUF_INIT;
>> + =A0 =A0 int quote =3D 0, comment =3D 0, space =3D 0;
>
> Eric,
> You're doing a lot more here than just making a simple char buffer
> larger...
>

I'm not quite sure why you're telling me this. After all, I wrote the
patch - of course I know that.

>> =A0 =A0 =A0 for (;;) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int c =3D get_next_char();
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (len >=3D sizeof(value) - 1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (c =3D=3D '\n') {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (quote)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return N=
ULL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 value[len] =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return strbuf_detach(&valu=
e, NULL);
>
> ...ditto...
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (comment)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (isspace(c) && !quote) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value.len)
>
> ...ditto...
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 space++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> @@ -160,7 +157,7 @@ static char *parse_value(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (; space; space--)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 value[len++] =3D ' ';
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addch(&value, ' ');
>
> ...ditto...
>
> (The rest cut for discussion...)
>
> The the first question that needs to be asked is: Is there a reason w=
hy
> it was still only 1kiB long?
> The second is why adopt the struct here and not use an expanded char[=
]
> element?
>

Yeah, and I don't know the answer to those questions.

But I do know how to fix the problem, so I posted a patch

> I'm not saying this is wrong by any means, but it is a lot more than
> just a simple change in the length of a char buffer.
>

We die on config-lines that we fail to parse. Increasing the size of
the buffer is just playing cat and mouse. And besides, we can save
arbitrary large values. If we're able to write config files we're
unable to parse, then we're violating the robustness principle.

IMO, I think this is the right approach. If you disagree, feel free to
complain when I submit the patch (after I get confirmation that this
was the culprit for Jeff, or some amount of time has passed).
