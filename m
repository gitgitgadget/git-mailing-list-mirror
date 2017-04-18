Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07FA1FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 00:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbdDRA0y (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 20:26:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42274 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753271AbdDRA0x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 20:26:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 49AF21FA26;
        Tue, 18 Apr 2017 00:26:52 +0000 (UTC)
Date:   Tue, 18 Apr 2017 00:26:52 +0000
From:   Eric Wong <e@80x24.org>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH v4 05/10] run-command: prepare child environment before
 forking
Message-ID: <20170418002651.GA14303@dcvr.yhbt.net>
References: <20170414165902.174167-1-bmwill@google.com>
 <20170417220818.44917-1-bmwill@google.com>
 <20170417220818.44917-6-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170417220818.44917-6-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+Cc Karsten for comments below...

Brandon Williams <bmwill@google.com> wrote:
> In order to avoid allocation between 'fork()' and 'exec()' prepare the
> environment to be used in the child process prior to forking.
> 
> Switch to using 'execve()' so that the construct child environment can
> used in the exec'd process.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  run-command.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 77 insertions(+), 10 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index 1c7a3b611..2fff60a04 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -267,6 +267,76 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
>  		}
>  	}
>  }
> +
> +static int env_isequal(const char *e1, const char *e2)
> +{
> +	for (;;) {
> +		char c1 = *e1++;
> +		char c2 = *e2++;
> +		c1 = (c1 == '=') ? '\0' : tolower(c1);
> +		c2 = (c2 == '=') ? '\0' : tolower(c2);

Dealing with C strings scares me so maybe I'm misreading;
but: why is this comparison case-insensitive?

Reading on...

> +
> +		if (c1 != c2)
> +			return 0;
> +		if (c1 == '\0')
> +			return 1;
> +	}
> +}
> +
> +static int searchenv(char **env, const char *name)
> +{
> +	int pos = 0;
> +
> +	for (; env[pos]; pos++)
> +		if (env_isequal(env[pos], name))
> +			break;
> +
> +	return pos;
> +}

So this scans through every string in env looking for something
that matches 'name' followed by a '=', and return the position
of that in env so do_putenv below can use it:

> +
> +static int do_putenv(char **env, int env_nr, const char *name)
> +{
> +	int pos = searchenv(env, name);
> +
> +	if (strchr(name, '=')) {
> +		/* ('key=value'), insert of replace entry */

		"insert or replace"

> +		if (pos >= env_nr)
> +			env_nr++;
> +		env[pos] = (char *) name;

OK, this sets an entry...

> +	} else if (pos < env_nr) {
> +		/* otherwise ('key') remove existing entry */
> +		env_nr--;
> +		memmove(&env[pos], &env[pos + 1],
> +			(env_nr - pos) * sizeof(char *));
> +		env[env_nr] = NULL;

And this clobbers it, freeing up a slot for future sets and
tells the caller by returning env_nr below:

> +	}
> +
> +	return env_nr;
> +}

So now the caller below will know where there's a free slot
to place the next environment variable:

> +static char **prep_childenv(const char *const *deltaenv)
> +{
> +	extern char **environ;
> +	char **childenv;
> +	int childenv_nr = 0, childenv_alloc = 0;
> +	int i;
> +
> +	for (i = 0; environ[i]; i++)
> +		childenv_nr++;
> +	for (i = 0; deltaenv && deltaenv[i]; i++)
> +		childenv_alloc++;
> +	/* Add one for the NULL termination */
> +	childenv_alloc += childenv_nr + 1;
> +
> +	childenv = xcalloc(childenv_alloc, sizeof(char *));
> +	memcpy(childenv, environ, childenv_nr * sizeof(char *));
> +
> +	/* merge in deltaenv */
> +	for (i = 0; deltaenv && deltaenv[i]; i++)
> +		childenv_nr = do_putenv(childenv, childenv_nr, deltaenv[i]);
> +
> +	return childenv;
> +}

OK, the above seems to make sense; copy parent environment and
then make changes from deltaenv on top of it...

>  #endif
>  
>  static inline void set_cloexec(int fd)
> @@ -395,12 +465,14 @@ int start_command(struct child_process *cmd)
>  #ifndef GIT_WINDOWS_NATIVE
>  {
>  	int notify_pipe[2];
> +	char **childenv;
>  	struct argv_array argv = ARGV_ARRAY_INIT;
>  
>  	if (pipe(notify_pipe))
>  		notify_pipe[0] = notify_pipe[1] = -1;
>  
>  	prepare_cmd(&argv, cmd);
> +	childenv = prep_childenv(cmd->env);
>  
>  	cmd->pid = fork();
>  	failed_errno = errno;
> @@ -456,14 +528,6 @@ int start_command(struct child_process *cmd)
>  		if (cmd->dir && chdir(cmd->dir))
>  			die_errno("exec '%s': cd to '%s' failed", cmd->argv[0],
>  			    cmd->dir);
> -		if (cmd->env) {
> -			for (; *cmd->env; cmd->env++) {
> -				if (strchr(*cmd->env, '='))
> -					putenv((char *)*cmd->env);
> -				else
> -					unsetenv(*cmd->env);
> -			}
> -		}

... which was what the original code did inside the forked child.

So, everything above made sense to me except the use of tolower.

So it looks like Brandon is reusing some of Karsten's
compat/mingw.c changes in
commit 343ff06da7d83f40892b10a3b653c7d0e6cb526c,
("Win32: keep the environment sorted")

But, since these changes to run-command are *nix only,
the sorting the env makes no sense, and neither
does case-insensitivity.

However, reading Karsten's commit; it only seems the use
of case-insensitive qsort is correct.  I'm not sure
if mingw is case-insensitive for actual env modifications,
but I know *nix env names are case-sensitive.

So, there _may_ be a bug in compat/mingw.c with the use
of bsearchenv and compareenv.  It does not seem bsearch
is correct to use there, nor can a case-insensitive
compareenv be used for searching, only sorting...
