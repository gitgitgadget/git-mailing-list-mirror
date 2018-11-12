Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ADD21F97E
	for <e@80x24.org>; Mon, 12 Nov 2018 12:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbeKLWYF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:24:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:35362 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729133AbeKLWYF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:24:05 -0500
Received: (qmail 23960 invoked by uid 109); 12 Nov 2018 12:31:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 12:31:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10204 invoked by uid 111); 12 Nov 2018 12:30:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 07:30:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 07:30:59 -0500
Date:   Mon, 12 Nov 2018 07:30:59 -0500
From:   Jeff King <peff@peff.net>
To:     Mateusz Loskot <mateusz@loskot.net>
Cc:     git@vger.kernel.org
Subject: Re: Migration to Git LFS inflates repository multiple times
Message-ID: <20181112123058.GE3956@sigill.intra.peff.net>
References: <CABUeae-Bk5hxEsLuDi=MytzN-kBG0D4psLbc_1=B+=70D=JKCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABUeae-Bk5hxEsLuDi=MytzN-kBG0D4psLbc_1=B+=70D=JKCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 12:47:42AM +0100, Mateusz Loskot wrote:

> Hi,
> 
> I'm posting here for the first time and I hope it's the right place to ask
> questions about Git LFS.
> 
> TL;TR: Is this normal a repository migrated to Git LFS inflates multiple times
> and how to deal with it?

That does sound odd to me. People with more LFS experience can probably
give you a better answers, but one thought occurred to me: does LFS
store backup copies of the original refs that it rewrites (similar to
the way filter-branch stores refs/original)?

If so, then the resulting repo has the new history _and_ the old
history. Which might mean storing those large blobs both as Git objects
(for the old history) and in an LFS cache directory (for the new
history).

And the right next step is probably to delete those backup refs, and
then "git gc --prune=now". Hmm, actually thinking about it, reflogs
could be making the old history reachable, too.

Try looking at the output of "git for-each-ref" and seeing if there are
any backup refs. After deleting them (or confirming that there aren't),
prune the reflogs with:

  git reflog expire --expire-unreachable=now --all

and then "git gc --prune=now".

-Peff
