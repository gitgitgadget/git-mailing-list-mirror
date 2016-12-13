Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 811962042F
	for <e@80x24.org>; Tue, 13 Dec 2016 13:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932291AbcLMNzS (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 08:55:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:55674 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbcLMNzR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 08:55:17 -0500
Received: (qmail 5263 invoked by uid 109); 13 Dec 2016 13:55:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 13:55:16 +0000
Received: (qmail 14657 invoked by uid 111); 13 Dec 2016 13:55:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 08:55:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 08:55:14 -0500
Date:   Tue, 13 Dec 2016 08:55:14 -0500
From:   Jeff King <peff@peff.net>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/commit.c: convert trivial snprintf calls to
 xsnprintf
Message-ID: <20161213135514.z7eituxgxsvybwgz@sigill.intra.peff.net>
References: <20161213132717.42965-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161213132717.42965-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 01:27:17PM +0000, Elia Pinto wrote:

> With the commits f2f02675 and 5096d490 we have been converted in some files the call from snprintf/sprintf/strcpy to xsnprintf.  This patch supersedes the
> snprintf with several calls that make use of the heap rather than fixed
> length buffers (eg. PATH_MAX) that may be incorrect on some systems.

I had trouble parsing this, because it leads with mention of commits
that _aren't_ doing the same thing we are doing here. I think the
argument you want to make is basically:

  1. snprintf is bad because it may silently truncate results if we're
     wrong.

  2. In cases where we use PATH_MAX, we'd want to handle larger paths
     anyway, so we should switch to dynamic allocation.

  3. In other cases where we know the input is bounded to a certain
     length we could use xsnprintf(), which asserts that we don't
     truncate. But by switching to dynamic allocation, we can avoid
     dealing with magic numbers in the code.

I'd actually consider splitting cases (2) and (3) into separate patches.
Even though the end result is the same, the reasoning is quite
different.

As far as the patch itself goes, they all look like improvements to me.
The extra allocations shouldn't matter because these are all heavy
operations already.

A few minor nits:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0ed634b26..37228330c 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -960,15 +960,16 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		return 0;
>  
>  	if (use_editor) {
> -		char index[PATH_MAX];
> -		const char *env[2] = { NULL };
> -		env[0] =  index;
> -		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> -		if (launch_editor(git_path_commit_editmsg(), NULL, env)) {
> +		struct argv_array env = ARGV_ARRAY_INIT;
> +
> +		argv_array_pushf(&env, "GIT_INDEX_FILE=%s", index_file);
> +		if (launch_editor(git_path_commit_editmsg(), NULL, env.argv)) {
>  			fprintf(stderr,
>  			_("Please supply the message using either -m or -F option.\n"));
> +			argv_array_clear(&env);
>  			exit(1);
>  		}
> +		argv_array_clear(&env);

I'd generally skip the clear() right before exiting, though I saw
somebody disagree with me recently on that.  I wonder if we should
decide as a project on whether it is worth doing or not.

> @@ -1525,12 +1526,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>  static int run_rewrite_hook(const unsigned char *oldsha1,
>  			    const unsigned char *newsha1)
>  {
> -	/* oldsha1 SP newsha1 LF NUL */
> -	static char buf[2*40 + 3];
> +	char *buf;
>  	struct child_process proc = CHILD_PROCESS_INIT;
>  	const char *argv[3];
>  	int code;
> -	size_t n;
>  
>  	argv[0] = find_hook("post-rewrite");
>  	if (!argv[0])
> @@ -1546,34 +1545,33 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
>  	code = start_command(&proc);
>  	if (code)
>  		return code;
> -	n = snprintf(buf, sizeof(buf), "%s %s\n",
> -		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
> +	buf = xstrfmt("%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
>  	sigchain_push(SIGPIPE, SIG_IGN);
> -	write_in_full(proc.in, buf, n);
> +	write_in_full(proc.in, buf, strlen(buf));
>  	close(proc.in);
> +	free(buf);

Any time you care about the length of the result, I'd generally use an
actual strbuf instead of xstrfmt. The extra strlen isn't a big deal
here, but it somehow seems simpler to me. It probably doesn't matter
much either way, though.

>  int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...)
>  {
> -	const char *hook_env[3] =  { NULL };
> -	char index[PATH_MAX];
> +	struct argv_array hook_env = ARGV_ARRAY_INIT;
>  	va_list args;
>  	int ret;
>  
> -	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> -	hook_env[0] = index;
> +	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
>  
>  	/*
>  	 * Let the hook know that no editor will be launched.
>  	 */
>  	if (!editor_is_used)
> -		hook_env[1] = "GIT_EDITOR=:";
> +		argv_array_push(&hook_env, "GIT_EDITOR=:");
>  
>  	va_start(args, name);
> -	ret = run_hook_ve(hook_env, name, args);
> +	ret = run_hook_ve(hook_env.argv,name, args);
>  	va_end(args);
> +	argv_array_clear(&hook_env);

Missing whitespace between arguments in the run_hook_ve() call.

-Peff
