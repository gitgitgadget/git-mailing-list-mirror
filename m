From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Git on Mac OS X 10.4.10
Date: Thu, 14 Aug 2014 16:39:16 +0200
Message-ID: <53ECCA14.40900@web.de>
References: <53ECA7DB.7060407@jump-ing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 16:41:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHwDM-00008D-IL
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 16:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbaHNOlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2014 10:41:12 -0400
Received: from mout.web.de ([212.227.17.12]:50148 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbaHNOlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 10:41:11 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MT8bi-1WqxRj09sk-00S9uT; Thu, 14 Aug 2014 16:41:09
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.6.0
In-Reply-To: <53ECA7DB.7060407@jump-ing.de>
X-Provags-ID: V03:K0:CSzjFZ/cukLfZvFPiUJesopgL2gtrXMGtQlzQKmLyY3SNxFoIcw
 e1dvgdhVmvf/SFsM+X043FcmDEyJ13EOdfAUmgDIAJhJ21hr/6ZP/bgr2BcI055U+EqD3ao
 U4iFk/AVc2xamN3deVcJ/EmM5U4CSHvVkANYpjB4u3q3UMAagvcORFgP38jZDwhfWqqGlCP
 i9KsHIB3+qcazTVAkY9SA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255264>

On 08/14/2014 02:13 PM, Markus Hitter wrote:
> I'm new to this list, so: Hello everybody!
>
> My backup servers run Mac OS X 10.4.10. Yes, these are old, but very
> reliable and easily up to the task. And Mac OS X 10.4 is the latest OS
> supported there (PowerPC G3).
>
> Recently I tried to upgrade to v2.0.4 (from 1.7.11.4).
>
> Issue 1: I get many of these warnings:
>
>      LINK [many cases]
> /usr/bin/ld: warning multiple definitions of symbol _regcomp
> libgit.a(regex.o) definition of _regcomp in section (__TEXT,__text)
> /usr/lib/gcc/powerpc-apple-darwin8/4.0.1/../../../libSystem.dylib(regcomp.So)
> definition of _regcomp
> /usr/bin/ld: warning multiple definitions of symbol _regexec
> libgit.a(regex.o) definition of _regexec in section (__TEXT,__text)
> /usr/lib/gcc/powerpc-apple-darwin8/4.0.1/../../../libSystem.dylib(regexec.So)
> definition of _regexec
> /usr/bin/ld: warning multiple definitions of symbol _regfree
> libgit.a(regex.o) definition of _regfree in section (__TEXT,__text)
> /usr/lib/gcc/powerpc-apple-darwin8/4.0.1/../../../libSystem.dylib(regfree.So)
> definition of _regfree
>
> Is this expected?
No.
Git has its own regcomp() (and the regXXX() ) in ./compat/regex/*, and 
for some reasons the linker
picks them both from libgit.a (which is a static library) and the 
dynamic library in libSystem.dylib

Either the linker needs to be convinced not to do that (by changing the 
command line to the linker,
changing the order of libraries may help, I don't know)
Or each regcomp in the .h and .c files is changed into git_regcomp.
This change shouldn't break anything.

>
>
> Issue 2: I need this simple patch ...
>
> --- compat/apple-common-crypto.h.org	2014-07-30 23:19:53.000000000 +0200
> +++ compat/apple-common-crypto.h	2014-08-14 12:57:37.000000000 +0200
> @@ -2,7 +2,7 @@
>   #define OPENSSL_NO_MD5
>   #define HEADER_HMAC_H
>   #define HEADER_SHA_H
> -#include <CommonCrypto/CommonHMAC.h>
> +//#include <CommonCrypto/CommonHMAC.h>
>   #define HMAC_CTX CCHmacContext
>   #define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, len)
>   #define HMAC_Update CCHmacUpdate
The  <CommonCrypto/CommonHMAC.h> is in Mac OS X 10.6 .. 10.9,
but not in 10.4 (I don't know about 10.5).
You can try to tweak the "makefiles",  search for NO_APPLE_COMMON_CRYPTO,
and set NO_APPLE_COMMON_CRYPTO, but only  for Darwin 10.3 (or below)

> ... and this command sequence ...
>
> make all
> touch imap-send.o
> touch git-imap-send
> make all
>
> ... to get it compiling. All, except git-imap-send, obviously, which is
> no loss for my purposes.
>
> I tried many releases, the patch requirement started with about v1.9.1,
> the git-imap-send failure somewhere between 1.8.1.6 and 1.8.4.3.
>
> Trying to be a good Open Source citizen, how would I proceed?
If you want to share your changes, please send a patch to this list.
> Thanks,
> Markus
