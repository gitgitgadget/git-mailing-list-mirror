Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3161C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 06:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E1120E65
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 06:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgKQGxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 01:53:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:60070 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKQGxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 01:53:06 -0500
Received: (qmail 14240 invoked by uid 109); 17 Nov 2020 06:53:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 06:53:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23374 invoked by uid 111); 17 Nov 2020 06:53:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Nov 2020 01:53:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Nov 2020 01:53:04 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] chdir-notify: UNLEAK registrated callback entries
Message-ID: <20201117065304.GA41136@coredump.intra.peff.net>
References: <58f36a04-afa7-3cf3-ce0a-ad53004dd774@web.de>
 <20201117044923.3703483-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117044923.3703483-1-newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 08:49:23PM -0800, Elijah Newren wrote:

> > Right, avoiding list.h like below lets Valgrind classify the memory as
> > "still reachable", without UNLEAK.  Not sure if it's worth it, though.
> >
> > Note my somewhat concerning knee-jerk reaction to write some macros. ;)
> 
> I've got a local patch that changes these to actually be freed as yet
> another route we could go.  It's mixed with a few (half-baked)
> revision-related memory cleanups that should be separated, and I'm
> unsure if there are other places that would need a finalize_globals()
> call too, but it's another approach to consider...

Here are a few thoughts...

> diff --git a/builtin/fast-rebase.c b/builtin/fast-rebase.c
> index 19333ca42d..32cab36ad3 100644
> --- a/builtin/fast-rebase.c
> +++ b/builtin/fast-rebase.c
> @@ -173,6 +173,8 @@ int cmd_fast_rebase(int argc, const char **argv, const char *prefix)
>  		last_commit = create_commit(result.tree, commit, last_commit);
>  	}
>  	fprintf(stderr, "\nDone.\n");
> +	rev_info_free(&revs);
> +	memset(&revs, 0, sizeof(revs));

This one could easily be an UNLEAK(), since we're presumably exiting
from cmd_fast_rebase() soon after. But I certainly don't mind a real
cleanup.

Probably rev_info_free() should leave the rev_info in a reasonable state
(so callers don't have to re-zero it).

> diff --git a/cache.h b/cache.h
> index c0072d43b1..b9b543f75b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -604,6 +604,9 @@ const char *setup_git_directory(void);
>  char *prefix_path(const char *prefix, int len, const char *path);
>  char *prefix_path_gently(const char *prefix, int len, int *remaining, const char *path);
>  
> +/* Release resources related to global config. */
> +void finalize_globals(void);

Yuck. Remembering to put things in this, and remembering to call it in
all of the right places seems ugly.

If we want to go this route, then I think individual pieces of code
could register their own atexit() handlers to clean up. But...

> +void chdir_deregister_all(void)
> +{
> +	struct list_head *pos, *tmp;
> +
> +	if (list_empty(&chdir_notify_entries))
> +		return;
> +
> +	list_for_each_safe(pos, tmp, &chdir_notify_entries) {
> +		struct chdir_notify_entry *e =
> +			list_entry(pos, struct chdir_notify_entry, list);
> +		free(e);
> +	}
> +	memset(&chdir_notify_entries, 0, sizeof(chdir_notify_entries));
> +}

I disagree that this is actually a leak. The memory is still referenced
by the list, just like a ton of other global variables (e.g., quite a
lot of config or environment variables that are loaded throughout a
normal program).

So my inclination is to leave referenced globals like this. If there are
tools that are confused by our linked list structure, then we should
adjust our tools (either using ASan, or turning off valgrind's "possibly
lost" report).

(My preference is to use ASan in general, because it's _so_ much
faster. Running the whole suite under valgrind is pretty painful, and
ideally we'd eventually hit a point where it was possible to run the
whole suite with leak-checking enabled).

> diff --git a/git.c b/git.c
> index af84f11e69..4b04988909 100644
> --- a/git.c
> +++ b/git.c
> @@ -358,6 +358,7 @@ static int handle_alias(int *argcp, const char ***argv)
>  			trace2_cmd_name("_run_shell_alias_");
>  
>  			ret = run_command(&child);
> +			finalize_globals();
>  			if (ret >= 0)   /* normal exit */
>  				exit(ret);

I thought common-main.c might be a better place to put something like
this, but any time we exit() it gets weird (of course, atexit() would
take care of this).

OTOH, if we call exit() then most things are still on the stack (or in
globals), so we're not actually leaking those things. I think the root
of this chdir-notify issue is not that we don't still have a handle to
the memory, but that the linked list confuses valgrind.  But the same
would be true if we were holding another linked list (or hashmap) in a
stack variable, referenced via the heap, etc, and called exit().

> +void rev_info_free(struct rev_info *revs)
> +{
> +	int i;
> +
> +	for (i = 0; i < revs->cmdline.nr; i++)
> +		free((char*)revs->cmdline.rev[i].name);
> +	free(revs->cmdline.rev);
> +}

I suspect there's quite a bit more needed here (René already found a
case where pathspecs needed to be freed). But I don't mind if we start
small and add to it as leak-checking notices items.

-Peff
