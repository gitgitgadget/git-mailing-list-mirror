From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/40] Windows: Treat Windows style path names.
Date: Thu, 28 Feb 2008 12:18:50 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281212140.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-11-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 13:20:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUhjz-0002rJ-LN
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 13:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbYB1MTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 07:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbYB1MTX
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 07:19:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:60904 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751000AbYB1MTW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 07:19:22 -0500
Received: (qmail invoked by alias); 28 Feb 2008 12:19:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 28 Feb 2008 13:19:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+a6GxRR/OauJHBu891zEb45mIG0+hihdhmT07CrS
	Uc+yhOCoAC/GPl
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-11-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75391>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> diff --git a/cache.h b/cache.h
> index e1000bc..3e4e10a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -441,7 +441,11 @@ int safe_create_leading_directories(char *path);
>  char *enter_repo(char *path, int strict);
>  static inline int is_absolute_path(const char *path)
>  {
> +#ifndef __MINGW32__
>  	return path[0] == '/';
> +#else
> +	return path[0] == '/' || (path[0] && path[1] == ':');

Maybe "(isalpha(path[0]) && ...)"?

And maybe make this an inline function in git-compat-util.h, like this?

static inline int has_dos_drive_prefix(const char *path)
{
#ifdef __MINGW32__
	return isalpha(*path) && path[1] == ':';
#else
	return 0;
#endif
}

> diff --git a/setup.c b/setup.c
> index dc247a8..77cc461 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -4,13 +4,26 @@
>  static int inside_git_dir = -1;
>  static int inside_work_tree = -1;
>  
> +#ifdef __MINGW32__
> +static inline int is_dir_sep(char c) { return c == '/' || c == '\\'; }
> +#else
> +static inline int is_dir_sep(char c) { return c == '/'; }
> +#endif

I think if you rename it to is_dir_separator(), you can put it into 
git-compat-util.h, right after the PATH_SEPARATOR Paolo suggested.

Thanks,
Dscho
