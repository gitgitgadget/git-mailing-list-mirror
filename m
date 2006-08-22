From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added support for dropping privileges to git-daemon.
Date: Mon, 21 Aug 2006 23:38:06 -0700
Message-ID: <7vhd05s2b5.fsf@assigned-by-dhcp.cox.net>
References: <20060819172533.GB64962@gaz.sfgoth.com>
	<1156079371.28098@hammerfest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 22 08:38:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFPu4-0006ya-Ix
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 08:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWHVGiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 02:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWHVGiJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 02:38:09 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:31730 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751294AbWHVGiH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 02:38:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822063807.YRMA12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 02:38:07 -0400
To: Tilman Sauerbeck <tilman@code-monkey.de>
In-Reply-To: <1156079371.28098@hammerfest> (Tilman Sauerbeck's message of
	"Sat, 19 Aug 2006 14:27:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25833>

Tilman Sauerbeck <tilman@code-monkey.de> writes:

> +	     [--reuseaddr] [--detach] [--pid-file=file]
> +	     [--user=u [--group=g]] [directory...]
>  
>  DESCRIPTION
>  -----------
> @@ -93,6 +94,14 @@ OPTIONS
>  --pid-file=file::
>  	Save the process id in 'file'.
>  
> +--user=u::
> +--group=g::
> +	These two options may be used to make `git-daemon` change its uid and
> +	gid	before entering the server loop.
> +	The uid that's used is the one of 'u'. If `group` is specified,
> +	the gid is set to the one of 'g', otherwise, the default gid
> +	of 'u' is used.
> +
>  <directory>::
>  	A directory to add to the whitelist of allowed directories. Unless
>  	--strict-paths is specified this will also include subdirectories

I'd prefer to spell <u> and <g> out, and clarify the description
that the parameter parsing code would do getpwent() for the
user, and the user does not have to supply numeric user and
group ids, and what happens if numeric ids are given.

How well does this interact with --inetd (inetd_mode)?  Do we
want to have some notes in the documentation on that topic? 

> diff --git a/daemon.c b/daemon.c
> index 012936f..70be10f 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -7,6 +7,8 @@ #include <netdb.h>
>  #include <netinet/in.h>
>  #include <arpa/inet.h>
>  #include <syslog.h>
> +#include <pwd.h>
> +#include <grp.h>
>  #include "pkt-line.h"
>  #include "cache.h"
>  #include "exec_cmd.h"
> @@ -14,12 +16,15 @@ #include "exec_cmd.h"
>  static int log_syslog;
>  static int verbose;
>  static int reuseaddr;
> +static const char *user;
> +static const char *group;

Do these have to be file-level global?

Do we want to do getpwnam/getgrnam lookup in drop_privileges()?
"Gaaaah, no such username/groupname!" would be needed anyway,
and I have a feeling that it might be better done once
immediately after argument parsing.  Then you can pass whatever
is needed for initgroups/setgid/setuid down as parameters to
serve() and drop_privileges().

Do we want to use initgroups(), which is _BSD_SOURCE?  I guess
it is perhaps Ok.

> +static void drop_privileges()
> +{
> +	struct passwd *p;
> +	struct group *g;
> +	gid_t gid;
> +
> +	p = getpwnam (user);

No space between function name and open parenthesis, please.

> @@ -709,6 +738,9 @@ static int serve(int port)
>  	if (socknum == 0)
>  		die("unable to allocate any listen sockets on port %u", port);
>  
> +	if (user)
> +		drop_privileges();
> +
>  	return service_loop(socknum, socklist);
>  }

Makes one wonder why it checks only user and not group, and then
makes one realize that the argument parsing code enforces that
group is never supplied without user, which leaves funny taste
in the mouth, but that is Ok, I guess.
