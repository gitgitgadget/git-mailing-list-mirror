Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0695C433E9
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A9964E65
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhBPTGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 14:06:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:34800 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhBPTGT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 14:06:19 -0500
Received: (qmail 14441 invoked by uid 109); 16 Feb 2021 19:05:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 19:05:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28393 invoked by uid 111); 16 Feb 2021 19:05:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 14:05:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 14:05:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jan =?utf-8?B?4oCcS2hhcmRpeOKAnSBTdGFuxJtr?= <khardix@gmail.com>,
        git@vger.kernel.org
Subject: Re: git-send-email: smtpserver in $HOME
Message-ID: <YCwXf1CA0Xyw/B88@coredump.intra.peff.net>
References: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
 <xmqqo8gksqr4.fsf@gitster.c.googlers.com>
 <YCvotU6KVruFuf9/@coredump.intra.peff.net>
 <xmqq35xvrgbg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35xvrgbg.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 10:57:39AM -0800, Junio C Hamano wrote:

> > It looks like there's some weirdness here, though; $smtp_server may be a
> > hostname, and it looks like we use "/" to distinguish a file path. I
> > wonder if allowing "!my-sendmail" would be more consistent with other
> > parts of Git (not to mention more flexible).
> 
> I am not sure '!' prefix fits well here.

Why not? It matches alias config, credential config, and perhaps others
as "treat this as a shell command".

And like a leading "/", it would not be likely to be confused with an
actual hostname.

> When cloning from something (that is not yet known as an entity that
> we must go over the network), we do an equivalent of "test -f" (for
> bundles) and "test -d" (for local repositories), and I think the use
> of "does it refer to a local file" here matches it as a precedent.

Sure, but you cannot say "does it refer to a local file" for a
non-absolute path. And that is the source of the problem, IMHO: there is
no way to signal "this is a command I expect to be executed" except by
using an absolute path.

Or do you mean that we should see if $smtp_server exists in the PATH,
and if so prefer it over a network hostname?

> I do find it sloppy that the check uses file_name_is_absolute() that
> only checks the shape of the string, without seeing if it actually
> exists and is an executable file, though.

Yes, though that comes with its own problems: you mean to say "foo", but
due to a typo or missing program it is not found, and so you hit "foo"
on the network. Probably not the end of the world, but unexpected, I
would say. That's why I'd prefer having a syntactic marker that
indicates what you mean.

(I'd prefer to just have $smtp_program or similar as that signal
instead, but it doesn't seem worth trying to retrofit it now).

-Peff
