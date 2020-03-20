Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97A8C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 06:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8849720709
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 06:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCTGMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 02:12:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:44772 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725446AbgCTGMP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 02:12:15 -0400
Received: (qmail 31149 invoked by uid 109); 20 Mar 2020 06:12:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Mar 2020 06:12:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3212 invoked by uid 111); 20 Mar 2020 06:21:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Mar 2020 02:21:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Mar 2020 02:12:14 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] fetch-pack: lazy fetch using tree:0
Message-ID: <20200320061214.GA511478@coredump.intra.peff.net>
References: <20200319174439.230969-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200319174439.230969-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 10:44:39AM -0700, Jonathan Tan wrote:

> Support for partial clones with filtered trees was added in bc5975d24f
> ("list-objects-filter: implement filter tree:0", 2018-10-07), but
> whenever a lazy fetch of a tree is done, besides the tree itself, some
> other objects that it references are also fetched.
> 
> The "blob:none" filter was added to lazy fetches in 4c7f9567ea
> ("fetch-pack: exclude blobs when lazy-fetching trees", 2018-10-04) to
> restrict blobs from being fetched, but it didn't restrict trees.
> ("tree:0", which would restrict all trees as well, wasn't added then
> because "tree:0" was itself new and may not have been supported by Git
> servers, as you can see from the dates of the commits.)
> 
> Now that "tree:0" has been supported in Git for a while, teach lazy
> fetches to use "tree:0" instead of "blob:none".

This does mean a new client fetching objects for a partial clone from an
older server (pre-bc5975d24f) used to work, but now won't (we couldn't
have fetched from it with a tree filter, but this patch makes the use of
tree:0 unconditional; so even a blob:none followup fetch would use it).
I'm not _too_ broken up about that, given that partial clone support at
that era was pretty clearly labeled as experimental. But it would be a
nice bonus to make it work everywhere.

> (An alternative to doing this is to teach Git a new filter that only
> returns exactly the objects requested, no more - but "tree:0" already
> does that for us for now, hence this patch. If we were to support
> filtering of commits in partial clones later, I think that specifying a
> depth will work to restrict the commits returned, so we won't need an
> additional filter anyway.)

The depth thing might work for commits, though there are a lot of
special code paths taken when the client is asking for shallow commits
that might be better avoided.

Being able to say "only send me the objects I'm asking for" seems like a
much more direct way. It doesn't even need to be a filter, really; it
could be a protocol capability. And in fact I think we'd want a
capability either way, because clients would ideally be able to send the
old "blob:none" for older servers, or the new "only what I'm asking for"
with new servers.

> ---
> This looks like a good change to me - in particular, it makes Git align
> with the (in my opinion, reasonable) mental model that when we lazily
> fetch something, we only fetch that thing. Some issues that I can think
> about:

Yeah, I like the mental model. I just think it should be expressed even
more explicitly. :)

>  - Some hosts like GitHub support some partial clone filters, but not
>    "tree:0".

Yes, this is going to fail against GitHub servers, just like it would
for older servers. One way to prevent that would be to use a "blob"
filter if that's what we originally partial-cloned with. I don't know if
that information always reliably makes it into this code path, though.
I think I'd prefer a capability-based fix in the long run.

We may support "tree:0" eventually at GitHub. It's quick to compute with
bitmaps, just like "blob:none" is. But "tree:1" isn't.

One side note (for Taylor, cc'd): our patches elsewhere to limit the
allowed filters don't make it possible to express the difference between
"tree:0" and "tree:1". It may be worth thinking about that, especially
if it influences the config schema (since we'll have to support it
forever once it makes it into a release).

>  - I haven't figured out the performance implications yet. If we want a
>    tree, I think that we typically will want some of its subtrees, but
>    not all.

I could imagine a scenario where you want to get trees one level at a
time in order to only grab the sub-trees you want based on pathnames
(sort of like sparse-checkout's cone mode). Though you do get into "n+1"
fetches based on tree depth there. If the latency for a fetch is high,
it will be pretty painful.

I can equally imagine there are cases where you want to grab the whole
subtree in one go, but I think that raises another performance issue:
you might already have most of it. E.g., consider a root tree with one
toplevel subtree that contains a million files. You already have the
root tree at some commit A. Now you want to diff against its parent, B.
You ask the server for B^{tree}, and it sends you the million-entry
tree, too (and maybe some blobs?). You could tell it you already have
them, but you don't actually know what's in B^{tree} until you get it.
And advertising all of your trees and blobs is prohibitively expensive.

So I think that pushes us back towards wanting an "n+1" scheme, even if
the latency is bad. And is really why partial clone is _so_ much easier
if you just resign yourself to giving the client all the commits and
trees. :)

-Peff
