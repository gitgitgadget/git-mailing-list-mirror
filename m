Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8348C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A193D20719
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbgI3WqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:46:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:46076 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731776AbgI3WqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 18:46:13 -0400
Received: (qmail 26857 invoked by uid 109); 30 Sep 2020 22:46:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 22:46:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1258 invoked by uid 111); 30 Sep 2020 22:46:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 18:46:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 18:46:11 -0400
From:   Jeff King <peff@peff.net>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] combine-diff: handle --find-object in multitree code path
Message-ID: <20200930224611.GC1908000@coredump.intra.peff.net>
References: <20200930115240.GA1899467@coredump.intra.peff.net>
 <CAPx1Gvd7WpAgUGgZkZARY7JcFj8nbDJ6zEDTSaBt2=xR535E-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPx1Gvd7WpAgUGgZkZARY7JcFj8nbDJ6zEDTSaBt2=xR535E-g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 01:06:02PM -0700, Chris Torek wrote:

> On Wed, Sep 30, 2020 at 4:54 AM Jeff King <peff@peff.net> wrote:
> > I'm a little nervous that the second "wart" may actually be making
> > things worse, because now we sometimes produce a wrong answer and
> > sometime a right one, and it can be difficult to know which options
> > cause which (e.g., rename detection puts us onto the slow path). Is it
> > worse to sometimes be right and sometimes wrong, or to always be
> > consistently and predictably wrong? I suppose one could even argue that
> > the current semantics aren't "wrong", but just what we happen to
> > produce. But IMHO they are so un-useful as to be considered wrong.
> 
> "Predictably wrong" *is* actually useful while "unpredictably wrong"
> is, um, "less useful".  Perhaps just documenting exactly which options
> use which path?  Basically turn some of this into documentation.

Perhaps. The thing is that I do have a use case for which I need that
answer, and I need it to be reliable and fast. So right now
--find-object is not useful at all, and this makes it useful for at
least my narrow case.

My big concern is just making the overall system more confusing. I agree
that documenting _might_ help, but we're getting pretty far into
internals here. I'm not sure I'd want to expose the user to a list of
"these options trigger this code path, which behaves like this". It's
likely to generate more confusion than it solves, and would likely
bitrot anyway.

Maybe something like this would help:

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index b10ff4caa6..f61af6af18 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -200,3 +200,7 @@ parents).  When shown by `git diff-files -c`, it compares the
 two unresolved merge parents with the working tree file
 (i.e. file1 is stage 2 aka "our version", file2 is stage 3 aka
 "their version").
+
+Note that the results of using `-c` or `--cc` with diff-filtering
+options such as `-S` or `--find-object` are currently poorly defined,
+and are subject to change.

I'd perhaps even put that in a BUGS section, but that can't be done from
an include file like this.

-Peff
