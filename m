Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DE6C433E4
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 07:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1FAC20717
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 07:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgGVHpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:45:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:34968 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbgGVHpb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 03:45:31 -0400
Received: (qmail 5825 invoked by uid 109); 22 Jul 2020 07:45:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Jul 2020 07:45:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29693 invoked by uid 111); 22 Jul 2020 07:45:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Jul 2020 03:45:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Jul 2020 03:45:30 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
Message-ID: <20200722074530.GB3306468@coredump.intra.peff.net>
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
 <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 22, 2020 at 07:50:08AM +0200, Johannes Sixt wrote:

> Am 22.07.20 um 01:29 schrieb B. Stebler:
> > I have been looking for a tool to display merge conflicts, that instead
> > of showing the two versions of the conflicting section, would show the
> > diff for that section in both conflicting commits.
> 
> Perhaps you want to configure `merge.conflictStyle=diff3`? It does not
> exactly show a diff, but it writes the base version of the conflicted
> part in addition to "ours" and "theirs".

Yeah, I find diff3 is usually sufficient. But the contents of the base,
"ours", and "theirs" sides are also available in the index:

  # diff between base (stage 1) and ours (stage 2)
  git diff :1:file :2:file

  # diff between base (stage 1) and theirs (stage 3)
  git diff :1:file :3:file

I thought we had added nice aliases for "ours" and "theirs" instead of
the hard-to-remember stage numbers, but I think we only did so for
things like "git checkout --ours", etc.

The big downside here, of course, is that it's showing the diff for the
whole file, not just one hunk (on the other hand, I often find the
trickiest conflicts are ones where the changes unexpectedly span
multiple hunks).

There's also git-mergetool, which uses the information in those stages
to feed content to other tools, which may show conflicts in more
advanced ways. I don't have opinions on any of the particular tools it
supports, but "git mergetool --tool-help" might be a good place to start
exploring.

-Peff
