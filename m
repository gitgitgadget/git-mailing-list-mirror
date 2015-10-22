From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Add git-grep threads-num param
Date: Thu, 22 Oct 2015 15:23:02 +0100
Message-ID: <20151022142302.GL19802@serenity.lan>
References: <1445520236-10753-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Victor Leschuk <vleschuk@accesssoftek.com>
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 16:23:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpGmB-0002oe-Pc
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 16:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757932AbbJVOXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 10:23:23 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:54021 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316AbbJVOXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 10:23:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 1D87F86604B;
	Thu, 22 Oct 2015 15:23:18 +0100 (BST)
X-Quarantine-ID: <4VxffKT8Zjnm>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4VxffKT8Zjnm; Thu, 22 Oct 2015 15:23:14 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 22C43CDA6B1;
	Thu, 22 Oct 2015 15:23:04 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1445520236-10753-1-git-send-email-vleschuk@accesssoftek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280055>

On Thu, Oct 22, 2015 at 04:23:56PM +0300, Victor Leschuk wrote:
> Hello all, I suggest we make number of git-grep worker threads a configuration
> parameter. I have run several tests on systems with different number of CPU cores.
> It appeared that the hard-coded number 8 lowers performance on both of my systems:
> on my 4-core and 8-core systems the thread number of 4 worked about 20% faster than
> default 8. So I think it is better to allow users tune this parameter.

For git-pack-objects we call the command-line parameter "--threads" and
the config variable "pack.threads".  Is there a reason not to use the
same name here (i.e. "--threads" and "grep.threads")?

> Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
> ---
>  Documentation/config.txt               |  4 ++++
>  Documentation/git-grep.txt             |  5 +++++
>  builtin/grep.c                         | 20 +++++++++++++-------
>  contrib/completion/git-completion.bash |  1 +
>  grep.c                                 | 15 +++++++++++++++
>  grep.h                                 |  4 ++++
>  6 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 391a0c3..c3df20c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1447,6 +1447,10 @@ grep.extendedRegexp::
>  	option is ignored when the 'grep.patternType' option is set to a value
>  	other than 'default'.
>  
> +grep.threadsNum::
> +	Number of grep worker threads, use it to tune up performance on
> +	multicore machines. Default value is 8.
> +
>  gpg.program::
>  	Use this custom program instead of "gpg" found on $PATH when
>  	making or verifying a PGP signature. The program must support the
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 4a44d6d..e9ca265 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -22,6 +22,7 @@ SYNOPSIS
>  	   [--color[=<when>] | --no-color]
>  	   [--break] [--heading] [-p | --show-function]
>  	   [-A <post-context>] [-B <pre-context>] [-C <context>]
> +	   [-t <threads-num>]
>  	   [-W | --function-context]
>  	   [-f <file>] [-e] <pattern>
>  	   [--and|--or|--not|(|)|-e <pattern>...]
> @@ -220,6 +221,10 @@ OPTIONS
>  	Show <num> leading lines, and place a line containing
>  	`--` between contiguous groups of matches.
>  
> +-t <num>::
> +--threads-num <num>::
> +	Set number of worker threads to <num>. Default is 8.
> +
>  -W::
>  --function-context::
>  	Show the surrounding text from the previous line containing a
> diff --git a/builtin/grep.c b/builtin/grep.c
> index d04f440..9b4fc47 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -27,8 +27,7 @@ static char const * const grep_usage[] = {
>  static int use_threads = 1;
>  
>  #ifndef NO_PTHREADS
> -#define THREADS 8
> -static pthread_t threads[THREADS];
> +static pthread_t *threads;
>  
>  /* We use one producer thread and THREADS consumer
>   * threads. The producer adds struct work_items to 'todo' and the
> @@ -206,7 +205,8 @@ static void start_threads(struct grep_opt *opt)
>  		strbuf_init(&todo[i].out, 0);
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(threads); i++) {
> +	threads = xmalloc(sizeof(pthread_t) * opt->num_threads);
> +	for (i = 0; i < opt->num_threads; i++) {
>  		int err;
>  		struct grep_opt *o = grep_opt_dup(opt);
>  		o->output = strbuf_out;
> @@ -220,7 +220,7 @@ static void start_threads(struct grep_opt *opt)
>  	}
>  }
>  
> -static int wait_all(void)
> +static int wait_all(struct grep_opt *opt)
>  {
>  	int hit = 0;
>  	int i;
> @@ -238,12 +238,14 @@ static int wait_all(void)
>  	pthread_cond_broadcast(&cond_add);
>  	grep_unlock();
>  
> -	for (i = 0; i < ARRAY_SIZE(threads); i++) {
> +	for (i = 0; i < opt->num_threads; i++) {
>  		void *h;
>  		pthread_join(threads[i], &h);
>  		hit |= (int) (intptr_t) h;
>  	}
>  
> +	free(threads);
> +
>  	pthread_mutex_destroy(&grep_mutex);
>  	pthread_mutex_destroy(&grep_read_mutex);
>  	pthread_mutex_destroy(&grep_attr_mutex);
> @@ -256,7 +258,7 @@ static int wait_all(void)
>  }
>  #else /* !NO_PTHREADS */
>  
> -static int wait_all(void)
> +static int wait_all(struct grep_opt *opt)
>  {
>  	return 0;
>  }
> @@ -702,6 +704,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  			N_("show <n> context lines before matches")),
>  		OPT_INTEGER('A', "after-context", &opt.post_context,
>  			N_("show <n> context lines after matches")),
> +#ifndef NO_PTHREADS
> +		OPT_INTEGER('t', "threads-num", &opt.num_threads,
> +			N_("use <n> worker threads")),
> +#endif /* !NO_PTHREADS */
>  		OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
>  			context_callback),
>  		OPT_BOOL('p', "show-function", &opt.funcname,
> @@ -910,7 +916,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (use_threads)
> -		hit |= wait_all();
> +		hit |= wait_all(&opt);
>  	if (hit && show_in_pager)
>  		run_pager(&opt, prefix);
>  	free_grep_patterns(&opt);
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 482ca84..6231595 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1310,6 +1310,7 @@ _git_grep ()
>  			--full-name --line-number
>  			--extended-regexp --basic-regexp --fixed-strings
>  			--perl-regexp
> +			--threads-num
>  			--files-with-matches --name-only
>  			--files-without-match
>  			--max-depth
> diff --git a/grep.c b/grep.c
> index 7b2b96a..17e6a7c 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -40,6 +40,9 @@ void init_grep_defaults(void)
>  	color_set(opt->color_selected, "");
>  	color_set(opt->color_sep, GIT_COLOR_CYAN);
>  	opt->color = -1;
> +#ifndef NO_PTHREADS
> +	opt->num_threads = GREP_NUM_THREADS_DEFAULT;
> +#endif /* !NO_PTHREADS */
>  }
>  
>  static int parse_pattern_type_arg(const char *opt, const char *arg)
> @@ -124,6 +127,14 @@ int grep_config(const char *var, const char *value, void *cb)
>  			return config_error_nonbool(var);
>  		return color_parse(value, color);
>  	}
> +
> +#ifndef NO_PTHREADS
> +	if (!strcmp(var, "grep.threadsnum")) {
> +		int threads = git_config_int(var, value);
> +		opt->num_threads = (threads >= 0) ? threads : GREP_NUM_THREADS_DEFAULT;
> +		return 0;
> +	}
> +#endif /* !NO_PTHREADS */
>  	return 0;
>  }
>  
> @@ -150,6 +161,10 @@ void grep_init(struct grep_opt *opt, const char *prefix)
>  	opt->pathname = def->pathname;
>  	opt->regflags = def->regflags;
>  	opt->relative = def->relative;
> +#ifndef NO_PTHREADS
> +	if(!opt->num_threads)
> +		opt->num_threads = def->num_threads;
> +#endif /* !NO_PTHREADS */
>  
>  	color_set(opt->color_context, def->color_context);
>  	color_set(opt->color_filename, def->color_filename);
> diff --git a/grep.h b/grep.h
> index 95f197a..e4a296b 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -132,6 +132,10 @@ struct grep_opt {
>  	unsigned pre_context;
>  	unsigned post_context;
>  	unsigned last_shown;
> +#ifndef NO_PTHREADS
> +#define GREP_NUM_THREADS_DEFAULT 8
> +	unsigned num_threads;
> +#endif /* !NO_PTHREADS */
>  	int show_hunk_mark;
>  	int file_break;
>  	int heading;
> -- 
> 2.6.2.281.gd4b1c9f
