Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37FB420951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdCQXY6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:24:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:46299 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdCQXY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:24:58 -0400
Received: (qmail 3253 invoked by uid 109); 17 Mar 2017 22:23:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 22:23:24 +0000
Received: (qmail 7348 invoked by uid 111); 17 Mar 2017 22:23:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 18:23:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 18:23:20 -0400
Date:   Fri, 17 Mar 2017 18:23:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: simplify run_update_post_hook()
Message-ID: <20170317222320.nsg3yk3nopjadr5t@sigill.intra.peff.net>
References: <ac1c0cfc-b1de-37be-23b3-98ef1081ec4a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac1c0cfc-b1de-37be-23b3-98ef1081ec4a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 11:02:13PM +0100, René Scharfe wrote:

> Instead of counting the arguments to see if there are any and then
> building the full command use a single loop and add the hook command
> just before the first argument.  This reduces duplication and overall
> code size.

Yeah, I agree one loop is nicer.

> -	argv_array_push(&proc.args, hook);
>  	for (cmd = commands; cmd; cmd = cmd->next) {
>  		if (cmd->error_string || cmd->did_not_exist)
>  			continue;
> +		if (!proc.args.argc)
> +			argv_array_push(&proc.args, hook);
>  		argv_array_push(&proc.args, cmd->ref_name);
>  	}
> +	if (!proc.args.argc)
> +		return;

It looks at first like the result leaks, because you have to realize
that the push will modify proc.args.argc. I wonder if:

  argv_array_push(&proc.args, hook);
  for (cmd = commands; cmd; cmd = cmd->next) {
	if (!cmd->error_string && !cmd->did_not_exist)
		argv_array_push(&proc.args, cmd->ref_name);
  }

  if (proc.args.argc == 1) {
	argv_array_clear(&proc.args);
	return;
  }

would be more obvious (at the cost of a pointless malloc in the corner
case. I can live with it either way.

-Peff
