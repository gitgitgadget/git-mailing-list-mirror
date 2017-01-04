Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2181FEB3
	for <e@80x24.org>; Wed,  4 Jan 2017 00:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbdADAs4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 19:48:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:34865 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932644AbdADAsy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 19:48:54 -0500
Received: (qmail 10765 invoked by uid 109); 4 Jan 2017 00:48:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 00:48:28 +0000
Received: (qmail 28163 invoked by uid 111); 4 Jan 2017 00:49:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Jan 2017 19:49:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2017 19:48:25 -0500
Date:   Tue, 3 Jan 2017 19:48:25 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jacob.keller@gmail.com,
        gitster@pobox.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v4 0/5] road to reentrant real_path
Message-ID: <20170104004825.3s27dsircdp5lqte@sigill.intra.peff.net>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
 <20170103190923.11882-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170103190923.11882-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 03, 2017 at 11:09:18AM -0800, Brandon Williams wrote:

> Only change with v4 is in [1/5] renaming the #define MAXSYMLINKS back to
> MAXDEPTH due to a naming conflict brought up by Lars Schneider.

Hmm. Isn't MAXSYMLINKS basically what you want here, though? It what's
what all other similar functions will be using.

The only problem was that we were redefining the macro. So maybe:

  #ifndef MAXSYMLINKS
  #define MAXSYMLINKS 5
  #endif

would be a good solution?

It looks like the "usual" value is more like 20 or 30 on most systems,
though.  We should probably also set errno to ELOOP when we hit the
limit, which is what other symlink-resolving functions would do.

I'm surprised we didn't hit this on Linux, which has MAXSYMLINKS, too.
We should be picking it up from <sys/param.h>.

-Peff
