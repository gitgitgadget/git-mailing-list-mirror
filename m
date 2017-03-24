Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32B791FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 14:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936342AbdCXO7u (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 10:59:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:50989 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936195AbdCXO7s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 10:59:48 -0400
Received: (qmail 5657 invoked by uid 109); 24 Mar 2017 14:59:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 14:59:42 +0000
Received: (qmail 18390 invoked by uid 111); 24 Mar 2017 14:59:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 10:59:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 10:59:40 -0400
Date:   Fri, 24 Mar 2017 10:59:40 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com,
        sxlijin@gmail.com
Subject: Re: [PATCH v2] travis-ci: build and test Git on Windows
Message-ID: <20170324145940.xqjmwxphwmtx67ug@sigill.intra.peff.net>
References: <20170324113747.44991-1-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170324113747.44991-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 12:37:47PM +0100, Lars Schneider wrote:

> I think I addressed all issues from the v1 review (see interdiff below)
> with one exception. The script still uses bash instead of sh. Something
> about this does not work in sh:
>     --output >(sed "$(printf '1s/^\xef\xbb\xbf//')" >cat >&3)
> 
> Does anyone know how to make this sh compatible?

Process substitution is a bash-ism. Just looking at this snippet I would
ask why you aren't just using stdout, but from the whole diff it looks
like you're using --write-out and want to keep the streams separate.

The POSIX shell way would be to make your own named pipe rather than
anonymous one:

  mkfifo data
  sed ... <data &
  curl ... --output data
  rm data

But I don't think relying on bash is that big a deal, as long as the
script is clearly marked with the correct #!-line (which it is).

The ">cat" isn't doing AFAICT, though.

-Peff
