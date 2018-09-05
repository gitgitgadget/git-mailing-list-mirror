Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0584C1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 17:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeIEWGH (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 18:06:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:40194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727714AbeIEWGH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 18:06:07 -0400
Received: (qmail 19543 invoked by uid 109); 5 Sep 2018 17:34:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Sep 2018 17:34:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21172 invoked by uid 111); 5 Sep 2018 17:35:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Sep 2018 13:35:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Sep 2018 13:34:55 -0400
Date:   Wed, 5 Sep 2018 13:34:55 -0400
From:   Jeff King <peff@peff.net>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH v2] Allow aliases that include other aliases
Message-ID: <20180905173455.GA2336@sigill.intra.peff.net>
References: <20180905085427.4099-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180905085427.4099-1-timschumi@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 05, 2018 at 10:54:27AM +0200, Tim Schumacher wrote:

> Aliases can only contain non-alias git commands and their
> arguments, not other user-defined aliases. Resolving further
> (nested) aliases is prevented by breaking the loop after the
> first alias was processed. Git then fails with a command-not-found
> error.
> 
> Allow resolving nested aliases by not breaking the loop in
> run_argv() after the first alias was processed. Instead, continue
> incrementing `done_alias` until `handle_alias()` fails, which means that
> there are no further aliases that can be processed. Prevent looping
> aliases by storing substituted commands in `cmd_list` and checking if
> a command has been substituted previously.
> ---
> 
> This is what I've come up with to prevent looping aliases. I'm not too
> happy with the number of indentations needed, but this seemed to be the
> easiest way to search an array for a value.

I think this approach is OK, though I wonder if we'd also be fine with
just:

  if (done_alias++ > 100)
	die("woah, is your alias looping?");

The point is just to prevent a runaway infinite loop, and this does that
while keeping the cost very low for the common case (not that one string
insertion is probably breaking the bank).

It could also extend to ! aliases if we wanted (i.e., my '!git foo'
example from earlier), but you'd have to carry the counter through the
environment between processes.

-Peff
