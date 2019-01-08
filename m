Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989001F803
	for <e@80x24.org>; Tue,  8 Jan 2019 06:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfAHGe7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 01:34:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:57378 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727538AbfAHGe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 01:34:59 -0500
Received: (qmail 1106 invoked by uid 109); 8 Jan 2019 06:35:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Jan 2019 06:35:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8569 invoked by uid 111); 8 Jan 2019 06:34:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 Jan 2019 01:34:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jan 2019 01:34:56 -0500
Date:   Tue, 8 Jan 2019 01:34:56 -0500
From:   Jeff King <peff@peff.net>
To:     Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Suspicious fetch-pack behaviour
Message-ID: <20190108063456.GA17588@sigill.intra.peff.net>
References: <CA+BUw6jXTt6QGXvdFjRDNqJcij+1hNP5xybUUuGqo3bY0=ueuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+BUw6jXTt6QGXvdFjRDNqJcij+1hNP5xybUUuGqo3bY0=ueuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 03, 2019 at 10:52:48AM +0100, Guilhem Bonnefille wrote:

> One of my users reported a strange problem: a simple HTTPS clone did
> not work with Git 1.8.3.1 on RedHat 7.
> I did many tests and I was not able to understand why his clone don't
> work while I'm able to do it on other similar host.
> 
> Nevertheless, we did more investigations. One of them: a raw strace.
> I discovered two strange behaviours:
> - fetch-pack closes its standard input and standard output and then
> tries to print the references on standard input and finaly dies.
> - git-remote-https does not react to fetch-pack death and continue
> polling an empty set of FD.
>
> [...]
>
> 2769  poll(NULL, 0, 1000)               = 0 (Timeout)

We actually don't use poll() very much in Git. And poking around the
v1.8.3.1 source, I do not see any places where remote-https would call
poll(), and none outside of "git help" and "git credential-cache-daemon"
that would ever provide a timeout like "1000".

I wonder if this poll is actually being run by libcurl.  Is it possible
to get a backtrace of the looping process with gdb?

I'd also point out that v1.8.3.1 is over 5 years old, and there have
been quite a few http-related fixes over the years. There is a good
chance that if this is a Git bug, it has long since been fixed. Is it
possible to reproduce with a more modern version of Git?

-Peff
