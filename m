From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 2/6] path: Make the 'get_st_mode_bits' symbol a file static
Date: Sun, 28 Apr 2013 08:02:22 +0200
Message-ID: <517CBB6E.205@web.de>
References: <517C1BF9.2050604@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, tboegi@web.de,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 28 08:02:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWKhB-0005Fx-SL
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 08:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab3D1GCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 02:02:31 -0400
Received: from mout.web.de ([212.227.15.3]:58065 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058Ab3D1GCa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 02:02:30 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0M4ZVE-1Ug8sE3VQi-00z9wC; Sun, 28 Apr 2013 08:02:23
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <517C1BF9.2050604@ramsay1.demon.co.uk>
X-Provags-ID: V02:K0:VW07JyMd1ZeR/Dl5xYlh9k0JL+7hcMhXz9kjNyAyZGZ
 FwyVlAyVQ4zFC1gE+SOae93MhXUbcO77FtcxtdCabIdR+faSbE
 D2dHp21OdQkLPuA5738igQ6vPwL3/wR17RLtAXam6rRPcf3trQ
 IKhdkR3X0c0FikYEnDj2h7QgJJkw2i9UvDwkR5rgLgvP9cbgYJ
 1wyEE1Sw+V0EuL9kZnksA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222728>

On 2013-04-27 20.42, Ramsay Jones wrote:
> 
> On MinGW, sparse issues an "'get_st_mode_bits' not declared. Should
> it be static?" warning. The MinGW and MSVC builds do not see the
> declaration of this function, within git-compat-util.h, due to it's
> placement within an preprocessor conditional. (So, one solution would
> be to simply move the declaration to the top level of the header.)
> 
> In order to suppress the warning, since this symbol does not need
> more than file visibility, we simply remove the declaration from
> the header and add the static modifier to the function definition.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  git-compat-util.h | 1 -
>  path.c            | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index e955bb5..3a990b3 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -163,7 +163,6 @@
>  typedef long intptr_t;
>  typedef unsigned long uintptr_t;
>  #endif
> -int get_st_mode_bits(const char *path, int *mode);
>  #if defined(__CYGWIN__)
>  #undef _XOPEN_SOURCE
>  #include <grp.h>
> diff --git a/path.c b/path.c
> index 04ff148..cc2e9ac 100644
> --- a/path.c
> +++ b/path.c
> @@ -11,7 +11,7 @@
>   * may return wrong permission bits. Most of the time we do not care,
>   * but the callsites of this wrapper do care.
>   */
> -int get_st_mode_bits(const char *path, int *mode)
> +static int get_st_mode_bits(const char *path, int *mode)
>  {
>  	struct stat st;
>  	if (lstat(path, &st) < 0)
> 
Sorry for breaking the MiNGW/MSVC builds.
It seams that the get_st_mode_bits is badly placed.

It should be in git compat-util.h, so that both compat/cygwin.c and path.c can see it.
So from my understanding, it should be placed here:
(I will send an official patch later)
/Torsten
 

diff -C 3 git-compat-util.h.~9526aa461f6c6900cb892a6fe248150ad436c0d~ git-compat-util.h.new
*** git-compat-util.h.~9526aa461f6c6900cb892a6fe248150ad436c0d~ 2013-04-28 07:53:28.000000000 +0200
--- git-compat-util.h.new       2013-04-28 07:53:58.000000000 +0200
***************
*** 127,132 ****
--- 127,133 ----
  #else
  #include <poll.h>
  #endif
+ int get_st_mode_bits(const char *path, int *mode);
  #if defined(__MINGW32__)
  /* pull in Windows compatibility stuff */
  #include "compat/mingw.h"
***************
*** 163,169 ****
  typedef long intptr_t;
  typedef unsigned long uintptr_t;
  #endif
- int get_st_mode_bits(const char *path, int *mode);
  #if defined(__CYGWIN__)
  #undef _XOPEN_SOURCE
  #include <grp.h>
