From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Tue, 29 May 2007 16:50:18 -0700
Message-ID: <7v646b5gw5.fsf@assigned-by-dhcp.cox.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<20070528154630.GA9176@fiberbit.xs4all.nl>
	<87646cx13d.fsf@rho.meyering.net>
	<7v4plwd6f0.fsf@assigned-by-dhcp.cox.net>
	<87veebs84i.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed May 30 01:50:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtBSo-0003NC-Tj
	for gcvg-git@gmane.org; Wed, 30 May 2007 01:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbXE2XuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 19:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbXE2XuV
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 19:50:21 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:32824 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbXE2XuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 19:50:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070529235018.MSXV19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 29 May 2007 19:50:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5BqJ1X0071kojtg0000000; Tue, 29 May 2007 19:50:18 -0400
In-Reply-To: <87veebs84i.fsf@rho.meyering.net> (Jim Meyering's message of
	"Tue, 29 May 2007 22:11:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48715>

Jim Meyering <jim@meyering.net> writes:

> ...
> Also, to be consistent with e.g., write_or_die, do not
> diagnose EPIPE write failures.
>
> Signed-off-by: Jim Meyering <jim@meyering.net>
> ---
>  git.c |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)
>
> diff --git a/git.c b/git.c
> index 29b55a1..8258885 100644
> --- a/git.c
> +++ b/git.c
> @@ -308,6 +308,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
>  	for (i = 0; i < ARRAY_SIZE(commands); i++) {
>  		struct cmd_struct *p = commands+i;
>  		const char *prefix;
> +		int status;
>  		if (strcmp(p->cmd, cmd))
>  			continue;
>
> @@ -321,7 +322,23 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
>  			die("%s must be run in a work tree", cmd);
>  		trace_argv_printf(argv, argc, "trace: built-in: git");
>
> -		exit(p->fn(argc, argv, prefix));
> +		status = p->fn(argc, argv, prefix);
> +
> +		/* Close stdout if necessary, and diagnose any failure
> +		   other than EPIPE.  */
> +		if (fcntl(fileno (stdout), F_GETFD) >= 0) {
> +			errno = 0;
> +			if ((ferror(stdout) || fclose(stdout))
> +			    && errno != EPIPE) {
> +				if (errno == 0)
> +					die("write failure on standard output");
> +				else
> +					die("write failure on standard output"
> +					    ": %s", strerror(errno));
> +			}

This makes the final write failure trump the breakage p->fn()
already diagnosed, doesn't it?  Maybe if (fcntrl(...) >=0 )
should read if (!status && fcntrl(...) >= 0).

> +		}
> +
> +		exit(status);
>  	}
>  }
>
> --
> 1.5.2.73.g18bece
