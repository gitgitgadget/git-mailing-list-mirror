From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 3/3] grep: add support for grepping in submodules
Date: Thu, 30 Sep 2010 00:21:11 +0200
Message-ID: <4CA3BBD7.3090006@web.de>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com> <1285792134-26339-4-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 00:21:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P151e-0005n8-2K
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 00:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247Ab0I2WVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 18:21:16 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:55594 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab0I2WVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 18:21:15 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 6CC4B1737FC2D;
	Thu, 30 Sep 2010 00:21:14 +0200 (CEST)
Received: from [93.246.52.249] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P151W-00088D-00; Thu, 30 Sep 2010 00:21:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <1285792134-26339-4-git-send-email-judge.packham@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18H4OWXTp1ynW9JtGJcKrG649PwOGpVQA87gD/5
	1GEj/B40nVN2zNM3W+wbBHhNz1il+O5MrcXzUnkUJyAYbZ4tzU
	qxbevJ11S+4/sp6fizJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157612>

Nice start!


Am 29.09.2010 22:28, schrieb Chris Packham:
> When the --recurse-submodules option is given git grep will search in
> submodules as they are encountered.

As "git clone" already introduced a "--recursive" option for
submodule recursion IMO "--recursive" should be used here too for
consistency. (Maybe you took the idea to use "--recurse-submodules"
from my "git-checkout-recurse-submodules" branch on github? But that
is only used there because I didn't get around to change it yet like
I did in the "fetch-submodules-too" branch).


> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
>  builtin/grep.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  grep.h         |    1 +
>  2 files changed, 73 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 8315ff0..c9befdc 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -30,6 +30,9 @@ static char const * const grep_usage[] = {
>  
>  static int use_threads = 1;
>  
> +static int saved_argc;
> +static const char **saved_argv;
> +
>  #ifndef NO_PTHREADS
>  #define THREADS 8
>  static pthread_t threads[THREADS];
> @@ -585,6 +588,67 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
>  	free(argv);
>  }
>  
> +static const char **create_sub_grep_argv(struct grep_opt *opt, const char *path)
> +{
> +	#define NUM_ARGS 10
> +	struct strbuf buf = STRBUF_INIT;
> +	const char **argv;
> +	int i = 0;
> +
> +	argv = xcalloc(NUM_ARGS, sizeof(const char *));
> +	argv[i++] = "grep";
> +	strbuf_addf(&buf, "--submodule-prefix=\\\"%s\\\"", path);
> +	//argv[i++] = buf.buf;

As C++ comments are not portable they have to be avoided, but I
assume this one here (and the unused "saved_argc" variable too) is
a hint that this code is not working as intended yet? ;-)

It seems you want to use strbuf_detach() here so that this argv[]
stays valid after the strbuf_release() at the end of this function.
And if I'm not missing something this would not work correctly in
the second recursion depth, as the new submodule prefix should
be the one given to this grep command concatenated with the current
submodule path.


> +	if (opt->linenum)
> +		argv[i++] = "-n";
> +	if (opt->invert)
> +		argv[i++] = "-v";
> +	if (opt->ignore_case)
> +		argv[i++] = "-i";
> +	if (opt->count)
> +		argv[i++] = "-c";
> +	if (opt->name_only)
> +		argv[i++] = "-l";
> +
> +	argv[i++] = saved_argv[0];
> +	argv[i++] = NULL;

Hm, at a quick glance it might be much easier to copy argc & argv
in cmd_grep() before parse_options() starts manipulating it. Then
you would only have to change/add the "--submodule-prefix" option
as needed and would not have to deal with all possible grep option
combinations (and for example you don't pass the recurse option
yet, which would stop the recursion pretty soon).


> +
> +	strbuf_release(&buf);
> +	return argv;
> +}
> +
> +static int grep_submodule(struct grep_opt *opt, const char *path)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct child_process cp;	
> +	const char **argv = create_sub_grep_argv(opt, path);
> +	const char *git_dir;
> +	int hit = 0;
> +
> +	strbuf_addf(&buf, "%s/.git", path);
> +	git_dir = read_gitfile_gently(buf.buf);
> +	if (!git_dir)
> +		git_dir = buf.buf;
> +	if (!is_directory(git_dir)) {
> +		warning("submodule %s has not been initialized\n", path);

Having a submodule which is not checked out is perfectly fine, so
I don't think we want to issue a warning here.


> +		goto out_free;
> +	}
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.argv = argv;
> +	cp.env = local_repo_env;
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +	if (run_command(&cp) == 0)
> +		hit = 1;
> +out_free:
> +	free(argv);
> +	strbuf_release(&buf);
> +	return hit;
> +}
> +
>  static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
>  {
>  	int hit = 0;
> @@ -593,6 +657,10 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
>  
>  	for (nr = 0; nr < active_nr; nr++) {
>  		struct cache_entry *ce = active_cache[nr];
> +		if (S_ISGITLINK(ce->ce_mode) && opt->recurse_submodules) {
> +			hit |= grep_submodule(opt, ce->name);
> +			continue;
> +		}
>  		if (!S_ISREG(ce->ce_mode))
>  			continue;
>  		if (!pathspec_matches(paths, ce->name, opt->max_depth))
> @@ -929,9 +997,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
>  		OPT_STRING(0, "submodule-prefix", &opt.submodule_prefix, "DIR",
>  			"prepend this to submodule path output"),
> +		OPT_BOOLEAN(0, "recurse-submodules", &opt.recurse_submodules,
> +			"recurse into submodules"),
>  		OPT_END()
>  	};
>  
> +	saved_argc = argc;
> +	saved_argv = argv;
>  	/*
>  	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
>  	 * to show usage information and exit.
> diff --git a/grep.h b/grep.h
> index d918da4..e3199c9 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -102,6 +102,7 @@ struct grep_opt {
>  	unsigned post_context;
>  	unsigned last_shown;
>  	int show_hunk_mark;
> +	int recurse_submodules;
>  	void *priv;
>  
>  	void (*output)(struct grep_opt *opt, const void *data, size_t size);
