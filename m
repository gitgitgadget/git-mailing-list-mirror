Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F981F462
	for <e@80x24.org>; Sun,  9 Jun 2019 13:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfFINAG (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 09:00:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:50082 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728422AbfFINAG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 09:00:06 -0400
Received: (qmail 23757 invoked by uid 109); 9 Jun 2019 13:00:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jun 2019 13:00:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19406 invoked by uid 111); 9 Jun 2019 13:00:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 09 Jun 2019 09:00:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2019 09:00:04 -0400
Date:   Sun, 9 Jun 2019 09:00:04 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH] revision: remove stray whitespace when name empty
Message-ID: <20190609130004.GB23555@sigill.intra.peff.net>
References: <20190607225900.89299-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190607225900.89299-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 07, 2019 at 03:59:00PM -0700, Emily Shaffer wrote:

> Teach show_object_with_name() to avoid writing a space before a name
> which is empty. Also teach tests for rev-list --objects --filter to not
> require a space between the object ID and name.
> [...]
> ---
> I don't see any reason _not_ to remove this stray whitespace at the end,
> since it seems like it just gets in the way of easy scripting. I also
> think this case will only present itself for root trees.

I'm a bit worried that this might break existing scripts. As ugly as
trailing whitespace is, it does tell you something here: that the object
is a root tree and not a commit.

So in the past I have done things like:

  git rev-list --objects --all | grep ' '

to get only the non-commits. I'm undecided on whether we're straying
into https://xkcd.com/1172/ territory here. I'd be more in favor if this
were making things significantly easier, but...

> show_object_with_name() inserts a space between an object's OID and name
> regardless of whether the name is empty or not. This causes 'git
> cat-file (--batch | --batch-check)' to fail to discover the type of root
> directories:
> 
>   git rev-list --objects --filter=tree:1 --max-count=1 HEAD \
>     | git cat-file --batch-check
>   git rev-parse HEAD: | xargs -I% git cat-file -t %
>   git rev-list --objects --filter=tree:1 --max-count=1 HEAD \
>     | xargs -I% echo "AA%AA"
>   git rev-list --objects --filter=tree:1 --max-count=1 HEAD \
>     | cut -f 1 -d ' ' | git cat-file --batch-check

Your patch only helps with this at all because you're using the "tree:1"
filter. It would not help:

  git rev-list --objects HEAD | git cat-file --batch-check

because there you'll have actual names which cat-file will choke on. So
it seems like this is helping only a very limited use case.

cat-file actually does know how to split on whitespace. Unfortunately it
does not do so by default, because that breaks some cases. See
97be04077f (cat-file: only split on whitespace when %(rest) is used,
2013-08-02).

So you _can_ do:

  git rev-list --objects HEAD |
  git cat-file --batch-check='%(objectname) %(objecttype) %(rest)'

But:

  1. That puts the %(rest) bits in your output, which you may not want.

  2. You have to actually specify the full format, so you might have to
     repeat batch-check's default format items.

I think it would be reasonable for cat-file to have an option to split
on whitespace (and if not given explicitly by the user, default to the
presence of %(rest) as we do now).

Alternatively, it would be reasonable to me to have an option for
"rev-list --objects" to have an option to suppress the filename (and
space) entirely.

I think in the longer run along those lines that "--objects" should
allow cat-file style pretty-print formats, which would eliminate the
need to pipe to cat-file in the first place. That makes this parsing
problem go away entirely, and it's way more efficient to boot (rev-list
already knows the types!).

-Peff
