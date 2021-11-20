Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D4C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 01:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbhKTB4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 20:56:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:35490 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235856AbhKTB4L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 20:56:11 -0500
Received: (qmail 9871 invoked by uid 109); 20 Nov 2021 01:53:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Nov 2021 01:53:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21884 invoked by uid 111); 20 Nov 2021 01:53:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 20:53:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 20:53:07 -0500
From:   Jeff King <peff@peff.net>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pager: fix crash when pager program doesn't exist
Message-ID: <YZhVA8DOjHu90gzs@coredump.intra.peff.net>
References: <20211119234745.26605-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211119234745.26605-1-ematsumiya@suse.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 08:47:45PM -0300, Enzo Matsumiya wrote:

> setup_pager() doesn't properly free pager_process.argv if
> start_command() fails, nor finish_command() is ever called.

Hmm. It shouldn't need to. It sets up the args using
prepare_pager_args(), which pushes onto the pager_process->args strvec.
If start_command fails, then it takes care of freeing that strvec.

In fact, it would be wrong to free that pointer, because it is usually
just pointing to the strvec's "v" array, which will already be freed by
strvec_clear().

> setup_pager() is called twice, once from commit_pager_choice(), and then
> from cmd_log_init_finish(). On the first run, it runs fine because
> start_command() assigns cmd->args.v to cmd->argv, and upon command
> failure, child_process_clear() clears cmd->args.

When pager setup succeeds, the second run is a noop, because isatty(1)
is no longer true. But for the case you're interested in, the first one
fails, so we do try again. And I can reproduce your problem with:

 GIT_PAGER=no-such-command git -p log

I had to run it with ASan to trigger a failure, as use-after-free bugs
aren't always deterministic.

> On the second run, though, argv is no longer NULL, but .args has been
> cleared, so any strvec_push() operation will crash.

Right. So we want to make sure that argv is NULL, but we don't need to
free it. I think the bug is not in failing to clean up, though. It's in
assuming that the child_process has been properly initialized. The first
call works because of the initialization in the declaration, but the
second call can't rely on that.

So one solution is more like this:

diff --git a/pager.c b/pager.c
index 52f27a6765..27877f8ebb 100644
--- a/pager.c
+++ b/pager.c
@@ -8,7 +8,7 @@
 #define DEFAULT_PAGER "less"
 #endif
 
-static struct child_process pager_process = CHILD_PROCESS_INIT;
+static struct child_process pager_process;
 static const char *pager_program;
 
 /* Is the value coming back from term_columns() just a guess? */
@@ -124,6 +124,8 @@ void setup_pager(void)
 
 	setenv("GIT_PAGER_IN_USE", "true", 1);
 
+	child_process_init(&pager_process);
+
 	/* spawn the pager */
 	prepare_pager_args(&pager_process, pager);
 	pager_process.in = -1;

which is enough to fix the use-after-free.

> While at it, I implemented a fallback to the DEFAULT_PAGER, so it tries
> at least one more time when the configured pager fails.

I think this is probably a bad idea. If the user told us to use a
different pager, then we should not unexpectedly use the default one. At
any rate, it's unrelated to this patch; if we were to do it, it should
be separate from the bugfix.

> diff --git a/pager.c b/pager.c
> index 52f27a6765c8..79a47db55d63 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -97,6 +97,9 @@ static void setup_pager_env(struct strvec *env)
>  
>  void prepare_pager_args(struct child_process *pager_process, const char *pager)
>  {
> +	child_process_clear(pager_process);
> +	if (pager_process->argv)
> +		free(pager_process->argv);

As noted above, this would be double-freeing the strvec's array. Except
that your free() here never runs, because you added a memset() to
child_process_clear() which will always set pager_process->argv to NULL.

> @@ -105,11 +108,14 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
>  
>  void setup_pager(void)
>  {
> -	const char *pager = git_pager(isatty(1));
> +	const char *tmp_pager = git_pager(isatty(1));
> +	char *pager;
>  
> -	if (!pager)
> +	if (!tmp_pager)
>  		return;
>  
> +	pager = xstrdup(tmp_pager);
> +

Why are we making a copy of the pager string? When it's pushed into the
strvec, that will take ownership of it. Your patch creates a leak (in
the case that we start_command() doesn't fail, and we miss the new
free() calls you added).

> diff --git a/run-command.c b/run-command.c
> index f329391154ae..d2b7647afdd8 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -19,6 +19,7 @@ void child_process_clear(struct child_process *child)
>  {
>  	strvec_clear(&child->args);
>  	strvec_clear(&child->env_array);
> +	memset(child, 0, sizeof(*child));
>  }

This doesn't set up a child_process to be correctly reused, as the
initialized state for a strvec is not all-bits-zero (though it often
works in practice).

The patch I showed above fixes the use-after-free by making sure the
child_process struct is initialized before we use it. But we could also
change the semantics of _clear() to make sure it is ready for reuse. To
do that, you'd want to just call child_process_init() here.

There's some precedent in that with other APIs (e.g., strvec_clear()
makes the struct ready for reuse immediately). Plus it's harder for the
callers to get wrong (after adding such a line, setup_pager() does not
have to do anything else at all).

So this single-line change also fixes the use-after-free, without any of
the other stuff:

diff --git a/run-command.c b/run-command.c
index f40df01c77..92e00d9455 100644
--- a/run-command.c
+++ b/run-command.c
@@ -21,6 +21,7 @@ void child_process_clear(struct child_process *child)
 {
 	strvec_clear(&child->args);
 	strvec_clear(&child->env_array);
+	child_process_init(child);
 }
 
 struct child_to_clean {

-Peff
