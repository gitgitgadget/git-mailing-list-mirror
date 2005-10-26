From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: Wed, 26 Oct 2005 14:22:21 -0300
Message-ID: <200510261722.j9QHMLGY006576@laptop11.inf.utfsm.cl>
References: <86u0f4fjah.fsf@blue.stonehenge.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 19:27:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUoyw-0000Sx-In
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 19:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVJZRWc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 13:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbVJZRWc
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 13:22:32 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42427 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964836AbVJZRWa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 13:22:30 -0400
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j9QHMNsQ026383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Oct 2005 14:22:23 -0300
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9QHMLGY006576;
	Wed, 26 Oct 2005 14:22:23 -0300
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: Message from merlyn@stonehenge.com (Randal L. Schwartz) 
   of "26 Oct 2005 07:24:22 PDT." <86u0f4fjah.fsf@blue.stonehenge.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 26 Oct 2005 14:22:23 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10682>

Randal L. Schwartz <merlyn@stonehenge.com> wrote:
> >>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:
> 
> Randal> gcc -o sha1_file.o -c -g -O2 -Wall -I/usr/local/include -L/usr/local/lib -Dstrcasestr=gitstrcasestr -DNO_STRCASESTR=1 -DSHA1_HEADER='<openssl/sha.h>' sha1_file.c
> Randal> sha1_file.c: In function `move_temp_to_file':
> Randal> sha1_file.c:1247: error: `ENOTSUP' undeclared (first use in this function)
> Randal> sha1_file.c:1247: error: (Each undeclared identifier is reported only once
> Randal> sha1_file.c:1247: error: for each function it appears in.)
> Randal> gmake: *** [sha1_file.o] Error 1
> 
> got it... a bit messy, but here it is:
> 
> Subject: [PATCH] fix for openbsd
> 
> ---
> 
>  sha1_file.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> applies-to: b16bae041dfd1c1081873f2e88a5f82858fb2051
> 28dcc3eaf13856585a81a24f1b4393032f825053
> diff --git a/sha1_file.c b/sha1_file.c
> index 7fdc469..1079ca5 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1244,7 +1244,11 @@ int move_temp_to_file(const char *tmpfil
>  		 * When this succeeds, we just return 0. We have nothing
>  		 * left to unlink.
>  		 */
> -		if ((ret == EXDEV || ret == ENOTSUP) && !rename(tmpfile, filename))
> +		if ((ret == EXDEV
> +#ifdef ENOTSUP
> +                     || ret == ENOTSUP
> +#endif
> +		     ) && !rename(tmpfile, filename))

This is EVIL.... why not just:

  #ifndef ENOTSUP
  #define ENOTSUP EXDEV
  #endif

someplace where it doesn't hurt the eyes? (The EXDEV makes the ENOTSUPP
fold away, I presume; not that it should really matter).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
