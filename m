From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Set GIT_PATHNAME_PREFIX with aliases.
Date: Tue, 4 May 2010 20:51:53 -0400
Message-ID: <20100505005153.GC25390@coredump.intra.peff.net>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 02:53:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Src-0006aI-AY
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 02:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302Ab0EEAv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 20:51:57 -0400
Received: from peff.net ([208.65.91.99]:47995 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706Ab0EEAv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 20:51:57 -0400
Received: (qmail 16420 invoked by uid 107); 5 May 2010 00:52:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 04 May 2010 20:52:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 May 2010 20:51:53 -0400
Content-Disposition: inline
In-Reply-To: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146361>

On Tue, May 04, 2010 at 08:25:22PM -0400, Jared Hance wrote:

> The environment variable GIT_PATHNAME_PREFIX passes on the
> current working directory (where the git command was called from)
> to shell aliases (aliases that begin with "!"). This allows these
> shell aliases to know the directory that the git command was called
> from.

Seems like a reasonable goal, but...

> --- a/git.c
> +++ b/git.c
> @@ -167,6 +167,9 @@ static int handle_alias(int *argcp, const char ***argv)
>  				free(alias_string);
>  				alias_string = buf.buf;
>  			}
> +			static char current_dir[PATH_MAX+1];
> +			setenv("GIT_PATHNAME_PREFIX", getcwd(current_dir, sizeof(current_dir)), 1);
> +
>  			trace_printf("trace: alias to shell cmd: %s => %s\n",
>  				     alias_command, alias_string + 1);
>  			ret = system(alias_string + 1);

I see three problems:

  1. Don't declare variables in the middle of a function. It's a C99-ism
     that we avoid to retain portability with older compilers.

  2. On getcwd error, we setenv the value to NULL. Is that OK on all
     platforms (I am specifically thinking of our Windows *env wrappers,
     which have some restrictions, but I don't remember the details)?

  3. Most importantly, isn't this totally the wrong place to look at
     getcwd? We're just about to run system(), which means we will
     already have done our chdir() (which probably is the one happening
     in setup_git_directory). On even a simple test, it seems to always
     print the root of the repository for me.

     I think instead you want to pass in the prefix value computed by
     setup_git_directory to handle_alias.

-Peff
