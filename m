Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162BD208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 19:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeG2Uxv (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 16:53:51 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:39538 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeG2Uxu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 16:53:50 -0400
Received: by mail-yb0-f193.google.com with SMTP id k124-v6so3952171ybk.6
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 12:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23utPACf4ffqpc0LzHEqUNXwgV8dATxqrsTua2siZrI=;
        b=mVEdLd/xAEUPWhBaG35MPq6GlnzjFpdAszlKdQEew2T1BqRi4+dTFa3DPbrgFBQqo1
         Y+03uAORMfi2xxgTyJ6hS6/T526Je+MPQXZmof8m+b+fUaIKyLnDs1UGoghUyQ/emaJw
         Ikf0dhZDd89BCPG5LZQpTwULR7zaDjzQvE76qu6LsuBhbwGny6+M6/YZxxiLc9Ij2UUL
         NHNu/X03x0YTQTuZJCn6CuX7gZA/QLOexrlqxHbzLpSR49LmkfQeVGfHDM7eITbQl4Mc
         TlfFIn00Mqfnm3OS5LUgGoR154n1gLVBfQ+qb2m/dGWkXsxqz/xRy96Co0L2TXOP+Rws
         3gig==
X-Gm-Message-State: AOUpUlEHmXS6PlE4JMDnOCSRNuKVt/zTPGFT83a//2ZLElLXdbWTPkVz
        5dDUD2WS9fqJlTIkjjiEU3nC5Pm7d4hDf2uS13s=
X-Google-Smtp-Source: AAOMgpcuWJix6YMmVp2n/tttEEf5h0Tek7btEtT/VMjGH03TX2rv1FqQu5OyzGmLhKf9rOYoOjcP6q+Lnj8ikboD/qA=
X-Received: by 2002:a25:9d81:: with SMTP id v1-v6mr7915295ybp.76.1532892141076;
 Sun, 29 Jul 2018 12:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com>
 <94afaeaf224563effda7b3c0b8939567302d2ba1.1532210683.git.gitgitgadget@gmail.com>
 <20180729190359.GD2734@hank.intra.tgummerer.com>
In-Reply-To: <20180729190359.GD2734@hank.intra.tgummerer.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Jul 2018 15:22:09 -0400
Message-ID: <CAPig+cTuD0+8etdMLu8FkFVxnXUM218taxU9in-fe3QXhDj5WQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/21] range-diff: also show the diff between patches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 29, 2018 at 3:04 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > Just like tbdiff, we now show the diff between matching patches. This is
> > a "diff of two diffs", so it can be a bit daunting to read for the
> > beginner.
> > [...]
> > Note also: while tbdiff accepts the `--no-patches` option to suppress
> > these diffs between patches, we prefer the `-s` option that is
> > automatically supported via our use of diff_opt_parse().
>
> One slightly unfortunate thing here is that we don't show these
> options in 'git range-diff -h', which would be nice to have.  I don't
> know if that's possible in git right now, if it's not easily possible,
> I definitely wouldn't want to delay this series for that, and we could
> just add it to the list of possible future enhancements that other
> people mentioned.

This issue is not specific to git-range-diff; it's shared by other
commands which inherit diff options via diff_opt_parse(). For
instance, "git log -h" doesn't show diff-related options either, yet
it accepts them.

> > diff --git a/range-diff.c b/range-diff.c
> > @@ -300,6 +325,9 @@ static void output(struct string_list *a, struct string_list *b)
> >                       printf("%d: %s ! %d: %s\n",
> >                              b_util->matching + 1, short_oid(a_util),
> >                              j + 1, short_oid(b_util));
> > +                     if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
>
> Looking at this line, it looks like it would be easy to support
> '--no-patches' as well, which may be slightly easier to understand that
> '-s' to someone new to the command.  But again that can be added later
> if someone actually cares about it.

What wasn't mentioned (but was implied) by the commit message is that
"-s" is short for "--no-patch", which also comes for free via
diff_opt_parse(). True, "--no-patch" isn't spelled exactly the same as
"--no-patches", but git-range-diff isn't exactly a perfect tbdiff
clone, so hopefully not a git problem. Moreover, "--no-patch" is
internally consistent within the Git builtin commands.
