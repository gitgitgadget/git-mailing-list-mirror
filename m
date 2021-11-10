Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB2EC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9582160F9E
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhKJU4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 15:56:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:57134 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233029AbhKJU4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 15:56:35 -0500
Received: (qmail 30704 invoked by uid 109); 10 Nov 2021 20:53:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Nov 2021 20:53:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20444 invoked by uid 111); 10 Nov 2021 20:53:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Nov 2021 15:53:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Nov 2021 15:53:40 -0500
From:   Jeff King <peff@peff.net>
To:     Daniel Hahler <git@thequod.de>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git-stash does not handle branch name with slash correctly
Message-ID: <YYwxVO7A29FcN+hN@coredump.intra.peff.net>
References: <693b55f9-3c0e-5a31-5a43-d6495d689779@hahler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <693b55f9-3c0e-5a31-5a43-d6495d689779@hahler.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 07:55:06PM +0100, Daniel Hahler wrote:

> The default (commit) message when creating a stash strips the beginning of
> branch names if they contain a slash,
> e.g. "WIP on 3.2.x: …" instead of "WIP on stable/3.2.x: …"
> 
> From builtin/stash.c (in do_create_stash):
> 
> 	branch_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
> 	if (flags & REF_ISSYMREF)
> 		branch_name = strrchr(branch_ref, '/') + 1;
> 
> 
> Whereas git-legacy-stash has this (in create_stash):
> 
> 	if branch=$(git symbolic-ref -q HEAD)
> 	then
> 		branch=${branch#refs/heads/}
> 	else
> 		branch='(no branch)'
> 	fi
> 	msg=$(printf '%s: %s' "$branch" "$head")
> 
> I think it should also strip only "refs/heads/" or use another method that
> keeps the branch name intact.

Yes, the C behavior just seems wrong (and came as part of the C rewrite,
so doesn't seem intentional). Something like:

diff --git a/builtin/stash.c b/builtin/stash.c
index d441481d68..70dcb15cb7 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1334,7 +1334,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 
 	branch_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
 	if (flags & REF_ISSYMREF)
-		branch_name = strrchr(branch_ref, '/') + 1;
+		skip_prefix(branch_ref, "refs/heads/", &branch_name);
 	head_short_sha1 = find_unique_abbrev(&head_commit->object.oid,
 					     DEFAULT_ABBREV);
 	strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);

seems like the right fix. Do you want to try to work that into a patch
with a test?

-Peff
