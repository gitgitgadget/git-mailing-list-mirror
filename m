Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0551F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970AbcHCWx2 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:53:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:54388 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932942AbcHCWx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 18:53:26 -0400
Received: (qmail 22458 invoked by uid 102); 3 Aug 2016 22:53:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 18:53:17 -0400
Received: (qmail 7849 invoked by uid 107); 3 Aug 2016 22:53:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 18:53:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 18:53:13 -0400
Date:	Wed, 3 Aug 2016 18:53:13 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 07/12] run-command: add clean_on_exit_handler
Message-ID: <20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.peff.net>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-8-larsxschneider@gmail.com>
 <20160803212433.zzdino3ivyem5a2v@sigill.intra.peff.net>
 <826967FE-BFF8-4387-83F7-AE7036D97FEC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <826967FE-BFF8-4387-83F7-AE7036D97FEC@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 12:15:46AM +0200, Lars Schneider wrote:

> > I'm not clear on why we want this cleanup filter. It looks like you use
> > it in the final patch to send an explicit shutdown to any filters we
> > start. But I see two issues with that:
> > 
> >  1. This shutdown may come at any time, and you have no idea what state
> >     the protocol conversation with the filter is in. You could be in
> >     the middle of sending another pkt-line, or in a sequence of non-command
> >     pkt-lines where "shutdown" is not recognized.
> 
> Maybe I am missing something, but I don't think that can happen because 
> the cleanup callback is *only* executed if Git exits normally without error. 
> In that case we would be in a sane protocol state, no?

OK, then maybe I am doubly missing the point. I thought this cleanup was
here to hit the case where we call die() and git exits unexpectedly.

If you only want to cover the "we are done, no errors, goodbye" case,
then why don't you just write shutdown when we're done?

I realize you may have multiple filters, but I don't think it should be
run-command's job to iterate over them. You are presumably keeping a
list of active filters, and should have a function to iterate over that.

Or better yet, do not require a shutdown at all. The filter sees EOF and
knows there is nothing more to do. If we are in the middle of an
operation, then it knows git died. If not, then presumably git had
nothing else to say (and really, it is not the filter's business if git
saw an error or not).

Though...

> Thanks. The shutdown command is not intended to be a mechanism to tell
> the filter that everything went well. At this point - as you mentioned -
> the filter already received all data in the right way. The shutdown
> command is intended to give the filter some time to perform some post
> processing before Git returns.
> 
> See here for some brainstorming how this feature could be useful
> in filters similar to Git LFS:
> https://github.com/github/git-lfs/issues/1401#issuecomment-236133991

OK, so it is not really "tell the filter to shutdown" but "I am done
with you, filter, but I will wait for you to tell me you are all done,
so that I can tell the user".

I'm not sure if calling that "shutdown" makes sense, though. It's almost
more of a checkpoint (and I wonder if git would ever want to
"checkpoint" without hanging up the connection).

-Peff
