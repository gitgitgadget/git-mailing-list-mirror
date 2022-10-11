Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA2BC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 01:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJKBus (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJKBuq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 21:50:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBDD5756E
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:50:44 -0700 (PDT)
Received: (qmail 30046 invoked by uid 109); 11 Oct 2022 01:50:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 01:50:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16404 invoked by uid 111); 11 Oct 2022 01:50:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 21:50:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 21:50:42 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 7/7] shortlog: implement `--group=trailer` in terms of
 `--group=<format>`
Message-ID: <Y0TL8unKev9TPytJ@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <02adc297e7661cbc25302b9f5659d2356b8b5008.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02adc297e7661cbc25302b9f5659d2356b8b5008.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 08:34:21PM -0400, Taylor Blau wrote:

> In the same spirit as the previous commit, reimplement
> `--group=trailer:<key>` as a special case of `--group=<format>`, too.
> 
> Unsurprisingly, this reimplementation is a little bit more complicated
> than the previous two. The complexity stems from having to enumerate
> each of the trailers one-by-one, as well as delegating control to
> `parse_ident()` to handle whether or not to show an individual's email.
> 
> To enumerate each trailer in a commit, we set the separator used in the
> pretty format to be a NUL byte. This hack allows us to treat the strbuf
> from `format_commit_message()` as an array of strings.

Hmph. So that's _probably_ OK, but I have to wonder if this is going too
far. The resulting code is not that much shorter, and IMHO is actually a
little more complicated, because of this hack and the extra util bit.

I also would be curious if there is any speed difference between the
two.

I spent a fair bit of time optimizing the regular author/committer paths
(and I think if we restore the skip-the-dedup logic I mentioned earlier
for those, they should be equivalent, as they already use
format_commit_message()). But the internals of the trailer code are
already so slow I doubt it makes much of a difference either way here.

The one thing that could hurt is that multiple trailers now require
multiple format calls, which may load the commit object for each one. I
think _probably_ not because we'd hopefully have it cached in the commit
slab via the save_commit_buffer mechanism. Though I guess if we used the
commit graph in the first place, we would need to load it. We'd also
likely reencode, but that's a noop on utf8 commits, so it's probably not
worth worrying about.

-Peff

PS That last paragraph gives me the suspicion that there's some
   low-hanging optimization fruit here: we want save_commit_buffer on in
   general, but after we visit each commit, we probably should call
   free_commit_buffer() on it to get rid of it, like we do for git-log.
   Probably shortlog is keeping all of the commit messages in memory at
   once (though of course not if the commit-graph is in use).

   If the commit-graph _is_ in use, there's probably the opposite
   optimization we could be doing: we should make sure to load it once,
   then do all of the formats, and then unuse it.

   Those don't have to be part of your series, but might be worth
   looking into while you're in the area.
