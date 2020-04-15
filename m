Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CF2C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 16:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7681D208FE
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415734AbgDOQXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:23:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:54692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1415722AbgDOQX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 12:23:28 -0400
Received: (qmail 12853 invoked by uid 109); 15 Apr 2020 16:23:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Apr 2020 16:23:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4887 invoked by uid 111); 15 Apr 2020 16:34:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Apr 2020 12:34:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Apr 2020 12:23:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vasil Dimov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Vasil Dimov <vd@freebsd.org>
Subject: Re: [PATCH 1/2] range-diff: fix a crash in parsing git-log output
Message-ID: <20200415162326.GG2464307@coredump.intra.peff.net>
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
 <2375e34100e571f9c3ce658d28aba6648fba18a6.1586960921.git.gitgitgadget@gmail.com>
 <xmqqsgh47okk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgh47okk.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 08:31:39AM -0700, Junio C Hamano wrote:

> "Vasil Dimov via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Vasil Dimov <vd@FreeBSD.org>
> >
> > `git range-diff` calls `git log` internally and tries to parse its
> > output. But `git log` output can be customized by the user in their
> > git config and for certain configurations either an error will be
> > returned by `git range-diff` or it will crash.
> >
> > To fix this explicitly set the output format of the internally
> > executed `git log` with `--pretty=medium`. Because that cancels
> > `--notes`, add explicitly `--notes` at the end.
> 
> Good finding.  
> 
> Shouldn't we also disable customizations that come from the
> configuration variables like diff.external, diff.<driver>.command?

If range-diff were a script, I would say it should be using the
"rev-list | diff-tree --stdin" plumbing under the hood, rather than
"log".

The read_patches() function does let callers pass options to git-log,
but I don't _think_ this is exposed to the user. We only allow a few
--notes options to be passed, and we should be able to apply those to
diff-tree. So converting it to use plumbing might be an option.

Though I think there is another bug:

  $ git rev-list HEAD | git diff-tree --stdin --pretty=medium --notes
  commit 8f3d9f354286745c751374f5f1fcafee6b3f3136
  git: notes.c:1308: format_display_notes: Assertion `display_notes_trees' failed.
  Aborted

Another option would be for range-diff to directly call the
revision-traversal plumbing itself. There may be complications there,
though (or else it would have been done from the outset).

We should fix that assertion regardless, though.

-Peff
