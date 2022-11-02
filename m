Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89856C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKBHj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKBHjY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:39:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB1310E6
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:39:22 -0700 (PDT)
Received: (qmail 8920 invoked by uid 109); 2 Nov 2022 07:39:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Nov 2022 07:39:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2803 invoked by uid 111); 2 Nov 2022 07:39:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Nov 2022 03:39:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Nov 2022 03:39:20 -0400
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Martin Englund <martin@englund.nu>, git@vger.kernel.org
Subject: Re: Git Bug Report: out of memory using git tag
Message-ID: <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
References: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
 <Y2EPgICMsmzKvCC8@coredump.intra.peff.net>
 <38d50c30-c6a3-5989-6e01-47c5467d9d6b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38d50c30-c6a3-5989-6e01-47c5467d9d6b@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 08:41:55PM -0400, Philippe Blain wrote:

> > The issue isn't unique to pgp signatures; the problem is in the parsing
> > done by ref-filter's find_subpos(), so any signature type exhibits the
> > problem. At the end of that function we do:
> > 
> >       *nonsiglen = sigstart - buf;
> > 
> > but "buf" has moved beyond "sigstart". Presumably because it uses
> > strstr() to look for end-of-line in buf. Since there isn't one before
> > the signature begins, we go to the end of the signature.
> > 
> > The bug bisects to 9f75ce3d8f (ref-filter: handle CRLF at end-of-line
> > more gracefully, 2020-10-29). Before then, I think our loop was careful
> > about moving past the start of the signature. Author cc'd.
> > 
> 
> Thanks for letting me know, and for the simple reproducer, that's very useful.
> I'll try to find time to fix that this week, but can't promise anything.

After sleeping on it, I think I fully understand what's going on. There
are actually _two_ bugs, but they are closely related. ;)

Here are patches which fix them both. I may be setting a new record for
the ratio of commit message lines to changed code. But it took me a
while to figure out what was going on, so I wanted to explain it fully.

  [1/2]: ref-filter: fix parsing of signatures without blank lines
  [2/2]: ref-filter: fix parsing of signatures with CRLF and no body

 ref-filter.c            |  8 ++++----
 t/t6300-for-each-ref.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 4 deletions(-)

-Peff
