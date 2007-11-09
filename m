From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] Add strchrnul()
Date: Fri, 09 Nov 2007 14:59:32 +0100
Message-ID: <473467C4.8020208@op5.se>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se> <fh1o4o$jei$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 14:59:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqUOm-0005V3-CZ
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 14:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759830AbXKIN7h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 08:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759912AbXKIN7h
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 08:59:37 -0500
Received: from mail.op5.se ([193.201.96.20]:46107 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759664AbXKIN7g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 08:59:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0303B1F0871F;
	Fri,  9 Nov 2007 14:59:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPUAFV+JVt-G; Fri,  9 Nov 2007 14:59:33 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 999671F0871E;
	Fri,  9 Nov 2007 14:59:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <fh1o4o$jei$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64184>

Jakub Narebski wrote:
> [Cc: Andreas Ericsson <ae@op5.se>,=20
>      Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>,=20
>      Junio C Hamano <gitster@pobox.com>,
>      git@vger.kernel.org]
>=20

I'm not sure what's up with this, but I didn't see this email on git@vg=
er,
so re-adding it to the Cc list now.

>=20
> Original patch lacked adding appropriate test to configure,
> i.e. something like below to configure.ac
>=20
>  #
>  # Define NO_STRCHRNUL if you don't have strchrnul.
>  AC_CHECK_FUNC(strchrnul,
>  [NO_STRCHRNUL=3D],
>  [NO_STRCHRNUL=3DYesPlease])
>  AC_SUBST(NO_STRCHRNUL)
> =20
> and the following line to config.mak.in
>=20
>  NO_STRCHRNUL=3D@NO_STRCHRNUL@
>=20
>> This seems overly complicated. How about this instead?
> [...]
>> I'm fairly much against forcing people to know what library
>> functions they have in order to get software to compile
>> properly. This is, imo, a neater solution, and also inlines
>> the function as suggested by Dscho.
>=20
> Wouldn't it be better to add ./configure check instead? See above.
>=20
> Although I guess that people using ./configure to set compilation
> options (to generate config.mak.autogen) are minority...
>=20

Perhaps. I know I don't anyway, and now it's become standard not to
do so for a significant part of the git-tracking world.

>> +#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)
>> +# define strchrnul(s, c) gitstrchrnul(s, c)
>> +static inline char *gitstrchrnul(const char *s, int c)
>> +{
>> +       while (*s && *s !=3D c)
>> +               s++;
>> +
>> +       return (char *)s;
>> +}
>> +#endif
>> +
>=20
> This is good solution, although I'm not sure about the check itself.
> What if somebody has libc which is not glibc, but it does have
> strchrnul?
>=20

They most likely fall into the minority that get to suffer from
using code that's as fast as what's in there today, although
a bit more readable. The glibc optimization is really only
worthwhile for architectures where strchrnul()-like operations
have microcode support, or when it's used on large strings.

YMMV. I suppose rewriting it as

#if defined(__GLIBC_PREREQ) && __GLIBC_PREREQ(2, 1)
# define HAVE_STRCHRNUL
#endif

#ifdef HAVE_STRCHRNUL
=2E..

would work too, and will provide an easier way out for other fellas
wanting to say "Hey, my favourite solaris libc has this too!". OTOH,
that rewrite can be done when the first such case appears.


>> diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
>=20
> This IMHO should go to separate patch.
>=20

*shrug* Rene had it in his. Monkey see monkey do ;-)

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
