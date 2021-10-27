Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359F6C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146936109D
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbhJ0MWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:22:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:47954 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231584AbhJ0MWR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:22:17 -0400
Received: (qmail 13229 invoked by uid 109); 27 Oct 2021 12:19:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Oct 2021 12:19:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22456 invoked by uid 111); 27 Oct 2021 12:19:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Oct 2021 08:19:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Oct 2021 08:19:49 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "commit-msg" hook unexpectedly called for "git pull
 --no-verify"
Message-ID: <YXlD5ecNSdeBSMoS@coredump.intra.peff.net>
References: <YXfwanz3MynCLDmn@pflmari>
 <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
 <YXlBhmfXl3wFQ5Bj@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXlBhmfXl3wFQ5Bj@pflmari>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 02:09:42PM +0200, Alex Riesen wrote:

> Jeff King, Tue, Oct 26, 2021 23:16:09 +0200:
> > On Tue, Oct 26, 2021 at 02:11:22PM +0200, Alex Riesen wrote:
> > I was going to ask whether this should be passing through "verify", and
> > allowing its "no-" variant, but there is no "--verify" in git-merge.
> > Arguably there should be (for consistency and to countermand an earlier
> > --no-verify), but that is outside the scope of your fix (sadly if
> > somebody does change that, they'll have to remember to touch this spot,
> > too, but I don't think it can be helped).
> 
> This seems simple enough, though. Like this?
> 
> [PATCH] Remove negation from the merge option "--no-verify"
> 
> This allows re-enabling hooks disabled by an earlier "--no-verify"
> in command-line and makes the interface more consistent.

Yeah, I don't see any problems in the patch below, and I agree it makes
things overall nicer (both the user-facing parts, and not having to see
the double-negative "!no_verify" in the code).

> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 80d4831662..54cd3b04df 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -112,8 +112,9 @@ option can be used to override --squash.
>  +
>  With --squash, --commit is not allowed, and will fail.
>  
> ---no-verify::
> -	This option bypasses the pre-merge and commit-msg hooks.
> +--[no-]verify::
> +	With `--no-verify`, bypass the pre-merge and commit-msg hooks,
> +	which will be run by default.

This "which will be run by default" is a little awkward. Maybe:

  By default, pre-merge and commit-msg hooks are run. When `--no-verify`
  is given, these are bypassed.

?

-Peff
