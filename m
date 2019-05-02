Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B1CC1F45F
	for <e@80x24.org>; Thu,  2 May 2019 09:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfEBJm4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 05:42:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41436 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfEBJm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 05:42:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B50EC1F453;
        Thu,  2 May 2019 09:42:55 +0000 (UTC)
Date:   Thu, 2 May 2019 09:42:55 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <stefanbeller@gmail.com>, git@vger.kernel.org,
        meta@public-inbox.org
Subject: Re: "IMAP IDLE"-like long-polling "git fetch"
Message-ID: <20190502094255.kbpzffokvdch63qg@dcvr>
References: <20181229034342.11543-1-e@80x24.org>
 <20181229035621.cwjpknctq3rjnlhs@dcvr>
 <20181229043858.GA28509@pure.paranoia.local>
 <CAGZ79kb9Tbnxe1mSnxpqT_FO6Gdi6wxd-r2YarHXRF1sVRyxLA@mail.gmail.com>
 <20190502085055.34kkll2deowat6il@dcvr>
 <87ftpxqkji.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftpxqkji.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Thu, May 02 2019, Eric Wong wrote:
> 
> > Stefan Beller <sbeller@google.com> wrote:
> >> IIRC, More than half the bandwidth of Googles git servers are used
> >> for ls-remote calls (i.e. polling a lot of repos, most of them did *not*
> >> change, by build bots which are really eager to try again after a minute).
> >
> > Thinking back at that statement; I think polling can be
> > optimized in git, at least.
> >
> > IIRC, your repos have lots of refs; right?
> > (which is why it's a bandwidth problem)
> >
> > Since info/refs is a static file (hopefully updated by a
> > post-update hook), the smart client can make an HTTP request
> > to check If-Modified-Since: to avoid the big response.
> >
> > The client would need to cache the mtime of the last requested
> > refs file; somewhere.
> >
> > IOW, do refs negotiation the "dumb" way; since it's no better
> > than the smart way, really.  Keep doing object transfers the
> > smart way.
> >
> > During the initial clone, smart servers could probably
> > have a header informing clients that their info/refs
> > is up-to-date and clients can do dumb refs negotiation.
> 
> Doing this with If-Modified-Since sounds like an easier drop-in
> replacement (just needs a client change), but I wonder if ETag isn't a
> better fit for this.

ETags overall could work.

> I.e. we'd document some convention where the ETag is a hash of the refs
> the client expects to be advertised in some format, it then sends that
> to the server.

But I was hoping to avoid the overhead of spawning git-http-backend
entirely.  And there's no consistent way to configure ETags on
different static servers.

> That allows the same thing without anyone keeping more state than they
> keep now in their local ref store

I think caching the remote info/refs is useful anyways in case
the user changes their fetch refspec, and it could speed up
invocations of "git ls-remote".

> On the fancier side I think bloom filters are something that's been
> discussed (and I believe someone (Twitter?) had such an internal patch),
> i.e. the client sends a bloom filter of refs they have, and the server
> advertises things they don't know about yet (and due to how bloom
> filters work, some things they *do* know about already but tripped up
> the bloom filter...).

I'm not smart enough to understand such fancy things :)
