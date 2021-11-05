Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0387C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 07:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21426124F
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 07:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhKEHJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 03:09:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:53688 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhKEHJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 03:09:58 -0400
Received: (qmail 10730 invoked by uid 109); 5 Nov 2021 07:07:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 07:07:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15088 invoked by uid 111); 5 Nov 2021 07:07:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 03:07:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 03:07:18 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Message-ID: <YYTYJpyrxtyR8yYZ@coredump.intra.peff.net>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 04, 2021 at 01:38:22PM +0100, Patrick Steinhardt wrote:

> When writing loose refs, we first create a lockfile, write the new ref
> into that lockfile, close it and then rename the lockfile into place
> such that the actual update is atomic for that single ref. While this
> works as intended under normal circumstences, at GitLab we infrequently
> encounter corrupt loose refs in repositories after a machine encountered
> a hard reset. The corruption is always of the same type: the ref has
> been committed into place, but it is completely empty.

Yes, I've seen this quite a bit, too, and I agree that more fsync()-ing
will probably help.

There are two things that have made me hesitate, though:

  1. This doesn't quite make the write durable. Doing that would also
     require fsyncing the surrounding directory (and so on up the tree).
     This is a much trickier problem, because we often don't even have
     open descriptors for those.

     I think we can ignore that, though. Doing an fsync() here makes
     things strictly better with respect to robustness (especially if
     you care less about "has my ref update been committed to disk" and
     more about "does this end up corrupt after a power failure").

  2. It's not clear what the performance implications will be,
     especially on a busy server doing a lot of ref updates, or on a
     filesystem where fsync() ends up syncing everything, not just the
     one file (my impression is ext3 is such a system, but not ext4).
     Whereas another solution may be journaling data and metadata writes
     in order without worrying about the durability of writing them to
     disk.

     I suspect for small updates (say, a push of one or two refs), this
     will have little impact. We'd generally fsync the incoming packfile
     and its idx anyway, so we're adding may one or two fsyncs on top of
     that. But if you're pushing 100 refs, that will be 100 sequential
     fsyncs, which may add up to quite a bit of latency. It would be
     nice if we could batch these by somehow (e.g., by opening up all of
     the lockfiles, writing and fsyncing them, and then renaming one by
     one).

     So I think we want to at least add a config knob here. That would
     make it easier to experiment, and provides an escape hatch.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 151b0056fe..06a3f0bdea 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1749,6 +1749,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
>  	fd = get_lock_file_fd(&lock->lk);
>  	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
>  	    write_in_full(fd, &term, 1) < 0 ||
> +	    fsync(fd) < 0 ||
>  	    close_ref_gently(lock) < 0) {
>  		strbuf_addf(err,
>  			    "couldn't write '%s'", get_lock_file_path(&lock->lk));

I agree with the sentiment elsewhere that this would probably make sense
for any lockfile. That does probably make batching a bit more difficult,
though it could be layered on top (i.e., we could still fsync in the ref
code, and the lockfile fsync-ing should then become a noop).

-Peff
