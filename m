From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.
Date: Thu, 15 Nov 2007 07:53:15 +0100
Message-ID: <9D2813B9-8E86-4551-94BF-2B04F5FBB141@zib.de>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-7-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-8-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-9-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-10-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-11-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-12-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Nov 15 07:53:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsYb5-0004Zu-6q
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 07:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850AbXKOGwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 01:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756653AbXKOGwV
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 01:52:21 -0500
Received: from mailer.zib.de ([130.73.108.11]:42716 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932505AbXKOGwT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 01:52:19 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAF6q0Ks026606;
	Thu, 15 Nov 2007 07:52:00 +0100 (CET)
Received: from [192.168.178.21] (brln-4db82eaf.pool.einsundeins.de [77.184.46.175])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAF6pwfI022183
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 15 Nov 2007 07:51:59 +0100 (MET)
In-Reply-To: <1194984306-3181-12-git-send-email-johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65071>


On Nov 13, 2007, at 9:05 PM, Johannes Sixt wrote:

> If ETC_GITCONFIG is not an absolute path, interpret it relative to
> --exec-dir. This makes the installed binaries relocatable because the
> prefix is not compiled-in.
>
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>  config.c |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)
>
> diff --git a/config.c b/config.c
> index dd7e9ad..9f014bb 100644
> --- a/config.c
> +++ b/config.c
> @@ -6,6 +6,7 @@
>   *
>   */
>  #include "cache.h"
> +#include "exec_cmd.h"
>
>  #define MAXNAME (256)
>
> @@ -454,7 +455,17 @@ int git_config_from_file(config_fn_t fn, const  
> char *filename)
>
>  const char *git_etc_gitconfig(void)
>  {
> -	return ETC_GITCONFIG;
> +	static const char *system_wide;
> +	if (!system_wide) {
> +		system_wide = ETC_GITCONFIG;
> +		if (!is_absolute_path(system_wide)) {
> +			/* interpret path relative to exec-dir */
> +			const char *exec_path = git_exec_path();
> +			system_wide = prefix_path(exec_path, strlen(exec_path),
> +						system_wide);
> +		}
> +	}
> +	return system_wide;
>  }

When I first stumbled over this code in msysgit I didn't
understand how to use it for making git relocatable. Maybe
I didn't appreciate the clue about the relative path, which
indicates to change the Makefile to provide ETC_GITCONFIG
starting with "..".

I think I stumbled over the idea to build a path by starting
with an absolute path to exec_path and than go up with
".." before going down again to etc/gitconfig. So, a paths
would for example be "C:/msysgit/bin/../etc/gitconfig".

Hence I wrote a function git_install_prefix(), which directly
points to "C:/msysgit". It is used in the following way:

----
			system_wide = prefix_path(exec_path, strlen(exec_path),
						system_wide);
		}
+#if __MINGW32__
+		/*
+		 * If it is an absolute Unix path it is prefixed with
+		 * the git_install_prefix().
+		 */
+		else if (system_wide[0] == '/') {
+			const char* prefix = git_install_prefix();
+			system_wide = prefix_path(prefix, strlen(prefix),
+			                           system_wide);
+		}
+#endif
	}
	return system_wide;
}

----

This is not very portable.  Prefixing _every_ absolute Unix path
makes sense for MINGW to map the fake unix root to its real
location in the Windows filesystem. But this probably doesn't
make sense on Unix at all.  And it's probably not needed at
all. I should have just read your code more carefully ;)

Your solution provides a sensible way to handle the issue.

Now I'm wondering if we could make path relocation a bit more
explicit.  How about doing something like.

	system_wide = relocate_path(ETC_GITCONFIG);

and relocate_path(const char *) would expand a format
string in path.  At this point I see only a single %s
that would be expanded with the install prefix.  If
ETC_GITCONFIG is "%s/etc/gitconfig" relocate path will return
"C:/msysgit/bin/etc/gitconfig" for my above example.  It is
basically a printf with the install prefix path.

This would support three cases:
- absolute path
- relative path
- paths that will be relocated.  The path includes a '%s'
   to indicate relocation.

I'm not sure if we ever need to support relative paths
without relocating them.

What do you think?  If my comments make any sense to you,
I could code a patch next weekend.

BTW, if we changed PATCH 11/11 we'd obviously change PATCH
9/11, too.

	Steffen


>  int git_config(config_fn_t fn)
> -- 
> 1.5.3.5.1592.g0d6db
