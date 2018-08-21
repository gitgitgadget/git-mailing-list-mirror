Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FAE51F954
	for <e@80x24.org>; Tue, 21 Aug 2018 20:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeHUX3Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 19:29:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:50920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726881AbeHUX3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 19:29:24 -0400
Received: (qmail 9260 invoked by uid 109); 21 Aug 2018 20:07:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 20:07:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26698 invoked by uid 111); 21 Aug 2018 20:07:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 16:07:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 16:07:47 -0400
Date:   Tue, 21 Aug 2018 16:07:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have"
 objects
Message-ID: <20180821200747.GA21955@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190705.GF30764@sigill.intra.peff.net>
 <xmqqin438pze.fsf@gitster-ct.c.googlers.com>
 <xmqqbm9v8pou.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbm9v8pou.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 12:50:09PM -0700, Junio C Hamano wrote:

> > Sorry for commenting on something completely off-topic, but when
> > applied with "git am -s", I get a resulting commit with 3 S-o-b (the
> > above two, plus the one added by "-s"), with a blank line in between
> > them.  I can understand the first blank line (the one between your
> > two S-o-b), as the first S-o-b does not even appear to be part of
> > the trailer block, but cannot explain why I get an extra one before
> > the one added by "-s".  Puzzled...
> 
> I think your original "two s-o-b with a blank line in between" was
> caused by the same problem, and "git commit --amend -s" perhaps
> added an extra one at the end, and added a blank line before the
> last "paragraph" while at it?
> 
> My suspicion is the long horizontal line at the beginning of the
> table, triggers it.  I haven't followed the code closely yet,
> though.

Ah, yeah, I think you're right. We call find_patch_start(), which thinks
the "---" line is the end of the commit message. That makes sense when
parsing trailers out of "format-patch" output, but not when we know we
have just the commit message.

So one obvious fix is a new option for the trailer code to tell it we
have _just_ a commit message. That would still leave this obvious false
positive for the format-patch case, but I'm not sure it can be helped.

-Peff
