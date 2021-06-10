Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2304C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D7D613FF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhFJNNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:13:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:51238 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhFJNNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:13:09 -0400
Received: (qmail 7666 invoked by uid 109); 10 Jun 2021 13:11:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 13:11:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29856 invoked by uid 111); 10 Jun 2021 13:11:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 09:11:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 09:11:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] add_pending_object_with_path(): work around "gcc -O3"
 complaint
Message-ID: <YMIPb+9e2PtaLZhl@coredump.intra.peff.net>
References: <YMIOY6Hp6//yGrFm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMIOY6Hp6//yGrFm@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 09:06:44AM -0400, Jeff King wrote:

> We can work around this by replacing our "did we hit the trailing NUL"
> subscript dereference with a length check. We do not even have to pay
> the cost for an extra strlen(), as we can pass our new length into
> interpret_branch_name(), which was converting our "0" into a call to
> strlen() anyway.
> [...]
> -		if (0 < len && name[len] && buf.len)
> +		if (0 < len && len < namelen && buf.len)
>  			strbuf_addstr(&buf, name + len);

I guess another option would be to drop the check entirely. It is only
protecting us from calling strbuf_addstr() with an empty string, which
is a noop anyway (it would not even cause a useless allocation, since we
know that buf is non-empty, and that it won't need to grow).

I think I still prefer my original solution, though.

-Peff
