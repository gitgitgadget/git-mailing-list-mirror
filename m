From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git_progname (was: Re: User-relative paths)
Date: Tue, 25 Oct 2005 11:31:50 +0200
Message-ID: <20051025093150.GB30889@pasky.or.cz>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se> <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net> <435DF6DA.6010205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 11:33:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EULAA-0000RX-IW
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 11:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVJYJbw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 05:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVJYJbw
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 05:31:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2749 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932108AbVJYJbw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 05:31:52 -0400
Received: (qmail 16996 invoked by uid 2001); 25 Oct 2005 11:31:50 +0200
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <435DF6DA.6010205@op5.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10578>

Could you please also trim the mails you are replying to a bit?

Dear diary, on Tue, Oct 25, 2005 at 11:11:54AM CEST, I got a letter
where Andreas Ericsson <ae@op5.se> told me that...
> See the attached patch, which adds git_progname as a global variable to 
> daemon.c with a minimum of fuzz. The one-liner below will add it to the 
> rest of the programs. GNU sed >= 4.0.9 required.
> 
> grep -l "int main" *.c | xargs -- sed -i '/^#include/i#include "main.h"'

Urgh. Now this is ugly. What about making it a bit more intrusive while
quite more saner?

> diff --git a/cache.h b/cache.h
> index d776016..db5d667 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -45,6 +45,13 @@
>  #endif
>  #endif
>  
> +#if defined(__GLIBC__)
> +extern const char *__progname;
> +#define git_progname __progname
> +#else
> +extern const char *git_progname;
> +#endif
> +
>  /*
>   * Intensive research over the course of many years has shown that
>   * port 9418 is totally unused by anything else. Or

Also, when you already solve this for non-__GLIBC__ systems, I doubt
that there is any win in keeping the __GLIBC__-specific hack, except
that most developers won't see any bugs in the generic solution since
they are using glibc.

> diff --git a/main.h b/main.h
> new file mode 100644
> index 0000000..472f134
> --- /dev/null
> +++ b/main.h
> @@ -0,0 +1,22 @@
> +/* unistd.h must be available and the glibc version includes features.h
> + * from it which #defines __GLIBC__ and friends */
> +#include <unistd.h>
> +#ifndef __GLIBC__
> +const char *git_progname;
> +static int git_main(int, char **);
> +
> +int main(int argc, char **argv)
> +{
> +	char *p;
> +	git_progname = p = *argv;
> +
> +	/* don't use any library functions. We won't have the headers */
> +	while(*p)
> +		if(*p++ == '/')
> +			git_progname = p;
> +
> +	return git_main(argc, argv);
> +}
> +
> +#define main(argc, argv) git_main(argc, argv)
> +#endif /* __GLIBC__ */

Someone said that converting main()s to git_main()s would help the
libification effort, but I suspect that you actually want to set the
progname to whatever you call when you call its git_main().

We can make it go into the init section, but that won't be too portable
either.

So I'd say just add setup_progname("foo") at the start of your main().

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
