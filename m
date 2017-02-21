Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9AE201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 21:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbdBUVIN (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 16:08:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:59469 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbdBUVIL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 16:08:11 -0500
Received: (qmail 592 invoked by uid 109); 21 Feb 2017 21:08:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 21:08:11 +0000
Received: (qmail 15707 invoked by uid 111); 21 Feb 2017 21:08:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 16:08:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2017 16:08:08 -0500
Date:   Tue, 21 Feb 2017 16:08:08 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] show decorations at the end of the line
Message-ID: <20170221210808.3ryri33ve7w7csdp@sigill.intra.peff.net>
References: <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com>
 <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
 <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net>
 <xmqqefywnk5a.fsf@gitster.mtv.corp.google.com>
 <CA+55aFw3ZRtgsLGW-TFqpq-3uCw55L42p7cF=Q-73qM_VPuYsQ@mail.gmail.com>
 <CA+P7+xqtPwzt3J6O05TP=E_hh-ko97adn+__Zmc0DNSDqEnEHw@mail.gmail.com>
 <20170220004648.c2zz6bm2hylvep6x@sigill.intra.peff.net>
 <CA+55aFwdUxCvmi28T3yn1K4rqn2bZmJBdTRr7tSbMa-g5izHbw@mail.gmail.com>
 <xmqqpoibfgo3.fsf@gitster.mtv.corp.google.com>
 <CA+55aFwT2HUBzZO8Gpt9tHoJtdRxv9oe3TDoSH5jcEOixRNBXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwT2HUBzZO8Gpt9tHoJtdRxv9oe3TDoSH5jcEOixRNBXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 12:40:11PM -0800, Linus Torvalds wrote:

> In fact, I played around with some formats, and the one I lines the
> most was actually one that split the line for decorations, but that
> one was admittedly pretty funky. It gives output like
> 
>   b9df16a4c (HEAD -> master)
>             pathspec: don't error out on all-exclusionary pathspec patterns
>   91a491f05 pathspec magic: add '^' as alias for '!'
>   c8e05fd6d ls-remote: add "--diff" option to show only refs that differ
>   20769079d (tag: v2.12.0-rc2, origin/master, origin/HEAD)
>             Git 2.12-rc2
>   076c05393 Hopefully the final batch of mini-topics before the final
>   c5b22b819 Merge branch 'jk/tempfile-ferror-fclose-confusion'
>   62fef5c56 Merge branch 'dp/submodule-doc-markup-fix'
>   1f73ff080 Merge branch 'jk/reset-to-break-a-commit-doc-updated'
>   bf5f11918 Merge branch 'jk/reset-to-break-a-commit-doc'
>   e048a257b Merge branch 'js/mingw-isatty'
> 
> (which looks better with colorization than it looks in the email).
> 
> But I'm not even going to send out that patch, because it was such an
> atrocious hack to line things up.

I was going to suggest a custom format string that does the same, but
what we have is not _quite_ flexible enough.

You can use "%+d" to insert a newline only when "%d" is not empty. But
it always inserts _before_ the decoration, not after. Likewise, you
cannot say "if it's not empty, then insert %d and a leading tab".

The for-each-ref formatting code has %(if), but it's not unified with
the commit-format ones.

So the best I could come up with is:

  git config pretty.twoline '%C(auto)%h %s%C(auto)%+d'
  git log --format=twoline

which looks like:

  80ba04ed9 Merge branch 'svn-escape-backslash' of git://bogomips.org/git-svn
   (origin/master, origin/HEAD)
  20769079d Git 2.12-rc2
   (tag: v2.12.0-rc2)
  076c05393 Hopefully the final batch of mini-topics before the final
  c5b22b819 Merge branch 'jk/tempfile-ferror-fclose-confusion'
  62fef5c56 Merge branch 'dp/submodule-doc-markup-fix'
  1f73ff080 Merge branch 'jk/reset-to-break-a-commit-doc-updated'

-Peff
