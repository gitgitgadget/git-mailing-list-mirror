Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA686C433E3
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06132071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHYS3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:29:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:40332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYS3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:29:24 -0400
Received: (qmail 1825 invoked by uid 109); 25 Aug 2020 18:29:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 18:29:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31013 invoked by uid 111); 25 Aug 2020 18:29:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 14:29:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 14:29:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] refs: remove lookup cache for reference-transaction
 hook
Message-ID: <20200825182922.GB1417288@coredump.intra.peff.net>
References: <0db8ad8cdb69afb9d6453bf60a808e8b82382a4e.1597998473.git.ps@pks.im>
 <c1cae6dd19ffe00e4456e4f96ad92277ceeced27.1598349284.git.ps@pks.im>
 <20200825151053.GA1409139@coredump.intra.peff.net>
 <xmqqd03e1tsd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd03e1tsd.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 11:09:54AM -0700, Junio C Hamano wrote:

> >> +test_perf "nonatomic push" '
> >> +	git push ./target-repo.git $(test_seq 1000) &&
> >> +	git push --delete ./target-repo.git $(test_seq 1000)
> >>  '
> >
> > This works as far as Git is concerned, but "seq 1000" output with NULs
> > is 3893 bytes. I wonder if some platforms might run into command-line
> > limits there.
> 
> That was my thought when I saw the above as well.  In addition, I do
> not think it is a good idea to encourage digit-only refnames.

Good point. It gets hairy at four digits:

  $ git show 1000
  error: short SHA1 1000 is ambiguous
  hint: The candidates are:
  hint:   10000434d2 tree
  hint:   10007bcb9e tree
  hint:   10008a0e22 tree
  hint:   1000bdf512 tree
  hint:   1000dc2368 blob
  fatal: ambiguous argument '1000': unknown revision or path not in the working tree.

So I think if the test works it may be relying on the exact object ids
that happen to be generated (which fortunately are at least
deterministic these days, but it may be a trap waiting to spring for
somebody later).

-Peff
