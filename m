Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194D91F406
	for <e@80x24.org>; Fri, 12 Jan 2018 13:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbeALNNE (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 08:13:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:42064 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753875AbeALNNE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 08:13:04 -0500
Received: (qmail 3388 invoked by uid 109); 12 Jan 2018 13:13:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 13:13:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30641 invoked by uid 111); 12 Jan 2018 13:13:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 08:13:37 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 08:13:02 -0500
Date:   Fri, 12 Jan 2018 08:13:02 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 3/4] trace.c: print env vars in trace_run_command()
Message-ID: <20180112131301.GD27499@sigill.intra.peff.net>
References: <20180111094712.2551-1-pclouds@gmail.com>
 <20180112095607.18293-1-pclouds@gmail.com>
 <20180112095607.18293-4-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180112095607.18293-4-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 04:56:06PM +0700, Nguyễn Thái Ngọc Duy wrote:

> Occasionally submodule code could execute new commands with GIT_DIR set
> to some submodule. GIT_TRACE prints just the command line which makes it
> hard to tell that it's not really executed on this repository.
> 
> Print modified env variables (compared to parent environment) in this
> case. Actually only modified or new variables (*) are printed. Variable
> deletion is suppressed because they are often used to clean up
> repo-specific variables that git passes around between processes. When
> submodule code executes commands on another repo, it clears all these
> variables, _many_ of these, that make the output really noisy.
> 
> (*) sort of. More on this in the next patch.

OK. I think we could probably just squash patches 3 and 4, but I'm OK
with them separate, too.

The code looks fine, though I have one nit:

> @@ -281,8 +299,17 @@ void trace_run_command(const struct child_process *cp)
>  				&trace_default_key, &buf))
>  		return;
>  
> +	strbuf_grow(&buf, 255);
> +

IMHO these magic-numbers grows detract from the readability (because you
wonder if they're meaningful), and I doubt if they provide any real
performance gain in practice.

-Peff
