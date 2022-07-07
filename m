Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD51C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 18:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbiGGSmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 14:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiGGSmX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 14:42:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFBB2A43E
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 11:42:22 -0700 (PDT)
Received: (qmail 6429 invoked by uid 109); 7 Jul 2022 18:42:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jul 2022 18:42:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3443 invoked by uid 111); 7 Jul 2022 18:42:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jul 2022 14:42:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jul 2022 14:42:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/mv.c: use correct type to compute size of an
 array element
Message-ID: <YscpDTgwxUko/aZM@coredump.intra.peff.net>
References: <xmqq8rp54r4l.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rp54r4l.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 06, 2022 at 07:02:18PM -0700, Junio C Hamano wrote:

>    * Should we in general use sizeof(TYPE) in these cases, instead
>      of the size of the zeroth element, e.g.
> 
>  		memmove(source + i, source + i + 1,
> 			n * sizeof(source[i]));
>     
>      It would have been caught by the above Coccinelle rule (we are
>      taking the size of *dst).

I'm not sure I understand this. As you noted in a later email, using
sizeof(TYPE) is less maintainable if the type of "source" changes. But
later you mention using "*source" instead of "source[i]". I don't think
there is a particular reason to prefer one over the other from the
compiler perspective. I find "*source" more idiomatic (but better still
of course is MOVE_ARRAY, which removes the choice entirely).

>    * Shouldn't we have an array of struct with four members, instead
>      of four parallel arrays, e.g.
> 
> 		struct {
> 			const char *source;
> 			const char *destination;
> 			enum update_mode mode;
> 			const char *submodule_gitfile;
> 		} *mv_file;
> 
>    The latter question is important to answer before we accept
>    Coccinelle-suggested rewrite to use four MOVE_ARRAY() on these
>    four parallel arrays on top of this fix.

I think that would make the code a lot cleaner. But it looks like
"source" and "destination" come from separate calls to
internal_prefix_pathspec().  So you'd have to reconcile that. And
there's some extra trickiness that sometimes "destination" comes from
"dest_path", which _isn't_ always the same size as "source".

So I suspect the code which uses these arrays would be cleaner with a
struct, but the setup may get worse. :)

-Peff
