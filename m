From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] grep: use regcomp() for icase search with non-ascii patterns
Date: Tue, 7 Jul 2015 06:02:11 +0700
Message-ID: <CACsJy8BDdxoN3m=FW9sCztz4Egjw7xnxXGZUkWQ3hAK9yXisnA@mail.gmail.com>
References: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg>
 <1436186551-32544-1-git-send-email-pclouds@gmail.com> <559AE0B9.2040704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, plamen.totev@abv.bg
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 07 01:02:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCFPT-0000bs-3I
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 01:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbbGFXCn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2015 19:02:43 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35074 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbbGFXCl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2015 19:02:41 -0400
Received: by igcqs7 with SMTP id qs7so20939240igc.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WPKpUZ2qCvM1Xop2WqN/B9fYSOs2intUq6co4CbHvsU=;
        b=ffy7GySxk9WKhFmCWmtXFx8OHZvEBihUEZplWuwmX2WHhYMXZeGFN2uWv5sscuTsCt
         leYsumC60QARI/mBHI3NnnZyH+B36K1Y0bPzJ0nWxkHPRGD+z8rze7Qe6FUp1+zrKt0+
         8PyXh+2ejMTZaLYlFT02QdyeQrzMho/6VCsdmFHWyjFp5XADOGmeaBAjhm5v9w5orEy1
         JHrNgDzc/p9ChNVQIMaS5Zg5DsKI5CRUem4dIq1eyqzDQrAwJpXdTD4qvzyhp7iWJoUt
         +YFJAslpykUFgpS4Za8eF7wtjfo0xtH0FbZsHpaqZUYmMgoQZLiXn28uf6NGyFRrbibR
         Jm3A==
X-Received: by 10.42.93.17 with SMTP id v17mr37757617icm.42.1436223760783;
 Mon, 06 Jul 2015 16:02:40 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Mon, 6 Jul 2015 16:02:11 -0700 (PDT)
In-Reply-To: <559AE0B9.2040704@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273468>

On Tue, Jul 7, 2015 at 3:10 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 06.07.2015 um 14:42 schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy:
>>
>> Noticed-by: Plamen Totev <plamen.totev@abv.bg>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>   grep.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/grep.c b/grep.c
>> index b58c7c6..48db15a 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -378,7 +378,7 @@ static void free_pcre_regexp(struct grep_pat *p)
>>   }
>>   #endif /* !USE_LIBPCRE */
>>
>> -static int is_fixed(const char *s, size_t len)
>> +static int is_fixed(const char *s, size_t len, int ignore_icase)
>>   {
>>         size_t i;
>>
>> @@ -391,6 +391,13 @@ static int is_fixed(const char *s, size_t len)
>>         for (i =3D 0; i < len; i++) {
>>                 if (is_regex_special(s[i]))
>>                         return 0;
>> +               /*
>> +                * The builtin substring search can only deal with c=
ase
>> +                * insensitivity in ascii range. If there is somethi=
ng
>> outside
>> +                * of that range, fall back to regcomp.
>> +                */
>> +               if (ignore_icase && (unsigned char)s[i] >=3D 128)
>> +                       return 0;
>
>
> How about "isascii(s[i])"?

Yes, better.

>
>>         }
>>
>>         return 1;
>> @@ -398,18 +405,19 @@ static int is_fixed(const char *s, size_t len)
>>
>>   static void compile_regexp(struct grep_pat *p, struct grep_opt *op=
t)
>>   {
>> +       int ignore_icase =3D opt->regflags & REG_ICASE || p->ignore_=
case;
>>         int err;
>>
>>         p->word_regexp =3D opt->word_regexp;
>>         p->ignore_case =3D opt->ignore_case;
>
>
> Using p->ignore_case before this line, as in initialization of the ne=
w
> variable ignore_icase above, changes the meaning.

Oops.

>> -       if (opt->fixed || is_fixed(p->pattern, p->patternlen))
>> +       if (opt->fixed || is_fixed(p->pattern, p->patternlen,
>> ignore_icase))
>>                 p->fixed =3D 1;
>>         else
>>                 p->fixed =3D 0;
>>
>>         if (p->fixed) {
>> -               if (opt->regflags & REG_ICASE || p->ignore_case)
>> +               if (ignore_case)
>
>
> ignore_icase instead?  ignore_case is for the config variable
> core.ignorecase.  Tricky.

Maybe we can test isascii separately and save the result in
has_non_ascii, then we can avoid ignore_(i)case

>
>>                         p->kws =3D kwsalloc(tolower_trans_tbl);
>>                 else
>>                         p->kws =3D kwsalloc(NULL);
>>
>
> So the optimization before this patch was that if a string was search=
ed for
> without -F then it would be treated as a fixed string anyway unless i=
t
> contained regex special characters.  Searching for fixed strings usin=
g the
> kwset functions is faster than using regcomp and regexec, which makes=
 the
> exercise worthwhile.
>
> Your patch disables the optimization if non-ASCII characters are sear=
ched
> for because kwset handles case transformations only for ASCII chars.
>
> Another consequence of this limitation is that -Fi (explicit
> case-insensitive fixed-string search) doesn't work properly with non-=
ASCII
> chars neither.  How can we handle this one?  Fall back to regcomp by
> escaping all special characters?  Or at least warn?

Hehe.. I noticed it too shortly after sending the patch. I was torn
between simply documenting the limitation and waiting for the next
person to come and fix it, or quoting the regex then passing to
regcomp. GNU grep does the quoting in this case, but that code is
GPLv3 so we can't simply copy over. It could be a problem if we need
to quote a regex in a multibyte charset where ascii is not a subset.
But i guess we can just go with utf-8..

> Tests would be nice. :)

Yeah.. but we now rely on system regcomp which may behave differently
across platforms. Then we need some locale to be always there. Some
platforms (like Gentoo) even allow building glibc without i18n.. So
I'm not sure how we know when to test or skip.
--=20
Duy
