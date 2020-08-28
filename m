Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50335C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 07:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3674320EDD
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 07:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgH1HIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:08:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:43354 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbgH1HID (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 03:08:03 -0400
Received: (qmail 23267 invoked by uid 109); 28 Aug 2020 07:08:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Aug 2020 07:08:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3776 invoked by uid 111); 28 Aug 2020 07:08:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Aug 2020 03:08:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Aug 2020 03:08:02 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] strmap: add strdup_strings option
Message-ID: <20200828070802.GC2105050@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <b3095d97d8ee9d6576292731cc100492e7c64f13.1598035949.git.gitgitgadget@gmail.com>
 <20200821200121.GF1165@coredump.intra.peff.net>
 <CABPp-BGJK4C7U+-MB-+TUgFAuuFJKE-E7y17FFJDRTyFydVX2A@mail.gmail.com>
 <20200821210301.GA11806@coredump.intra.peff.net>
 <CABPp-BE8tdpjx2RBGyZOYV4hsfjm5HF_dmehvX792x7TtWkLcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE8tdpjx2RBGyZOYV4hsfjm5HF_dmehvX792x7TtWkLcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 03:25:44PM -0700, Elijah Newren wrote:

> >   - That sounds like a lot of maps. :) I guess you've looked at
> >     compacting some of them into a single map-to-struct?
> 
> Oh, map-to-struct is the primary use.  But compacting them won't work,
> because the reason for the additional maps is that they have different
> sets of keys (this set of paths meet a certain condition...).  Only
> one map contains all the paths involved in the merge.

OK, I guess I'm not surprised that you would not have missed such an
obvious optimization. :)

> Also, several of those maps don't even store a value; and are really
> just a set implemented via strmap (thus meaning the only bit of data I
> need for some conditions is whether any given path meets it).  It
> seems slightly ugly to have to call strmap_put(map, string, NULL) for
> those.  I wonder if I should have another strset type much like your
> suggesting for strintmap.  Hmm...

FWIW, khash does have a "set" mode where it avoids allocating the value
array at all.

What's the easiest way to benchmark merge-ort? I suspect I could swap
out hashmap for khash (messily) in an hour or less.

-Peff
