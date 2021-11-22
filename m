Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F5DC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbhKVRfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:35:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:36432 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240440AbhKVRfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:35:48 -0500
Received: (qmail 21105 invoked by uid 109); 22 Nov 2021 17:32:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 17:32:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21477 invoked by uid 111); 22 Nov 2021 17:32:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 12:32:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 12:32:39 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 5/5] run-command API: remove "argv" member, always use
 "args"
Message-ID: <YZvUN0kuTpmf9Q7P@coredump.intra.peff.net>
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <patch-5.5-ea1011f7473-20211122T153605Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.5-ea1011f7473-20211122T153605Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 05:04:07PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This change is larger than I'd like, but there's no easy way to avoid
> it that wouldn't involve even more verbose intermediate steps. We use
> the "argv" as the source of truth over the "args", so we need to
> change all parts of run-command.[ch] itself, as well as the trace2
> logging at the same time.

Yeah, agreed most of this needs to come in a bundle. But at least few spots
could be split out into the earlier patches:

>  builtin/worktree.c          |  2 --
>  t/helper/test-run-command.c | 10 +++++---

as they are just users of the API.

> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 3c4fb862234..b5519f92a19 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> [...]
> @@ -396,7 +396,8 @@ int cmd__run_command(int argc, const char **argv)
>  	}
>  	if (argc < 3)
>  		return 1;
> -	proc.argv = (const char **)argv + 2;
> +	strvec_clear(&proc.args);
> +	strvec_pushv(&proc.args, (const char **)argv + 2);
>  
>  	if (!strcmp(argv[1], "start-command-ENOENT")) {
>  		if (start_command(&proc) < 0 && errno == ENOENT)
> @@ -408,7 +409,8 @@ int cmd__run_command(int argc, const char **argv)
>  		exit(run_command(&proc));
>  
>  	jobs = atoi(argv[2]);
> -	proc.argv = (const char **)argv + 3;
> +	strvec_clear(&proc.args);
> +	strvec_pushv(&proc.args, (const char **)argv + 3);
>  
>  	if (!strcmp(argv[1], "run-command-parallel"))
>  		exit(run_processes_parallel(jobs, parallel_next,

These two in particular are tricky. This second strvec_clear() is
necessary because we are overwriting what was put into proc.args by the
earlier strvec_pushv(). I think this is one of two interesting ways
these kinds of trivial conversions can fail:

  - somebody is relying on the fact that "argv = whatever" is an
    assignment, not an append (which is the case here)

  - somebody is relying on the fact that assignment of the pointer is
    shallow, whereas strvec_push() is doing a deep copy. So converting:

      cp.argv = argv;
      argv[1] = "foo";

    to:

      strvec_pushv(&cp.args, argv);
      argv[1] = "foo";

    is not correct. We wouldn't use the updated "foo". I didn't notice
    any cases like this during my rough own rough conversion, but they
    could be lurking.

The strvec_clear() in the first hunk above is also not necessary (nobody
has written anything before it), but I don't mind it for consistency /
being defensive.

> @@ -902,8 +900,9 @@ int start_command(struct child_process *cmd)
>  #else
>  {
>  	int fhin = 0, fhout = 1, fherr = 2;
> -	const char **sargv = cmd->argv;
> +	const char **sargv = strvec_detach(&cmd->args);
>  	struct strvec nargv = STRVEC_INIT;
> +	const char **temp_argv = NULL;

I wondered about detaching here, because other parts of the code
(finish_command(), tracing, etc) will be looking at cmd->args.v[0] for
the command name.

But we eventually overwrite it with munged results:

> @@ -929,20 +928,26 @@ int start_command(struct child_process *cmd)
>  		fhout = dup(cmd->out);
>  
>  	if (cmd->git_cmd)
> -		cmd->argv = prepare_git_cmd(&nargv, cmd->argv);
> +		temp_argv = prepare_git_cmd(&nargv, sargv);
>  	else if (cmd->use_shell)
> -		cmd->argv = prepare_shell_cmd(&nargv, cmd->argv);
> +		temp_argv = prepare_shell_cmd(&nargv, sargv);
> +	else
> +		temp_argv = sargv;
> +	if (!temp_argv)
> +		BUG("should have some cmd->args to set");
> +	strvec_pushv(&cmd->args, temp_argv);
> +	strvec_clear(&nargv);

So we have to do some replacement. I think the memory management gets
confusing here, though.

At this point "temp_argv" might point to nargv.v (in which case it is a
dangling pointer after we clear nargv) or to the original sargv (in
which case it is memory owned by us that must be freed). The former is
OK, because we never look at it again. And the latter we eventually
reattach into &cmd->args, but:

> -	strvec_clear(&nargv);
> -	cmd->argv = sargv;
> +	strvec_pushv(&cmd->args, sargv);;
> +	free(sargv);

I think we still have all the entries we pushed into cmd->args from
temp_argv earlier. So we'd need to strvec_clear() it before pushing
sargv again.

And then the free(sargv) is too shallow. It's just freeing the outer
array, but sargv[0], etc, are leaked.

I think what you really want is the equivalent of strvec_attach(). We
don't have that, but it's basically just:

  void strvec_attach(struct strvec *s, const char **v)
  {
	/*
	 * this is convenient for our caller, but if we wanted to find
	 * potential misuses, we could also BUG() if s.nr > 0
	 */
	strvec_clear(&s);

        /* take over ownership */
	s->v = v;

	/* v must be NULL-terminated; count up to set number */
	s->nr = 0;
	for (; *v; v++)
		s->nr++;
	/*
	 * we don't know how big the original allocation was, so we can
	 * assume only nr. But add 1 to account for the NULL.
	 */
	s->alloc = s->nr + 1;
  }

I do think this whole thing would be easier to read if we left cmd->argv
intact, and just operated on a separate argv strvec. That's what the
non-Windows side does. But that distinction is nothing new in your
patch, and I'm not sure if there is a reason that the Windows code does
it differently.

-Peff
