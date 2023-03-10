Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248B9C6FD19
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 09:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjCJJuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 04:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjCJJuP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 04:50:15 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E22F1ADD8
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 01:49:51 -0800 (PST)
Received: (qmail 19417 invoked by uid 109); 10 Mar 2023 09:49:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Mar 2023 09:49:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10609 invoked by uid 111); 10 Mar 2023 09:49:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Mar 2023 04:49:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Mar 2023 04:49:49 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] format-patch: do not respect diff.noprefix
Message-ID: <ZAr9PbevIMASG5b+@coredump.intra.peff.net>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
 <ZAl4pZV08a6Bgoip@coredump.intra.peff.net>
 <xmqqy1o5op1i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1o5op1i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 08:41:29AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   - if a project really does have a workflow that likes prefix-less
> >     patches, and the receiver is prepared to use "-p0", then the sender
> >     now has to manually say "--no-prefix" for each format-patch
> >     invocation. That doesn't seem _too_ terrible given that the receiver
> >     has to manually say "-p0" for each git-am invocation.
> 
> It does seem very terrible if any existing projects do use the
> workflow, as their receivers need to change their workflow, though.

I think the escape hatch there is patch 5, where the sender just sets
the new variable to say "no, really, I actually want to send patches
without a prefix".

I had originally thought to squash them together to help explain that
better, but I wasn't 100% sure we'd want format.noprefix.

> But we can declare that we do not care about such projects that do
> not honor our -p1 worldview, and I have no objection to this change
> if we can have list consensus for us to go in that direction.

Yeah, I would very much like to hear from others on the list, especially
anybody who does have a "-p0" workflow.

> Colored patches, by the way, cannot be applied, so perhaps we should
> disable ui_config altogether, on the other hand?  I dunno.

Yeah, color is a bit weird there. We auto-disable it when the patch
isn't going to stdout or a pager, so it's mostly a non-issue. I think
more interesting cases are ones like diff.algorithm, diff.context, etc,
where they don't break the diff, but we don't quite consider them
vanilla enough for plumbing.

I do wonder about diff.relative, which may or may not cause confusion on
the receiving end, depending on what you're trying to achieve (are you
sending a patch for somebody else's git repo, or did you make a git repo
yourself and want to send a diff of some subset).

Also diff.submodule, but the implications of submodule-via-format-patch
are too scary for me to even contemplate. ;)

-Peff
