From: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Subject: Re: [PATCH v3] gettext.c: detect the vsnprintf bug at runtime
Date: Mon, 02 Dec 2013 14:40:55 +0700
Message-ID: <529C3987.7070708@gmail.com>
References: <1385812884-23776-1-git-send-email-pclouds@gmail.com> <1385865938-16392-1-git-send-email-pclouds@gmail.com> <529BD4E1.8040408@gmail.com> <CACsJy8B5aBGnm=04y60W1XVovHVryP1Co0_mmgV0f7Ox13aGjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGE=?= =?UTF-8?B?dXNlbg==?= 
	<tboegi@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 08:41:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnO8B-0002gS-UK
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 08:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab3LBHlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 02:41:12 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39246 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab3LBHlL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 02:41:11 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so17539888pde.13
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 23:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kBuKfqLk3vHxwubRQQQ++9t2XUCsUe9gIff30yXrCJ0=;
        b=HorqCR7eQ0MXXtgxaLWoAB5uJ5pIq7mu3JqXxGjGMinVByiawPPtP9VitcXK0VkB3E
         5NlmR94MFUxckA8uH/GtDLHFpG4DCIz+TsfPB3KLuet/QKjDx+Z2rAsekn5LXDDdnbK7
         2tf3nNvQXWhk8YZDtk0wCAjIyEsINMVanpZ+OK2Nsx77v2HcEkcRvoFp0xGM4Hy2aNSt
         aWJ0invZnkNg5fJVl7BU5jHZUNdw8/oQ/FBlJYnwxzXDoQ6mc1JZv9vnf5+SpL9cLAWu
         jYTnsl2LNkH4x7DJZnPd2psKEyqRMYzv+2jhEss3GcfVP3vUqdx66dENC2HrIVdWm1Ma
         2tDw==
X-Received: by 10.66.121.201 with SMTP id lm9mr65209844pab.80.1385970070906;
        Sun, 01 Dec 2013 23:41:10 -0800 (PST)
Received: from vnwildman.myftp.org ([113.181.229.73])
        by mx.google.com with ESMTPSA id xn12sm86971119pac.12.2013.12.01.23.41.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 01 Dec 2013 23:41:10 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CACsJy8B5aBGnm=04y60W1XVovHVryP1Co0_mmgV0f7Ox13aGjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238616>

On 02/12/2013 12:57, Duy Nguyen wrote:
>> I suggest use C preprocessor instead. The person who complete git (m=
ake debian, rpm etc. package) decide  enable it or not (disable by defa=
ult). Most of people use git from distribution instead of complete it f=
rom source.
>>
>> #ifndef VSNPRINTF_OK
>>         setlocale(LC_CTYPE, "C");
>> #endif
>>
> A single vsnprintf is cheap enough that I would not worry about
> performance impact. Given a choice between this and distro
> maintainers, some of them do check release notes, some not so much,
> I'd rather go with this.
We can set this macro automatically  by using autoconf.
Add following code in configure.ac


AC_LANG_CONFTEST(
[AC_LANG_PROGRAM([[
#include <stdio.h>
#include <locale.h>
#include <gnu/libc-version.h>

#define STR "David_K\345gedal"
]],[[
    char buf[20];
    setlocale(LC_ALL, "en_US.UTF-8");
    if (snprintf(buf, 13, "%.13s", STR) < 0){
        printf("0");
    }else{
        printf("1");
    }
]])])
gcc -o conftest conftest.c
AC_DEFINE([VSNPRINTF_OK], [m4_esyscmd([./conftest])], [Enable l10n libc
if vnsprintf OK])

You can change c code here!

--=20
Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
