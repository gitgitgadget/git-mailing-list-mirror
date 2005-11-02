From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] git-daemon support for user-relative paths.
Date: Tue, 01 Nov 2005 16:14:11 -0800
Message-ID: <7vvezb6h4c.fsf@assigned-by-dhcp.cox.net>
References: <20051101225921.3E7455BF74@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 01:15:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6Gd-0007dI-KJ
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 01:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbVKBAON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 19:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbVKBAON
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 19:14:13 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:22494 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751466AbVKBAOM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 19:14:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102001352.XYMD1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Nov 2005 19:13:52 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10979>

Andreas Ericsson <ae@op5.se> writes:

> +             [--timeout=n] [--init-timeout=n] [--strict-paths] [directory...]

Why not just --strict?

> @@ -10,16 +10,18 @@
>  #include "pkt-line.h"
>  #include "cache.h"
>  
> -static int log_syslog;
> +static int log_syslog = 0;

I'd drop this.

>  /* If this is set, git-daemon-export-ok is not required */
>  static int export_all_trees = 0;
>  
> @@ -81,69 +83,49 @@ static void loginfo(const char *err, ...
>  	va_end(params);
>  }
>  
> -static int path_ok(const char *dir)
> +static const char *path_ok(const char *dir)
>  {
> +	const char *path = is_git_repo(dir, strict_paths);
> +	/* No such directory or not a git archive */
> +	if(!path) {
> +		logerror("'%s': unable to chdir or not a git archive", dir);
> +		return NULL;
>  	}
>  
>  	if ( ok_paths && *ok_paths ) {
> +		char **pp = NULL;
> +		int dirlen = strlen(path);
>  
>  		for ( pp = ok_paths ; *pp ; pp++ ) {
>  			int len = strlen(*pp);
> +			if ( len <= dirlen && !strncmp(*pp, path, len) ) {
> +				if( path[len] == '\0' || (!strict_paths && path[len] == '/') )
> +					return path;
>  			}
>  		}

Sorry, but I am a bit confused.  Does this mean that you need to
list all directories under --strict-paths, instead of saying
"/pub/scm and everything under it is OK"?

I like the general direction this set is taking, but let's let
it simmer for a while.
