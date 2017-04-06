Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFFE0209F1
	for <e@80x24.org>; Thu,  6 Apr 2017 08:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbdDFIdQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 04:33:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:57386 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbdDFIdM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 04:33:12 -0400
Received: (qmail 28380 invoked by uid 109); 6 Apr 2017 08:33:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Apr 2017 08:33:07 +0000
Received: (qmail 24119 invoked by uid 111); 6 Apr 2017 08:33:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Apr 2017 04:33:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Apr 2017 04:33:06 -0400
Date:   Thu, 6 Apr 2017 04:33:06 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix stack-use-after-scope error reported by ASAN by
 GCC 7.
Message-ID: <20170406083305.bs3hkxp7dagajg7m@sigill.intra.peff.net>
References: <072afb58-6159-ddeb-b7dc-40a87e8c6ae7@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <072afb58-6159-ddeb-b7dc-40a87e8c6ae7@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2017 at 10:02:45AM +0200, Martin Liška wrote:

> Subject: [PATCH 2/2] Fix stack-use-after-scope error reported by ASAN by GCC
>  7.
> 
> The use-after-scope is triggered here:
> READ of size 8 at 0x7ffc4f674e20 thread T0
>     #0 0x6f0b69 in finish_command /home/marxin/Programming/git/run-command.c:570
>     #1 0x5b6101 in kill_multi_file_filter /home/marxin/Programming/git/convert.c:570
>     #2 0x5b798a in kill_multi_file_filter /home/marxin/Programming/git/convert.c:770

Yeah, this is definitely a problem. Your fix works, but...

> @@ -600,7 +601,8 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
>  	process = &entry->process;
>  
>  	child_process_init(process);
> -	process->argv = argv;
> +	process->argv = xcalloc(2, sizeof(const char *));
> +	process->argv[0] = cmd;
>  	process->use_shell = 1;
>  	process->in = -1;
>  	process->out = -1;

We can just do:

  argv_array_push(&process->args, cmd);

here. And then it is freed automatically when finish_command() is
called (and also if start_command never starts the process, which I
think your patch misses).

-Peff
