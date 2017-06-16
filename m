Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D556120D0C
	for <e@80x24.org>; Fri, 16 Jun 2017 12:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbdFPMO0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 08:14:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:41453 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752601AbdFPMOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 08:14:25 -0400
Received: (qmail 15424 invoked by uid 109); 16 Jun 2017 12:14:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 12:14:25 +0000
Received: (qmail 4308 invoked by uid 111); 16 Jun 2017 12:14:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 08:14:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jun 2017 08:14:23 -0400
Date:   Fri, 16 Jun 2017 08:14:23 -0400
From:   Jeff King <peff@peff.net>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, houstonfortney@gmail.com,
        kostix+git@007spb.ru, sxlijin@gmail.com
Subject: Re: [PATCH 2/3] wt-status: add optional stash status information
Message-ID: <20170616121423.smdtmcmbktuit2qb@sigill.intra.peff.net>
References: <20170616043050.29192-1-liambeguin@gmail.com>
 <20170616043050.29192-3-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170616043050.29192-3-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 12:30:49AM -0400, Liam Beguin wrote:

> @@ -1642,6 +1664,8 @@ static void wt_longstatus_print(struct wt_status *s)
>  		} else
>  			printf(_("nothing to commit, working tree clean\n"));
>  	}
> +	if (!git_config_get_bool("status.showStash", &show_stash) && show_stash)
> +		wt_longstatus_print_stash_summary(s);
>  }

This feels like a funny place to look up the config. How would you
override it if were to have a "--no-stash" command line option?

The usual flow is for the caller to examine the config and set up fields
in the wt_status object, which are then respected here in the low-level
code.

So I think you probably want to handle this in git_status_config() along
with other similar variables (like "status.branch").

I don't personally insist on actually adding "--no-stash" or similar to
override it from the command line (there is always "git -c
status.showStash=false" in a pinch). But I have seen other reviewers
(including the maintainer) ask for that in the past, so you may want to
anticipate it.

-Peff
