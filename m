Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B421F597
	for <e@80x24.org>; Thu, 26 Jul 2018 18:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbeGZURW (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 16:17:22 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39200 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbeGZURW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 16:17:22 -0400
Received: by mail-yw0-f195.google.com with SMTP id r184-v6so957817ywg.6
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 11:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTGsyljfOcjUAgy5FnCKrKTr5k34lQEgX60myLnRE5w=;
        b=LXDspNW30OBUlE7fZBd9glOo3k0lS5fg+l+PzfFukEcJpT7ZCy0RQ/Df2+L6EUsHDA
         M8wiOjn3XGNAt6rFzxFeHsfE+QSs0W8Xq0P5Lnl1FMkm5+ZqYjMv2v6Azmj8xC90Dbmi
         0gQxhR+gx6NjTSLXERF8Feo6GmJvEDOu+1uh+9F6+aK2ZQcNAtML9zbsKkidmnGiiAce
         mK/vG9gSjPptg3dvpdMhrEBTuSD3VPc0EjeLPVz25h5lp8haBmHhJjUaBlaA+Dc/VR2Y
         DaljGNU7e8r18see2C3W0Llgr3VSdGcEQYQzDjwxUboK7Agko//qx4IkBV3bNPtb64Bh
         gOdQ==
X-Gm-Message-State: AOUpUlHXqRRad86Iv+q3PbKIrQuw8m7pb5T+rURdwfRZPEkEUS6Hj4ZG
        OaMY4rLSqfUcPA+DQk7hL3nYUP5xwyuqAcxznVg=
X-Google-Smtp-Source: AAOMgpeDKgZaDhHa/2AXdv1C9OAbHV1hsae1gqL9NNpZ32PL5JdQaDkMZwbLnQCp1VROICdgkPOnPIGzsyFJ3P1YpgI=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr1621066ywc.70.1532631553681;
 Thu, 26 Jul 2018 11:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <CAPig+cQZ4g-6uT3zB0n2XWb-68DUUBZdaimTb6_Y4DNZrLUdyQ@mail.gmail.com>
 <960c32c0-5b10-6854-73c9-392814dddbb3@gmail.com> <xmqqeffqrqb3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqeffqrqb3.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 26 Jul 2018 14:59:02 -0400
Message-ID: <CAPig+cRtUeSCUnUFw0xgXEV7nyBiORZSLfLYfhKWjXxcgHvQmg@mail.gmail.com>
Subject: Re: [PATCH v1] checkout: optionally speed up "git checkout -b foo"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 11:04 AM Junio C Hamano <gitster@pobox.com> wrote:
> Ben Peart <peartben@gmail.com> writes:
> > I'm not thrilled with the long list either (the plethora of comments
> > probably makes it appear worse than it is) but I don't see how...
>
> If there were a simple and futureproof way to tell the option
> parsing loop to notice any feature other than "-b newbranch" was
> used, then such a whitelisting may be a viable way, but there is
> not, and the whitelist condition can become (over time---we are
> talking about futureproofing and not "a filter that happens to match
> today's feature set") just as complex as this blacklisting function
> is (e.g. feature A and feature B when used alone may be compatible
> with the optimization but not when used both), so if we were to use
> this optimization, I think this long list of special-case checks is
> the best we could do.

I'm wondering if a two-stage parse-options invocations could make this
potential maintenance problem more manageable by altogether
eliminating needs_working_tree_merge(). Something very roughly along
the lines of:

    new_branch_and_passive_options = {
        OPT_STRING('b', NULL, ...),
        ...options which can't impact "optimization" decision...
    };
    argc = parse_options(argc, argv, prefix,
        new_branch_and_passive_options, NULL,
        PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);

    can_optimize_new_branch = 1;
    for (i = 0; i < argc; i++)
        if (argv[i][0] == '-') {
            can_optimize_new_branch = 0;
            break;
        }

    options = {
        ...all other options...
    }
    argc = parse_options(argc, argv, prefix, options,
        checkout_usage, PARSE_OPT_KEEP_DASHDASH);

    ...as before...

The can_optimize_new_branch check could, of course, be fooled by a
non-option which starts with a "-", but that would err toward safety
of not optimizing, so shouldn't be a worry.
