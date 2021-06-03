Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89CFC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86C8613F6
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFCTcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:32:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:45372 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhFCTcx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 15:32:53 -0400
Received: (qmail 6397 invoked by uid 109); 3 Jun 2021 19:31:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Jun 2021 19:31:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28516 invoked by uid 111); 3 Jun 2021 19:31:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Jun 2021 15:31:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Jun 2021 15:31:07 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Eric Wong' <e@80x24.org>, 'Taylor Blau' <me@ttaylorr.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
Message-ID: <YLkt+w9Lxyy8iLS5@coredump.intra.peff.net>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
 <YLfc2+Te7Y3UY+Sm@nand.local>
 <YLfgy94sbmStC0mR@coredump.intra.peff.net>
 <20210602201150.GA29388@dcvr>
 <YLfmo8kl0URnGgp5@coredump.intra.peff.net>
 <003c01d757ee$c0664600$4132d200$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <003c01d757ee$c0664600$4132d200$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 04:34:51PM -0400, Randall S. Becker wrote:

> >> The wrapper should apply to all platforms.  NFS (and presumably other
> >> network FSes) can be mounted with interrupts enabled.
> >
> >I don't mind that, as the wrapper is pretty low-cost (and one less Makefile knob is nice). If it's widespread, though, I find it curious that
> >nobody has run into it before now.
> 
> I suspect this is because of the way the file system on NonStop behaves. It is a multi-processor platform, with multi-cores, so anything can happen. If the file system is delayed for any reason, like a signal coming from a different core (EINTR has high priority), then fsync() will be interrupted. EINTR is allowed on NonStop for fsync(). So it would be really great if the patch included a modification to config.mak.uname to include that. This would be a timing-only issue on most other systems, probably something that would hit NFS.
> 
> The patch for the config is:
> diff --git a/config.mak.uname b/config.mak.uname
> index cb443b4e02..ac3e3ca2c5 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -566,6 +566,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>         NO_REGEX = NeedsStartEnd
>         NO_PTHREADS = UnfortunatelyYes
>         FREAD_READS_DIRECTORIES = UnfortunatelyYes
> +       FSYNC_NEEDS_RESTART = YesPlease
> 
>         # Not detected (nor checked for) by './configure'.

Yeah, if we don't make it unconditional, then this is the obvious next
step. But the more important question is: did you test this out and did
it fix the test breakage you saw on NonStop?

-Peff
