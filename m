Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C9C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 22:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbjELWBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjELWBU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 18:01:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B1C7AB3
        for <git@vger.kernel.org>; Fri, 12 May 2023 15:01:18 -0700 (PDT)
Received: (qmail 14656 invoked by uid 109); 12 May 2023 22:01:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 May 2023 22:01:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26462 invoked by uid 111); 12 May 2023 22:01:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 May 2023 18:01:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 12 May 2023 18:01:17 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
Message-ID: <20230512220117.GA2971903@coredump.intra.peff.net>
References: <cover.1683847221.git.me@ttaylorr.com>
 <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
 <20230512212456.GA2495860@coredump.intra.peff.net>
 <20230512214542.GB2495860@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230512214542.GB2495860@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 05:45:43PM -0400, Jeff King wrote:

> The thing that confused me when looking at the code earlier is that
> git-prune itself checks the mtime of the objects, too, even if they were
> not mentioned in the recent-but-reachable walk. That seems redundant to
> me, but somehow it isn't. If I do:
> 
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 5dc9b20720..22b7ce4b10 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -92,7 +92,7 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
>  		return 0;
>  	}
>  	if (st.st_mtime > expire)
> -		return 0;
> +		BUG("object should have been saved via is_object_reachable!");
>  	if (show_only || verbose) {
>  		enum object_type type = oid_object_info(the_repository, oid,
>  							NULL);
> 
> then t5304 shows some failures. I'm not quite sure what is going on, but
> _if_ that mtime check in prune_object() is important, then it probably
> should also respect the hook mechanism. So there may be a (3) to add to
> your patch there.

Ah, I see. The problem is that "git prune --expire=never" relies on this
check. In mark_reachable_objects(), we take a "0" expiration as "do not
bother adding these objects to the traversal", so it's here that we
catch them and say "ah, we are not expiring anything, so keep this".

If my hack above is switched to:

diff --git a/builtin/prune.c b/builtin/prune.c
index 5dc9b20720..108305cd26 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -91,8 +91,11 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
 		error("Could not stat '%s'", fullpath);
 		return 0;
 	}
-	if (st.st_mtime > expire)
-		return 0;
+	if (st.st_mtime > expire) {
+		if (!expire)
+			return 0; /* we are not expiring anything! */
+		BUG("object should have been saved via is_object_reachable!");
+	}
 	if (show_only || verbose) {
 		enum object_type type = oid_object_info(the_repository, oid,
 							NULL);

then all of the tests pass. I do suspect this code could trigger racily
in the real world (we do our traversal, and then a new object is added,
which is of course recent). So we would not want to drop the check.

Is it important there for your patch to kick in and say "we were
specifically asked to consider this object recent, so do so"? I think it
shouldn't matter, because any such object is by definition recent,
having an mtime greater than or equal to when we started (it cannot even
get racily old while we traverse, because we decide the cutoff time as
an absolute value even before starting the traversal). The strict
greater-than in the check makes it feel like an off-by-one problem, but
unless you are saying "now" it must be at least 1 second in the past
anyway.

It does make me wonder why "git prune --expire=never" does not simply
exit immediately. Isn't there by definition nothing useful to do?

-Peff
