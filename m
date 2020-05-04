Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EC6C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A6220658
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgEDVd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:33:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:36666 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726291AbgEDVd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 17:33:27 -0400
Received: (qmail 2307 invoked by uid 109); 4 May 2020 21:33:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 21:33:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22345 invoked by uid 111); 4 May 2020 21:33:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 17:33:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 17:33:26 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Paul Ganssle <paul@ganssle.io>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
Message-ID: <20200504213326.GA31037@coredump.intra.peff.net>
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 08:40:04PM +0000, Johannes Schindelin via GitGitGadget wrote:

> When rearranging the todo list so that the fixups/squashes are reordered
> just after the commits they intend to fix up, we use two arrays to
> maintain that list: `next` and `tail`.
> 
> The idea is that `next[i]`, if set to a non-negative value, contains the
> index of the item that should be rearranged just after the `i`th item.
> 
> To avoid having to walk the entire `next` chain when appending another
> fixup/squash, we also store the end of the `next` chain in `last[i]`.

s/last/tail/, I think? (and below)

> The good news is that it is easy to fix this: we can detect the
> situation by looking at `last[i2]` (which will be `-1` if `i2` is
> actually in the middle of a fixup chain), and in that case we simply
> need to squeeze the current item into the middle of the `next` chain,
> without touching `last` (i.e. leaving the end index of the fixup chain
> alone).

OK, good. I definitely had figured out how to detect the case, but
wasn't quite sure how to manipulate next.

But your fix here makes sense:

>  			if (next[i2] < 0)
>  				next[i2] = i;
> -			else
> +			else if (tail[i2] >= 0)
>  				next[tail[i2]] = i;
> +			else {
> +				/*
> +				 * i2 refers to a fixup commit in the middle of
> +				 * a fixup chain
> +				 */
> +				next[i] = next[i2];
> +				next[i2] = i;
> +				continue;
> +			}

I do have one question, though. What happens if we add a second
fixup-of-a-fixup?

We'd see its "next" slot filled, but now pointing to the first
fixup-of-a-fixup. And we'd add ourselves at the front of that list. So I
think:

  1234 foo
  5678 !fixup foo
  abcd !fixup 5678
  dbaf !fixup 5678

would end up reordering abcd and dbaf (putting dbaf first), wouldn't it?

But when I tested it doesn't seem to:

  git init
  git commit -m base --allow-empty
  git commit --squash HEAD -m 'this is the first squash' --allow-empty
  s=$(git rev-parse HEAD)
  git commit -m "squash! $s" -m 'this is the second squash' --allow-empty
  git commit -m "squash! $s" -m 'this is the third squash' --allow-empty
  git rebase -ki --autosquash --root

So I think there's something I don't quite understand about how the
chain of "next" works. If you can enlighten me, I'd be grateful.

But your patch does seem to work as advertised. It might be worth adding
the double-squash-of-squash to the test.

-Peff
