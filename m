From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Allow commit (and tag) messages to be edited when
 $EDITOR has arguments
Date: Sun, 16 Dec 2007 15:36:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712161525090.27959@racer.site>
References: <20071216073408.GA5343@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 16:37:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3vYO-00077M-V6
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 16:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbXLPPg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 10:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbXLPPg6
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 10:36:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:45829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754703AbXLPPg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 10:36:57 -0500
Received: (qmail invoked by alias); 16 Dec 2007 15:36:55 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp001) with SMTP; 16 Dec 2007 16:36:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SdkRkIppSOv7P93mJ2Rhu0KQaJgxSff+3HchoTD
	+3WHPK9hDbNREW
X-X-Sender: gene099@racer.site
In-Reply-To: <20071216073408.GA5343@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68460>

Hi,

On Sat, 15 Dec 2007, Steven Grimm wrote:

> @@ -238,7 +186,7 @@ struct cmd_struct {
>  	int option;
>  };
>  
> -static int run_command(struct cmd_struct *p, int argc, const char **argv)
> +static int run_git_command(struct cmd_struct *p, int argc, const char **argv)
>  {
>  	int status;
>  	struct stat st;

Funny ;-) I have a similar change in my (now-inactive until 1.5.4) tree, 
but I renamed it to execv_git_builtin (because it is not supposed to 
return in case of success).

> diff --git a/run-command.c b/run-command.c
> index 476d00c..3ae55ec 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -237,3 +237,68 @@ int finish_async(struct async *async)
>  		ret = error("waitpid (async) failed");
>  	return ret;
>  }
> +
> +/*
> + * Parses a command line into an array of char* representing the tokens
> + * on the command line.  Pass in a count to reserve some number of additional
> + * slots in the allocated array, e.g., so the caller can add a filename
> + * argument without having to reallocate the array.

In the editor call, you said "2" for this, but I suspect that you counted 
the NULL extra.  However, in git.c you said "0", thus not counting the 
NULL.  IMHO it makes sense _not_ to count the NULL (and NULL-terminate 
the list _always_).

> +int split_cmdline(char *cmdline, const char ***argv, int extra_slots)
> +{
> +	int src, dst, count = 0, size = extra_slots + 16;
> +	char quoted = 0;
> +
> +	*argv = xmalloc(sizeof(char*) * size);
> +
> +	/* split alias_string */

s/alias_string/the command line/

> +	(*argv)[count++] = cmdline;
> +	for (src = dst = 0; cmdline[src];) {
> +		char c = cmdline[src];
> +		if (!quoted && isspace(c)) {
> +			cmdline[dst++] = 0;
> +			while (cmdline[++src]
> +					&& isspace(cmdline[src]))
> +				; /* skip */
> +			if (count >= size) {

s/count/count + extra_slots/

> +				size += 16;
> +				*argv = xrealloc(*argv, sizeof(char*) * size);

This seems a nice candidate for ALLOC_GROW() in any case:

			ALLOC_GROW(*argv, count + extra_slots + 1, size);

> +			}
> +			(*argv)[count++] = cmdline + dst;
> +		} else if(!quoted && (c == '\'' || c == '"')) {
> +			quoted = c;
> +			src++;
> +		} else if (c == quoted) {
> +			quoted = 0;
> +			src++;
> +		} else {
> +			if (c == '\\' && quoted != '\'') {
> +				src++;
> +				c = cmdline[src];
> +				if (!c) {
> +					free(*argv);
> +					*argv = NULL;
> +					return error("cmdline ends with \\");
> +				}
> +			}
> +			cmdline[dst++] = c;
> +			src++;
> +		}
> +	}
> +
> +	cmdline[dst] = 0;
> +
> +	if (quoted) {
> +		free(*argv);
> +		*argv = NULL;
> +		return error("unclosed quote");
> +	}

AFAICT the argv were not NULL terminated before.  But now that the 
function is public, it is safer to do so:

	(*argv)[count] = NULL;

> +
> +	return count;
> +}
> +

Thanks,
Dscho
