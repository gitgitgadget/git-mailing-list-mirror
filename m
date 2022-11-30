Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5077C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 21:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiK3VEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 16:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiK3VEo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 16:04:44 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF355CBD
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 13:04:43 -0800 (PST)
Received: (qmail 19143 invoked by uid 109); 30 Nov 2022 21:04:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Nov 2022 21:04:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8299 invoked by uid 111); 30 Nov 2022 21:04:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Nov 2022 16:04:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Nov 2022 16:04:42 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] commit: don't lazy-fetch commits
Message-ID: <Y4fFaoRFro2hNDdv@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <6af8dcebd14d803fc8d2a01fbcc7f42ff380719d.1669839849.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6af8dcebd14d803fc8d2a01fbcc7f42ff380719d.1669839849.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2022 at 12:30:49PM -0800, Jonathan Tan wrote:

> When parsing commits, fail fast when the commit is missing or
> corrupt, instead of attempting to fetch them. This is done by inlining
> repo_read_object_file() and setting the flag that prevents fetching.
> 
> This is motivated by a situation in which through a bug (not necessarily
> through Git), there was corruption in the object store of a partial
> clone. In this particular case, the problem was exposed when "git gc"
> tried to expire reflogs, which calls repo_parse_commit(), which triggers
> fetches of the missing commits.

Makes sense.

> diff --git a/commit.c b/commit.c
> index 572301b80a..17e71f5be4 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -508,6 +508,13 @@ int repo_parse_commit_internal(struct repository *r,
>  	enum object_type type;
>  	void *buffer;
>  	unsigned long size;
> +	const struct object_id *real_oid;
> +	struct object_info oi = {
> +		.typep = &type,
> +		.sizep = &size,
> +		.contentp = &buffer,
> +		.real_oidp = &real_oid,
> +	};
>  	int ret;
>  
>  	if (!item)
> @@ -516,11 +523,18 @@ int repo_parse_commit_internal(struct repository *r,
>  		return 0;
>  	if (use_commit_graph && parse_commit_in_graph(r, item))
>  		return 0;
> -	buffer = repo_read_object_file(r, &item->object.oid, &type, &size);
> -	if (!buffer)
> +
> +	/*
> +	 * Git does not support partial clones that exclude commits, so set
> +	 * OBJECT_INFO_SKIP_FETCH_OBJECT to fail fast when an object is missing.
> +	 */
> +	if (oid_object_info_extended(r, &item->object.oid, &oi,
> +	    OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT) < 0) {
> +		die_if_corrupt(r, &item->object.oid, real_oid);
>  		return quiet_on_missing ? -1 :
>  			error("Could not read %s",
>  			     oid_to_hex(&item->object.oid));
> +	}

OK, so we know we want a commit object because we're in the
commit-parsing function, so we just ask to disable fetching.

Two devil's advocate thoughts:

  1. What if we're wrong that it's a commit? If somebody references a
     blob in a commit "parent" header, the "right" outcome is for us to
     say "oops, the type is wrong" when we try to parse it as a commit.
     But now in a partial clone, we might avoid fetching that supposed
     commit and say "you don't have this object", even though we could
     get it.

     I think I'm OK with that. Either way, the repo is corrupt, and
     we'll have informed the user of that. The fact that this bizarre
     and specific sequence of corruptions might not go as far as it can
     to deduce the root cause is probably fine.

  2. Are there other places where we'd want to do the same thing? E.g.,
     in parse_object() we might ask for an object (not knowing its type)
     only to find out that it is a commit. But we have no idea if we
     lazy-fetched it or not!

     I had somehow imagined your series would be hooking in at the level
     of the lazy-fetch code, and complaining about fetching commits. But
     that may be tricky to do, because we really don't know the type
     until after we fetch it, and selectively removing an object from
     the odb is quite hard. We'd probably have to tell the other side
     "please, don't send me any commits", which requires a protocol
     extension, and...yuck.

     By comparison, your approach is an easy win that may catch problems
     in practice (and is certainly better than the status quo).

-Peff
