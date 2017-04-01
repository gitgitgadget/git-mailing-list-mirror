Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B4020966
	for <e@80x24.org>; Sat,  1 Apr 2017 08:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750802AbdDAID4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 04:03:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:55279 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbdDAIDy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 04:03:54 -0400
Received: (qmail 29049 invoked by uid 109); 1 Apr 2017 08:03:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 08:03:51 +0000
Received: (qmail 16162 invoked by uid 111); 1 Apr 2017 08:04:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 04:04:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 04:03:49 -0400
Date:   Sat, 1 Apr 2017 04:03:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: SHA1 collision in production repo?! (probably not)
Message-ID: <20170401080349.lccextuc3l6fgs6j@sigill.intra.peff.net>
References: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com>
 <xmqqh929z6wl.fsf@gitster.mtv.corp.google.com>
 <20170331174515.j2ruifuigskyvucc@sigill.intra.peff.net>
 <xmqq37dtxi36.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37dtxi36.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 02:16:29PM -0700, Junio C Hamano wrote:

> Before we forget...
> 
> -- >8 --
> From: Jeff King <peff@peff.net>
> 
> When sha1_loose_object_info() finds that a loose object file cannot
> be stat(2)ed or mmap(2)ed, it returns -1 to signal an error to the
> caller.  However, if it found that the loose object file is corrupt
> and the object data cannot be used from it, it forgets to return -1.
> 
> This can confuse the caller, who may be lead to mistakenly think
> that there is a loose object and possibly gets an incorrect type and
> size from the function.  The SHA-1 collision detection codepath, for
> example, when it gets an object over the wire and tries to see the
> data is the same as what is available as a loose object locally, can
> get confused when the loose object is correupted due to this bug.

Unfortunately this isn't quite right. I was able to reproduce the
problem that Lars saw, and this patch doesn't fix it.

So here's a two-patch series. The first fixes the problem described
above, along with a simpler test that demonstrates it. The second fixes
Lars's problem on top.

I know you're heading out for a week, so I'll post it now for review,
and then hold and repost when you get back.

  [1/2]: sha1_loose_object_info: return error for corrupted objects
  [2/2]: index-pack: detect local corruption in collision check

 builtin/index-pack.c         |  2 ++
 sha1_file.c                  |  2 +-
 t/t1060-object-corruption.sh | 24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

-Peff
