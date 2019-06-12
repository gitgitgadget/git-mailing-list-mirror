Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6781F462
	for <e@80x24.org>; Wed, 12 Jun 2019 19:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfFLTIu (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 15:08:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:53192 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726840AbfFLTIu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 15:08:50 -0400
Received: (qmail 25397 invoked by uid 109); 12 Jun 2019 19:08:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jun 2019 19:08:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13277 invoked by uid 111); 12 Jun 2019 19:09:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 12 Jun 2019 15:09:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jun 2019 15:08:46 -0400
Date:   Wed, 12 Jun 2019 15:08:46 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Christian Hesse <mail@eworm.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: cgit and global configuration
Message-ID: <20190612190845.GA14949@sigill.intra.peff.net>
References: <20190611170401.15d43623@leda>
 <1cdb3444-fb39-66a4-fb27-01e1617e538a@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cdb3444-fb39-66a4-fb27-01e1617e538a@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 11, 2019 at 04:22:32PM -0400, Jeff Hostetler wrote:

> As for going forward, I see 3 options:
> 
> [1] update your tests to allow this.  (I didn't dig thru your
>     tests to see how extensive this might be.)
> 
> [2] define your own version of common-main.c and link with it
>     instead of git/common-main.c and delete the calls to trace2_*()
>     in it.
> 
> [3] define your own version of common-main.c and then call your
>     prepare_repo_env() prior to trace2_initialize().
> 
> Granted, I've only spent 15 minutes looking at your code, so
> I may be mistaken about several things, but I think those are
> your options.

After reading the original report, my instinct was that (2) or (3) is
probably the right way forward. We could make it a little easier for
them by splitting up common-main a bit into two parts:

  - put the actual setup bits into a callable run_cmd_main() that ends
    up in libgit.a

  - make common-main.c a tiny shim that does:

      int main(int argc, const char **argv)
      {
		return run_cmd_main(argc, argv);
      }

And that makes it easy for them to replace just that shim with some
setup steps, ending in calling run_cmd_main().

All that said, it sounds like cgit doesn't actually need to do any setup
that _must_ be in-process; it's just modifying state like environment
variables that is passed down to children.

So I think it would also be sufficient to simply wrap it with something
like:

  #!/bin/sh
  unset HOME
  unset XDG_CONFIG_HOME
  exec /path/to/cgit "$@"

But maybe there are reasons not to want the complexity of a wrapper.

-Peff
