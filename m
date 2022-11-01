Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF19C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 10:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiKAKPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 06:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKAKPf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 06:15:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B1DF9E
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 03:15:34 -0700 (PDT)
Received: (qmail 5556 invoked by uid 109); 1 Nov 2022 10:15:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 10:15:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21643 invoked by uid 111); 1 Nov 2022 10:15:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Nov 2022 06:15:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Nov 2022 06:15:33 -0400
From:   Jeff King <peff@peff.net>
To:     Martin von Zweigbergk <martinvonz@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug in `git branch --delete main` when on other orphan branch
Message-ID: <Y2DxxZAFbN8juHY6@coredump.intra.peff.net>
References: <CAESOdVBpsbJ0obD=qDjHBJg-wwWUL5sQ-7X_h13Vw39Q9QUzHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAESOdVBpsbJ0obD=qDjHBJg-wwWUL5sQ-7X_h13Vw39Q9QUzHA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 10:46:37PM -0700, Martin von Zweigbergk wrote:

> I did this:
> git init test
> cd test
> echo a > file
> git add file
> git commit -m a
> git checkout --orphan other
> git branch --delete main
> 
> The last command fails with:
> fatal: Couldn't look up commit object for HEAD
> 
> That's a bug, right? I can of course work around it with `rm
> .git/refs/heads/main`.

Sort of. This is part of the "is the thing we are deleting merged into
HEAD" check. It tries to look up the HEAD and calls die() when it can't.
The more correct thing, I think, would be for it to just return "nope,
there is no HEAD so nothing is merged into it".

But that probably won't make your command succeed; you'll just get:

  error: The branch 'main' is not fully merged.

At which point you'd retry with "-f" (or "-D"). And then it succeeds,
because the force path is smart enough to skip loading HEAD, from
67affd5173 (git-branch -D: make it work even when on a yet-to-be-born
branch, 2006-11-24).

At the time, I suspect that logic was "good enough". You'd need "-f"
either way, so it is really just a question of producing a lousy error
message.

But since then, I think there are more cases. For example, 99c419c915
(branch -d: base the "already-merged" safety on the branch it merges
with, 2009-12-29) makes it OK to delete the branch if it's merged to
HEAD _or_ to its upstream. You don't have an upstream in your example,
but it's not hard to imagine one (just start the repo via "clone" rather
than from scratch).

And in that case I think the HEAD check calling die() is actively doing
the wrong thing, and would prevent an otherwise successful deletion.

The fix might be as simple as:

diff --git a/builtin/branch.c b/builtin/branch.c
index 15be0c03ef..f6ff9084c8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -235,11 +235,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
-	if (!force) {
+	if (!force)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
-		if (!head_rev)
-			die(_("Couldn't look up commit object for HEAD"));
-	}
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;

as the later code seems to do the right thing with the NULL head_rev. It
would definitely need more careful investigation (and tests!) to confirm
that, though.

And in the meantime, hopefully you noticed that "-f" is a better
workaround than manually deleting the refs file. :)

-Peff

