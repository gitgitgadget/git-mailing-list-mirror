Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39095C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 17:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C0564E8A
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 17:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhBKRJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 12:09:18 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:55308 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232152AbhBKRHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 12:07:09 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C740F1F8C2;
        Thu, 11 Feb 2021 17:06:25 +0000 (UTC)
Date:   Thu, 11 Feb 2021 17:06:25 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t1500: ensure current --since= behavior remains
Message-ID: <20210211170625.GA8280@dcvr>
References: <20210210215543.18960-1-e@80x24.org>
 <YCUSaXCg8Abg+vGs@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCUSaXCg8Abg+vGs@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Wed, Feb 10, 2021 at 09:55:43PM +0000, Eric Wong wrote:
> 
> > This behavior of git-rev-parse is observed since git 1.8.3.1
> > at least(*), and likely earlier versions.
> > 
> > At least one git-reliant project in-the-wild relies on this
> > current behavior of git-rev-parse being able to handle multiple
> > --since= arguments without squeezing identical results together.
> > So add a test to prevent the potential for regression in
> > downstream projects.
> 
> I had to read this a few times to understand what "this behavior" meant.
> It is just: when given multiple --since options, output a --max-age for
> each of them, even though internally, Git's revision traversal will only
> use one (in the usual last-one-wins fashion).
> 
> I'm not sure if I was just being dense, or if this could be spelled out
> more clearly. :)

*shrug* :>  My brain struggles with coherent thought so I'm
surprised anybody is able to understand me at all :x

> Out of curiosity, why does the other project want that? From your
> mention of libgit2's git__date_parse(), I assume it's something that
> wants to parse approxidates into timestamps in a script. Maybe we ought
> to provide a more direct and robust way of doing that. We have a similar
> need in t0006, but we use a test-helper program for it.

It takes about 5ms for my system to run git-rev-parse once.  I
may be getting multiple approxidates at once, 1-2 in a typical
input (start..end); but a strange or malicious input could have
hundreds/thousands of approxidates to parse.

Thus, I'm batching up all the approxidates into one rev-parse
invocation (up to system argv limits right now).  With the
output lines split into an array, walking the output/input
arrays in parallel will match them up.  Hypothetically, if
rev-parse were to get clever and deduplicate or reject identical
inputs; then the parallel walk would be broken.

> (I have no problem in the meantime with this patch, though; any new
> method for accomplishing this would want to give other projects time to
> adapt to its use).

Yes.  I think I've mentioned some years/decade ago having
general functionality along the lines of "git cat-file --batch"
or fast-import would be nice (even for some existing scripts and
tests shipped with git).  (v)fork+execve is painful even on
Linux.
