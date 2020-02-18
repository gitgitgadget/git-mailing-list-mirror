Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210F1C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 05:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F227A20722
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 05:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgBRFvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 00:51:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:46560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725939AbgBRFvK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 00:51:10 -0500
Received: (qmail 14532 invoked by uid 109); 18 Feb 2020 05:51:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 05:51:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14672 invoked by uid 111); 18 Feb 2020 06:00:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 01:00:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 00:51:08 -0500
From:   Jeff King <peff@peff.net>
To:     Tomas Mudrunka <mudrunka@spoje.net>
Cc:     git@vger.kernel.org
Subject: Re: "Garbage collect" old commits in git repository to free disk
 space
Message-ID: <20200218055108.GE1641086@coredump.intra.peff.net>
References: <8a4001f7b0e23e7df3172deeb32e0553@spoje.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a4001f7b0e23e7df3172deeb32e0553@spoje.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 01:29:24AM +0100, Tomas Mudrunka wrote:

> is there safe way to garbage collect old commits from git repository? Lets
> say that i want to always keep only last 100 commits and throw everything
> older away. To achieve similar goal as git clone --depth=100, but on the
> server side. I had partial success with doing shallow clone and then
> converting to bare repo while removing the shallow flag from .git/config.
> But i didn't liked that solution and wasn't really sure what consequences in
> terms of data integrity and forward compatibility with newer git versions
> might be.

I can't say for sure, but what you did with the shallow file is likely
to bite you later. Shallow repositories are supposed to know where their
boundary cutoffs are, and that information is stored in that file.

The normal answer here is that you'd want to rewrite the history using
grafts and git-filter-branch, or the new git-filter-repo. But...

> To tell you more about my USE CASE:
> 
> I want to create free opensource sofware similar to dropbox, but based on
> git. My idea is following:

...I think the rewrite would defeat the purpose, since you're relying on
the stability of the hashes to let all sides of the conversation figure
out when they're in sync.

> I am aware that this is not something which git was designed for, but to me
> it seems like it should be more than doable. Do you think, any of you can
> give me some hints on how to approach this problem please?

I don't know that there's an easy way. Git is close to what you want,
but really is designed to assume the other side has all the reachable
objects.  Shallow clones are the feature that's closest to what you
want, but:

  - I haven't had good experiences with repeatedly fetching into a
    shallow clone. I believe the shallow list can grow because the
    client doesn't realize which commits are reachable from others (and
    hence are redundant). And I have seen shallow cuts crossing merge
    boundaries cause a lot of extra objects to be transferred.

  - It's really designed for _some_ repository to have all of the
    objects. Fetching out of a shallow repository does work, I think,
    but I would guess isn't very well exercised. So I have no idea what
    kind of dragons you'd encounter.

Another option would be to periodically rewrite the history to a point
that you think all clients have synced, and then somehow communicate the
rewrite to them (outside of Git, but it sounds like you'd have software
wrapping Git). And then they could all do the identical rewrite and keep
going.

Also look at git-annex if you haven't, which I think supports this kind
of history truncation. I don't remember how it works exactly, but I
think that it may not put the blobs into Git at all, but rather just
pointers. So you're free to remove the actual data, but the pointer
remains (and will later say "sorry, I can't get that data for you").

-Peff
