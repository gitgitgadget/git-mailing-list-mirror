Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816C6C43332
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3F764E12
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbhCDAXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:50646 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhCCNmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 08:42:47 -0500
Received: (qmail 22013 invoked by uid 109); 3 Mar 2021 13:41:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Mar 2021 13:41:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26961 invoked by uid 111); 3 Mar 2021 13:41:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Mar 2021 08:41:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Mar 2021 08:41:30 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joachim Schmitz <jojo@schmitz-digital.de>,
        Matt Kraai <kraai@ftbfs.org>,
        "Randall S. Becker" <randall.becker@nexbridge.ca>,
        git@vger.kernel.org, Aleksey Kliger <alklig@microsoft.com>
Subject: Re: [PATCH] config.mak.uname: enable OPEN_RETURNS_EINTR for macOS
 Big Sur
Message-ID: <YD+SCtzmtWgFArwW@coredump.intra.peff.net>
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
 <YDXaJHnZ5LgCj9NX@coredump.intra.peff.net>
 <xmqqzgzuyqli.fsf@gitster.g>
 <YDaY/M3Rw+6xwZlf@coredump.intra.peff.net>
 <YDiRywyld/0OTT5U@coredump.intra.peff.net>
 <xmqq8s7ascby.fsf@gitster.g>
 <YDy0C9sRvboGXQ7P@coredump.intra.peff.net>
 <xmqqczwimnps.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczwimnps.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 01, 2021 at 03:57:35PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I got another off-list report of the problem. I think we probably want
> > to do this on top:
> 
> Queued and pushed out.

Thanks. I guess we're a bit late to make it into the upcoming release.
Certainly we have survived for many years without this particular
bugfix, so in that sense it is not urgent. But I do wonder if we will
see more reports as more people start using the new macOS release. So it
might be good to keep in mind for maint, if we cut a minor release.

Or alternatively, we could include _just_ the first patch. That's low
risk, since you have to enable to knob yourself, but it gives people an
option if they run into the symptom. But even that is probably not that
urgent. People can also cherry-pick the patch, after all (and a
distributor like homebrew can probably include the patch in their recipe
if need be).

> I wonder if these hits for SA_RESTART in config.mak.uname would be a
> good way to guide us.
> 
>     [6c109904 (Port to HP NonStop, 2012-09-19)]
>             # Not detected (nor checked for) by './configure'.
>             # We don't have SA_RESTART on NonStop, unfortunalety.
>             COMPAT_CFLAGS += -DSA_RESTART=0
> 
>     [40036bed (Port to QNX, 2012-12-18)]
>     ifeq ($(uname_S),QNX)
>             COMPAT_CFLAGS += -DSA_RESTART=0

I'm inclined to leave them alone until somebody with access to such a
system can look further into it. After all, if you do not have
SA_RESTART, you might not even have EINTR in the first place.

> One caveat is that we do not know if their system headers hide the
> real implementation of open(2) behind a C preprocessor macro, in
> whcih case OPEN_RETURNS_EINTR wrapper may not work correctly.

Yeah. I didn't think about that when I did the original "just do it
everywhere" patch. But that is exactly what caused the problem on
Windows (not a system macro, but in fact our own!). So I'm glad to have
backed it off to a Makefile knob.

-Peff
