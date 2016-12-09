Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E83F2093C
	for <e@80x24.org>; Fri,  9 Dec 2016 05:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbcLIFhz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 00:37:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:54017 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752097AbcLIFhy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 00:37:54 -0500
Received: (qmail 31764 invoked by uid 109); 9 Dec 2016 05:37:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 05:37:54 +0000
Received: (qmail 15705 invoked by uid 111); 9 Dec 2016 05:38:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 00:38:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Dec 2016 00:37:51 -0500
Date:   Fri, 9 Dec 2016 00:37:51 -0500
From:   Jeff King <peff@peff.net>
To:     unixway.drive@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [BUG] regarding `git add -p` and files containing wildcard
 characters
Message-ID: <20161209053751.dpq3brm6pih3rc3n@sigill.intra.peff.net>
References: <c9876671-6252-5dfa-18df-a6719dc6834c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9876671-6252-5dfa-18df-a6719dc6834c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2016 at 04:46:49AM +0300, unixway.drive@gmail.com wrote:

> The problem is that `git-diff-files` does some globbing on the 'path'
> arguments on its own and has no option to disable that (and
> `git-add--interactive`'s `run_cmd_pipe` already handles all other sorts of
> unsafe characters like spaces and backticks well).

I think the option you're looking for is:

  git --literal-pathspecs diff-files ... -- 'Random *'

I don't know if there are other commands run by add--interactive that
would want the same treatment. It might actually make sense to set
GIT_LITERAL_PATHSPECS=1 in the environment right after it expands the
list via ls-files.

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index ee3d812..358d877 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -2,3 +2,3 @@
> 
> -use 5.008;
> +use 5.014;
>  use strict;
> @@ -761,3 +761,5 @@ sub parse_diff {
>         }
> -       my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
> +       my @diff = run_cmd_pipe("git", @diff_cmd, "--", (
> +               $path =~ s#[\[*?]#\\$&#gr
> +       ));

This callsite covers "-p". It looks like list_modified() probably needs
similar treatment. Maybe others; I didn't look exhaustively.

-Peff
