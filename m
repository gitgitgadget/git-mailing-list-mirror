Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7DEC636CD
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 12:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjBAMuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 07:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjBAMuh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 07:50:37 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6756A5A
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 04:50:36 -0800 (PST)
Received: (qmail 31839 invoked by uid 109); 1 Feb 2023 12:50:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 12:50:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20140 invoked by uid 111); 1 Feb 2023 12:50:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 07:50:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 07:50:35 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 6/6] hash-object: use fsck for object checks
Message-ID: <Y9pgG10dAoQABGXG@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8haHL9xIWntSm0/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8haHL9xIWntSm0/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 03:44:12PM -0500, Jeff King wrote:

> @@ -2350,12 +2340,13 @@ static int index_mem(struct index_state *istate,
>  		}
>  	}
>  	if (flags & HASH_FORMAT_CHECK) {
> -		if (type == OBJ_TREE)
> -			check_tree(buf, size);
> -		if (type == OBJ_COMMIT)
> -			check_commit(buf, size);
> -		if (type == OBJ_TAG)
> -			check_tag(buf, size);
> +		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
> +
> +		opts.strict = 1;
> +		opts.error_func = hash_format_check_report;
> +		if (fsck_buffer(null_oid(), type, buf, size, &opts))
> +			die(_("refusing to create malformed object"));
> +		fsck_finish(&opts);
>  	}

By the way, I wanted to call out one thing here that nobody mentioned
during review: we are not checking the return value of fsck_finish().

That is a bit of a weird function. We must call it because it cleans up
any resources allocated during the fsck_buffer() call. But it also is
the last chance to fsck any special blobs (like those that are found as
.gitmodules, etc). We only find out the filenames while looking at the
enclosing trees, so we queue them and then check the blobs later.

So if we are hashing a blob, that is mostly fine. We will not have the
blob's name queued as anything special, and so the fsck is a noop.

But if we fsck a tree, and it has a .gitmodules entry pointing to blob
X, then we would also pull X from the odb and fsck it during this
"finish" phase.

Which leads me to two diverging lines of thought:

  1. One of my goals with this series is that one could add objects to
     the repository via "git hash-object -w" and feel confident that no
     fsck rules were violated, because fsck implements some security
     checks. In the past when GitHub rolled out security checks this was
     a major pain, because objects enter repositories not just from
     pushes, but also from web-client activity (e.g., editing a blob on
     the website). And since Git had no way to say "fsck just this
     object", we ended up implementing the fsck checks multiple times,
     in libgit2 and in some of its calling code.

     So I was hoping that just passing the objects to "hash-object"
     would be a viable solution. I'm not sure if it is or not. If you
     just hash a blob, then we'll have no clue it's a .gitmodules file.
     OTOH, you have to get the matching tree which binds the blob to the
     .gitmodules path somehow. So if that tree is fsck'd, and then
     checks the blob during fsck_finish(), that should be enough.
     Assuming that fsck complains when the pointed-to blob cannot be
     accessed, which I think it should (because really, incremental
     pushes face the same problem).

     In which case we really ought to be checking the result of
     fsck_finish() here and complaining.

  2. We're not checking fsck connectivity here, and that's intentional.
     So you can "hash-object" a tree that points to blobs that we don't
     actually have. But if you hash a tree that points a .gitmodules
     entry at a blob that doesn't exist, then that will fail the fsck
     (during the finish step). And respecting the fsck_finish() exit
     code would break that.

     As an addendum, in a regular fsck, many trees might mention the
     same blob as .gitmodules, and we'll queue that blob to be checked
     once. But here, we are potentially running a bunch of individual
     fscks, one per object we hash. So if you had, say, 1000 trees that
     all mentioned the same blob (because other entries were changing),
     and you tried to hash them all with "hash-object --stdin-paths" or
     similar, then we'd fsck that blob 1000 times.

     Which isn't wrong, per se, but seems inefficient. Solving it would
     require keeping track of what has been checked between calls to
     index_mem(). Which is kind of awkward, seeing as how low-level it
     is. It would be a lot more natural if all this checking happened in
     hash-object itself.

So I dunno. The code above is doing (2), albeit with the inefficiency of
checking blobs that we might not care about. I kind of think (1) is the
right thing, though, and anybody who really wants to make trees that
point to bogus .gitmodules can use --literally.

-Peff
