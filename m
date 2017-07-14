Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22A9202DD
	for <e@80x24.org>; Fri, 14 Jul 2017 09:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdGNJDA (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 05:03:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:40488 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750799AbdGNJC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 05:02:59 -0400
Received: (qmail 8275 invoked by uid 109); 14 Jul 2017 09:02:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 09:02:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9067 invoked by uid 111); 14 Jul 2017 09:03:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 05:03:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 05:02:56 -0400
Date:   Fri, 14 Jul 2017 05:02:56 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Fix regression: CamelCased aliases
Message-ID: <20170714090256.ne4gqgppt2qshtak@sigill.intra.peff.net>
References: <cover.1500021526.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1500021526.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 10:39:24AM +0200, Johannes Schindelin wrote:

> It was possible before v2.13.3 to invoke:
> 
> 	git config alias.CamelCased <something>
> 	git CamelCased
> 
> This regressed (due to a stupid mistake of mine that was not caught in
> patch review, sadly) in v2.13.3.

Interesting. I don't think this was ever intended to work. Prior to
v2.2.0 it did not, and it was "fixed" inadvertently by 111791559
(alias.c: replace `git_config()` with `git_config_get_string()`,
2014-08-07).

It's a known limitation of the alias config scheme that it cannot
distinguish between "camelcase" and "CamelCase" (nor represent commands
with underscores or other characters that are invalid in a keyname). In
the long run we'd want to allow "alias.CamelCase.command" or similar to
make this work correctly.

It probably doesn't hurt anything to make this old ambiguous style work
in the meantime if people are using it and finding it convenient.

> Johannes Schindelin (2):
>   t1300: demonstrate that CamelCased aliases regressed
>   alias: compare alias name *case-insensitively*

The patches look obviously correct.

As a meta-comment, I find splitting the tests from the fix like this
makes review more tedious. The commit messages have to repeat the exact
same reasoning.

The only value I think it brings is that you can confirm in the
first commit that the expect_failure does indeed fail. I guess that has
some value, though I usually do it by running the test against the
version of git built from HEAD^.

-Peff
