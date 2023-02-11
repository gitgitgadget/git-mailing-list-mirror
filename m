Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66069C05027
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 02:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBKCUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 21:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKCUb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 21:20:31 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21D35FE44
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 18:20:30 -0800 (PST)
Received: (qmail 21504 invoked by uid 109); 11 Feb 2023 02:20:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Feb 2023 02:20:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30410 invoked by uid 111); 11 Feb 2023 02:20:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Feb 2023 21:20:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Feb 2023 21:20:29 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: t5559 breaks with apache 2.4.55
Message-ID: <Y+b7bTs2vdXAe/ky@coredump.intra.peff.net>
References: <Y8ztIqYgVCPILJlO@coredump.intra.peff.net>
 <Y81lQwG85+Skujja@pobox.com>
 <Y9Jmfg/jlSszVep4@coredump.intra.peff.net>
 <Y9YTsF4a8lL7uHm+@coredump.intra.peff.net>
 <xmqq357ems2h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq357ems2h.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2023 at 01:45:10PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ...
> > But that does at least give me more confidence that the bug is in
> > mod_http2, and isn't, say, some intentional behavior change there that
> > happens to trigger a bug in curl.
> >
> > I opened an issue here: https://github.com/icing/mod_h2/issues/243
> >
> > So we'll see if that helps.
> 
> Thanks.  I've seen that the above issue may have redirected the
> investigation to cURL, and over time, I expect taht this will start
> to trigger in more environments (as Apache 2.4.55 and mod_h2 2.0.10
> propagates) before it fixes itself (as fixed versions of these
> things we use in our tests percolates down).

Yeah, I am worried that this will bite other people, though it's not
clear to me yet how common the problematic version will be. But...

> In the meantime, perhaps we should punt with a patch like this?
> 
> 
> ------------ >8 ------------
> Subject: [PATCH] t5559: skip a known-to-be-broken test
> 
> t5559 runs the same set of tests as t5551 under HTTP/2 but one of
> them started failing with Apache 2.4.55 and mod_h2 2.0.10 (but not
> with HTTP/1.1).  Newer mod_h2 is known to have fixed the issue.
> 
> In the meantime, skip the test.

I'm not sure this is really sufficient. As I was running t5559 over and
over to test various versions, I noticed a few other cases that seemed
to fail, some of them racily. So I'm a bit worried that the problem may
be more extensive, and it is only that this particular test happened to
trigger it reliably.

In which case the right solution may be ditching t5559, or at the very
least adding a knob or version check to disable it.

So I'm tempted to just punt for now and see how often this bites people
in the real world. And if it does become a problem, we'll have more data
on what exactly should be changed.

-Peff
