Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C279C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6008061241
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhFQHVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:21:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:58328 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhFQHV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 03:21:27 -0400
Received: (qmail 16837 invoked by uid 109); 17 Jun 2021 07:19:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Jun 2021 07:19:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1732 invoked by uid 111); 17 Jun 2021 07:19:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Jun 2021 03:19:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Jun 2021 03:19:19 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Simulating network throttling
Message-ID: <YMr3dwW/hnNhptFN@coredump.intra.peff.net>
References: <65b4040c-2a9c-7d49-43ce-dad7d5a9c62d@gmail.com>
 <CAGyf7-HyUHJacvpwx6R+_hCVsK_t3F1mQ++2_4-NeJWB9uUjdA@mail.gmail.com>
 <YMqB1mT9yeRCuA/N@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMqB1mT9yeRCuA/N@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 10:57:26PM +0000, brian m. carlson wrote:

> On Linux, you can also use the tc command to do traffic shaping and
> policing to allow only a certain amount of bandwidth, and you can use it
> in conjunction with iptables or nftables to do it only on certain ports
> or IPs.  It's very powerful and doesn't suffer from the limitations of
> proxies, but it also is rather complicated to set up, so you may want to
> try a proxy first to see if it meets your needs with less work.
> 
> OpenBSD's (and FreeBSD's, Darwin's, etc.) pf supports the same
> functionality but with a much nicer and easier to use interface (and I
> say this as a Linux user).

Yeah, these are both good suggestions that work transparently with any
protocol. I second the notion that tc is complicated to set up. ;)

If you really just want a pipe that will do rate-limiting in one
direction, many tools (e.g., "pv", which is available in debian) will do
it. That's hard to use with http, but you can stick it into an ssh
pipeline:

  $ git clone git@github.com:torvalds/linux.git
  Cloning into 'linux'...
  remote: Enumerating objects: 8129587, done.
  Receiving objects:   2% (163965/8129587), 70.89 MiB | 20.22 MiB/s
  ^C

  $ GIT_SSH_COMMAND='f() { ssh "$@" | pv -qL 512k; }; f' \
    git clone git@github.com:torvalds/linux.git
  Cloning into 'linux'...
  remote: Enumerating objects: 8129587, done.
  Receiving objects:   0% (15263/8129587), 7.57 MiB | 512.00 KiB/s
  ^C

-Peff
