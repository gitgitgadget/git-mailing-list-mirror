Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7705120229
	for <e@80x24.org>; Thu, 10 Nov 2016 21:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965343AbcKJVnt (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 16:43:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:41339 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965279AbcKJVnr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 16:43:47 -0500
Received: (qmail 12457 invoked by uid 109); 10 Nov 2016 21:43:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 21:43:47 +0000
Received: (qmail 8095 invoked by uid 111); 10 Nov 2016 21:44:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 16:44:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2016 16:43:45 -0500
Date:   Thu, 10 Nov 2016 16:43:45 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
Message-ID: <20161110214345.cau5i4eybqdv74k3@sigill.intra.peff.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-3-larsxschneider@gmail.com>
 <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com>
 <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net>
 <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com>
 <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net>
 <xmqq1syj6mvq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1syj6mvq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 01:33:29PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > IMHO, the value in the http tests is not testing the server side, but
> > the client side. Without being able to set up a dummy HTTP server, we do
> > not have any way to exercise the client side of git-over-http at all.
> > And people on macOS _do_ use that. :)
> 
> Amen to that.
> 
> I however do not know what the universally available simplest dummy
> HTTP server would be.  There probably are better alternative than
> Apache with distro-customized ways of configuration that we have to
> adjust.  
> 
> A solution around HTTP::Server::Simple sounds attractive but is it
> a realistic alternative or too much effort required?  I dunno.

I'm less concerned about the amount of effort (though I agree it may be
a blocker) than about the fact that it may not behave similarly to real
servers. We have had real bugs and surprises with the way that various
web servers implement things. A few that come to mind are:

  1. Buffering/deadlock issues between the webserver and the CGI (this
     was an issue with Apache, but I don't know about other servers).

  2. The handling of CONTENT_LENGTH with chunked-encoding (this is still
     an issue with IIS).

  3. What happens when you ask for "foo.git/info/refs" and "foo.git" is
     a bundle file (Apache gives you a 404, lighttpd serves the bundle).

Ideally we'd test against a lot of different webservers, but that's
expensive (in CPU, but also in developer time). But I'd guess that
Apache is at least more representative than HTTP::Server::Simple of real
servers in the wild.

So if we had a simple fallback in addition to Apache, I'd be OK with
that. But we still have a problem that (say) people on MacOS would never
actually test against Apache, because it's not supported there.

-Peff
