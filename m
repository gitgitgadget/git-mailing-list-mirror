Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0467A1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 13:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfAJNY4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 08:24:56 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:37577 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfAJNYz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 08:24:55 -0500
Received: by mail-yb1-f182.google.com with SMTP id 2so4412171ybw.4
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 05:24:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0BZw1FdB5E1R6psrLpUuRFChaO3rs3s/ZYSWDTqtQw=;
        b=EK0OJSoXl4U4ZQUoS2C3og48d5YLomv7o0fZxrcvNAEUTU/O28lDSuSXZ2DHywFDVs
         oa60rtJj7I7wafCOngPNbojTpRgPvkotrbOK6AQ4TbUK0LlFaQdsqJntfg2X8tT9iC9y
         ao44L0679STqtVozHj55054lpazLj/xk0u+F6vbh9ZGGJBMK6b+1UDuuF6TcYInMChRH
         Fvdvc9f4cNknre0YZUB3g//WVYEUY602jb2nVcM3RBzfHJZ1zvyYZGnh42L4GgadKRxL
         0qbWclGhWkPuoao4GtFXy7+KN3p+vc64eJB8M04Oj+wFwS1snKpGRy07LvH+4SjpS9AY
         Ifjg==
X-Gm-Message-State: AJcUukf0wNfFUtOf0nVAIF0kwfV9U5bKVknl7vBrSBKuOZDfTbPqUUIb
        Dx8HBzOWnKaJ5RSmUmlwoXoYD157AvzFT3S3AJupaTbnTLg=
X-Google-Smtp-Source: ALg8bN5jSGC21/KujtSDVHQgOU69WpjAw1plrscTXDwlW1SxIjc+cCSbpVpiCNj4rMswB0gu89GlXxA8Tz4jQFJiYBs=
X-Received: by 2002:a25:1344:: with SMTP id 65mr9524021ybt.402.1547126694623;
 Thu, 10 Jan 2019 05:24:54 -0800 (PST)
MIME-Version: 1.0
References: <CANT8FXRRTpAaW0JxYCt94f52eKAz1cBAGpPA84CUTMJUgQrkuw@mail.gmail.com>
 <20190106065032.GC4207@sigill.intra.peff.net>
In-Reply-To: <20190106065032.GC4207@sigill.intra.peff.net>
From:   Michal Novotny <clime@redhat.com>
Date:   Thu, 10 Jan 2019 14:24:43 +0100
Message-ID: <CANT8FXSqmGqj3yFDMCYEKmiR04qYmqt7L67k2Ny4FxX3Lh0ktA@mail.gmail.com>
Subject: Re: A few questions regarding git annotated tags
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Jeff!

On Sun, Jan 6, 2019 at 7:50 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Jan 05, 2019 at 04:50:30PM +0100, Michal Novotny wrote:
>
> > I could potentially make it so that I tag subtrees instead of commits
> > and then derive the needed information from these subtree tags. This
> > could be useful if I have multiple rpm packages in different subtrees
> > of the same repo. I could then tag the subtree where the rpm package
> > is placed.
> >
> > This could bring some simplification into the code but as far as I
> > know, you cannot easily checkout a tree tag, which is something a
> > packager should be able to do easily: to checkout a state of repo when
> > a certain subpackage was tagged. This is the first question. Can you
> > e.g. do:
> >
> > git tag somename HEAD:
> >
> > and then do something similar to
> >
> > git checkout somename
> >
> > which would restore the repository or at least the respective subtree
> > of it into the state when "somename" tag was created?
>
> No, there's no easy way to check out a bare tree (and in fact, HEAD is
> forbidden to point to a non-commit).
>
> You could hack around that by making a new commit that wraps the tree,
> like:
>
>   commit=$(echo 'wrap foo package' | git commit-tree HEAD:foo)
>   git tag foo-1.2.3 $commit
>
> There are also useful things to do with the tag of the bare tree. E.g.,
> export it via git-archive, diff it, "git checkout -p" changes from it,
> etc. But actually creating a working tree state from it is awkward:
>
>   # move to being on an "unborn" branch foo
>   git checkout --orphan foo
>
>   # load the desired tree state; "-u" will update the working tree
>   # files
>   git read-tree -m -u foo-1.2.3
>
>   # if we were to commit now, it would become the root commit of the
>   # "foo" branch, with no parents. That would make it pretty useful for
>   # things like merging between tags.
>   git commit -m 'kind of weird'
>
> So it seems kind of awkward and useless.  I'm not sure I totally
> understand your problem space, but if you can have actual commits with a
> logical progression (i.e., where the parent links actually mean
> something), I think Git's tools will be more useful.
>
> > Right now, I am putting a package name directly into tag name so I
> > know what tags belong to what package based on that. And I am using
> > normal annotated tags. This works quite well, I would say, but at one
> > point I need to use shared state to move the discovered package name
> > from one part of the code to another so that the other part can work
> > with the correct subset of the available annotated tags. I wouldn't
> > need to do that if I could derive the correct tag subset based just on
> > the path to the subtree where a package is placed.
>
> I'm not sure I understand this bit. Even if you tag a subtree, like:
>
>   git tag foo-1.2.3 HEAD:foo
>
> then that tree doesn't "know" that it was originally at the path "foo".
> You'd have to tag the root tree, and then know to look in the "foo"
> subtree from there. At which point you might as well tag the commit that
> contains that root tree. Whether it happens to touch the "foo" path or
> not, it represents a particular state.
>
> > Alternative approach to creating the tree tags would be to store the
> > path information into annotated tag message, which I could do. But is
> > there a relatively simple way to filter tags based on their message
> > content? Can I put the information into some other part of tag than
> > name or the message so that it can be easily filtered?
>
> I don't think there's an easy way to show only tags matching a pattern.
> You could do something like:
>
>   git tag -m 'path: foo' foo
>
>   git for-each-ref --format='%(refname:strip=2) %(subject)' refs/tags/ |
>   grep 'path: foo' |
>   awk '{print $1}'
>
> to grep their subjects (or body, if you want to make the grep stage a
> little more clever). Obviously that is not really a structured lookup,
> but if you control the tag contents, it might be OK.
>
> In commit messages there's a concept of machine-readable trailers, like
> "Signed-off-by", etc, and even some tools for displaying those. But
> there's not currently any support for parsing them out of tag objects.
>
>
> I sort of answered your questions literally, but TBH I'm still not
> entirely sure what you're trying to accomplish. So hopefully it was
> useful, but feel free to follow up with more questions. ;)

No, I think you summed it up pretty well for me.

I would like to ask one more question, which is now unrelated.

But I will probably ask in a new thread.

Thank you!
clime

>
> -Peff
