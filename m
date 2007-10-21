From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] execv_git_cmd(): also try PATH if everything else fails.
Date: Sat, 20 Oct 2007 22:36:14 -0400
Message-ID: <20071021023614.GB14735@spearce.org>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net> <Pine.LNX.4.64.0710202258440.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Parish <sRp@srparish.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 04:36:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjQg3-0000E4-0D
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 04:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbXJUCgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 22:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbXJUCgT
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 22:36:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57215 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbXJUCgS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 22:36:18 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjQfc-0004iM-8F; Sat, 20 Oct 2007 22:36:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 61D4520FBAE; Sat, 20 Oct 2007 22:36:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710202258440.25221@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61866>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 	On Sat, 20 Oct 2007, Scott Parish wrote:
> 
> 	> Actually, i didn't test it right, execve() were using the files 
> 	> in my cwd. In addition to you patch, you'd need to use execvp() 
> 	> instead of execve().
> 
> 	Ah, right.  I missed that one ;-)
> 
> 	How about this instead?

Uhhh.  Its the same, isn't it?  Still using execve() which means
we will not look at PATH in the final attempt.
 
>  exec_cmd.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/exec_cmd.c b/exec_cmd.c
> index 9b74ed2..c928f37 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -36,7 +36,8 @@ int execv_git_cmd(const char **argv)
>  	int i;
>  	const char *paths[] = { current_exec_path,
>  				getenv(EXEC_PATH_ENVIRONMENT),
> -				builtin_exec_path };
> +				builtin_exec_path,
> +				"" };
>  
>  	for (i = 0; i < ARRAY_SIZE(paths); ++i) {
>  		size_t len;
> @@ -44,9 +45,12 @@ int execv_git_cmd(const char **argv)
>  		const char *exec_dir = paths[i];
>  		const char *tmp;
>  
> -		if (!exec_dir || !*exec_dir) continue;
> +		if (!exec_dir) continue;
>  
> -		if (*exec_dir != '/') {
> +		if (!*exec_dir)
> +			/* try PATH */
> +			*git_command = '\0';
> +		else if (*exec_dir != '/') {
>  			if (!getcwd(git_command, sizeof(git_command))) {
>  				fprintf(stderr, "git: cannot determine "
>  					"current directory: %s\n",
> @@ -81,7 +85,7 @@ int execv_git_cmd(const char **argv)
>  
>  		len = strlen(git_command);
>  		rc = snprintf(git_command + len, sizeof(git_command) - len,
> -			      "/git-%s", argv[0]);
> +			      "%sgit-%s", *exec_dir ? "/" : "", argv[0]);
>  		if (rc < 0 || rc >= sizeof(git_command) - len) {
>  			fprintf(stderr,
>  				"git: command name given is too long.\n");
> -- 
> 1.5.3.4.1287.g8b31e

-- 
Shawn.
