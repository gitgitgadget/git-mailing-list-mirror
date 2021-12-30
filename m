Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D362CC433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 06:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhL3GWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 01:22:06 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:41784 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhL3GWG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 01:22:06 -0500
Received: by mail-pl1-f174.google.com with SMTP id z3so17565414plg.8
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 22:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGwmke0yB7convIdVE43Q2xcLMwLgscIgv1nfTwM5Mc=;
        b=P+5gYXbeVrE8P5eNyiyT/izPwS+Kthesxul/CgqFr23UPIbPT52Iil3oiAoOESZYDZ
         PLNlCOcV4Co2XZE9s6XcWrYm2pmFCyJYpnPem537ViUiWCEgykyUElKO62jB4xyUDpTo
         NS5O+hFDqWX2/NuZsgGQ7Az9dOpmmfXvo7XXpRRQllj2EPQ1R0x35+06IDA0zFf1VHvH
         +mpooyvR0AoRDlaSE7g08YeyRXcqzcJ+cnalOjrJ/hK0zivOmczFymtYxIYEVknCPk4L
         caozPvmu1/0qT+bY65ain7pFkO6xPfORNbFrZgGGfLAsFr0ZdlhtVK53GMubhdKXXOsS
         JAFw==
X-Gm-Message-State: AOAM530SPJWYJLzR80NhrKvfVrGOxytquBm3WUOzHY+0XJOxdI3B9xGO
        ofuYWDk5596cw+9n7Uf/WODV6j7JQDXXzo+Z7PQ=
X-Google-Smtp-Source: ABdhPJyHvibKSXYjq7ibJKZOXuFum8biBxP0+VoozRycg38KEFhU2wDtO95X1VTNq1oYcKt2PRaeQ58+dzqLzlBQWvA=
X-Received: by 2002:a17:902:e211:b0:149:8bd6:583b with SMTP id
 u17-20020a170902e21100b001498bd6583bmr13569892plb.35.1640845325841; Wed, 29
 Dec 2021 22:22:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
 <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com>
 <CAPig+cQjYiARBwSZTsswk442TvDC2UiyOx5wNdRwF6C7i8ENxA@mail.gmail.com> <CABPp-BHMr32MuisNzt-R3O4=HPY63HQT0=ykrbtiASyS1K_JjQ@mail.gmail.com>
In-Reply-To: <CABPp-BHMr32MuisNzt-R3O4=HPY63HQT0=ykrbtiASyS1K_JjQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Dec 2021 01:21:54 -0500
Message-ID: <CAPig+cRs4Vvp4rQ_EhMxB_qe4YAh3+NnqETTpYyMnAjsRhAUbg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 27, 2021 at 3:16 PM Elijah Newren <newren@gmail.com> wrote:
> On Sun, Dec 26, 2021 at 11:34 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Your proposal is _almost_ the same as my suggestion of eventually
> > making per-worktree config the default. The difference is that you're
> > only making it the default if `core.bare=true` or `core.worktree` is
> > set.
>
> Indeed.  :-)

I mentioned previously[1] that I needed to find a block of time to
really think through the topic before I'd be able to respond to this
email. So, today I spent some time trying to reason through the
various cases under discussion, and I came back and re-read this email
with the intention of trying to summarize my understanding of the
situation and my understanding of the points you were making. However,
you did such a good job of summarizing the various cases at the very
end of [2] that it probably makes more sense for me to respond to that
email instead.

[1]: https://lore.kernel.org/git/CAPig+cTFSDw-9Aq+=+r4sHSzTmG7s2T93Z0uqWTxHbKwGFaiYQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com/

> > But do we need that distinction? If people are comfortable with
> > that, then are they comfortable with simply flipping the switch and
> > making per-worktree config the default today regardless of `core.bare`
> > and `core.worktree`?
>
> This is tempting, at least if we leave core.repositoryFormatVersion as
> 0 (see 11664196ac ("Revert "check_repository_format_gently(): refuse
> extensions for old repositories"", 2020-07-15)) when core.bare is
> false and core.worktree was unset.  However, for that case:

I had seen 11664196ac when researching one of my earlier responses,
though it took more than one read to (hopefully) fully understand what
it is saying (i.e. due to an oversight, it's too late to enforce the
`core.repositoryFormatVersion=1` requirement when extensions are used,
as originally intended).

> * This is a case where operating on the primary worktree was not
> previously problematic for older git versions or third party tools.
> * Interestingly, git <= 2.6.2 can continue to operate on the primary
> worktree (because it didn't know to error out on unknown extensions)
> * git >= 2.19.0 could continue to operate on the primary worktree
> (because it understands the extension)
> * git versions between that range would suddenly break, erroring out
> on the unknown extension (though those versions would start working
> again if we migrated core.bare and core.worktree but just didn't set
> extensions.worktreeConfig).

The significance of versions 2.6.2 and 2.19.0 is unclear to me. What
context or criteria are you using to identify those versions as
meaningful here?
