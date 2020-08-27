Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633B1C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 05:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0D922B40
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 05:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgH0FD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:03:56 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:37230 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgH0FD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 01:03:56 -0400
Received: by mail-ej1-f67.google.com with SMTP id e23so5124202ejb.4
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 22:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ble0McxLaxoXEGs4hRTdd3jnrRE+9cdH5gGDFPckUh8=;
        b=mhf4+8du8qVhfmvMRKV237k/v87mhWssJteO5fmDe2me7U9kkh84vKdefgDavfJrAH
         tDUPqq44rc80n82pf/9pHpdUd4EF4p6a7K7LqzB80avVXcYYTKjP9Od9nwfgH1Y0D59R
         sJMJfJsixId7W+vD9rRbGs9MwiEBvrNGMGX4+5FV5E3eTdSmEBaTGFyPiL6GxW57jfiw
         22F4ddCm2WWRukqLkcTKIxToxWvNtQWkbiG+Tw888wx7K0jMEIs86BUisouSQH+YYgD9
         i4F7hgIcyXKDcMCDdwkkPk3ZobjQLqDxx0Otx2DDc9j5yEyrNBgG+EnBlxSnQgZLhT0W
         yrzA==
X-Gm-Message-State: AOAM531JuaUlbsMg5omowMYq77pnPiIyKb8TRlF43NnpqoNu2jioiSZK
        PifVaxU0RS+EtuEcBoaWd2nW8CeRDNu2ElRjtWK1OqMSwgg=
X-Google-Smtp-Source: ABdhPJxtfTLcD1llLew2fr+sbyu3Ex6QmqEkmPjo/P7Yp8rih+JSIYp9/Plko6dla6Mt+mVzY2Wt5d6rMnk9QKhPrWY=
X-Received: by 2002:a17:906:2cc2:: with SMTP id r2mr18837802ejr.482.1598504634335;
 Wed, 26 Aug 2020 22:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com> <20200826194650.4031087-1-gitster@pobox.com>
 <20200826194650.4031087-3-gitster@pobox.com> <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
 <xmqqmu2ht58g.fsf_-_@gitster.c.googlers.com> <20200827042157.GC3346457@coredump.intra.peff.net>
 <CAPig+cS1uMw6YDVjzb8FbBmC=iVjged-wHu0LF2+trmW-4ZfVw@mail.gmail.com> <20200827044420.GA3360616@coredump.intra.peff.net>
In-Reply-To: <20200827044420.GA3360616@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Aug 2020 01:03:43 -0400
Message-ID: <CAPig+cSA56xgNN0WP4t+YoyNU8fGf5eaz__=4Vh+s=He-tG=DA@mail.gmail.com>
Subject: Re: [PATCH] run_command: teach API users to use embedded 'args' more
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 12:44 AM Jeff King <peff@peff.net> wrote:
> On Thu, Aug 27, 2020 at 12:31:52AM -0400, Eric Sunshine wrote:
> > Nevertheless, that isn't much of a reason to keep child_process.env.
> > Refactoring add_worktree() a bit to rebuild the environment strvec
> > on-demand wouldn't be very difficult.
>
> I think they'd still be one-liner changes, like:
>
> -       cp.env = child_env.v;
> +       strvec_pushv(&cp.env_array, child_env.v);

Nice and simple.

> I think there are other opportunities for cleanup, too:

True on both counts.

>   - the code right above the second hunk clears cp.args manually. That
>     shouldn't be necessary because run_command() will leave it in a
>     blank state (and we're already relying on that, since otherwise we'd
>     be left with cruft in other fields from the previous run).

Right. I wonder why the author of 7f44e3d1de (worktree: make setup of
new HEAD distinct from worktree population, 2015-07-17) chose to clear
cp.args manually like that.

>   - check_clean_worktree() only uses it once, and could drop the
>     separate child_env (and in fact appears to leak it)

Perhaps this unnecessary 'child_env' strvec was a copy/paste from
add_worktree()? But certainly cp.env_array would be simpler and avoid
the leak.
