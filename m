Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E732D20357
	for <e@80x24.org>; Tue, 11 Jul 2017 10:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755309AbdGKKYy (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 06:24:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:36790 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752361AbdGKKYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 06:24:53 -0400
Received: (qmail 2432 invoked by uid 109); 11 Jul 2017 10:24:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 10:24:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14895 invoked by uid 111); 11 Jul 2017 10:25:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 06:25:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 06:24:51 -0400
Date:   Tue, 11 Jul 2017 06:24:51 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 2/7] git.c: let builtins opt for handling `pager.foo`
 themselves
Message-ID: <20170711102451.27r3yaa2mgjgk4qv@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <62a5a588d880d1a41d6cdd54cd92ee577a0451fa.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62a5a588d880d1a41d6cdd54cd92ee577a0451fa.1499723297.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 11:55:15PM +0200, Martin Ågren wrote:

> To allow individual builtins to make more informed decisions about when
> to respect `pager.foo`, introduce a flag IGNORE_PAGER_CONFIG. If the flag
> is set, do not check `pager.foo`. This applies to two code-paths -- one
> in run_builtin() and one in execv_dashed_external().

Can this ever trigger in execv_dashed_external()? We should only get
there if get_builtin() returned NULL in the first place. Otherwise, we'd
run and exited via handle_builtin().

So I think this hunk:

> @@ -543,11 +550,14 @@ static void execv_dashed_external(const char **argv)
>  {
>  	struct child_process cmd = CHILD_PROCESS_INIT;
>  	int status;
> +	struct cmd_struct *builtin;
>  
>  	if (get_super_prefix())
>  		die("%s doesn't support --super-prefix", argv[0]);
>  
> -	if (use_pager == -1)
> +	builtin = get_builtin(argv[0]);
> +	if (use_pager == -1 &&
> +	    !(builtin && builtin->option & IGNORE_PAGER_CONFIG))
>  		use_pager = check_pager_config(argv[0]);
>  	commit_pager_choice();

...can just go away. And that highlights the issue with externals; we
don't have any internal database that says "these ones handle their own
pager". We don't even have a list of all the possibilities, since users
can drop whatever they like into their $PATH.

So we'd have to make a (backwards-incompatible) decision that pager.*
doesn't work for external commands, and they must manually trigger the
pager themselves. I'm undecided on whether that's reasonable or not
(certainly it's what git-stash would want, but it may be hurting other
commands).

Anyway, I think that's out of scope for your series, which is just
trying to make the builtins work better.

-Peff
