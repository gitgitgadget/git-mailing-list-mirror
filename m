Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1141F453
	for <e@80x24.org>; Fri,  2 Nov 2018 16:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeKCB65 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 21:58:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:38302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726318AbeKCB65 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 21:58:57 -0400
Received: (qmail 20110 invoked by uid 109); 2 Nov 2018 16:51:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 16:51:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5656 invoked by uid 111); 2 Nov 2018 16:50:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 12:50:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 12:51:10 -0400
Date:   Fri, 2 Nov 2018 12:51:10 -0400
From:   Jeff King <peff@peff.net>
To:     Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFE] Please add name and email to git credentials
Message-ID: <20181102165110.GA11212@sigill.intra.peff.net>
References: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
 <87zhutjb3t.fsf@evledraar.gmail.com>
 <6f3d8c49e1d44ab20d4169e5254364cba707f1af.camel@laposte.net>
 <CAP8UFD1rTJNOZzFMryY9BNKHUZKE8FUEgw+4jFfnZ7G8KGNrkw@mail.gmail.com>
 <62bf61555a6c2789e959e4f085bfedf28b60f268.camel@laposte.net>
 <CAP8UFD0DHGShwo=DnwbSHz3nvRMF9P4GegEzC27uwHLXQ=A4Zw@mail.gmail.com>
 <1e3901b9a75a043d9c31d66d98410f3288a7c5be.camel@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e3901b9a75a043d9c31d66d98410f3288a7c5be.camel@laposte.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 02, 2018 at 09:57:30AM +0100, Nicolas Mailhot wrote:

> Or are you arguing that having two separate mecanisms in git, to match
> config directives to repo urls, is some kind of improvement?

There are already are multiple mechanisms (e.g., http.* config). So that
ship has sailed. ;)

> I didn't create or write or specify the way git credential matches repo
> urls. It already exists within git. If you have a problem with the
> matching logic git credential uses, why are you arguing with me instead
> of taking it up with the maintainers of this logic?

I did create the way git credential matches repo urls. And I do not
think your proposal is a good idea. The credential system is about
interacting with a remote URL, and creating a commit object is a local
operation. That mismatch leaks through when you work with multiple
remotes, since it is not clear which URL we would match against when the
operation does not involve a remote at all.

If you want to have per-repo name/email for creating commits, right now
your option is to have conditional config based on the local filesystem
path.

Elsewhere in this thread[1] Ævar suggested having conditional config
directives based on the presence of a remote. I'm a little hesitant
there because it requires the config parsing to depend on the value of
another key (introducing subtle timing dependencies). But aside from
bizarre corner cases (e.g., including config for remote.* via a
conditional include on the remote.* config), I think it would do what
you want and would be generally useful.

That seems like a more fruitful direction to me.

-Peff

[1] https://public-inbox.org/git/87wopxj5wr.fsf@evledraar.gmail.com/
