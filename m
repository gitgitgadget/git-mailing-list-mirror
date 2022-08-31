Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BDBECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 15:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiHaPgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiHaPgW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 11:36:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F91C2775
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 08:36:20 -0700 (PDT)
Received: (qmail 14965 invoked by uid 109); 31 Aug 2022 15:36:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Aug 2022 15:36:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14717 invoked by uid 111); 31 Aug 2022 15:36:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Aug 2022 11:36:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Aug 2022 11:36:19 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/5] t3701: redefine what is "bogus" output of a diff
 filter
Message-ID: <Yw9/81QFPsSjDUTM@coredump.intra.peff.net>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
 <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
 <a01fa5d25e4a94dd8ece5e328f853c000a2ad0f9.1661785916.git.gitgitgadget@gmail.com>
 <9261de42-3287-6ccb-6cf5-21c0a8ee1f17@gmail.com>
 <xmqq7d2pifby.fsf@gitster.g>
 <742b42af-a298-219d-a35f-1fa8ba985aed@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <742b42af-a298-219d-a35f-1fa8ba985aed@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2022 at 10:26:17AM +0100, Phillip Wood wrote:

> > Is it that all it cares about is that the output has the same number
> > of lines as the input?  If so, I agree that it is much less realistic,
> > but it may not matter in practice.  Even an "exit 0" might do ;-)
> 
> Yes I think it only cares that there are the same number of lines which begs
> the question "why are we changing this test in the first place?". The commit
> message talks about the being unable to parse the hunk header but that's
> only true because we would be looking in the wrong place for it - the output
> does in fact contain a valid hunk header. With this change there is no hunk
> header in the filtered output at all. In practice if the number of lines
> differs it is normally because the filter messed with the diff header and
> removed some lines from it which is what the existing test simulates.
> 
> I'm struggling to understand the need for this change from the explanation
> in the commit message as it seems to me  to assume the line being deleted is
> the hunk header when in fact it is deleting the diff header.

FWIW, as the author of the original test, I'm also confused about why it
needs to be changed. The filter I wrote in the original test was just
"echo too-short". It was switched to "sed 1d" because the original did
not read the input at all, which racily caused Git to see SIGPIPE:

  https://lore.kernel.org/git/20200113170417.GK32750@szeder.dev/

Switching to "exit 0" would bring that problem back. But I think "sed q"
potentially does, too, because sed will quit without reading all of the
input. We really do want something like "sed 1d" that changes the number
of lines, but ensures that the filter reads to EOF.

-Peff
