Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8732FC636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 14:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBOOau (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBOOat (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 09:30:49 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE33756F
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 06:30:48 -0800 (PST)
Received: (qmail 11390 invoked by uid 109); 15 Feb 2023 14:30:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Feb 2023 14:30:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14029 invoked by uid 111); 15 Feb 2023 14:30:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Feb 2023 09:30:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Feb 2023 09:30:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] shorten_unambiguous_ref(): avoid sscanf()
Message-ID: <Y+zslp55nmAQ5Fvi@coredump.intra.peff.net>
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
 <Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net>
 <xmqqmt5f535i.fsf@gitster.g>
 <Y+wLoFKXhlugxrh1@coredump.intra.peff.net>
 <xmqqwn4j3mhy.fsf@gitster.g>
 <Y+wN0agVK9ZQU/sT@coredump.intra.peff.net>
 <xmqqsff71plf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsff71plf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 09:10:04PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It does indeed. I pulled the logic from skip_prefix(), thinking that by
> > relying on it I would avoid making a stupid mistake. Oh well. :)
> >
> > Doing it like this is much more readable:
> > ...
> > I'll hold on to that (plus an adjustment to the comment below to match,
> > and perhaps a test for this negative-match case) for a day or so to give
> > anybody else a chance to comment, and then send out a v2 tomorrow.
> 
> Thanks, and surely that is very readable.
> 
> Alternatively, I think you can just compare refname and rule until
> they diverge, without doing any special casing for per-cent on the
> rule side inside the loop.
> 
> If you do not find any difference, or the byte that differ is not
> the per-cent at the beginning of "%.*s" on the rule side, they they
> do not match.

I had a similar thought, but I think it is fooled by "refs/heads/%foo".
The correct shortening there is "%foo".  But we'd parse the
"refs/heads/%.*s" rule up to the ".", and then complain that they do not
match.

-Peff
