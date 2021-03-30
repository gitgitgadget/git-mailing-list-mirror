Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9226AC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 17:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3EC619C0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 17:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhC3RMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhC3RMi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 13:12:38 -0400
X-Greylist: delayed 72158 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Mar 2021 10:12:38 PDT
Received: from vps892.directvps.nl (unknown [IPv6:2a02:2308::216:3eff:fede:83d0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D72C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 10:12:37 -0700 (PDT)
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 37D69440138; Tue, 30 Mar 2021 19:12:35 +0200 (CEST)
Date:   Tue, 30 Mar 2021 19:12:35 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] maintenance: specify explicit stdin for crontab
Message-ID: <YGNcA3paBeZ8mYVP@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Derrick Stolee <stolee@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20210329210928.561586-1-me@ikke.info>
 <CAN0heSrSNJhy33Wi9Yq8kfnkJEyvQoadyj8joLqHtV+SYPs1sw@mail.gmail.com>
 <25ea6f26-c829-f63f-77a1-11a28bbe7fc0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25ea6f26-c829-f63f-77a1-11a28bbe7fc0@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 08:02:22AM -0400, Derrick Stolee wrote:
> On 3/30/2021 1:41 AM, Martin Ågren wrote:
> > On Mon, 29 Mar 2021 at 23:23, Kevin Daudt <me@ikke.info> wrote:
> >>
> >> There are multiple crontab implementations that require stdin for
> >> editing a crontab to be explicitly specified as '-'.
> 
> Thank you for reporting this, especially with a patch!
> 
> However, I'm not sure about this adding of '-' being something that
> crontab ignores so commonly. My Ubuntu machine reports this:
> 
> $ crontab -e -
> crontab: usage error: no arguments permitted after this option
> usage:  crontab [-u user] file
>         crontab [ -u user ] [ -i ] { -e | -l | -r }
>                 (default operation is replace, per 1003.2)
>         -e      (edit user's crontab)
>         -l      (list user's crontab)
>         -r      (delete user's crontab)
>         -i      (prompt before deleting user's crontab)
> 
> Is there a way we could attempt writing over stdin, notice the
> failure, then retry with the '-' option?

We do not use -e to edit, we run `crontab` and provide the contents to
stdin. `crontab -e` just opens the crontab in the users editor, which
would work with busybox as well, but that's not what's being done here.

> 
> > 
> > [...]
> > 
> >> --- a/t/helper/test-crontab.c
> >> +++ b/t/helper/test-crontab.c
> >> @@ -17,7 +17,7 @@ int cmd__crontab(int argc, const char **argv)
> >>                 if (!from)
> >>                         return 0;
> >>                 to = stdout;
> >> -       } else if (argc == 2) {
> >> +       } else if ((argc == 3 && !strcmp(argv[2], "-")) || argc == 2) {
> >>                 from = stdin;
> >>                 to = fopen(argv[1], "w");
> > 
> > Would it make sense to make this
> > 
> >   } else if (argc == 3 && !strcmp(argv[2], "-")) {
> > 
> > in order to make this test-tool as picky as possible and to only accept
> > the kind of usage we want to (well, need to) use? The tests as they
> > stand would still pass, which I think argues for us not really needing
> > that "argc == 2".
> > 
> > This would be followed by
> > 
> >   } else
> >           return error("unknown arguments");
> > 
> > which wouldn't be super helpful if you forgot the "-", but helpful
> > enough for an internal test-tool, I guess.
> >
> > Speaking of usage and hints, there's "Usage: ..." in a comment at the
> > top of this file. It should probably be updated either way.
> 
> I agree with Martin's review here, too.

Yes, I agree too, was already contemplating that.

> 
> Thanks,
> -Stolee
