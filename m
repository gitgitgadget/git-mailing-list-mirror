Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97CB202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 22:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936778AbdKQWTk (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 17:19:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:33018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S936777AbdKQWTi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 17:19:38 -0500
Received: (qmail 9608 invoked by uid 109); 17 Nov 2017 22:19:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Nov 2017 22:19:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29016 invoked by uid 111); 17 Nov 2017 22:19:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 17 Nov 2017 17:19:53 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Nov 2017 17:19:36 -0500
Date:   Fri, 17 Nov 2017 17:19:36 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 4/6] list-objects: filter objects in
 traverse_commit_list
Message-ID: <20171117221936.zsokhvmslnf6jete@sigill.intra.peff.net>
References: <20171116180743.61353-1-git@jeffhostetler.com>
 <20171116180743.61353-5-git@jeffhostetler.com>
 <20171116122133.4cc718414579c1a5a682174b@google.com>
 <bdf75d90-570d-8cf0-886a-2c5c9cdba1c1@jeffhostetler.com>
 <20171116215725.k44e3alk2lq6bbwu@sigill.intra.peff.net>
 <xmqqh8tttzwq.fsf@gitster.mtv.corp.google.com>
 <6f433987-f91b-d5b5-242e-3a241b7442c7@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f433987-f91b-d5b5-242e-3a241b7442c7@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 17, 2017 at 10:42:52AM -0500, Jeff Hostetler wrote:

> > Yes, I share the same feeling.  It does not help that the series
> > defines its own notion of arg_needs_armor() and uses it to set a
> > field called requires_armor that is not yet used, the definition of
> > "armor"ing being each byte getting encoded as two hexadecimal digits
> > without any sign (which makes me wonder what a receiver of
> > "deadbeef" would do---did it receive an armored string or a plain
> > one???).  I do not understand why these strings are not passed as
> > opaque sequences of bytes and instead converted at this low a layer.
> 
> I'm probably being too paranoid.  My fear is that a client could pass
> an expression to clone/fetch/fetch-pack that would be sent to the
> server and evaluated by the interface between upload-pack and pack-objects.
> I'm not worried about the pack-protocol transport.  I'm mainly concerned
> in how upload-pack passes that *client-expression* to pack-objects and are
> there ways for that to go south on the server with a carefully crafted
> expression.

I think you have to trust that those interfaces are capable of passing
raw bytes, whether directly via execve() or because we got the quoting
right. If there's a bug there, it's going to be a bigger problem than
just this code path (and the fix needs to be there, not second-guessing
it in the callers).

So I'd say that yeah, you are being too paranoid.

As an aside, though, I wonder if these client expressions should be fed
over stdin to pack-objects. That removes any argv limits we might run
into on the server side. It also removes shell injections as a
possibility, though of course we'd need quoting in that layer to avoid
argument-injection to pack-objects.

-Peff
