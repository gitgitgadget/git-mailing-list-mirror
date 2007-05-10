From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --aggressive option to 'git gc'
Date: Thu, 10 May 2007 00:38:56 -0700
Message-ID: <7vzm4dku0f.fsf@assigned-by-dhcp.cox.net>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
	<11786309073709-git-send-email-tytso@mit.edu>
	<11786309072612-git-send-email-tytso@mit.edu>
	<11786309071033-git-send-email-tytso@mit.edu>
	<Pine.LNX.4.64.0705090056231.18541@iabervon.org>
	<7v3b26xvjo.fsf@assigned-by-dhcp.cox.net>
	<20070509194839.GB10280@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu May 10 09:39:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm3FG-0007Ky-Gg
	for gcvg-git@gmane.org; Thu, 10 May 2007 09:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360AbXEJHi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 03:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756657AbXEJHi6
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 03:38:58 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:44850 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757360AbXEJHi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 03:38:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510073856.OLCH13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 03:38:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xKew1W0061kojtg0000000; Thu, 10 May 2007 03:38:57 -0400
In-Reply-To: <20070509194839.GB10280@thunk.org> (Theodore Tso's message of
	"Wed, 9 May 2007 15:48:39 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46836>

Theodore Tso <tytso@mit.edu> writes:

> Junio, would you be willing to apply this?

Yes, but ;-).

>  static int pack_refs = -1;
> +static int aggressive_window = -1;
>  
> +#define MAX_ADD 10
>  static const char *argv_pack_refs[] = {"pack-refs", "--prune", NULL};
>  static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
> -static const char *argv_repack[] = {"repack", "-a", "-d", "-l", NULL};
> +static const char *argv_repack[MAX_ADD] = {"repack", "-a", "-d", "-l", NULL};
>  static const char *argv_prune[] = {"prune", NULL};
>  static const char *argv_rerere[] = {"rerere", "gc", NULL};
>  
> @@ -34,13 +36,34 @@ static int gc_config(const char *var, const char *value)
>  			pack_refs = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "gc.aggressiveWindow")) {

Callbacks to git_config() are called with variable names
downcased (except for the 2nd level for 3-level variables.  E.g.
[REMOTE "Foo"] URL = ...; becomes var = "remote.Foo.url", val =
...).

> +		aggressive_window = git_config_int(var, value);
> +		printf("aggressive_window = %d\n", aggressive_window);

Did you mean to leave this in?  Looks like a debug remnant...

> +		return 0;
> +	}
>  	return git_default_config(var, value);
>  }
>  
> +static append_option(const char **cmd, const char *opt, int max_length)

Type is "static void" I presume.

> +{
> +	int	i;

Funny tab here.

> +
> +	for (i=0; cmd[i]; i++)
> +		;

SP around operator '='.

> +
> +	if (i+2 >= max_length) {

Same for '+'

> +		fprintf(stderr, "Too many options specified\n");
> +		exit(1);

die("Too many...specified"); /* note the lack of \n at the end */

> +	}
> +	cmd[i++] = opt;
> +	cmd[i] = 0;

We tend to spell out NULL, although we all are aware that C says
literal '0' is the null pointer.

All fixups are trivial so I'd take the patch and amend locally.
