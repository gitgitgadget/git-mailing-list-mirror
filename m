Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D72AC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 18:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiGASJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiGASJs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 14:09:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFE81145C
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 11:09:47 -0700 (PDT)
Received: (qmail 9690 invoked by uid 109); 1 Jul 2022 18:09:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Jul 2022 18:09:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27583 invoked by uid 111); 1 Jul 2022 18:09:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Jul 2022 14:09:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Jul 2022 14:09:46 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 0/4] add and apply a rule to find "unused" init+free
Message-ID: <Yr84aglgBwIvnwC7@coredump.intra.peff.net>
References: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 01, 2022 at 12:30:55PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This series adds a coccinelle rule to find and remove code where the
> only reference to a variable in a given function is to malloc() &
> free() it, where "malloc" and "free" also match
> "strbuf_init/strbuf_release", and then later in the series anything
> that looks like a init/free pattern.

Overall, I hated this much less than I expected to. ;)

My main concern was that we'd have a jumble of init/release rules for
every data type, but the regex matching on identifier names lets us do
things broadly. And for data types that don't match our usual naming
conventions, that seems like a good opportunity to consider changing
their names.

I'm not too concerned about false positives here, since there are humans
in the loop. The resulting diffs are pretty obvious to review, and a
compiler would obviously catch any case where the variable really did
get used in between.

I do wish we could do it with the compiler and not coccinelle, just
because the latter has been such a source of frustration in terms of
performance issues and head-scratching "why didn't it catch this one"
cases. But this is IMHO much better than nothing, as shown by the
cleanups it already found.

-Peff
