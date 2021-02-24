Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF59C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5A364E6C
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhBXEvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:51:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:42678 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232331AbhBXEvY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 23:51:24 -0500
Received: (qmail 28997 invoked by uid 109); 24 Feb 2021 04:50:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Feb 2021 04:50:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8878 invoked by uid 111); 24 Feb 2021 04:50:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 23:50:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 23:50:42 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git format-patch lost the last part when branch merge
Message-ID: <YDXbIk5TLrHWQhwv@coredump.intra.peff.net>
References: <20210222211621.0C5D.409509F4@e16-tech.com>
 <YDQ27qbbblPfLCpU@coredump.intra.peff.net>
 <CABPp-BFa3CnOHMg4t99xMHWif8kMZJFcmHtLSNxZgAPaw1Cd=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFa3CnOHMg4t99xMHWif8kMZJFcmHtLSNxZgAPaw1Cd=Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 08:24:24PM -0800, Elijah Newren wrote:

> > You could imagine ways for format-patch to represent the conflict
> > resolution done in a merge, but it's not quite trivial, and nobody has
> > done it yet.
> 
> Are you referring to something like this (in the git.git repository)?
> 
> $ git show --oneline --remerge-diff 42342b3ee6
> 42342b3ee6 Merge branch 'ab/mailmap'
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 1bce961e07..6fb18a34b0 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -257,16 +257,8 @@ test_expect_success 'No mailmap files, but configured' '
> 
>  test_expect_success 'setup mailmap blob tests' '
>         git checkout -b map &&
> -<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 60ecad090d (Merge branch 'ps/fetch-atomic')
>         test_when_finished "git checkout main" &&
> -       cat >just-bugs <<- EOF &&
> -|||||||||||||||||||||||||||||||| 72c4083ddf
> -       test_when_finished "git checkout master" &&
> -       cat >just-bugs <<- EOF &&
> -================================
> -       test_when_finished "git checkout master" &&
>         cat >just-bugs <<-\EOF &&
> ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 4e168333a8 (shortlog: remove
> unused(?) "repo-abbrev" feature)
>         Blob Guy <bugs@company.xx>
>         EOF
>         cat >both <<-EOF &&
> 
> 
> I agree that representing the conflict done in a merge is more
> difficult than it sounds, but if you mean what I think you mean then I
> disagree with the "nobody has done it yet" half of your statement.
> :-)
> 
> That said, I haven't attempted to tie this into format-patch in any
> way, and have absolutely no plans to.  (And --remerge-diff hasn't been
> submitted upstream, because it depends on ort, and that still needs
> reviews...)

I certainly was thinking of remerge-diff when I was writing all of that,
but didn't want to get too far into the details. I think it's an
absolutely wonderful way of showing off conflict resolution, and I'm
excited to see it as a feature in Git. But:

  - as you note, it isn't a public feature yet ;)

  - while format-patch will learn about it because it knows all of the
    diff formats, the fundamental point of format-patch is to produce
    output that can be applied with git-am. So we'd only be halfway
    there.

  - it does still get weird specifying a merge at all as part of a
    series. Merging _what_ exactly? The topic branch made of the patches
    that were just sent?  A back-merge from some other commit on master
    into the topic branch? And if the latter, wouldn't that depend
    heavily on the base commit that the patches are applied on top of?

So I left it as "you could imagine" and "it's not quite trivial". ;)

-Peff
