Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1D322027C
	for <e@80x24.org>; Thu, 13 Jul 2017 21:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbdGMVvs (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 17:51:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34992 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbdGMVvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 17:51:47 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 53C1F2027C;
        Thu, 13 Jul 2017 21:51:47 +0000 (UTC)
Date:   Thu, 13 Jul 2017 21:51:47 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
Subject: Re: reftable: new ref storage format
Message-ID: <20170713215147.GA31153@starla>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net>
 <CAGZ79kbY_t=Xtpb7fy0sZ9TWOy-UOUx8X5+_qLx60Dtg48Ok-g@mail.gmail.com>
 <20170713203533.vcfyf5iei46g4tcf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713203533.vcfyf5iei46g4tcf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> I agree that a full binary search of a reftable is harder because of the
> prefix compression (it may still be possible by scanning backwards, but
> I think there are ambiguities when you land in the middle of a record,
> since there's no unambiguous end-of-record character). But I don't think
> it matters. If you binary-search to a constant-sized block, then a
> linear scan of the block is acceptable.

For a new packed-refs, I think an intrusive critbit tree would
be a good way to store refs which have many common prefixes and
I've always wanted to apply critbit to an on-disk storage
format...

Several years ago, I started writing one in Perl using
pwrite/pread to provide Message-ID <=> NNTP article number
mapping several years ago, but gave up on it out of laziness:

  https://80x24.org/spew/1441508596-19511-1-git-send-email-e@80x24.org/raw

The end goal would've been to have two tries sharing the same
storage struct: one keyed by Message-ID, the other keyed by NNTP
article number (and figuring out the node using offsets like
we do with (container_of|list_entry) in list.h.

For git, being able to do an O(hashlength) prefix search based
on the object_id from the reftable would speed up decorations, I
think.  And of course, the O(refnamelength) prefix search would
also apply to the refnames themselves.
