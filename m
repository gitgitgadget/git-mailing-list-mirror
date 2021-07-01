Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48930C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C5A61411
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhGAQPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:15:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:38830 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhGAQPw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:15:52 -0400
Received: (qmail 28241 invoked by uid 109); 1 Jul 2021 16:13:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 16:13:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17171 invoked by uid 111); 1 Jul 2021 16:13:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 12:13:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 12:13:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] *.[ch]: don't duplicate *_init() and *_INIT logic
Message-ID: <YN3pmS8q3dA3Gnd+@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 01, 2021 at 12:51:24PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This series implements a suggestion by Jeff King to use an idiom for
> *_init() functions that avoids duplicating what we've declared in the
> corresponding *_INIT macros. See
> https://lore.kernel.org/git/YNytp0JAIaQih0Y4@coredump.intra.peff.net/

These all look pretty good to me. My comments are minor enough that I'll
include them here rather than individual replies:

> Ævar Arnfjörð Bjarmason (5):
>   *.h: move some *_INIT to designated initializers

I agree with Martin's suggestion to prefer the designated initializer
for STRING_LIST_INIT_NODUP. The consistency makes it easier to read.

>   *.c *_init(): define in terms of corresponding *_INIT macro

Yep, nice.

>   dir.[ch]: replace dir_init() with DIR_INIT

I like this. Since there is a dir_clear(), I guess somebody could argue
that lacking an init function makes things less consistent/balanced. But
if we don't need it, I'm happy to drop it.

>   string-list.[ch]: add a string_list_init_{nodup,dup}()

I like this. I agree the current "0/1" in the callers is kind of
inscrutable. It does make things harder if we wanted to add more
options, but that is already true due to the macro initializers.

>   string-list.h users: change to use *_{nodup,dup}()

Nice. IMHO you should drop the convenience wrapper here. Leaving it
means we'll have to circle back later and fix up topics in flight (and
it's not atomic; when we finally drop it, there may be more topics in
flight then!).

If it were somehow complicated to convert callers, that might be more
justified. But doing a quick conversion (which is easily detected by the
compiler) in the merge commit seems like less work than having to
revisit the topic later.

-Peff
