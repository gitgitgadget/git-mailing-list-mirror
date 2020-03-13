Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9C7C2BB1D
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788E5206E2
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCMRuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:50:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37352 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMRuO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 13:50:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id 6so13207058wre.4
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 10:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGXI10QWfjbsSHvqYlxUceaPfUCXpZ98ActoFr/jF6c=;
        b=kvZfBEpc+3EPIXjg70xwIlpLuIk2twrCz9Xh9Ripy49Z0xnnakyolvBMB2X6191+pj
         o7rm9YkDqT4J+GpG1PPRV/mAOKyQsPsQj/2qmOMP3FgeUsFYBgNEmGInMS4B2VS6qN0l
         QBGZGOJ8zeK9seS3nMBKOkJNw2v2i1sHXx2DQGOaGNvOn5l+2scPWC7yGYb7SKkTeQVz
         0KUYmnrRDcP6rBrAbHtPU/bhIxO1hVGShZNwlZ1IgwAsBUaA5QJT/Qm8IGKfNyMXvnfU
         gG6MFnL24iQpwQATAHSW4PRq6fdvcUUSDOlC8H3WiPVLHW53bWYHpSvbuoBcC872FE5x
         oNXA==
X-Gm-Message-State: ANhLgQ29YAi0b8UMbnLOgOpgqxP5XU3DeT3QogwLtWdY+yWdrI7lNfBj
        zSu3VxDny7WNuQ2UNQsaX8NeHTFCQacRoXPDx9A=
X-Google-Smtp-Source: ADFU+vtBy24ROd0n3NtA1sKeMW4EvkiJFA0hj2y2qsyrovY4rLp0MzLZLrBcaF4k/Mn4RtnHpC9b5lzeDaPXi/Pxiy4=
X-Received: by 2002:adf:ed42:: with SMTP id u2mr13396215wro.226.1584121812555;
 Fri, 13 Mar 2020 10:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk66ftWBYF3d_L0-__BP5mKNxBioj57y44yhyqGrtK3TZTjSg@mail.gmail.com>
In-Reply-To: <CAHk66ftWBYF3d_L0-__BP5mKNxBioj57y44yhyqGrtK3TZTjSg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 13 Mar 2020 13:50:01 -0400
Message-ID: <CAPig+cQBz-ZoV5ZX17WgW9p+ychONN8o_E13HHnR8ZGmhLk5aQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Make rev-parse -q and --is-* quiet
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     erlend-a@innova.no, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 13, 2020 at 1:30 PM Abhishek Kumar
<abhishekkumar8222@gmail.com> wrote:
> > If rev-parse is called with both -q and an --is-* option, the result is
> > provided as the return code of the command, iso. printed to stdout.
> >
> > This simplifies using these queries in shell scripts:
> > git rev-parse --is-bare-repository && do_stuff
> > git rev-parse --is-shallow-repository && do_stuff
> >
> > Signed-off-by: Erlend E. Aasland <erlend.aasland@innova.no>
> > ---
> > diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> > @@ -874,24 +874,31 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> >                 continue;
> >             }
> >             if (!strcmp(arg, "--is-inside-git-dir")) {
> > -                printf("%s\n", is_inside_git_dir() ? "true"
> > -                        : "false");
> > +                int is_set = is_inside_git_dir();
>
> Avoid declaration after statement. Move is_set to the beginning of
> cmd_rev_parse().

Thanks for taking up this review. You hit on some of the points I was
going to mention. Note, however, that this declaration is fine as-is;
it immediately follows the opening brace of the 'if' statement, thus
it is the not "declaration after statement". Also, it makes sense to
declare it here to keep its scope small and visible only where the
variable is needed/used.

> Also, be more specific than "is_set". A variable like "is_inside" would
> be more appropriate.

Agreed. And since the variable can be declared in this tiny scope, an
even shorter and simpler name (such as "x") could likely work, though
I don't insist upon it.

> > +                if (quiet)
> > +                    return is_set ? 0 : 1;
>
> Returning prematurely might be a bad idea. If there are more options after
> "--is-inside-git-dir", they will be not executed.

The big problem with returning early like this is that it means that:

    git rev-parse -q --is-whatever

behaves differently than:

    git rev-parse --is-whatever -q

which is undesirable.

> You can maybe rewrite this as:
>
>              if (!strcmp(arg, "--is-inside-git-dir")) {
>                 is_set = is_inside_git_dir();
>                 if (!quiet)
>                         printf("%s\n", is_set ? "true"
>                             : "false");
>                  continue;
>              }

> And then return the value at the end of function, replacing '0' with !is_set.

Since git-rev-parse knows how to respond to multiple --is-whatever
flags in a single invocation, my thought was that the return code
would be cumulative. That is, something like this:

    int rc = 0;
    ...
    if (!strcmp(arg, "--is-whatever")) {
        int x = is_inside_git_dir();
        rc |= x;
        if (!quiet)
            printf("%s\n", x ? "true" : "false");
        continue
    }

> I am wondering if we should stop the script from running if both quiet
> and --is-* options are passed.

That's a possibility. More generally, I haven't seen enough evidence
to convince me that this new mode of behavior is worth the effort.
That is, after this patch, one can script like this:

    if git rev-parse -q --is-whatever
    then
        ...
    fi

which is not much different from:

    if test "$(git rev-parse --is-whatever) == "true"
    then
        ...
    fi

This is RFC, so I let the lack of documentation and test update slide.
