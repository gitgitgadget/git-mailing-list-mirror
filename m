Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B51C433E3
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 05:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7B120786
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 05:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgH0FZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:25:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:42270 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgH0FZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 01:25:05 -0400
Received: (qmail 13321 invoked by uid 109); 27 Aug 2020 05:25:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2020 05:25:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22869 invoked by uid 111); 27 Aug 2020 05:25:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2020 01:25:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Aug 2020 01:25:04 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: [PATCH] worktree: fix leak in check_clean_worktree()
Message-ID: <20200827052504.GA3360984@coredump.intra.peff.net>
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
 <20200826194650.4031087-1-gitster@pobox.com>
 <20200826194650.4031087-3-gitster@pobox.com>
 <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
 <xmqqmu2ht58g.fsf_-_@gitster.c.googlers.com>
 <20200827042157.GC3346457@coredump.intra.peff.net>
 <CAPig+cS1uMw6YDVjzb8FbBmC=iVjged-wHu0LF2+trmW-4ZfVw@mail.gmail.com>
 <20200827044420.GA3360616@coredump.intra.peff.net>
 <CAPig+cSA56xgNN0WP4t+YoyNU8fGf5eaz__=4Vh+s=He-tG=DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSA56xgNN0WP4t+YoyNU8fGf5eaz__=4Vh+s=He-tG=DA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 01:03:43AM -0400, Eric Sunshine wrote:

> >   - the code right above the second hunk clears cp.args manually. That
> >     shouldn't be necessary because run_command() will leave it in a
> >     blank state (and we're already relying on that, since otherwise we'd
> >     be left with cruft in other fields from the previous run).
> 
> Right. I wonder why the author of 7f44e3d1de (worktree: make setup of
> new HEAD distinct from worktree population, 2015-07-17) chose to clear
> cp.args manually like that.

I wondered if we might not have cleared the array automatically back
then, but it looks like we did.

I do think this kind of child_process struct reuse is slightly sketchy
in general. Looking at child_process_clear(), we only free the memory,
but leave other fields set. And in fact we rely on that here; git_cmd
needs to remain set for both commands to work. But if the first command
had used, say, cp.in, then we'd be left with a bogus descriptor.

> >   - check_clean_worktree() only uses it once, and could drop the
> >     separate child_env (and in fact appears to leak it)
> 
> Perhaps this unnecessary 'child_env' strvec was a copy/paste from
> add_worktree()? But certainly cp.env_array would be simpler and avoid
> the leak.

Yeah, that was my guess, too.

Most of these issues are more complex and/or should be part of a larger
cleanup effort. But let's fix the leak while we're thinking about it.

-- >8 --
Subject: [PATCH] worktree: fix leak in check_clean_worktree()

We allocate a child_env strvec but never free its memory. Instead, let's
just use the strvec that our child_process struct provides, which is
cleaned up automatically when we run the command.

And while we're moving the initialization of the child_process around,
let's switch it to use the official init function (zero-initializing it
works OK, since strvec is happy enough with that, but it sets a bad
example).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/worktree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 378f332b5d..df214697d2 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -924,7 +924,6 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 static void check_clean_worktree(struct worktree *wt,
 				 const char *original_path)
 {
-	struct strvec child_env = STRVEC_INIT;
 	struct child_process cp;
 	char buf[1];
 	int ret;
@@ -935,15 +934,14 @@ static void check_clean_worktree(struct worktree *wt,
 	 */
 	validate_no_submodules(wt);
 
-	strvec_pushf(&child_env, "%s=%s/.git",
+	child_process_init(&cp);
+	strvec_pushf(&cp.env_array, "%s=%s/.git",
 		     GIT_DIR_ENVIRONMENT, wt->path);
-	strvec_pushf(&child_env, "%s=%s",
+	strvec_pushf(&cp.env_array, "%s=%s",
 		     GIT_WORK_TREE_ENVIRONMENT, wt->path);
-	memset(&cp, 0, sizeof(cp));
 	strvec_pushl(&cp.args, "status",
 		     "--porcelain", "--ignore-submodules=none",
 		     NULL);
-	cp.env = child_env.v;
 	cp.git_cmd = 1;
 	cp.dir = wt->path;
 	cp.out = -1;
-- 
2.28.0.751.g0834cceced

