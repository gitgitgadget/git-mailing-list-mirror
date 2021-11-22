Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE80C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 04:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhKVEi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 23:38:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:36022 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhKVEi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 23:38:58 -0500
Received: (qmail 18535 invoked by uid 109); 22 Nov 2021 04:35:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 04:35:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9495 invoked by uid 111); 22 Nov 2021 04:35:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Nov 2021 23:35:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 21 Nov 2021 23:35:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>, git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Message-ID: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
 <xmqqfsrplz3z.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfsrplz3z.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 21, 2021 at 06:10:08PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We'd usually leave of "Reviewed-by" until the reviewer has had a chance
> > to see _this_ version of the patch. I.e., usually it would not be added
> > by the submitter, but by the maintainer (unless you are resending
> > verbatim a patch that already got review).
> >
> >> diff --git a/run-command.c b/run-command.c
> >> index f329391154ae..a7bf81025afb 100644
> >> --- a/run-command.c
> >> +++ b/run-command.c
> >> @@ -19,6 +19,7 @@ void child_process_clear(struct child_process *child)
> >>  {
> >>  	strvec_clear(&child->args);
> >>  	strvec_clear(&child->env_array);
> >> +	child_process_init(child);
> >>  }
> >
> > And naturally I agree that the patch itself looks good. :)
> 
> Well, not to me X-<.  This is way too aggressive a change to be made
> lightly without auditing the current users of run_command API.

Yikes. Thanks for a dose of sanity. I was looking too much at just the
pager tests.

> It is rather common for us to reuse "struct child_process" in a code
> path, e.g. builtin/worktree.c::add_worktree() prepares a single
> instance of such a struct, sets cp.git_cmd to true, and runs either
> "update-ref" or "symbolic-ref" to update "HEAD".  After successful
> invocation of such a git subcommand, it then runs "git reset --hard",
> with this piece of code:
> 
> 	cp.git_cmd = 1;
> 
> 	if (!is_branch)
> 		strvec_pushl(&cp.args, "update-ref", "HEAD",
> 			     oid_to_hex(&commit->object.oid), NULL);
> 	else {
> 		strvec_pushl(&cp.args, "symbolic-ref", "HEAD",
> 			     symref.buf, NULL);
> 		if (opts->quiet)
> 			strvec_push(&cp.args, "--quiet");
> 	}
> 
> 	cp.env = child_env.v;
> 	ret = run_command(&cp);
> 	if (ret)
> 		goto done;
> 
> 	if (opts->checkout) {
> 		cp.argv = NULL;
> 		strvec_clear(&cp.args);
> 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
> 		if (opts->quiet)
> 			strvec_push(&cp.args, "--quiet");
> 		cp.env = child_env.v;
> 		ret = run_command(&cp);
> 		if (ret)
> 			goto done;
> 	}

This is a pretty horrid interface, in that the caller has to understand
which bits of "cp" need to be adjusted: setting cp.argv to NULL, but
also potentially cp.env (if cp.env_array was used), and clearing any
stdin/out/err descriptors created as pipes in the previous command. And
probably more; that's just off the top of my head.

But clearly there's a bunch of code relying on the current state of
affairs.

> Now, we could argue that this existing caller is too lazy to assume
> that cp.git_cmd bit will be retained after run_command()
> successfully finishes and can reuse the structure without setting
> the bit again, and it should be more defensive.  And "successful
> run_command() clears the child process so that you'll get a clean
> slate" may even be a better API in the longer term.
> 
> But then a change like this one that changes the world order to make
> it a better place is also responsible to ensure that the callers are
> already following the new world order.

Yep. But I do worry a bit about changing the interface in such a subtle
way, as nothing would catch topics in flight.

> When merged to 'seen', this literally destroys tons of tests (the
> first and easiest one to observe may be t0002).

Forget 'seen'. Applying it on master shows plenty of breakages. :)

I think we should probably punt on this direction, and just make sure
that setup_pager() either reinitializes the child_process as appropriate
(as in the patch I showed in the earlier thread) or just refuses to try
running the pager twice (I didn't show a patch, but it should just be a
matter of setting a static flag).

-Peff
