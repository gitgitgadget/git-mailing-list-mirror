Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80F7EB64DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGCGAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjGCGAC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:00:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A0CA
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 22:59:51 -0700 (PDT)
Received: (qmail 9368 invoked by uid 109); 3 Jul 2023 05:59:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 05:59:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2312 invoked by uid 111); 3 Jul 2023 05:59:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 01:59:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 01:59:49 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 11/16] revision.h: store hidden refs in a `strvec`
Message-ID: <20230703055949.GG3502534@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <dd856a3982bbc01af7b79399808a5e3baace3899.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd856a3982bbc01af7b79399808a5e3baace3899.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 10:21:57AM -0400, Taylor Blau wrote:

> In subsequent commits, it will be convenient to have a 'const char **'
> of hidden refs (matching `transfer.hiderefs`, `uploadpack.hideRefs`,
> etc.), instead of a `string_list`.
> 
> Convert spots throughout the tree that store the list of hidden refs
> from a `string_list` to a `strvec`.
> 
> Note that in `parse_hide_refs_config()` there is an ugly const-cast used
> to avoid an extra copy of each value before trimming any trailing slash
> characters. This could instead be written as:
> 
>     ref = xstrdup(value);
>     len = strlen(ref);
>     while (len && ref[len - 1] == '/')
>             ref[--len] = '\0';
>     strvec_push(hide_refs, ref);
>     free(ref);
> 
> but the double-copy (once when calling `xstrdup()`, and another via
> `strvec_push()`) is wasteful.

I saw strvec_push_nodup() suggested here. I'm OK leaving it like this
for now, but I do think we'll want that in the long run.

-Peff
