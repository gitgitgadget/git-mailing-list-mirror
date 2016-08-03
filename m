Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5261F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933242AbcHCXlx (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:41:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:54481 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933200AbcHCXlv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 19:41:51 -0400
Received: (qmail 23506 invoked by uid 102); 3 Aug 2016 23:15:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 19:15:10 -0400
Received: (qmail 8404 invoked by uid 107); 3 Aug 2016 23:15:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 19:15:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 19:15:06 -0400
Date:	Wed, 3 Aug 2016 19:15:06 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 07/12] run-command: add clean_on_exit_handler
Message-ID: <20160803231506.h5mo5lah2pgwdvip@sigill.intra.peff.net>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-8-larsxschneider@gmail.com>
 <20160803212433.zzdino3ivyem5a2v@sigill.intra.peff.net>
 <826967FE-BFF8-4387-83F7-AE7036D97FEC@gmail.com>
 <20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.peff.net>
 <74C2CEA6-EAAB-406F-8B37-969654955413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74C2CEA6-EAAB-406F-8B37-969654955413@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 01:09:57AM +0200, Lars Schneider wrote:

> > Or better yet, do not require a shutdown at all. The filter sees EOF and
> > knows there is nothing more to do. If we are in the middle of an
> > operation, then it knows git died. If not, then presumably git had
> > nothing else to say (and really, it is not the filter's business if git
> > saw an error or not).
> 
> EOF? The filter is supposed to process multiple files. How would one EOF
> indicate that we are done?

I think we may be talking about two different EOFs.

Git sends a file in pkt-line format, and the flush marks EOF for that
file. But the filter keeps running, waiting for more input. This can
happen multiple times.

Eventually git calls close() on the descriptor, and the filter sees the
"real" EOF (i.e., read() returns 0). That is the signal that git is
done.

> > I'm not sure if calling that "shutdown" makes sense, though. It's almost
> > more of a checkpoint (and I wonder if git would ever want to
> > "checkpoint" without hanging up the connection).
> 
> OK, I agree that the naming might not be ideal. But "checkpoint" does not
> convey that it is only executed once after all blobs are filtered?!

Does the filter need to care? It's told to do any deferred work, and to
report back when it's done. The fact that git is calling it before it
decides to exit is not the filter's business (and you can imagine for
something like fast-import, it might want to feed files to something
like LFS, too; it already checkpoints occasionally to avoid lost work,
and would presumably want to ask LFS to checkpoint, too).

> I understand that Git might not want to wait for the filter...

If git _doesn't_ want to wait for the filter, I don't think you need a
checkpoint at all. The filter just does its deferred work when it sees
git hang up the connection (i.e., the "real" EOF from above).

-Peff
