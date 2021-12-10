Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA91C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 04:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbhLJELx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 23:11:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:48442 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236451AbhLJELw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 23:11:52 -0500
Received: (qmail 16660 invoked by uid 109); 10 Dec 2021 04:08:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 04:08:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26387 invoked by uid 111); 10 Dec 2021 04:08:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Dec 2021 23:08:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Dec 2021 23:08:17 -0500
From:   Jeff King <peff@peff.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     git@vger.kernel.org
Subject: Re: Issue with git clone via http/https and alternates
Message-ID: <YbLSsbBOtcFb0hIy@coredump.intra.peff.net>
References: <YbJgEnvuKm+GGXkd@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbJgEnvuKm+GGXkd@linux-mips.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 08:59:14PM +0100, Ralf Baechle wrote:

> I'm hosting a number of largish repositories which being very similar
> are using git's alternates feature to save disk and memory.  Cloning via
> git:// or ssh for users with accounts on the server works as expected but
> cloning via http or https results fails as follows:
> 
> $ git clone http://git.linux-mips.org/pub/scm/linux-mti.git
> Cloning into 'linux-mti'...
> warning: alternate disabled by http.followRedirects: http://git.linux-mips.org/pub/scm/ralf/linux.git/
> error: Unable to find e4add961d4aaeb19f607f6d7bea8d59e1bd39ff0 under http://git.linux-mips.org/pub/scm/linux-mti.git
> Fetching objects: 11, done.
> Cannot obtain needed object e4add961d4aaeb19f607f6d7bea8d59e1bd39ff0
> while processing commit 9e2bf7cf7d9003c0f06736be5218ed79234f254c.
> error: fetch failed.
> 
> Adding -c http.followRedirects=true will make the clone succeed. Question,
> shouldn't the default of http.followRedirects=initial already suffice?

There are security implications to allowing more redirects. See
cb4d2d35c4 (http: treat http-alternates like redirects, 2016-12-06).
That commit message does mention that we could be more lenient for
same-server redirects here, but AFAIK this is the first time anybody
cared enough to even bring it up the list.

That said...

> Anyway, what I'm looking for is something I can do serverside so users
> cloning the repository are not bothered with this http.followRedirects
> business.  Is there anything I can do?

Turn on smart-http support for your server. The dumb-http protocol is
rather inefficient, and is what requires the client to even know about
your server-side alternates in the first place. And personally, I have a
lot less trust in it in general, compared to smart-http. There have been
tons of fixes and improvements in the smart-http code in the past 10
years, and I don't think anybody is really paying much attention to
dumb-http.

-Peff
