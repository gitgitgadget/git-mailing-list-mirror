From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/40] MinGW port
Date: Sun, 2 Mar 2008 22:07:17 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803022200070.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <200803022220.59711.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Mar 02 23:08:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVwMM-0002pq-LS
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 23:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbYCBWIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 17:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbYCBWIF
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 17:08:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:58894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751086AbYCBWIE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 17:08:04 -0500
Received: (qmail invoked by alias); 02 Mar 2008 22:08:00 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp050) with SMTP; 02 Mar 2008 23:08:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AWYRlH35AyYOewIcPHIIrFpJTc1HEjaaR/8MLpk
	OdbOhsJAazrqCg
X-X-Sender: gene099@racer.site
In-Reply-To: <200803022220.59711.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75851>

Hi,

On Sun, 2 Mar 2008, Johannes Sixt wrote:

> On Wednesday 27 February 2008 19:54, Johannes Sixt wrote:
> > So here it is, the MinGW port of git.
> > This series is also available from
> >
> > git://repo.or.cz/git/mingw/j6t.git upstream
> > http://repo.or.cz/w/git/mingw/j6t.git?a=shortlog;h=upstream
> 
> I've integrated the feedback that I received in this series. Thanks to 
> has_dos_drive_prefix() as suggested by Dscho quite a number of #ifdef's 
> could be removed. Below is the interdiff between the old and the new 
> state. However, I have not yet moved stuff out of git-compat-util.h into 
> compat/mingw.h to keep this message readable. I'll do that later after I 
> have rebased the series on top of the latest git.git master.

Thanks!

And especially thanks for the interdiff, it makes reviewing much easier 
;-)

> diff --git a/Makefile b/Makefile
> index 53a4e2a..2ea53c0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -265,6 +265,7 @@ PROGRAMS = \
>  	git-pack-redundant$X git-var$X \
>  	git-merge-tree$X \
>  	git-merge-recursive$X \
> +	$(POSIX_ONLY_PROGRAMS) \
>  	$(EXTRA_PROGRAMS)

Clever name!  But shouldn't EXTRA_PROGRAMS go?

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 0888288..6733727 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -330,16 +330,13 @@ struct tm *localtime_r(const time_t *timep, struct tm 
> *result)
>  #undef getcwd
>  char *mingw_getcwd(char *pointer, int len)
>  {
> +	int i;
>  	char *ret = getcwd(pointer, len);
>  	if (!ret)
>  		return ret;
> -	if (pointer[0] != 0 && pointer[1] == ':') {
> -		int i;
> -		for (i = 2; pointer[i]; i++)
> -			/* Thanks, Bill. You'll burn in hell for that. */
> -			if (pointer[i] == '\\')
> -				pointer[i] = '/';
> -	}
> +	for (i = 0; pointer[i]; i++)
> +		if (pointer[i] == '\\')
> +			pointer[i] = '/';

Boo.  My nice comment.  You just deleted it.  ;-)

> diff --git a/templates/Makefile b/templates/Makefile
> index eb08702..6c0da7a 100644
> --- a/templates/Makefile
> +++ b/templates/Makefile
> @@ -34,11 +34,8 @@ boilerplates.made : $(bpsrc)
>  		mkdir -p blt/$$dir && \
>  		case "$$boilerplate" in \
>  		*--) ;; \
> -		*) if test -n "$$(sed -ne '/^#!\//p' -e '1q' < "$$boilerplate")"; then \
> -			cp "$$boilerplate" "blt/$${dst}$(NOEXECTEMPL)"; \
> -		   else \
> -			cp "$$boilerplate" "blt/$$dst"; \
> -		   fi ;; \
> +		hooks--*) cp $$boilerplate blt/$${dst}$(NOEXECTEMPL) ;; \
> +		*) cp $$boilerplate blt/$$dst ;; \

Nice!  (IOW much better than what I suggested.)

> diff --git a/transport.c b/transport.c
> index 397983d..266a6cc 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -692,7 +692,8 @@ static int is_local(const char *url)
>  {
>  	const char *colon = strchr(url, ':');
>  	const char *slash = strchr(url, '/');
> -	return !colon || (slash && slash < colon);
> +	return !colon || (slash && slash < colon) ||
> +		has_dos_drive_prefix(url);

This must be the bug fix ;-)

I like it!

Thanks,
Dscho

