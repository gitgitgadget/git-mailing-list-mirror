Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237D3C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 02:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJKCCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 22:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJKCCP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 22:02:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8918562AB1
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 19:02:14 -0700 (PDT)
Received: (qmail 30081 invoked by uid 109); 11 Oct 2022 02:02:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 02:02:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16503 invoked by uid 111); 11 Oct 2022 02:02:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 22:02:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 22:02:13 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 4/7] shortlog: support arbitrary commit format `--group`s
Message-ID: <Y0TOpVF+Y70YJHzx@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <6f38990cc2ea8460ce37437e0770784d9b712dab.1665448437.git.me@ttaylorr.com>
 <Y0TDDvzeCxIMFbG5@coredump.intra.peff.net>
 <Y0TF0M6UzLS9r6iM@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0TF0M6UzLS9r6iM@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 09:24:32PM -0400, Taylor Blau wrote:

> > Hmm. I see why we don't need to guard this with:
> >
> >   if (log->groups & SHORTLOG_GROUP_FORMAT)
> >
> > since our helper function is a noop if log->format is empty. But I
> > wonder if:
> >
> >   - it's more clear to match the others (although it looks like they are
> >     going away later, so that potentially becomes a non-issue)
> >
> >   - it's useful to have a conditional that lets us skip any setup work.
> >     For trailers, in particular, we call logmsg_reencode(), which is
> >     potentially expensive. OTOH, it would be easy for the helper
> >     function to just return early when log->format.nr is 0.
> 
> In this case, `insert_records_from_format()` is cheap when
> log->format.nr is 0. It is limited to setting up a strbuf to
> STRBUF_INIT, and then calling strbuf_release() on it before returning.
> 
> And, indeed, the remaining conditionals go away by the final patch, so
> you may want to decide then if it looks good to you or not.

Right. Having read to the end, a few new thoughts:

  - I'm skeptical on the conversion of --group=trailer to use the
    formats. It seems more complicated. The others seem fine.

    As a result, I do think it's awkward to check bits for log.format
    (since now there are many), and we should just enter the helper
    function unconditionally. I do think it's a little weird to check
    the TRAILER bit just before it though (assuming we'd leave that in
    place). But it would be natural for us to just return early and skip
    any setup work in insert_records_from_trailers(). I.e., something
    like this:

    diff --git a/builtin/shortlog.c b/builtin/shortlog.c
    index 086dfee45a..19d953c26a 100644
    --- a/builtin/shortlog.c
    +++ b/builtin/shortlog.c
    @@ -170,6 +170,9 @@ static void insert_records_from_trailers(struct shortlog *log,
     	const char *commit_buffer, *body;
     	struct strbuf ident = STRBUF_INIT;
     
    +	if (!log->trailers.nr)
    +		return;
    +
     	/*
     	 * Using format_commit_message("%B") would be simpler here, but
     	 * this saves us copying the message.
    @@ -240,9 +243,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
     		    strset_add(&dups, ident.buf))
     			insert_one_record(log, ident.buf, oneline_str);
     	}
    -	if (log->groups & SHORTLOG_GROUP_TRAILER) {
    -		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
    -	}
    +	insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
     
     	strset_clear(&dups);
     	strbuf_release(&ident);

  - I mentioned possible setup work. And indeed, I think it may be
    useful for insert_records_from_format() to load and cache the commit
    message once via get_commit_buffer(), since that result could then
    be used by all formats. But that is not really specific to
    --group=format! The existing code would benefit for any multi-group
    invocation. So any such setup should probably be at the top of
    shortlog_add_commit() anyway.

> >   - since the multiple-option behavior is so subtle, maybe show a case
> >     where two formats partially overlap. A plausible one is "--group=%aN
> >     --group=%cN", but the test setup might need tweaked to cover both.
> >     There's an existing "multiple groups" test that might come in handy.
> 
> Interesting. I was starting to write that test up, but then realized
> that this will be covered by the end of the series, since the
> `--group=trailer` machinery is reimplemented in terms of the new format
> group.

True, if we follow through on that. ;)

-Peff
