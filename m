From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2] gettext.c: only work around the vsnprintf bug on glibc
 < 2.17
Date: Sun, 01 Dec 2013 00:01:28 +0100
Message-ID: <529A6E48.4050001@web.de>
References: <1385776291-21006-1-git-send-email-pclouds@gmail.com> <1385812884-23776-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>, vnwildman@gmail.com,
	schwab@linux-m68k.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 01 00:01:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmtXg-0000KM-7v
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 00:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab3K3XBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Nov 2013 18:01:36 -0500
Received: from mout.web.de ([212.227.17.11]:52060 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab3K3XBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 18:01:35 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MIvJx-1VkxjI1xwP-002bbD for <git@vger.kernel.org>;
 Sun, 01 Dec 2013 00:01:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <1385812884-23776-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:apjTfx/VSBEXxoINLKbCckijqRQ6xoyaQeCgt+OgTiAhQBdsRf7
 daCJFFVzDySJxLYicPdX0/g452iT3j4gbl4/j/jlXBDk+Wd451jtckL9zaLNBzoATvxkrnu
 sDr0Qz/yJMt9dTuM4EL6/9mlrA6QrKhk5AlMAyOkG5OuXC4jlYRRbIUPsNK088LD/hoDusl
 +F9dYNQUPJib+fkrN6uTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238573>

On 2013-11-30 13.01, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Bug 6530 [1] causes "git show v0.99.6~1" to fail with error "your
causes or caused (as we have a work around?)
> vsnprintf is broken". The workaround avoids that, but it corrupts
> system error messages in non-C locales.
[snip]
> The bug in glibc has been fixed since 2.17. If git is built with glib=
c, it can
                ^^^^^^ (Should we name glibc ?)
[snip]
> -	setlocale(LC_MESSAGES, "");
> -	init_gettext_charset("git");
> +	setlocale(vsnprintf_broken ? LC_MESSAGES : LC_ALL, "");
1) One thing I don't understand: Why do we need to set LC_ALL ?
The old patch didn't do it, or what do I miss ?
See https://wiki.debian.org/Locale :
Using LC_ALL is strongly discouraged as it overrides everything. Please=
 use it only when testing and never set it in a startup file.
2) I stole the code partly from here:
   http://sourceware.org/bugzilla/show_bug.cgi?id=3D6530
----------------------
#include <stdio.h>
#include <locale.h>
#include <gnu/libc-version.h>

#define STR "=C2=B2=C3=A9=C3=84=C2=BE=C3=82=C3=AD=C3=89=C2=B1=C2=B2=C2=A1=
=C2=B6=C2=BE=C2=A3=C2=AC=C3=96=C3=9C=C2=BA=C3=A8=C2=B5t=C3=84=C3=BA=C2=B5=
=C3=84360=C2=B2=C2=BB=C3=97=C2=A8=C3=92=C2=B5=C2=A3=C2=A1"

int main(void) {
        char buf[200];
        setlocale(LC_ALL, "");
                                printf("gnu_glibc_version()=3D%s\n",  g=
nu_get_libc_version());
        printf("ret(snprintf)=3D%d\n", snprintf(buf, 150, "%.50s", STR)=
);
        return 0;
}

----------------------
Then I run it on different machines:

gnu_glibc_version()=3D2.11.3 /* Ubuntu 10.4, no updates */
gnu_glibc_version()=3D2.11.3 /* Debian Squeze  ?*/
gnu_glibc_version()=3D2.13 /* Debian Wheezy */
ret(snprintf)=3D50 /* All the 3 above */
-------------
So could it be that libc is patched in Debian/Ubuntu, and we
can do a runtime check (rather than looking at the version number),
similar to the code above ?
------------

3) The patch didn't break anything here (Debian, Mac OS).

4) Could it be good to have a test case ? Is t0204 good for inspiration=
 ?

5) I can do more testing if needed.

/Torsten
