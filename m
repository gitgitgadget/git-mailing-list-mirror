Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EAFC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300E260F38
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhHPQhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:37:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:48558 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhHPQhc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 12:37:32 -0400
Received: (qmail 20359 invoked by uid 109); 16 Aug 2021 16:37:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 16:37:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15931 invoked by uid 111); 16 Aug 2021 16:37:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 12:37:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 12:36:59 -0400
From:   Jeff King <peff@peff.net>
To:     jim.cromie@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: git format-patch -s enhancement
Message-ID: <YRqUK3cRFJmANzDd@coredump.intra.peff.net>
References: <CAJfuBxxT_7weC8_O=KYScSbDcSeBdb3v5d_gtn-NXzW_fKLrsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfuBxxT_7weC8_O=KYScSbDcSeBdb3v5d_gtn-NXzW_fKLrsA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 15, 2021 at 05:07:34PM -0600, jim.cromie@gmail.com wrote:

> git format-patch -s is sub-optimal :
> it appends the SoB,
> which falls after the snips
> ---
> changelog ...
> that the commit message may contain
> 
> 
> So it misfires on any maintainer scripts
> expecting the SoB above the 1st snip.
> 
> The workaround is manual SoBs above any snips.
> 
> I note this in -s doc,
> 
>            Add a Signed-off-by trailer to the commit message, using
> the committer identity of yourself.
>            See the signoff option in git-commit(1) for more information.
> 
> "trailer" is really "document current working behavior"
> (normative docu-speak, so to speak;)
> 
> Ideal behavior is to find 1st in-body  --- snip
> and insert there

The big disconnect here is that "---" snip lines are not meant to be
meaningful within commit messages themselves. They are part of the
process of sticking a commit message into an email. So format-patch and
git-am know about them, but "git commit" for example doesn't.

So "git commit --signoff" probably shouldn't take them into account when
deciding the end of a commit message. The user might or might not have
meant "---" to be syntactically meaningful, depending on whether they
plan to send the message with format-patch (and changing the behavior
now is questionable).

Doing so with "git format-patch --signoff" is a slightly different
question.  The current behavior is working as intended, in the sense
that it signs off just as "commit -s" would, and then separately sticks
the result into the email. The fact that "---" in the commit message is
indistinguishable from the ones added by format-patch is mostly an
accident.

That said, it's kind of a useful accident for some workflows, exactly
because you can carry these non-commit-message notes inside the commit
message. And since we know how any in-commit-message "---" will be
treated by git-am on the other side, it might be reasonable for
format-patch to start considering them to be syntactically significant.

So I guess I would disagree that it's a bug exactly, in that the
workflow you're advocating was never meant to be supported. But I don't
see any reason we couldn't be a little friendlier to it, if somebody
wanted to teach format-patch to do so.

An alternative workflow would be to use git-notes to attach the
changelog data to the commit. Those are shown after the "---" by
format-patch already. Unfortunately, keeping them up to date is kind of
annoying. Ages ago, I had a patch to let you modify them while editing
the commit message, which makes it pretty seamless:

  https://lore.kernel.org/git/20110225133056.GA1026@sigill.intra.peff.net/

I carried the patch in my local build for a while, but never really
ended up using it. So I never polished it further. But I think it's
still fundamentally a reasonable idea, if somebody is interested in
carrying it forward. If so, here's the version I've been rebasing
forward over the years:

  https://github.com/peff/git jk/commit-notes-wip

but it doesn't seem to actually pass its own tests anymore (so it may or
may not be a helpful starting point. ;) ).

-Peff
