Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6545AC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 10:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A719601FD
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 10:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbhHaKic (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 06:38:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:34816 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241081AbhHaKiF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 06:38:05 -0400
Received: (qmail 5782 invoked by uid 109); 31 Aug 2021 10:37:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Aug 2021 10:37:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22697 invoked by uid 111); 31 Aug 2021 10:37:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Aug 2021 06:37:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Aug 2021 06:37:09 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     gitster@pobox.com, me@ttaylorr.com, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v3 1/2] pkt-line: add stdio packet write functions
Message-ID: <YS4GVWdsnRqpM+4y@coredump.intra.peff.net>
References: <xmqqbl5ic19t.fsf@gitster.g>
 <20210831093444.28199-1-jacob@gitlab.com>
 <20210831093444.28199-2-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831093444.28199-2-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 11:34:43AM +0200, Jacob Vosmaer wrote:

> +void fwrite_or_die(FILE *f, const void *buf, size_t count)
> +{
> +	if (fwrite(buf, count, 1, f) != 1)
> +		die_errno("fwrite error");
> +}

One small oddity I noticed. The definition of fwrite is
fwrite(ptr, size, nmemb, strea), where we write "nmemb" items of "size"
bytes each. I'd argue we're writing "count" single bytes, so it should
be:

  if (fwrite(buf, 1, count, f) != count)

This matters a lot for fread(), where any read shorter than "count"
(e.g., due to EOF) would return "0" rather than a partial result. But I
have a hard time imagining an implementation of fwrite() where the
distinction would matter. And grepping around, we seem to have both
forms in our code base already. So it's probably fine.

-Peff
