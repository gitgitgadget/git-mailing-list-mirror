Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CFE81F406
	for <e@80x24.org>; Fri, 12 Jan 2018 13:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933717AbeALNd5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 08:33:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:42080 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933604AbeALNd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 08:33:57 -0500
Received: (qmail 4280 invoked by uid 109); 12 Jan 2018 13:33:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 13:33:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30725 invoked by uid 111); 12 Jan 2018 13:34:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 08:34:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 08:33:55 -0500
Date:   Fri, 12 Jan 2018 08:33:55 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 4/4] trace.c: be smart about what env to print in
 trace_run_command()
Message-ID: <20180112133355.GE27499@sigill.intra.peff.net>
References: <20180111094712.2551-1-pclouds@gmail.com>
 <20180112095607.18293-1-pclouds@gmail.com>
 <20180112095607.18293-5-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180112095607.18293-5-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 04:56:07PM +0700, Nguyễn Thái Ngọc Duy wrote:

> The previous concatenate_env() is kinda dumb. It receives a env delta
> in child_process and blindly follows it. If the run_command() user
> "adds" more vars of the same value, or deletes vars that do not exist
> in parent env in the first place (*), then why bother to print them?
> 
> This patch checks child_process.env against parent environment and
> only print the actual differences. The unset syntax (and later on cwd)
> follows closely shell syntax for easy reading/guessing and copy/paste.

I like it.

> There is an interesting thing with this change. In the previous patch,
> we unconditionally print new vars. With submodule code we may have
> something like this
> 
>     trace: ... GIT_DIR='.git' git 'status' '--porcelain=2'
> 
> but since parent's GIT_DIR usually has the same value '.git' too, this
> change suppress that, now we can't see that the above command runs in
> a separate repo. This is the run for printing cwd. Now we have
> 
>     trace: ... cd foo; git 'status' '--porcelain=2'

Makes sense (though s/run/reason/ in the last paragraph?).

> Another equally interesting thing is, some caller can do "unset GIT_DIR;
> set GIT_DIR=.git". Since parent env can have the same value '.git', we
> don't re-print GIT_DIR=.git. In that case must NOT print "unset GIT_DIR"
> or the user will be misled to think the new command has no GIT_DIR.

Interesting. I wonder if any callers actually do that. It seems like
kind of an odd thing, but maybe a caller sets GIT_DIR on top of the
clearing of local_repo_env.

> A note about performance. Yes we're burning a lot more cycles for
> displaying something this nice. But because it's protected by
> $GIT_TRACE, and run_command() should not happen often anyway, it should
> not feel any slower than before.

I'd agree that performance probably doesn't matter much here.

> +		/*
> +		 * Do we have a sequence of "unset GIT_DIR; GIT_DIR=foo"?
> +		 * Then don't bother with the unset thing.
> +		 */
> +		if (i + 1 < envs.nr &&
> +		    !strcmp(env, envs.items[i + 1].string))
>  			continue;

Are we guaranteed that "FOO" and "FOO=bar" appear next to each other in the
sorted list? I think "FOO123=bar" could come between.

I also think this is a special case of a more general problem. FOO could
appear any number of times in the "env" array, as a deletion or with
multiple values. Our prep_childenv() would treat that as "last one
wins", I think. Could we just do the same here?

-Peff
