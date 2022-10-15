Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DE6C433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 18:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJOSVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 14:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJOSVj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 14:21:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F14A4660B
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 11:21:34 -0700 (PDT)
Received: (qmail 19426 invoked by uid 109); 15 Oct 2022 18:21:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 Oct 2022 18:21:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12137 invoked by uid 111); 15 Oct 2022 18:21:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Oct 2022 14:21:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 Oct 2022 14:21:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
Message-ID: <Y0r6LaxDLjpiRNqS@coredump.intra.peff.net>
References: <xmqqk05cipq8.fsf@gitster.g>
 <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
 <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net>
 <xmqq35buykz1.fsf@gitster.g>
 <Y0VtkmNwjKcXcemP@coredump.intra.peff.net>
 <xmqqpmeyuvxt.fsf@gitster.g>
 <221011.86czayns5x.gmgdl@evledraar.gmail.com>
 <xmqq8rlmujcz.fsf@gitster.g>
 <Y0m8AU+Yf7PREI2E@coredump.intra.peff.net>
 <9d924a5d-5c72-fbe6-270c-a8f6c5fc5850@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d924a5d-5c72-fbe6-270c-a8f6c5fc5850@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 15, 2022 at 08:51:34AM +0200, René Scharfe wrote:

> Am 14.10.22 um 21:44 schrieb Jeff King:
> > And I'd be happy to see all of the run_command_v() variants go away
> > entirely. It does save a few lines, but with modern niceties, it's
> > not very many, and it's much less flexible.
> That would look something like below.
>
> [...]
>  27 files changed, 330 insertions(+), 374 deletions(-)

I was a little surprised we ended up with fewer lines, but I guess most
of that is not in the callers themselves, but deleting the function and
flag definitions.

Most call sites seem to be about as long. IMHO the result is quite
readable, though of course any big change like this carries risk of
regression.

> diff --git a/add-interactive.c b/add-interactive.c
> index f071b2a1b4..ecc5ae1b24 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -997,18 +997,17 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
>  	count = list_and_choose(s, files, opts);
>  	opts->flags = 0;
>  	if (count > 0) {
> -		struct strvec args = STRVEC_INIT;
> +		struct child_process cmd = CHILD_PROCESS_INIT;
> 
> -		strvec_pushl(&args, "git", "diff", "-p", "--cached",
> +		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached",
>  			     oid_to_hex(!is_initial ? &oid :
>  					s->r->hash_algo->empty_tree),
>  			     "--", NULL);
>  		for (i = 0; i < files->items.nr; i++)
>  			if (files->selected[i])
> -				strvec_push(&args,
> +				strvec_push(&cmd.args,
>  					    files->items.items[i].string);
> -		res = run_command_v_opt(args.v, 0);
> -		strvec_clear(&args);
> +		res = run_command(&cmd);
>  	}

So ones like this are just swapping "args" for "cmd.args". It's nice
that we don't have to remember to free (and in some cases, that lets us
return directly rather than stashing the result of run_command(),
cleaning up, and then returning it).

> -static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
> -
>  static const char *term_bad;
>  static const char *term_good;
> 
> @@ -729,20 +727,22 @@ static int is_expected_rev(const struct object_id *oid)
>  enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
>  				  int no_checkout)
>  {
> -	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
>  	struct commit *commit;
>  	struct pretty_print_context pp = {0};
>  	struct strbuf commit_msg = STRBUF_INIT;
> 
> -	oid_to_hex_r(bisect_rev_hex, bisect_rev);
>  	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
> 
> -	argv_checkout[2] = bisect_rev_hex;
>  	if (no_checkout) {
>  		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
>  			   UPDATE_REFS_DIE_ON_ERR);
>  	} else {
> -		if (run_command_v_opt(argv_checkout, RUN_GIT_CMD))
> +		struct child_process cmd = CHILD_PROCESS_INIT;
> +
> +		cmd.git_cmd = 1;
> +		strvec_pushl(&cmd.args, "checkout", "-q",
> +			     oid_to_hex(bisect_rev), "--", NULL);
> +		if (run_command(&cmd))

This one is a little longer, but IMHO worth it regardless to avoid the
magic "2" that must match the NULL stuffed into argv_checkout.

That is mostly coming from using a strvec at all, though. It _could_ use
one and then run_command_v_opt() or whatever, though I like the full
conversion.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 5900b81729..5e14decc22 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -347,58 +347,52 @@ static int save_state(struct object_id *stash)
> 
>  static void read_empty(const struct object_id *oid, int verbose)
>  {
> -	int i = 0;
> -	const char *args[7];
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> 
> -	args[i++] = "read-tree";
> +	strvec_push(&cmd.args, "read-tree");
>  	if (verbose)
> -		args[i++] = "-v";
> -	args[i++] = "-m";
> -	args[i++] = "-u";
> -	args[i++] = empty_tree_oid_hex();
> -	args[i++] = oid_to_hex(oid);
> -	args[i] = NULL;
> +		strvec_push(&cmd.args, "-v");
> +	strvec_pushl(&cmd.args, "-m", "-u", empty_tree_oid_hex(),
> +		     oid_to_hex(oid), NULL);
> 
> -	if (run_command_v_opt(args, RUN_GIT_CMD))
> +	cmd.git_cmd = 1;
> +	if (run_command(&cmd))
>  		die(_("read-tree failed"));
>  }

Likewise this one, which is even worse, as that "7" must match the
number of "i++" lines. So regardless of any run_command_v() conversion,
I am happy to see this move to a strvec (and again, IMHO you might as
well go straight to using cmd.args rather than a separate strvec).

-Peff
