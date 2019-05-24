Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DE31F462
	for <e@80x24.org>; Fri, 24 May 2019 08:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389327AbfEXINk (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 04:13:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:37658 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389658AbfEXINj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 04:13:39 -0400
Received: (qmail 26324 invoked by uid 109); 24 May 2019 08:13:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 May 2019 08:13:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7676 invoked by uid 111); 24 May 2019 08:14:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 May 2019 04:14:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 May 2019 04:13:37 -0400
Date:   Fri, 24 May 2019 04:13:37 -0400
From:   Jeff King <peff@peff.net>
To:     Keegan Carruthers-Smith <keegan.csmith@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git archive generates tar with malformed pax extended attribute
Message-ID: <20190524081337.GA9082@sigill.intra.peff.net>
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
 <20190524070644.GF25694@sigill.intra.peff.net>
 <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 09:35:51AM +0200, Keegan Carruthers-Smith wrote:

> > I can't reproduce on Linux, using GNU tar (1.30) nor with bsdtar 3.3.3
> > (from Debian's bsdtar package). What does your "tar --version" say?
> 
> bsdtar 2.8.3 - libarchive 2.8.3

Interesting. I wonder if there was a libarchive bug that was fixed
between 2.8.3 and 3.3.3.

> > Git does write a pax header with the commit id in it as a comment.
> > Presumably that's what it's complaining about (but it is not malformed
> > according to any tar I've tried). If you feed git-archive a tree rather
> > than a commit, that is omitted. What does:
> >
> >   git archive --format tar c21b98da2^{tree} | tar tf - >/dev/null
> >
> > say? If it doesn't complain, then we know it's indeed the pax comment
> > field.
> 
> It also complains
> 
>   $ git archive --format tar c21b98da2^{tree} | tar tf - >/dev/null
>   tar: Ignoring malformed pax extended attribute
>   tar: Error exit delayed from previous errors.

Ah, OK. So it's not the comment field at all, but some other entry.

> Some more context: I work at Sourcegraph.com We mirror a lot of repos
> from github.com. We usually interact with a working copy by running
> git archive on it in our infrastructure. This is the first repository
> that I have noticed which produces this error. An interesting thing to
> note is the commit metadata contains a lot of non-ascii text which was
> my guess at what my be tripping up the tar creation.

Yeah, though the only thing that makes it into the tarfile is the actual
tree entries. I'd imagine the file content is not likely to be a source
of problems, as it's common to see binary gunk there. Most of the
filenames are pretty mundane, but this symlink destination is a little
funny:

  $ git archive ... | tar tvf - | grep nicovideo4as.swc
  lrwxrwxrwx root/root         0 2019-05-24 03:05 libs/nicovideo4as.swc -> PK\003\004\024

That's not the full story, though. It is indeed a symlink in the
tree:

  $ git ls-tree -r HEAD libs/nicovideo4as.swc
  120000 blob ec3137b5fcaeae25cf67927068af116517683806	libs/nicovideo4as.swc

But the contents of that blob, which should be the destination filename,
are definitely not:

  $ git cat-file blob ec3137b5f | wc -c
  57804
  $ git cat-file blob ec3137b5f | xxd | head -1
  00000000: 504b 0304 1400 0800 0800 5069 694e 0000  PK........PiiN..

There's quite a bit more data there. And what tar showed us goes up to
the first NUL, which does not seem surprising.

It's possible Git is doing the wrong thing on the writing side, but
given that newer versions of bsdtar handle it fine, I'd guess that the
old one simply had problems consuming poorly formed symlink filenames.

-Peff
