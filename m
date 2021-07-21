Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D316DC6377E
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A42610F7
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbhGUKpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:45:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:53046 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237413AbhGUJmy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:42:54 -0400
Received: (qmail 2032 invoked by uid 109); 21 Jul 2021 10:23:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 10:23:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3248 invoked by uid 111); 21 Jul 2021 10:23:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 06:23:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 06:23:23 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 06:25:18PM -0400, Taylor Blau wrote:

> When writing a new multi-pack index, write_midx_internal() attempts to
> load any existing one to fill in some pieces of information. But it uses
> load_multi_pack_index(), which ignores the configuration
> "core.multiPackIndex", which indicates whether or not Git is allowed to
> read an existing multi-pack-index.
> 
> Replace this with a routine that does respect that setting, to avoid
> reading multi-pack-index files when told not to.
> 
> This avoids a problem that would arise in subsequent patches due to the
> combination of 'git repack' reopening the object store in-process and
> the multi-pack index code not checking whether a pack already exists in
> the object store when calling add_pack_to_midx().
> 
> This would ultimately lead to a cycle being created along the
> 'packed_git' struct's '->next' pointer. That is obviously bad, but it
> has hard-to-debug downstream effects like saying a bitmap can't be
> loaded for a pack because one already exists (for the same pack).

I'm not sure I completely understand the bug that this causes.

But another question: does this impact how

  git -c core.multipackindex=false multi-pack-index write

behaves? I.e., do we still write, but just avoid reading the existing
midx? That itself seems like a more sensible behavior (e.g., trying to
recover from a broken midx state).

-Peff
