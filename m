Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADA6C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 20:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69833221E5
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 20:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIJUDS convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 10 Sep 2020 16:03:18 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:45004 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgIJUCM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 16:02:12 -0400
Received: by mail-ed1-f50.google.com with SMTP id b12so7595741edz.11
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 13:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=el3on0j/XKj99gqQYLA8hsgmLknICo8qTKzHBPD/hCc=;
        b=St5QwobY1JgNKoF+gTQrILH3BEuhJWBI1nMvme/6o3LeV//rpu4AmCu0au5Bw7mNFP
         6TbiZmovxRsxFtemvxAT2i48p2oAaG0fThzMy0h/Njo4EXNx5RNzZDixXusTrzjHhsag
         TRVzEF5xpAZzaR09v0ZIuspCsZCoX4aXm8s+nRYnA+ig1QT73UAQ+ZisbAMh3zBqQCcN
         X00iWtFfCnAAPEhO0KbZ/E7R45vtcLs8qa1o8NtNGxZ05RHqXaQn+c8nEvTrV238iKIK
         SYfTnWXnpW9PzptVhmFyZSivcjnVsE2eIXWqWXKMRijBu1Bju18v2huccaN7yu8ojW7s
         3dOw==
X-Gm-Message-State: AOAM531Ix9I5WmJ6WCsE2C2YmqHm7Uom5UNNhMzRC1Le3HDXwN4N2QsF
        Jqi2ss4BrU97Ti1z+v+IUSCCWuZRhnSm8Jdt5Og=
X-Google-Smtp-Source: ABdhPJySTpmTx+GKkNUj/nQU9wb8h+KcL5IP7PeabOO5KpaUeQqCBY3gE9591Ku+GHbtkjzlDRLdsu/P9qcbH5nFTJ8=
X-Received: by 2002:a05:6402:17da:: with SMTP id s26mr11115814edy.221.1599768128213;
 Thu, 10 Sep 2020 13:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599762679.git.martin.agren@gmail.com> <8383c246f8c23e61dedd69d6e69c72d51fd6b469.1599762679.git.martin.agren@gmail.com>
 <CAPig+cT_VvOiKBCC=E_P0R8SXkoWPVUxxOOLovOmr8N377YNdQ@mail.gmail.com> <CAN0heSrUWiZ_xar3G5rZG-c=8OVp5-eByS6rMXOw9wfTA8kmbA@mail.gmail.com>
In-Reply-To: <CAN0heSrUWiZ_xar3G5rZG-c=8OVp5-eByS6rMXOw9wfTA8kmbA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 10 Sep 2020 16:01:57 -0400
Message-ID: <CAPig+cQ871p8+oQdBBY=ebDdjDWfa5NvEMroitEmk4Db8DfLvA@mail.gmail.com>
Subject: Re: [PATCH 8/8] worktree: simplify search for unique worktree
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 10, 2020 at 3:48 PM Martin Ågren <martin.agren@gmail.com> wrote:
> On Thu, 10 Sep 2020 at 21:28, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Although this change appears to be correct and does simplify the code,
> > I think it also makes it a bit more opaque. With the explicit
> > `nr_found == 1`, it is quite obvious that the function considers
> > "success" to be when one and only one entry is found and any other
> > number is failure. But with the revised code, it is harder to work out
> > precisely what the conditions are.
>
> Thanks for commenting. I found the original trickier than it had to be.
> It spreads out the logic in several places and is careful to short-cut
> the loop. My first thought was "why doesn't this just use the standard
> form?". But I'm open to the idea that it might be a fairly personal
> standard form... If there's any risk that someone else comes along and
> simplifies this to use a `nr_found` variable, then maybe file this under
> code churning?

Maybe. Dunno. Even with the suggested function comment, I still find
that the revised code has a higher cognitive load because the reader
has to remember or figure out mentally what `found` contains by the
`return found;` at the end of the function. Compare that with the old
code, in which the reader doesn't have to remember or figure out
anything. The final `return nr_found == 1 ? found : NULL;` condition
spells out everything the reader needs to know -- even if the reader
didn't pay close attention to the meat of the function. So, we each
have a different take on the apparent complexity.

> > Having said that, I think a simple
> > comment before the function would suffice to clear up the opaqueness.
> > Perhaps something like:
> >
> >     /* If exactly one worktree matches 'target', return it, else NULL. */
>
> That's a good suggestion regardless.

The function is so small that the increased cognitive load (for me) in
the rewrite probably doesn't matter at all, so I don't feel strongly
one way or the other. Keeping the patch (amended with the suggested
comment) or dropping it are both suitable options.
