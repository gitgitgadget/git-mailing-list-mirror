Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F9EC433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE62D20786
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgH0EoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:44:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:42248 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgH0EoV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 00:44:21 -0400
Received: (qmail 13231 invoked by uid 109); 27 Aug 2020 04:44:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2020 04:44:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22595 invoked by uid 111); 27 Aug 2020 04:44:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2020 00:44:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Aug 2020 00:44:20 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] run_command: teach API users to use embedded 'args' more
Message-ID: <20200827044420.GA3360616@coredump.intra.peff.net>
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
 <20200826194650.4031087-1-gitster@pobox.com>
 <20200826194650.4031087-3-gitster@pobox.com>
 <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
 <xmqqmu2ht58g.fsf_-_@gitster.c.googlers.com>
 <20200827042157.GC3346457@coredump.intra.peff.net>
 <CAPig+cS1uMw6YDVjzb8FbBmC=iVjged-wHu0LF2+trmW-4ZfVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cS1uMw6YDVjzb8FbBmC=iVjged-wHu0LF2+trmW-4ZfVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 12:31:52AM -0400, Eric Sunshine wrote:

> On Thu, Aug 27, 2020 at 12:22 AM Jeff King <peff@peff.net> wrote:
> > I've actually considered dropping child_process.argv entirely. Having
> > two separate ways to do the same thing gives the potential for
> > confusion. [...]
> >
> > Likewise for child_process.env_array.
> 
> builtin/worktree.c:add_worktree() is a case in which an environment
> strvec is built once and re-used for multiple run_command()
> invocations by re-assigning it to child_process.env before each
> run_command(). It uses child_process.env rather than
> child_process.env_array because run_command() clears
> child_process.env_array upon completion, which makes it difficult to
> reuse a prepared environment strvec repeatedly.
> 
> Nevertheless, that isn't much of a reason to keep child_process.env.
> Refactoring add_worktree() a bit to rebuild the environment strvec
> on-demand wouldn't be very difficult.

I think they'd still be one-liner changes, like:

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 378f332b5d..b40f0d4cea 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -422,7 +422,7 @@ static int add_worktree(const char *path, const char *refname,
 			strvec_push(&cp.args, "--quiet");
 	}
 
-	cp.env = child_env.v;
+	strvec_pushv(&cp.env_array, child_env.v);
 	ret = run_command(&cp);
 	if (ret)
 		goto done;
@@ -433,7 +433,7 @@ static int add_worktree(const char *path, const char *refname,
 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 		if (opts->quiet)
 			strvec_push(&cp.args, "--quiet");
-		cp.env = child_env.v;
+		strvec_pushv(&cp.env_array, child_env.v);
 		ret = run_command(&cp);
 		if (ret)
 			goto done;

I think there are other opportunities for cleanup, too:

  - the code right above the second hunk clears cp.args manually. That
    shouldn't be necessary because run_command() will leave it in a
    blank state (and we're already relying on that, since otherwise we'd
    be left with cruft in other fields from the previous run).

  - check_clean_worktree() only uses it once, and could drop the
    separate child_env (and in fact appears to leak it)

-Peff
