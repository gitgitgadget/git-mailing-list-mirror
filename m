Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58545C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 16:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbhLIQtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:49:13 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:39852 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhLIQtM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 11:49:12 -0500
Received: by mail-pg1-f179.google.com with SMTP id r5so5576787pgi.6
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 08:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjoh9NPDRPIOtdJPGHuy5BhKX/83WkmH2FTutEofF3k=;
        b=MdRNl9ws437UVRNIDX/BhaiXFqEC5gndtNdmbAx1PVGixyH1WdxTYuTB7by9dDn7z/
         sqoHhqfhYRVRfy/RhZcA1ESAl6bWN5CfzpSjyo3lC6uP+QKUk4vfWlnxaIfENxLxO+io
         cllbNp0k7lK6ymxPTukSnu8LpYV3BBYg0oXTN6YnNOeFpeaA2P7gTsfD05/tdp+zDs6I
         ILvhODWp4rlIyuTl8q3/V2ybUTn9R6PbzNlwYh0tJZtThAbpmj1u4Qdqn0S+ZlMWPSoT
         19eGPRW+ioW9RKxiUXP8voq25SiaPRlEvCPNnqsi/afvX7J+/thjMEUHd7OJ67qPGq20
         lMbA==
X-Gm-Message-State: AOAM530JcNRLnWmo9O9EH5sSriJKoigDqTr5XpMaH3AX0cYyr5/TUqdg
        dsWDMGe1udZ9UfBW6JcN4Fl+2ECVi4WHpJQfcy8=
X-Google-Smtp-Source: ABdhPJwFrJ3iFa1r1aaNrfWenRGnTBcNWDBG87b8T2s4iJ+3UAsdACSAMHlXvHcSEGl0ILsu2xjXAOr4IDuBgRTkXmQ=
X-Received: by 2002:a05:6a00:140d:b0:4a9:5e10:60c2 with SMTP id
 l13-20020a056a00140d00b004a95e1060c2mr12661960pfu.4.1639068334042; Thu, 09
 Dec 2021 08:45:34 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-3-sunshine@sunshineco.com> <CABPp-BGBZ6_CqbUg3=sK2b4yELC5NHHyH68_df22n=t=hARH_g@mail.gmail.com>
In-Reply-To: <CABPp-BGBZ6_CqbUg3=sK2b4yELC5NHHyH68_df22n=t=hARH_g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 9 Dec 2021 11:45:23 -0500
Message-ID: <CAPig+cR0eKhz+ncWb4v9dSY0A03P+K0+WT90J2cBKvLqT8DXrA@mail.gmail.com>
Subject: Re: [PATCH 02/19] t1010: fix unnoticed failure on Windows
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 9, 2021 at 11:28 AM Elijah Newren <newren@gmail.com> wrote:
> On Thu, Dec 9, 2021 at 12:22 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > The reason this problem has gone unnoticed for so long is twofold.
> > First, the failed `git add` is swallowed silently because the loop is
> > not terminated explicitly by `|| return 1` to signal the failure.
> > Second, none of the tests in this script care about the actual directory
> > names or even the number of tree entries.
>
> Is this true?  The names look like they were selected on the basis that
>     '.' < '/' < '0'
>
> We have multiple paths in the code that write tree structures, and
> it's important that the order be
>   100644 blob $OID1 a.
>   040000 tree $OID2 a
>   100644 blob $OID3 a0
>
> i.e. that 'a' as a tree object sorts as though it were actually named
> 'a/'.  I suspect the code might have been making sure that the
> different paths creating tree objects did so consistently, and the
> special handling of subdirectories is the edge case that needs careful
> checks.

I meant it in the sense that the tests don't care about the literal
names "a", "a.", "a0". They do care about ordering...

> > Skipping these tests on Windows by, for instance, checking the
> > FUNNYNAMES predicate would avoid the problem, however, the funny-looking
> > name is not what is being tested here. Rather, the tests are about
> > checking that `git mktree` produces stable results for various input
> > conditions, such as when the input order is not consistent or when an
> > object is missing.

... which I hoped to convey to readers by saying "stable results ...
when input order is not consistent", but I guess I wasn't clear enough
or obvious enough, or this mention is too far removed from the "don't
care about the actual names" statement.

> > Therefore, resolve the problem simply by using a directory name which is
> > legal on Windows (i.e. "a-" rather than "a."). While at it, add the
> > missing `|| return 1` to the loop body in order to catch this sort of
> > problem in the future.
>
> The choice to replace '.' with '-' is excellent since '-' < '/' as well.

I can rewrite the earlier paragraph to mention name ordering so it's
more obvious that it has significance.

I am a bit hesitant about spamming the list with a reroll of this
lengthy series just for this change, though I can certainly do it if
you consider it important.
