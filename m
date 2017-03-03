Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DC6E2023D
	for <e@80x24.org>; Fri,  3 Mar 2017 10:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbdCCKl7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 05:41:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:37880 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751512AbdCCKlp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 05:41:45 -0500
Received: (qmail 29058 invoked by uid 109); 3 Mar 2017 10:33:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 10:33:21 +0000
Received: (qmail 26675 invoked by uid 111); 3 Mar 2017 10:33:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 05:33:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 05:33:19 -0500
Date:   Fri, 3 Mar 2017 05:33:19 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] config: check if config path is a file before
 parsing it
Message-ID: <20170303103319.uei446qkt6jadsn5@sigill.intra.peff.net>
References: <20170303094252.11706-1-pclouds@gmail.com>
 <20170303094252.11706-2-pclouds@gmail.com>
 <20170303095351.rgifjpfuvafx33jy@sigill.intra.peff.net>
 <CACsJy8DU7-o06mfuw1L02CFFR2wmoNa0MQJ8KqsV79ULzjRaRQ@mail.gmail.com>
 <20170303101503.lf2ub2c7i6w7kg3t@sigill.intra.peff.net>
 <CACsJy8CDOBUe7S3sYz=_tAJy2ajM5h2v+ZypD6Cr1uJo7XAnGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CDOBUe7S3sYz=_tAJy2ajM5h2v+ZypD6Cr1uJo7XAnGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 05:29:47PM +0700, Duy Nguyen wrote:

> On Fri, Mar 3, 2017 at 5:15 PM, Jeff King <peff@peff.net> wrote:
> > But I do think option (a) is cleaner. The only trick is that for errno
> > to be valid, we need to make sure we check ferror() soon after seeing
> > the EOF return value. I suspect it would work OK in practice for the
> > git_config_from_file() case.
> 
> stdio error handling is a pain. Maybe we're better of with open() and
> mmap() (or even read_in_full)? I/O error handling would be at the
> beginning, not buried deep in the parser. Hmm.. since we already have
> "fgetc' version for config blobs, this could kill some code...

Yeah, I don't mind a read_in_full() version. Config isn't _supposed_ to
be big (and if it is you're in trouble anyway, because I'm pretty sure
we still parse it several times per command invocation).

I don't think that removes the issues I've mentioned with
git_config_from_file() being too quiet. But it solves the ferror()
question (though I think we pretty much return immediately from the
parser on EOF, so it's _probably_ OK to use it like in the diff I just
sent).

-Peff
