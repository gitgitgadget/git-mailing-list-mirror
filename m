Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8532C2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 20:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61952071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 20:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgAYUFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 15:05:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:44722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726448AbgAYUFz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 15:05:55 -0500
Received: (qmail 19410 invoked by uid 109); 25 Jan 2020 20:05:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 20:05:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20222 invoked by uid 111); 25 Jan 2020 20:13:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jan 2020 15:13:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Jan 2020 15:05:54 -0500
From:   Jeff King <peff@peff.net>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] doc: clarify "explicitly given" in push.default
Message-ID: <20200125200554.GC5519@coredump.intra.peff.net>
References: <ed9a0485-1e6c-79ae-6a59-655105203728@googlemail.com>
 <20200125003836.GA568952@coredump.intra.peff.net>
 <b4c31e50-6da5-7699-1069-d94091f768bd@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4c31e50-6da5-7699-1069-d94091f768bd@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 25, 2020 at 08:38:04AM +0100, Bert Wesarg wrote:

> thanks for this pointer. My initial pointer was the help for push.default:
> 
>  From git-config(1):
> 
>        push.default
>            Defines the action git push should take if no refspec is explicitly
>            given. Different values are well-suited for specific workflows; for
> 
> Thus I expected, that this takes effect, when just calling 'git push'.

Yeah, I agree "explicitly given" is vague there. Perhaps the patch below
is worth doing?

> What I actually want to achieve, is to track a remote branch with a
> different name locally, but 'git push' should nevertheless push to
> tracked remote branch.
> 
> In my example above, befor adding the 'push.origin.push' refspec, rename the branch:
> 
>     $ git branch -m local
>     $ git push --dry-run
>       To ../bare.git
>        * [new branch]      local -> local
> 
> Is it possible that this pushes to the tracked branch automatically,
> and because I have multiple such branches, without the use of a push
> refspec.

I think if push.default is set to "upstream" then it would do what you
want as long as you set the upstream of "local" (e.g., by doing "git
branch --set-upstream-to=origin/master local).

There's another way of doing this, which is when you have a "triangular"
flow: you might pull changes from origin/master into your local branch
X, but then push them elsewhere. Usually this would be pushing to a
branch named X on a different remote than origin (e.g., your public fork
of upstream on a server). And for that you can set branch.X.pushRemote.

There's no corresponding triangular config branch.X.pushBranch to push
to a different name than "X" on the remote. And while I do think it
would be rare to want it, I could imagine a case (you have a triangular
flow where everybody shares a central repo, but you want to push to some
local namespace within it; usually people do that now by just making the
namespace part of their local branch names, too).

Anyway, here's the documentation patch.

-- >8 --
Subject: [PATCH] doc: clarify "explicitly given" in push.default

The documentation for push.default mentions that it is used if no
refspec is "explicitly given". Let's clarify that giving a refspec on
the command-line _or_ in the config will override it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config/push.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 0a0e000569..554ab44b4c 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -1,6 +1,7 @@
 push.default::
 	Defines the action `git push` should take if no refspec is
-	explicitly given.  Different values are well-suited for
+	explicitly given (either on the command-line or via a
+	`remote.*.push` config option). Different values are well-suited for
 	specific workflows; for instance, in a purely central workflow
 	(i.e. the fetch source is equal to the push destination),
 	`upstream` is probably what you want.  Possible values are:
-- 
2.25.0.430.g8dfc7de6f7

