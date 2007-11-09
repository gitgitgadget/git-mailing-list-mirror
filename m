From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Add strchrnul()
Date: Fri, 09 Nov 2007 14:42:48 +0100
Organization: At home
Message-ID: <fh1o4o$jei$1@ger.gmane.org>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 14:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqU8n-0007i7-CD
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 14:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759203AbXKINnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 08:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758614AbXKINnF
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 08:43:05 -0500
Received: from main.gmane.org ([80.91.229.2]:39591 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758271AbXKINnD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 08:43:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IqU8P-0005qW-6n
	for git@vger.kernel.org; Fri, 09 Nov 2007 13:42:57 +0000
Received: from abvp178.neoplus.adsl.tpnet.pl ([83.8.213.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 13:42:57 +0000
Received: from jnareb by abvp178.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 13:42:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvp178.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64178>

[Cc: Andreas Ericsson <ae@op5.se>,=20
     Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>,=20
     Junio C Hamano <gitster@pobox.com>,
     git@vger.kernel.org]

Andreas Ericsson wrote:

> Ren=E9 Scharfe wrote:
>> As suggested by Pierre Habouzit, add strchrnul().  It's a useful GNU
>> extension and can simplify string parser code.  There are several
>> places in git that can be converted to strchrnul(); as a trivial
>> example, this patch introduces its usage to builtin-fetch--tool.c.
>>=20
>> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
>> ---
>>=20
>>  Makefile              |   13 +++++++++++++
>>  builtin-fetch--tool.c |    8 ++------
>>  compat/strchrnul.c    |    8 ++++++++
>>  git-compat-util.h     |    5 +++++
>>  4 files changed, 28 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/Makefile b/Makefile
>> index 0d5590f..578c999 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -30,6 +30,8 @@ all::
>>  #
>>  # Define NO_MEMMEM if you don't have memmem.
>>  #
>> +# Define NO_STRCHRNUL if you don't have strchrnul.
>> +#

Original patch lacked adding appropriate test to configure,
i.e. something like below to configure.ac

 #
 # Define NO_STRCHRNUL if you don't have strchrnul.
 AC_CHECK_FUNC(strchrnul,
 [NO_STRCHRNUL=3D],
 [NO_STRCHRNUL=3DYesPlease])
 AC_SUBST(NO_STRCHRNUL)
=20
and the following line to config.mak.in

 NO_STRCHRNUL=3D@NO_STRCHRNUL@

> This seems overly complicated. How about this instead?
[...]
> I'm fairly much against forcing people to know what library
> functions they have in order to get software to compile
> properly. This is, imo, a neater solution, and also inlines
> the function as suggested by Dscho.

Wouldn't it be better to add ./configure check instead? See above.

Although I guess that people using ./configure to set compilation
options (to generate config.mak.autogen) are minority...

> +#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)
> +# define strchrnul(s, c) gitstrchrnul(s, c)
> +static inline char *gitstrchrnul(const char *s, int c)
> +{
> +       while (*s && *s !=3D c)
> +               s++;
> +
> +       return (char *)s;
> +}
> +#endif
> +

This is good solution, although I'm not sure about the check itself.
What if somebody has libc which is not glibc, but it does have
strchrnul?

> diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
> index 6a78517..ed60847 100644
> --- a/builtin-fetch--tool.c
> +++ b/builtin-fetch--tool.c
> @@ -435,9 +435,7 @@ static int pick_rref(int sha1_only, const char *r=
ref, const char *ls_remote_resu
>                               cp++;
>                       if (!*cp)
>                               break;
> -                     np =3D strchr(cp, '\n');
> -                     if (!np)
> -                             np =3D cp + strlen(cp);
> +                     np =3D strchrnul(cp, '\n');
>                       if (pass) {
>                               lrr_list[i].line =3D cp;
>                               lrr_list[i].name =3D cp + 41;
> @@ -461,9 +459,7 @@ static int pick_rref(int sha1_only, const char *r=
ref, const char *ls_remote_resu
>                       rref++;
>               if (!*rref)
>                       break;
> -             next =3D strchr(rref, '\n');
> -             if (!next)
> -                     next =3D rref + strlen(rref);
> +             next =3D strchrnul(rref, '\n');
>               rreflen =3D next - rref;
> =20
>               for (i =3D 0; i < lrr_count; i++) {

This IMHO should go to separate patch.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
