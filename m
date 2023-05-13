Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A59C77B7F
	for <git@archiver.kernel.org>; Sat, 13 May 2023 00:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbjEMALV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 20:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEMALU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 20:11:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26921BE6
        for <git@vger.kernel.org>; Fri, 12 May 2023 17:11:18 -0700 (PDT)
Received: (qmail 15289 invoked by uid 109); 13 May 2023 00:11:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 13 May 2023 00:11:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27766 invoked by uid 111); 13 May 2023 00:11:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 May 2023 20:11:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 12 May 2023 20:11:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
Message-ID: <20230513001117.GA2974285@coredump.intra.peff.net>
References: <cover.1683847221.git.me@ttaylorr.com>
 <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
 <20230512212456.GA2495860@coredump.intra.peff.net>
 <20230512214542.GB2495860@coredump.intra.peff.net>
 <20230512220117.GA2971903@coredump.intra.peff.net>
 <xmqq4johnnjr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4johnnjr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 04:21:44PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It does make me wonder why "git prune --expire=never" does not simply
> > exit immediately. Isn't there by definition nothing useful to do?
> 
> I think the answer to the question is "no", but if I have to guess
> why such a low-hanging fruit optimization possibility has not been
> exploited so far is because it does not optimize a useful case,
> perhaps?  IOW, falling into "if it hurts, then don't do it" category?

I think it would come up any time you run "git gc", if you've set
gc.pruneExpire to "never". And then it wastes time running a full object
walk (which is 30+ seconds for linux.git) even though it won't do
anything useful.

Curiously, git-gc is sprinkled with "if (prune_expire)" logic, including
skipping the call to git-prune entirely. But that only kicks in if you
run "git gc --no-prune". If "never" is truly the same thing (and I
cannot off the top of my head think of a reason that it isn't), then
this:

diff --git a/builtin/gc.c b/builtin/gc.c
index f3942188a6..5118535a4d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -610,6 +610,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
 		die(_("failed to parse prune expiry value %s"), prune_expire);
+	if (prune_expire && !dummy)
+		prune_expire = NULL; /* "never" same as --no-prune */
 
 	if (aggressive) {
 		strvec_push(&repack, "-f");

would bring the two cases in sync (I tried to minimize the diff for
illustration; probably some light refactoring would be in order).

I guess nobody cared because it is not that common to set pruneExpire to
"never". We did something like that at GitHub, but we always drove
repack and prune through our own scripts, not through git-gc. I don't
have access to those scripts anymore, but I'm pretty sure they just
skipped calling git-prune entirely for this case.

So yeah, I think it may just be a curiosity that nobody noticed and
bothered to optimize it. I am tempted to work the above into a proper
patch. We even do something similar already for the reflog expiration
variables.

-Peff
