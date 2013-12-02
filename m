From: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Subject: Re: [PATCH v3] gettext.c: detect the vsnprintf bug at runtime
Date: Mon, 02 Dec 2013 15:49:54 +0700
Message-ID: <529C49B2.6050402@gmail.com>
References: <1385812884-23776-1-git-send-email-pclouds@gmail.com> <1385865938-16392-1-git-send-email-pclouds@gmail.com> <529BD4E1.8040408@gmail.com> <CACsJy8B5aBGnm=04y60W1XVovHVryP1Co0_mmgV0f7Ox13aGjw@mail.gmail.com> <529C3987.7070708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGE=?= =?UTF-8?B?dXNlbg==?= 
	<tboegi@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 09:50:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnPCn-0004n8-77
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 09:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab3LBIuJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 03:50:09 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:44416 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab3LBIuI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 03:50:08 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so17397882pde.7
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mOFg00+JIpPUKNe9n9P9gcM5jiAsC7RjKkkJ8mjFZdk=;
        b=iS9KnCc1SswbHNj0yKiVbWasWKIhZs2LtMR8wyTjU0W52sUc+9Fx9LFIe/VKsur50I
         exBAbh/UtlapLOTtbFZ8pkaEp0jtwxrvK/veBhkyTHlSkRSMd1tLjOSHjTn55hiaTq6e
         4czaVra3ZQJcMT7W70gaD8q36fH9kAue5aroDAiZMqrcvemJXCtrpdSTteSovSR4sBXb
         o6Hpl2snsOfig2SGKqCtKC3sLi+rSeYfYdRcuHA0mWif0flcdyHwS0e6OGzQZX6CoulZ
         ScyTzo9T/O7VST7FlMj52F0iczDOfyy9odXnYHgqY9ESu67yJsIr+E+PgkMe/QWgEaNA
         F6XQ==
X-Received: by 10.66.218.166 with SMTP id ph6mr67047056pac.28.1385974207534;
        Mon, 02 Dec 2013 00:50:07 -0800 (PST)
Received: from vnwildman.myftp.org ([113.181.229.73])
        by mx.google.com with ESMTPSA id rx4sm137045869pab.13.2013.12.02.00.50.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Dec 2013 00:50:06 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <529C3987.7070708@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238618>

On 02/12/2013 14:40, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n wrote:
> On 02/12/2013 12:57, Duy Nguyen wrote:
>>> I suggest use C preprocessor instead. The person who complete git (=
make debian, rpm etc. package) decide  enable it or not (disable by def=
ault). Most of people use git from distribution instead of complete it =
from source.
>>>
>>> #ifndef VSNPRINTF_OK
>>>         setlocale(LC_CTYPE, "C");
>>> #endif
>>>
>> A single vsnprintf is cheap enough that I would not worry about
>> performance impact. Given a choice between this and distro
>> maintainers, some of them do check release notes, some not so much,
>> I'd rather go with this.
> We can set this macro automatically  by using autoconf.
> Add following code in configure.ac
>
>
> AC_LANG_CONFTEST(
> [AC_LANG_PROGRAM([[
> #include <stdio.h>
> #include <locale.h>
> #include <gnu/libc-version.h>
>
> #define STR "David_K\345gedal"
> ]],[[
>     char buf[20];
>     setlocale(LC_ALL, "en_US.UTF-8");
>     if (snprintf(buf, 13, "%.13s", STR) < 0){
>         printf("0");
>     }else{
>         printf("1");
>     }
> ]])])
> gcc -o conftest conftest.c
> AC_DEFINE([VSNPRINTF_OK], [m4_esyscmd([./conftest])], [Enable l10n li=
bc
> if vnsprintf OK])
>
> You can change c code here!
>
Sorry I'm wrong,  m4_esyscmd don't work as I spect
Change to:
AC_LANG_CONFTEST(
[AC_LANG_PROGRAM([[
#include <stdio.h>
#include <locale.h>
#include <gnu/libc-version.h>

#define STR "David_K\345gedal"
]],[[
    char buf[20];
    setlocale(LC_CTYPE, "en_US.UTF-8");
    if (snprintf(buf, 13, "%.13s", STR) < 0){
        printf("0");
    }else{
        printf("1");
    }
]])])
gcc -o conftest conftest.c
VSNPRINTF=3D$(./conftest)
AC_DEFINE_UNQUOTED([VSNPRINTF_OK], [ $VSNPRINTF ], [Enable libc if
vnsprintf OK])

don't missing run this:
$ autoconf && autoheader

My os (ubuntu 12.04) don't pass this test (libc6:i386     2.15-0ubuntu)

$ grep VSNPRINTF_OK  config.h
#define VSNPRINTF_OK 0

--=20
Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
