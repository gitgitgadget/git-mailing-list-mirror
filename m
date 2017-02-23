Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5229E2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 20:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdBWU6c (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 15:58:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:32860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751259AbdBWU6I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 15:58:08 -0500
Received: (qmail 17366 invoked by uid 109); 23 Feb 2017 20:57:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 20:57:42 +0000
Received: (qmail 32331 invoked by uid 111); 23 Feb 2017 20:57:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 15:57:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 15:57:39 -0500
Date:   Thu, 23 Feb 2017 15:57:39 -0500
From:   Jeff King <peff@peff.net>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     David Lang <david@lang.hm>, Junio C Hamano <gitster@pobox.com>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223205739.t4kekrp2kb7zkimv@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <nycvar.QRO.7.75.62.1702230907340.6590@qynat-yncgbc>
 <e57958d4-7c51-3f5e-6ff5-f863920fd883@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e57958d4-7c51-3f5e-6ff5-f863920fd883@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 09:49:09PM +0100, Jakub Narębski wrote:

> > How is GIT affected? GIT strongly relies on SHA-1 for the
> > identification and integrity checking of all file objects and
> > commits. It is essentially possible to create two GIT repositories
> > with the same head commit hash and different contents, say a benign
> > source code and a backdoored one. An attacker could potentially
> > selectively serve either repository to targeted users. This will
> > require attackers to compute their own collision.
> 
> The attack on SHA-1 presented there is "identical-prefix" collision,
> which is less powerful than "chosen-prefix" collision.  It is the
> latter that is required to defeat SHA-1 used in object identity.
> Objects in Git _must_ begin with given prefix;

I don't think this helps. The chosen-prefix lets you append hash data to
an existing file. Here we just have identical prefixes in the two
colliding halves. In the real-world example, they used a PDF header. But
it could have been a PDF header with "blob 1234" prepended to it (note
also that Git's use of the size doesn't help; the attack files are the
same length).

> the use of zlib
> compression adds to the difficulty.  'Forged' Git object would
> simply not validate...

No, zlib doesn't help. The sha1 is computed on the uncompressed data.

-Peff
