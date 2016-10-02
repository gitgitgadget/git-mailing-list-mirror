Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1161F4F8
	for <e@80x24.org>; Sun,  2 Oct 2016 13:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbcJBNDu (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Oct 2016 09:03:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:51041 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbcJBNDt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2016 09:03:49 -0400
Received: (qmail 24440 invoked by uid 109); 2 Oct 2016 13:03:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Oct 2016 13:03:48 +0000
Received: (qmail 22767 invoked by uid 111); 2 Oct 2016 13:04:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Oct 2016 09:04:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Oct 2016 09:03:46 -0400
Date:   Sun, 2 Oct 2016 09:03:46 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 2/6] sha1_file: always allow relative paths to alternates
Message-ID: <20161002130346.4ay2d52su3bggh6o@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <20160930193604.hqspizasfpqa6bez@sigill.intra.peff.net>
 <c27dc1a4-3c7a-2866-d9d8-f5d3eb161650@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c27dc1a4-3c7a-2866-d9d8-f5d3eb161650@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 02, 2016 at 11:07:39AM +0200, René Scharfe wrote:

> Am 30.09.2016 um 21:36 schrieb Jeff King:
> > We adjust the test script here to demonstrate that this now
> > works. Unfortunately, we can't demonstrate that the
> > duplicate is suppressed, since it has no user-visible
> > behavior (it's just one less place for our object lookups to
> > go). But you can verify it manually via gdb, with something
> > like:
> > 
> >     for i in a b c; do
> >             git init --bare $i
> >             blob=$(echo $i | git -C $i hash-object -w --stdin)
> >     done
> >     echo "../../b/objects" >a/objects/info/alternates
> >     echo "../../c/objects" >>a/objects/info/alternates
> >     echo "../../c/objects" >b/objects/info/alternates
> >     gdb --args git cat-file -e $blob
> > 
> > After prepare_alt_odb() runs, we have only a single copy of
> > "/path/to/c/objects/" in the alt_odb list.
> 
> A better way would be to provide a UI for that.  We could easily bolt
> it to the side of count-objects like in the patch below.  Feels a bit
> hackish, though.

Yeah, I thought about something like that, but I'm a bit hesitant to add
public interfaces that exist just for testing. OTOH, "count-objects
--list-alternates" is conceivably a useful debugging tool for "did I set
up my alternates correctly?".

-Peff
