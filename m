From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git: handle aliases defined in $GIT_DIR/config
Date: Sun, 04 Jun 2006 13:24:47 -0700
Message-ID: <7v3bekacts.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606042047160.1598@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 22:24:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmz9Z-0004Yy-4Y
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 22:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWFDUYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 16:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWFDUYt
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 16:24:49 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:5057 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932112AbWFDUYs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 16:24:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060604202448.ZRIY11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 16:24:48 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606042047160.1598@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 4 Jun 2006 20:47:48 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21281>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	For me, short cuts have to be easy to type, so they never
> 	include digits, and they are never case sensitive, so I do not
> 	need any fancy config stuff...

Fair enough, and the spirit is the same as what Pasky suggested
earlier, I think.

However, I am not sure about some parts of the code.  I started
mucking with it myself, but realized it is far easier for me to
just let the original submitter, especially the capable one like
you, do a bit more work ;-).

> +#define MAX_ALIAS_ARGS 32
> +
> +static int handle_alias(int *argcp, const char **argv, char **envp)
> +{
> +	int i, i2, j = 0;

Please name them src, dst and cnt.

> +	char *new_argv[MAX_ALIAS_ARGS];
> +
> +	alias_command = argv[0];
> +	git_config(git_alias_config);
> +	if (!alias_string)
> +		return 0;
> +
> +	/* split alias_string */
> +	new_argv[j++] = alias_string;
> +	for (i = i2 = 0; alias_string[i]; i++, i2++) {
> +		if (isspace(alias_string[i])) {
> +			alias_string[i2] = 0;
> +			while (alias_string[++i] && isspace(alias_string[i]));

Please make empty loops easier to read by saying:

	while (alias_string[++src] && isspace(alias_string[src]))
		; /* skip */

> +			new_argv[j++] = alias_string + i;
> +			i2 = i;

Do we need to reset dst here?  I suspect starting the next
parsed string immediately after the terminating NUL might be
cleaner.

> +			if (j >= MAX_ALIAS_ARGS)
> +				die("too many args in alias %s",
> +						alias_command);
> +		} else {
> +			if (alias_string[i] == '\\')
> +				i++;

Barf when the config line ends with a lone backslash, perhaps?
Since the configuration file parser uses backslash for quoting
itself, the user would need to have double backslashes, I
suspect.  We might want to support single/double quote pairs in
this parser as well.  I would further suggest separating this
"split single string into a pair of (argc, argv)" into a helper
function, so we can reuse it in other parts of the system later.

> +			if (i != i2)
> +				alias_string[i2] = alias_string[i];

Doing this unconditionally is probably more readable (i.e. lose
the if condition) -- this is not performance critical part of
the system.

> +		}
> +	}
> +
> +	if (j < 1)
> +		die("empty alias: %s", alias_command);
> +
> +	/* insert after command name */
> +	if (j > 1)
> +		memmove(argv + j, argv + 1, (*argcp - 1) * sizeof(char*));
> +	memcpy(argv, new_argv, j * sizeof(char*));

Who guarantees the original argv array main() received is big
enough to hold (j-1) additional pointers, I wonder?  I think you
would need to allocate a new array, and muck with both argc and
argv of the caller by passing the pointers to them, not just
argc.

> @@ -121,6 +176,7 @@ int main(int argc, const char **argv, ch
>  	if (!strncmp(cmd, "git-", 4)) {
>  		cmd += 4;
>  		argv[0] = cmd;
> +		handle_alias(&argc, argv, envp);

Hence probably "handle_alias(&argc, &argv, envp)" is needed here.

>  		handle_internal_command(argc, argv, envp);
>  		die("cannot handle %s internally", cmd);
>  	}
> @@ -178,6 +234,8 @@ int main(int argc, const char **argv, ch
>  	exec_path = git_exec_path();
>  	prepend_to_path(exec_path, strlen(exec_path));
>  
> +	handle_alias(&argc, argv, envp);
> +

... and here.
