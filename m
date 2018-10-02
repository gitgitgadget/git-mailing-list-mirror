Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C97B1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 23:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeJCG0s (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 02:26:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:39288 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725198AbeJCG0r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 02:26:47 -0400
Received: (qmail 22372 invoked by uid 109); 2 Oct 2018 23:40:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Oct 2018 23:40:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8155 invoked by uid 111); 2 Oct 2018 23:40:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 19:40:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 19:40:56 -0400
Date:   Tue, 2 Oct 2018 19:40:56 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: Re: [PATCH v4 3/4] transport.c: introduce core.alternateRefsCommand
Message-ID: <20181002234056.GA18516@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538446826.git.me@ttaylorr.com>
 <aadb27c0106d8f1a49dd35e7a040131aecaef2c1.1538446827.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aadb27c0106d8f1a49dd35e7a040131aecaef2c1.1538446827.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 01, 2018 at 07:23:58PM -0700, Taylor Blau wrote:

> +core.alternateRefsCommand::
> +	When advertising tips of available history from an alternate, use the shell to
> +	execute the specified command instead of linkgit:git-for-each-ref[1]. The
> +	first argument is the absolute path of the alternate. Output must contain one
> +	hex object id per line (i.e., the same as produce by `git for-each-ref
> +	--format='%(objectname)'`).
> ++
> +This is useful when a repository only wishes to advertise some of its
> +alternate's references as `.have`'s. For example, to only advertise branch
> +heads, configure `core.alternateRefsCommand` to the path of a script which runs
> +`git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.
> ++
> +Note that the configured value is executed in a shell, and thus
> +linkgit:git-for-each-ref[1] by itself does not work, as scripts have to handle
> +the path argument specially.

This last paragraph is trying to fix the wrong-impression that we
discussed in the last round. But I'm not sure it doesn't make things
more confusing. ;)

Specifically, the problem isn't the shell. The issue is that we pass the
repo path as an argument to the command. So either:

  - it's a real command that we run, in which case git-for-each-ref does
    not take a repo path argument and so doesn't work; or

  - it's a shell snippet, in which case the argument is appended to the
    snippet (and here's where you can get into a rabbit hole of
    explaining how our shell invocation works, and we should avoid that)

Can we just say:

  Note that you cannot generally put `git for-each-ref` directly into
  the config value, as it does not take a repository path as an argument
  (but you can wrap the command above in a shell script).

> [...]

The rest of the patch looks good to me, along with the other three
(modulo the "expect" fixup you already sent).

-Peff
