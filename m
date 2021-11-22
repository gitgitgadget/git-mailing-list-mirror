Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F70C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhKVQdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:33:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:36306 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239211AbhKVQdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:33:19 -0500
Received: (qmail 20493 invoked by uid 109); 22 Nov 2021 16:30:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 16:30:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20547 invoked by uid 111); 22 Nov 2021 16:30:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 11:30:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 11:30:11 -0500
From:   Jeff King <peff@peff.net>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Message-ID: <YZvFkwivicJ/tFAo@coredump.intra.peff.net>
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
 <xmqqfsrplz3z.fsf@gitster.g>
 <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 12:31:19PM -0300, Enzo Matsumiya wrote:

> On 11/21, Junio C Hamano wrote:
> > It is rather common for us to reuse "struct child_process" in a code
> > path, e.g. builtin/worktree.c::add_worktree() prepares a single
> > instance of such a struct, sets cp.git_cmd to true, and runs either
> > "update-ref" or "symbolic-ref" to update "HEAD".  After successful
> > invocation of such a git subcommand, it then runs "git reset --hard",
> > with this piece of code:
> 
> Do you agree that at least NULLing .argv and .env could be part of
> child_process_clear()?
> 
> diff --git a/run-command.c b/run-command.c
> index a7bf81025afb..3839a26eff11 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -18,8 +18,9 @@ void child_process_init(struct child_process *child)
>  void child_process_clear(struct child_process *child)
>  {
>         strvec_clear(&child->args);
> +       child->argv = NULL;
>         strvec_clear(&child->env_array);
> +       child->env = NULL;
>  }

It's still potentially dangerous, as callers which do not use
child->args could be pointing child->argv to to a more stable array, and
expecting it to be reused. It's definitely _less_ dangerous, and maybe
even OK, but you'd still have to look at the callers.

What would be safe is NULLing them if we know they point to the strvecs
that are about to be cleared, like so:

diff --git a/run-command.c b/run-command.c
index f40df01c77..60c7331213 100644
--- a/run-command.c
+++ b/run-command.c
@@ -19,6 +19,10 @@ void child_process_init(struct child_process *child)
 
 void child_process_clear(struct child_process *child)
 {
+	if (child->argv == child->args.v)
+		child->argv = NULL;
+	if (child->env == child->env_array.v)
+		child->env = NULL;
 	strvec_clear(&child->args);
 	strvec_clear(&child->env_array);
 }


> With this change on main, all tests are successful.

That gives us some confidence, but I don't fully trust our tests to
cover every corner case (the bug you found being a good example :) ).

-Peff
