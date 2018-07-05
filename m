Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550931F62D
	for <e@80x24.org>; Thu,  5 Jul 2018 19:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeGETiK (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 15:38:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:49696 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753752AbeGETiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 15:38:09 -0400
Received: (qmail 11896 invoked by uid 109); 5 Jul 2018 19:38:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Jul 2018 19:38:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17852 invoked by uid 111); 5 Jul 2018 19:38:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Jul 2018 15:38:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jul 2018 15:38:07 -0400
Date:   Thu, 5 Jul 2018 15:38:07 -0400
From:   Jeff King <peff@peff.net>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Taylor Blau <me@taylorr.com>
Subject: Re: [PATCH] builtin/config: work around an unsized array forward
 declaration
Message-ID: <20180705193807.GA4826@sigill.intra.peff.net>
References: <20180705183445.30901-1-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180705183445.30901-1-dev+git@drbeat.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 05, 2018 at 08:34:45PM +0200, Beat Bolli wrote:

> As reported here[0], Microsoft Visual Studio 2017.2 and "gcc -pedantic"
> don't understand the forward declaration of an unsized static array.
> They insist on an array size:
> 
>     d:\git\src\builtin\config.c(70,46): error C2133: 'builtin_config_options': unknown size
> 
> The thread [1] explains that this is due to the single-pass nature of
> old compilers.

Right, that makes sense.

> To work around this error, introduce the forward-declared function
> usage_builtin_config() instead that uses the array
> builtin_config_options only after it has been defined.
> 
> Also use this function in all other places where usage_with_options() is
> called with the same arguments.

Your patch is obviously correct, but I think here there might be an even
simpler solution: just bump option_parse_type() below the declaration,
since it's the only one that needs it. That hunk is bigger, but the
overall diff is simpler, and we don't need to carry that extra wrapper
function.

As a general rule for this case (because reordering isn't always an
option), I also wonder if we should prefer just introducing a pointer
alias:

  /* forward declaration is a pointer */
  static struct option *builtin_config_options;

  /* later, declare the actual storage and its alias */
  static struct option builtin_config_options_storage[] = {
	...
  };
  static struct option *builtin_config_options = builtin_config_options_storage;

There are occasionally cases where the caller really wants an array and
not a pointer, but in practice those are pretty rare.

I have a slight preference for the reordering solution in this case, but
any of them would be OK with me.

-Peff
