Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34831F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 17:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbcHXRBL (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 13:01:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:60549 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751742AbcHXRBL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 13:01:11 -0400
Received: (qmail 10515 invoked by uid 109); 24 Aug 2016 17:00:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 17:00:31 +0000
Received: (qmail 4560 invoked by uid 111); 24 Aug 2016 17:00:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 13:00:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 13:00:28 -0400
Date:   Wed, 24 Aug 2016 13:00:28 -0400
From:   Jeff King <peff@peff.net>
To:     David McGough <dmcgough@opentext.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Smart HTTP push permissions failure
Message-ID: <20160824170028.y4kr5jchsnb5xdge@sigill.intra.peff.net>
References: <89CBBBEBEE33F5469A9FA456B5F70625CCDB9BEB@otwlxg20.opentext.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89CBBBEBEE33F5469A9FA456B5F70625CCDB9BEB@otwlxg20.opentext.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 03:45:33PM +0000, David McGough wrote:

> When I try to push to the server I get this message:
> remote: error: insufficient permission for adding an object to repository database ./objects
> remote: fatal: failed to write object
> [...]
> So I am pretty confused about what the issue.  Which OS user is git
> using to write the files?  I hope somebody can help me understand why
> the project cannot be pushed to the git server.

For a smart-http push, it will be whatever user the web server execs the
CGI as. So I'd think "apache" would be the default, but it's possible
that it runs CGIs as a different user, depending on your config.

One possibility may be to add a simple shell script CGI that does
something like:

  #!/bin/sh
  echo "Content-type: text/plain"
  echo
  id

just to see what's happening.

Based on the data you showed, here are some wild possibilities I can
think of:

  - the CGI runs as "apache", but your files are owned by "git".
    "apache" is in the "staff" group, and the directories all have write
    permission for that group. But are we sure that apache does not shed
    any group permissions when running a CGI? The "id" script above
    should hopefully show that.

  - You mentioned CentOS. It has been a while since I dealt with RHEL
    and its derivatives, but I think selinux is turned on by default
    there. Is it possible that the webserver runs in an selinux profile
    that does not allow writing to the repository directory?

    I don't recall the specifics of debugging selinux problems, but
    there may be logs there.

Sorry those are just stabs in the dark, but I don't see anything else
obviously wrong with what you've posted.

-Peff
