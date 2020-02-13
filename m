Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D05AC2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22480222C2
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgBMSkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:40:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:42616 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725781AbgBMSkf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:40:35 -0500
Received: (qmail 16541 invoked by uid 109); 13 Feb 2020 18:40:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 18:40:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15655 invoked by uid 111); 13 Feb 2020 18:49:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Feb 2020 13:49:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Feb 2020 13:40:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/13] rev-list: fallback to non-bitmap traversal when
 filtering
Message-ID: <20200213184033.GA15046@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
 <20200213021730.GC1126038@coredump.intra.peff.net>
 <xmqq8sl6s63c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8sl6s63c.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 10:19:19AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The "--use-bitmap-index" option is usually aspirational: if we have
> > bitmaps and the request can be fulfilled more quickly using them we'll
> > do so, but otherwise fall back to a non-bitmap traversal.
> >
> > The exception is object filtering, which explicitly dies if the two
> > options are combined. Let's convert this to the usual fallback behavior.
> >
> > This is a minor convenience for now (since the caller can easily know
> > that --filter and --use-bitmap-index don't combine), but will become
> > much more useful as we start to support _some_ filters with bitmaps, but
> > not others.
> 
> Makes sense.  
> 
> Perhaps the option should have been called allow-bitmap-index or
> something along that line, but it is too late ;-)

Yeah. It's also annoyingly long to type, and makes for long lines in the
test scripts. ;)

There are also some weird semantics with the fallback, because the
output may differ depending on whether we use bitmaps (see one of the
later patches). I wouldn't be opposed to cleaning this up and giving it
a new option ("--allow-bitmaps" or something) to keep compatibility, but
it's out of scope here.

The existing option (and my suggestion, as well as most of the internal
code) are guilty of equating "bitmap" with "object reachability bitmap".
There's lots of things one might use bitmaps for, and at some point we
might even expose such a thing via rev-list.

Anyway, that concludes my rant. I don't think any of these are urgent to
fix, and definitely shouldn't be part of this series.

-Peff
