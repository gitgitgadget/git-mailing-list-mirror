From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Move run_hook() from builtin-commit.c into run-command.c
 (libgit)
Date: Thu, 15 Jan 2009 16:46:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151637590.3586@pacific.mpi-cbg.de>
References: <1232031618-5243-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 16:47:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNURP-0002Mo-RW
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 16:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbZAOPqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 10:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755050AbZAOPqK
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 10:46:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:57224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754976AbZAOPqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 10:46:09 -0500
Received: (qmail invoked by alias); 15 Jan 2009 15:46:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 15 Jan 2009 16:46:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KNcg9tX1KaWmVPEtSFbqo4I0J0E+5MQoD76HRok
	pLLdriNS7vrl4M
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232031618-5243-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105839>

Hi,

On Thu, 15 Jan 2009, Stephan Beyer wrote:

> 	Stripping out a libified version seemed better to me than
> 	copy and paste.

Oh, definitely.

> -	ret = start_command(&hook);
> -	if (ret) {
> -		warning("Could not spawn %s", argv[0]);
> -		return ret;
> -	}
> -	ret = finish_command(&hook);
> -	if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
> -		warning("%s exited due to uncaught signal", argv[0]);

What are the side effects of replacing this with "ret = 
run_command(&hook);"?  This has to be discussed and defended in the commit 
message.

> diff --git a/run-command.c b/run-command.c
> index c90cdc5..602fe85 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -342,3 +342,38 @@ int finish_async(struct async *async)
>  #endif
>  	return ret;
>  }
> +
> +int run_hook(const char *index_file, const char *name, ...)
> +{
> +	struct child_process hook;
> +	const char *argv[10], *env[2];
> +	char index[PATH_MAX];
> +	va_list args;
> +	int i;
> +
> +	va_start(args, name);
> +	argv[0] = git_path("hooks/%s", name);
> +	i = 0;
> +	do {
> +		if (++i >= ARRAY_SIZE(argv))
> +			die("run_hook(): too many arguments");
> +		argv[i] = va_arg(args, const char *);
> +	} while (argv[i]);
> +	va_end(args);
> +
> +	if (access(argv[0], X_OK) < 0)
> +		return 0;
> +
> +	memset(&hook, 0, sizeof(hook));
> +	hook.argv = argv;
> +	hook.no_stdin = 1;
> +	hook.stdout_to_stderr = 1;
> +	if (index_file) {
> +		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> +		env[0] = index;
> +		env[1] = NULL;
> +		hook.env = env;
> +	}
> +
> +	return run_command(&hook);
> +}

Lots of improvements possible (I agree; _after_ this patch):

- deuglify the loop,

- use ALLOC_GROW instead of having a fixed size argv,

- use an strbuf for the index file

- checking executability of argv[0] before filling argv,

and possibly others, too.

Ciao,
Dscho
