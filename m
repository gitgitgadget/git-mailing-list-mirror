Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42C03208E3
	for <e@80x24.org>; Sat,  2 Sep 2017 13:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbdIBNuS (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Sep 2017 09:50:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:55818 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752441AbdIBNuR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2017 09:50:17 -0400
Received: (qmail 13558 invoked by uid 109); 2 Sep 2017 13:50:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Sep 2017 13:50:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11326 invoked by uid 111); 2 Sep 2017 13:50:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Sep 2017 09:50:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Sep 2017 09:50:15 -0400
Date:   Sat, 2 Sep 2017 09:50:15 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Brandon Williams <bmwill@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
Message-ID: <20170902135015.2hf4b3o4xivdd5x2@sigill.intra.peff.net>
References: <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
 <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
 <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
 <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
 <20170830055539.xpgxeu3flmxs55av@sigill.intra.peff.net>
 <8e09e4e1-984c-78d1-7b87-0bafe5346621@alum.mit.edu>
 <20170902084451.h5pmbtolqcl2j3w4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170902084451.h5pmbtolqcl2j3w4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 02, 2017 at 04:44:51AM -0400, Jeff King wrote:

> There are actually very few callers of create_tempfile (I count two).
> Everybody just uses lock_file(). So I think we could get away with just
> modifying the internals of the lock struct to hold a pointer, and then
> teaching commit_lock_file() et al to reset it to NULL after performing
> an operation that frees the tempfile. We could even modify
> rename_tempfile() and friends to take a pointer-to-pointer and NULL it
> itself. That would make it harder to get wrong.

I take it back.  It's true that there are very few create_tempfile()
callers, but we'd want to have a similar change for mks_tempfile_*, and
there are a lot more of those.

One solution would be to add an extra level of indirection, like:

  struct tempfile {
	struct the_part_that_we_put_on_our_global_list *data;
  };

That lets us keep normal value semantics for "struct tempfile", which is
nice. And existing callers wouldn't have to be modified at all for the
creation/deletion bits. But I suspect it would also result in a lot of
replacements like s/temp->/temp.data->/ for any callers that look at the
underlying fields that have moved into the sub-struct.

-Peff
