Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F1E201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 21:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbdBXVNd (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:13:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:33623 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbdBXVNc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:13:32 -0500
Received: (qmail 12704 invoked by uid 109); 24 Feb 2017 21:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 21:06:46 +0000
Received: (qmail 25618 invoked by uid 111); 24 Feb 2017 21:06:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 16:06:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 16:06:44 -0500
Date:   Fri, 24 Feb 2017 16:06:44 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] refs: parse_hide_refs_config to use parse_config_key
Message-ID: <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
References: <20170224203335.3762-1-sbeller@google.com>
 <20170224203940.hbmfsouw5k67l3h3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170224203940.hbmfsouw5k67l3h3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 03:39:40PM -0500, Jeff King wrote:

> This will start parsing "receive.foobar.hiderefs", which we don't want.
> I think you need:
> 
>   !parse_config_key(var, section, &subsection, &subsection_len, &key) &&
>   !subsection &&
>   !strcmp(key, "hiderefs")
> 
> Perhaps passing NULL for the subsection variable should cause
> parse_config_key to return failure when there is a non-empty subsection.
> 
> -Peff
> 
> PS Outside of parse_config_key, this code would be nicer if it used
>    skip_prefix() instead of starts_with(). Since it's going away, I
>    don't think it matters, but I note that parse_config_key could
>    probably benefit from the same.

While I'm thinking about it, here are patches to do that. The third one
I'd probably squash into yours (after ordering it to the end).

  [1/3]: parse_config_key: use skip_prefix instead of starts_with
  [2/3]: parse_config_key: allow matching single-level config
  [3/3]: parse_hide_refs_config: tell parse_config_key we don't want a subsection

 cache.h  |  5 ++++-
 config.c | 15 +++++++++------
 refs.c   |  7 +++----
 3 files changed, 16 insertions(+), 11 deletions(-)

