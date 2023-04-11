Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2077CC77B74
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 09:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjDKJa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 05:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjDKJaK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 05:30:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8F33A80
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 02:30:06 -0700 (PDT)
Received: (qmail 6789 invoked by uid 109); 11 Apr 2023 09:30:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Apr 2023 09:30:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5846 invoked by uid 111); 11 Apr 2023 09:30:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Apr 2023 05:30:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Apr 2023 05:30:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] date: remove approxidate_relative()
Message-ID: <20230411093005.GB398350@coredump.intra.peff.net>
References: <f5b9a290-7cec-7a83-660b-e15494d2cdc8@web.de>
 <xmqqjzyjemji.fsf@gitster.g>
 <20230410202536.GE104097@coredump.intra.peff.net>
 <xmqqy1mzcus6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy1mzcus6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 02:05:45PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Cute. It feels like this only goes half-way, though. You really want
> > per-hunk configurable context. This particular patch was just lucky that
> > there was only one hunk in the date.c file.
> 
> "-U16" extends the context lines in both directions by the same
> number of lines, but most likely you need to extend asymmetrically.

Good point. This is sort of like grep's "-C" along with "-A" and "-B".
All of which I generally find somewhat awkward. :)

> In René's patch, for example, much of the body of approxidate_str()
> is visible in the precontext of the hunk to remove
> approxidate_relative(), but the body of that function is irrelevant.
> What he wanted to show was the body of approxidate_careful() and the
> size of that function is where the -U16 came from.
> 
> Instead, imagine --extra-context='<range>:<path>' were the way to
> tell Git to include the specified range of lines in the post context
> even though they may not have been modified.  Then René's patch
> could have been produced with
> 
>     $ git format-patch -1 \
>       --extra-context='/^timestamp_t approxidate_careful/,/^}$/:date.c'
> 
> and would have shown 3 lines of precontext before the removed
> approxidate_relative(), plus the unchanged approxidate_careful()
> function in full in the postcontext.

Ooh, I like that very much. In that sense it really feels like an
extension of --function-context. Would the regexes be searches starting
from the edge of some context (as they more or less are under the hood
for function context), or would you search within the whole file for
ranges (and then presumably use them when a hunk's context is adjacent
to or overlaps a range)?

If the latter, I guess you could also allow both absolute and relative
line numbers, similar to how "-L" accepts range input.

-Peff
