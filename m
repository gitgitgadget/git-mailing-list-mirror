From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3] Add git-grep threads param
Date: Mon, 26 Oct 2015 19:32:41 +0000
Message-ID: <20151026193241.GO19802@serenity.lan>
References: <1445862733-838-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Victor Leschuk <vleschuk@accesssoftek.com>
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 20:33:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqnVv-0005VX-1f
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 20:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbbJZTc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 15:32:58 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:54604 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbbJZTc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 15:32:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E3C48CDA5DB;
	Mon, 26 Oct 2015 19:32:55 +0000 (GMT)
X-Quarantine-ID: <pdOui4tE4DHs>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pdOui4tE4DHs; Mon, 26 Oct 2015 19:32:52 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 1B373CDA553;
	Mon, 26 Oct 2015 19:32:43 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1445862733-838-1-git-send-email-vleschuk@accesssoftek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280211>

On Mon, Oct 26, 2015 at 03:32:13PM +0300, Victor Leschuk wrote:
> Make number of git-grep worker threads a configuration parameter.
> According to several tests on systems with different number of CPU cores
> the hard-coded number of 8 threads is not optimal for all systems:
> tuning this parameter can significantly speed up grep performance.
> 
> Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
> ---
>  Documentation/config.txt               |  4 ++++
>  Documentation/git-grep.txt             |  4 ++++
>  builtin/grep.c                         | 34 ++++++++++++++++++++++++++--------
>  contrib/completion/git-completion.bash |  1 +
>  grep.c                                 | 10 ++++++++++
>  grep.h                                 |  2 ++
>  6 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 391a0c3..1c95587 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1447,6 +1447,10 @@ grep.extendedRegexp::
>  	option is ignored when the 'grep.patternType' option is set to a value
>  	other than 'default'.
>  
> +grep.threads::
> +	Number of grep worker threads, use it to tune up performance on
> +	multicore machines. Default value is 8.
> +
>  gpg.program::
>  	Use this custom program instead of "gpg" found on $PATH when
>  	making or verifying a PGP signature. The program must support the
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 4a44d6d..fbd4f83 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -22,6 +22,7 @@ SYNOPSIS
>  	   [--color[=<when>] | --no-color]
>  	   [--break] [--heading] [-p | --show-function]
>  	   [-A <post-context>] [-B <pre-context>] [-C <context>]
> +	   [--threads <num>]

Is this the best place for this option?  I know the current list isn't
sorted in any particular way, but here you're splitting up the set of
context options (`-A`, `-B`, `-C` and `-W`).

>  	   [-W | --function-context]
>  	   [-f <file>] [-e] <pattern>
>  	   [--and|--or|--not|(|)|-e <pattern>...]
> @@ -220,6 +221,9 @@ OPTIONS
>  	Show <num> leading lines, and place a line containing
>  	`--` between contiguous groups of matches.
>  
> +--threads <num>::
> +	Set number of worker threads to <num>. Default is 8.

The same comment as above applies here.

>  -W::
>  --function-context::
>  	Show the surrounding text from the previous line containing a
> diff --git a/builtin/grep.c b/builtin/grep.c
> index d04f440..5ef1b07 100644
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
> +	threads = xcalloc(opt->num_threads, sizeof(pthread_t));
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

I'm not sure passing a grep_opt in here is the cleanest way to do this.
Options are a UI concept and all we care about here is the number of
threads.

Since `threads` is a global, shouldn't the number of threads be a global
as well?  Could we reuse `use_threads` here (possibly renaming it
`num_threads`)?

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
> @@ -702,6 +704,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  			N_("show <n> context lines before matches")),
>  		OPT_INTEGER('A', "after-context", &opt.post_context,
>  			N_("show <n> context lines after matches")),
> +		OPT_INTEGER(0, "threads", &opt.num_threads,
> +			N_("use <n> worker threads")),
>  		OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
>  			context_callback),
>  		OPT_BOOL('p', "show-function", &opt.funcname,
> @@ -832,8 +836,22 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	}
>  
>  #ifndef NO_PTHREADS
> -	if (list.nr || cached || online_cpus() == 1)
> +	if (!opt.num_threads) {
> +		use_threads = 0; /* User explicitely told not to use threads */
> +	}
> +	else if (list.nr || cached) {
> +		use_threads = 0; /* Can not multi-thread object lookup */
> +	}
> +	else if (opt.num_threads >= 0) {
> +		use_threads = 1; /* User explicitely set the number of threads */
> +	}
> +	else if (online_cpus() <= 1) {
>  		use_threads = 0;
> +	}
> +	else {
> +		use_threads = 1;
> +		opt.num_threads = GREP_NUM_THREADS_DEFAULT;
> +	}
>  #else
>  	use_threads = 0;
>  #endif
> @@ -910,7 +928,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (use_threads)
> -		hit |= wait_all();
> +		hit |= wait_all(&opt);
>  	if (hit && show_in_pager)
>  		run_pager(&opt, prefix);
>  	free_grep_patterns(&opt);
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 482ca84..390d9c0 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1310,6 +1310,7 @@ _git_grep ()
>  			--full-name --line-number
>  			--extended-regexp --basic-regexp --fixed-strings
>  			--perl-regexp
> +			--threads
>  			--files-with-matches --name-only
>  			--files-without-match
>  			--max-depth
> diff --git a/grep.c b/grep.c
> index 7b2b96a..b53fb14 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -40,6 +40,7 @@ void init_grep_defaults(void)
>  	color_set(opt->color_selected, "");
>  	color_set(opt->color_sep, GIT_COLOR_CYAN);
>  	opt->color = -1;
> +	opt->num_threads = -1;
>  }
>  
>  static int parse_pattern_type_arg(const char *opt, const char *arg)
> @@ -124,6 +125,14 @@ int grep_config(const char *var, const char *value, void *cb)
>  			return config_error_nonbool(var);
>  		return color_parse(value, color);
>  	}
> +
> +	if (!strcmp(var, "grep.threads")) {
> +		int threads = git_config_int(var, value);
> +		if (threads < 0)
> +			die("invalid number of threads specified (%d)", threads);
> +		opt->num_threads = threads;
> +		return 0;
> +	}
>  	return 0;
>  }
>  
> @@ -150,6 +159,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
>  	opt->pathname = def->pathname;
>  	opt->regflags = def->regflags;
>  	opt->relative = def->relative;
> +	opt->num_threads = def->num_threads;
>  
>  	color_set(opt->color_context, def->color_context);
>  	color_set(opt->color_filename, def->color_filename);
> diff --git a/grep.h b/grep.h
> index 95f197a..bb20456 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -132,6 +132,8 @@ struct grep_opt {
>  	unsigned pre_context;
>  	unsigned post_context;
>  	unsigned last_shown;
> +#define GREP_NUM_THREADS_DEFAULT 8
> +	int num_threads;
>  	int show_hunk_mark;
>  	int file_break;
>  	int heading;
> -- 
> 2.6.2.281.g222e106.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
