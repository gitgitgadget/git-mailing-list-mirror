Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E058C433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 07:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023E2619F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 07:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352421AbhJAHDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 03:03:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:58922 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352432AbhJAHCz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 03:02:55 -0400
Received: (qmail 26344 invoked by uid 109); 1 Oct 2021 07:01:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Oct 2021 07:01:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8556 invoked by uid 111); 1 Oct 2021 07:01:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Oct 2021 03:01:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Oct 2021 03:01:06 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: en/remerge-diff [Was: Re: What's cooking in git.git (Sep 2021,
 #09; Thu, 30)]
Message-ID: <YVayMiOJPLFcTlY9@coredump.intra.peff.net>
References: <xmqqh7e18soj.fsf@gitster.g>
 <CABPp-BH2C5HFw_=NtK71oNGXkntzcJd2un0TgMb=UnJ5yJxAAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BH2C5HFw_=NtK71oNGXkntzcJd2un0TgMb=UnJ5yJxAAA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 11:31:32PM -0700, Elijah Newren wrote:

>   * Do something different with the tmp-objdir usage or use
> pretend_object_file().  I'm slightly worried the latter was only
> designed for a few files that all fit into memory, which may not be
> valid for this usecase.

Just to make sure I was being clear on this final point: the
pretend_object_file() interface _now_ is definitely not suitable for the
sizes you'd want. I think you'd need to:

  - have it handle pointers to non-duplicated storage, instead of owning
    all buffers (and then the remerge-diff code would do something
    clever with mmaps and tempfiles).

  - use something better than the linear cached_objects array for
    storing the entries, so lookup doesn't suffer with many objects.
    Perhaps an oidmap.

  - teach it to remove objects. For your purposes, a complete clear
    function would be sufficient.

-Peff
