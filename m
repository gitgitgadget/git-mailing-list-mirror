Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837891F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 19:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbdAYTfp (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 14:35:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:44679 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751375AbdAYTfo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 14:35:44 -0500
Received: (qmail 28976 invoked by uid 109); 25 Jan 2017 19:35:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 19:35:44 +0000
Received: (qmail 14887 invoked by uid 111); 25 Jan 2017 19:35:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 14:35:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 14:35:42 -0500
Date:   Wed, 25 Jan 2017 14:35:42 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/12] clone: disable save_commit_buffer
Message-ID: <20170125193541.yxqq4avnjngbigmq@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
 <20170124004500.v7geae55w6zeax7m@sigill.intra.peff.net>
 <xmqqmvefaray.fsf@gitster.mtv.corp.google.com>
 <20170125192740.5lqoc2srqfjiyfwr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170125192740.5lqoc2srqfjiyfwr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 02:27:40PM -0500, Jeff King wrote:

> > > For fetching operations like clone, we already disable
> > 
> > s/clone/fetch/ you meant?
> 
> Well, no, because this patch deals with clone.
> 
> It's likely that builtin/fetch.c would want the same treatment. It
> didn't come up for me because I've disabled the alternates check for
> that case (but you can't do that with stock git), and I didn't dig
> further.
> 
> Possibly this should just go into fetch-pack.c, right before we walk
> over all of the refs and call parse_object() and deref_tag() on all of
> them. It feels a little funny to tweak the global save_commit_buffer
> flag there, but it already do so in everything_local(), so I don't think
> we're really losing much.

Hrm. So I thought it might be useful to write a patch that just tweaks
save_commit_buffer at the start of fetch_pack(). But looking it over,
we call everything_local() _before_ we walk over all the refs. So
save_commit_buffer should already be turned off for my case.

I wonder if I made a mistake while measuring the peak RSS. Or if clone
parses some commits before it calls into fetch_pack() (but which
objects? It doesn't have any until it does the fetch).

Perhaps we should just drop this patch (though I think it is logically
consistent and wouldn't hurt anything).

-Peff
