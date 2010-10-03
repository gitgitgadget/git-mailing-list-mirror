From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH v2 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Sun, 03 Oct 2010 03:07:33 -0600
Message-ID: <4CA847D5.4000903@workspacewhiz.com>
References: <20101003043221.1960.73178.stgit@SlamDunk>	<20101003043228.1960.88989.stgit@SlamDunk> <AANLkTikU7D5dWAc-04cVUnjPPrC7rjaqjPe_j3rEvn0u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j6t@kdbg.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 11:07:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2KXk-0004JO-VQ
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 11:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab0JCJHf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 05:07:35 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:41825 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab0JCJHf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 05:07:35 -0400
Received: (qmail 4460 invoked by uid 399); 3 Oct 2010 03:07:34 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 3 Oct 2010 03:07:34 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTikU7D5dWAc-04cVUnjPPrC7rjaqjPe_j3rEvn0u@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157846>

  ----- Original Message -----
=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
Date: 10/3/2010 2:30 AM
> On Sun, Oct 3, 2010 at 04:32, Joshua Jensen<jjensen@workspacewhiz.com=
>  wrote
>> +int fnmatch_casefold(const char *pattern, const char *string, int f=
lags)
>> +{
>> +       char lowerPatternBuf[MAX_PATH];
>> +       char lowerStringBuf[MAX_PATH];
>> +       char* lowerPattern;
>> +       char* lowerString;
>> +       size_t patternLen;
>> +       size_t stringLen;
>> +       char* out;
>> +       int ret;
>> +
>> +       /*
>> +        * Use the provided stack buffer, if possible.  If the strin=
g is too
>> +        * large, allocate buffer space.
>> +        */
>> +       patternLen =3D strlen(pattern);
>> +       if (patternLen + 1>  sizeof(lowerPatternBuf))
>> +               lowerPattern =3D xmalloc(patternLen + 1);
>> +       else
>> +               lowerPattern =3D lowerPatternBuf;
>> +
>> +       stringLen =3D strlen(string);
>> +       if (stringLen + 1>  sizeof(lowerStringBuf))
>> +               lowerString =3D xmalloc(stringLen + 1);
>> +       else
>> +               lowerString =3D lowerStringBuf;
>> +
>> +       /* Make the pattern and string lowercase to pass to fnmatch.=
 */
>> +       for (out =3D lowerPattern; *pattern; ++out, ++pattern)
>> +               *out =3D tolower(*pattern);
>> +       *out =3D 0;
>> +
>> +       for (out =3D lowerString; *string; ++out, ++string)
>> +               *out =3D tolower(*string);
>> +       *out =3D 0;
>> +
>> +       ret =3D fnmatch(lowerPattern, lowerString, flags);
>> +
>> +       /* Free the pattern or string if it was allocated. */
>> +       if (lowerPattern !=3D lowerPatternBuf)
>> +               free(lowerPattern);
>> +       if (lowerString !=3D lowerStringBuf)
>> +               free(lowerString);
>> +       return ret;
>> +}
>> +
>> +int fnmatch_icase(const char *pattern, const char *string, int flag=
s)
>> +{
>> +       return ignore_case ? fnmatch_casefold(pattern, string, flags=
) : fnmatch(pattern, string, flags);
>> +}
>
> I liked v1 of this patch better, although it obviously had portabilit=
y
> issues. But I think it would be better to handle this with:
>
>      #ifndef FNM_CASEFOLD
>      int fnmatch_casefold(const char *pattern, const char *string, in=
t flags)
>      {
>          ...
>      }
>      #endf
>
>      int fnmatch_icase(const char *pattern, const char *string, int f=
lags)
>      {
>      #ifndef FNM_CASEFOLD
>             return ignore_case ? fnmatch_casefold(pattern, string,
> flags) : fnmatch(pattern, string, flags);
>      #else
>              return fnmatch(pattern, string, flags | (ignore_case ?
> FNM_CASEFOLD : 0));
>      #endif
>      }
>
> Or simply use fnmatch(..., FNM_CASEFOLD) everywhere and include
> compat/fnmatch/* on platforms like Solaris that don't have the GNU
> extension.
The real problem with compat/fnmatch is determining which random=20
platforms need that support and updating the makefile accordingly. =20
=46urther, the compat/fnmatch/* code would need to be rejigged somewhat=
,=20
so there is no possible conflict (now or in the future) with the=20
provided symbols.  We discussed this as a potential problem developers=20
would need to be aware of if the system fnmatch.h (or whatever it is=20
called) gets #included.

Anyway, what you describe above creates two code paths.  I would imagin=
e=20
that would be harder to debug; that is, on some platforms, it uses=20
fnmatch_casefold and on others, it hands it off to fnmatch(...,=20
=46NM_CASEFOLD).

In any case, I'd like to find a solution to get this series working for=
=20
everyone.  I've been out of commission for a month (deploying Git to 80=
+=20
programmers at an organization, by the way), but I'm back now and can=20
work this until it is complete.

Josh
