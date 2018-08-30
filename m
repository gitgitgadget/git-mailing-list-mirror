Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C3C61F404
	for <e@80x24.org>; Thu, 30 Aug 2018 08:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeH3MXZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 08:23:25 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:35743 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbeH3MXY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 08:23:24 -0400
Received: by mail-qt0-f180.google.com with SMTP id j7-v6so8870909qtp.2
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 01:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebtBt1T2/76W5xL/ZJ+wrmqqgn7LIH/x5r/4DExQHwI=;
        b=GrBlKEvL1e+lTqWBvL4L/iLfzLipjiCn2eIIE8inHwEm65WcIT4nEk5sph+bLNgHJU
         7Hvv+vBuPwnrZ2oTzV9d2bVnVj7AUD7wg3P9Pz3NaJZI+34J9Gh41hQsslI9xsr/WRfi
         NRG1tk31djdkgArVkoxRP9SW1LweELRcRGZDuQJrslKMUWG7aKTv9l88sLATYkFV3oi9
         /3s0Qx0OR7LnVZERuU5oFduYVyb3KTBqT4LGZc7gBrwMrWKMrPhXDi0dA7Qu30YKrXpG
         NHm7ojPnvH3SdoRLnCUfJZami1m1xNO8yVkB6iMTzaupHxV53HuXL+XvIutETIMVaXIf
         /M/A==
X-Gm-Message-State: APzg51CLI/t5WT80cSyR0DA0J7paVqsJPItry7jyG3gLoJs3wGOOP3Hs
        YZGuUZLnN15OCHN/czXz3QUZETsLZ2eky0QibWU=
X-Google-Smtp-Source: ANB0VdYFofI5+hIXXXGBjjVgo9PnX9oWQqaFWS2L7/6KvigTGWUs8r0AGmzxUu0BnzY7PNUHa0kYkGdNRe3S/xWXLkU=
X-Received: by 2002:a0c:e292:: with SMTP id r18-v6mr10281573qvl.62.1535617345471;
 Thu, 30 Aug 2018 01:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180828212026.21989-6-sunshine@sunshineco.com> <20180830072808.GB11944@sigill.intra.peff.net>
In-Reply-To: <20180830072808.GB11944@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Aug 2018 04:22:13 -0400
Message-ID: <CAPig+cSbUVcs+eg1V_7xPY4ZMUpGZ5dQQ8iD8DWomZ-K=0mkug@mail.gmail.com>
Subject: Re: [PATCH 5/9] worktree: disallow adding same path multiple times
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 3:28 AM Jeff King <peff@peff.net> wrote:
> On Tue, Aug 28, 2018 at 05:20:22PM -0400, Eric Sunshine wrote:
> > +     /*
> > +      * find_worktree()'s suffix matching may undesirably find the main
> > +      * rather than a linked worktree (for instance, when the basenames
> > +      * of the main worktree and the one being created are the same).
> > +      * We're only interested in linked worktrees, so skip the main
> > +      * worktree with +1.
> > +      */
> > +     wt = find_worktree(worktrees + 1, NULL, path);
>
> Very appropriate use of a comment. :)

I tried repeatedly to write the comment as a one-liner but simply
couldn't do it in a way which conveyed the necessary information.

> > +     if (locked)
> > +             die(_("'%s' is a missing but locked worktree;\nuse 'unlock' and 'prune' or 'remove' to clear"), path);
> > +     else
> > +             die(_("'%s' is a missing but already registered worktree;\nuse 'prune' or 'remove' to clear"), path);
>
> Nice, I like giving separate messages for the locked and unlocked cases
> The formatting of the message itself is a little funny:
>   $ git worktree add --detach foo
>   fatal: 'foo' is a missing but already registered worktree;
>   use 'prune' or 'remove' to clear

I couldn't come up with an improvement, so I went with this.

> I'd say that the second line would ideally be advise(), since we're
> dying. You could do:
>   error(%s is missing...)
>   advise(use prune...)
>   exit(128);
> but that loses the "fatal" in the first message.

I'm somewhat hesitant to sidestep die() here because die() brings its
own "special" behaviors and cleanups. (Even if they aren't needed
today, perhaps they will be in the future.)

> I wonder if just manually writing "hint:" would be so bad.

That would lose coloring of "hint", though.

Another alternative would be to make it just a long one-liner error
message. I don't feel strongly one way or the other.

> > +done:
> > +     free_worktrees(worktrees);
>
> You could easily avoid this goto with:
>
>   if (wt) {
>      /* check wt or die */
>   }
>
>   free_worktrees(worktrees);
>
> but it may not be worth it if the logic gets more complicated in future
> patches.

I did suspect that a reviewer would comment on this, but, yes, the
logic does get more complicated in subsequent patches, and the 'goto'
makes a cleaner result in the end.
