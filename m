Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92BC1FE4E
	for <e@80x24.org>; Fri,  1 Jul 2016 05:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbcGAFzh (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 01:55:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:38723 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751508AbcGAFzg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 01:55:36 -0400
Received: (qmail 23675 invoked by uid 102); 1 Jul 2016 05:55:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 01:55:37 -0400
Received: (qmail 13534 invoked by uid 107); 1 Jul 2016 05:55:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 01:55:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 01:55:32 -0400
Date:	Fri, 1 Jul 2016 01:55:32 -0400
From:	Jeff King <peff@peff.net>
To:	"dmh@ucar.edu" <dmh@ucar.edu>
Cc:	git@vger.kernel.org
Subject: [PATCH 0/5] consistent setup code for external commands
Message-ID: <20160701055532.GA4488@sigill.intra.peff.net>
References: <7210bce6-093b-9fdf-9a9b-94059ad0d4e3@ucar.edu>
 <20160701040715.GB4832@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160701040715.GB4832@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 01, 2016 at 12:07:15AM -0400, Jeff King wrote:

> Interesting. It's failing on the assert(argv0_path) in system_path().
> 
> That's part of the RUNTIME_PREFIX code which is built only on Windows,
> so this is a Windows-specific issue.
> 
> I can guess the reason that argv0_path is not set is that
> credential-store has its own main() function and does not call
> git_extract_argv0_path(). It never mattered before, but as of v2.8.0,
> one of the library functions it calls wants to use system_path(), which
> assumes that the argv0 stuff has been set up.
> 
> I'm preparing some patches to fix this case (and some other related
> ones).

Here they are:

  [1/5]: add an extra level of indirection to main()
  [2/5]: common-main: call git_extract_argv0_path()
  [3/5]: common-main: call sanitize_stdfds()
  [4/5]: common-main: call restore_sigpipe_to_default()
  [5/5]: common-main: call git_setup_gettext()

The first patch is refactoring so we can fix this problem once, rather
than in the dozens of programs that need it.

The second should fix the problem you saw. It's unfortunate that the
tests didn't detect it; there's some discussion of that in the commit
message.

Patches 3-5 are other places where we can use the refactoring to be more
consistent and remove boilerplate code.

I almost did a patch 6 moving trace_command_performance(), but I'm not
sure if people would care or not. Running "git foo" already covers that,
even for an external command, because the git wrapper waits until the
sub-process finishes. Setting it up in each sub-program would mean:

  - you get it for dashed externals you run directly, too

  - for external programs run as "git foo", you get _two_ times. One for
    the time the actual sub-program ran, and one with the overhead of
    the git wrapper process.

    I'm not sure if people actually care about that distinction, or
    whether the extra number would simply be annoying.

So I punted. It's easy to move it over later if anybody cares.

-Peff
