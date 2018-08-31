Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48DD41F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeIAAQw (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:16:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:35682 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726987AbeIAAQw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:16:52 -0400
Received: (qmail 30749 invoked by uid 109); 31 Aug 2018 20:07:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Aug 2018 20:07:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8379 invoked by uid 111); 31 Aug 2018 20:07:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 31 Aug 2018 16:07:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Aug 2018 16:07:48 -0400
Date:   Fri, 31 Aug 2018 16:07:48 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] doc/Makefile: drop doc-diff worktree and temporary
 files on "make clean"
Message-ID: <20180831200748.GD5120@sigill.intra.peff.net>
References: <20180830195546.GA22407@sigill.intra.peff.net>
 <20180831063318.33373-1-sunshine@sunshineco.com>
 <20180831063318.33373-4-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180831063318.33373-4-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 02:33:18AM -0400, Eric Sunshine wrote:

> doc-diff creates a temporary working tree (git-worktree) and generates a
> bunch of temporary files which it does not remove since they act as a
> cache to speed up subsequent runs. Although doc-diff's working tree and
> generated files are not strictly build products of the Makefile (which,
> itself, never runs doc-diff), as a convenience, update "make clean" to
> clean up doc-diff's working tree and generated files along with other
> development detritus normally removed by "make clean".

Makes sense.

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index a42dcfc745..26e268ae8d 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -332,6 +332,7 @@ clean:
>  	$(RM) SubmittingPatches.txt
>  	$(RM) $(cmds_txt) $(mergetools_txt) *.made
>  	$(RM) manpage-base-url.xsl
> +	'$(SHELL_PATH_SQ)' ./doc-diff --clean

This spelling took me by surprise. The doc-diff script itself specifies
/bin/sh, and we do not build it, so the #! line is never replaced. I
guess we are leaving it to people on exotic shells to run "$their_sh
doc-diff" in the first place. That's probably OK, since it should work
out of the box on most /bin/sh instances, and people on other platforms
aren't that likely to even run it.

I don't think the script does anything complicated that would choke a
lesser /bin/sh. But it doesn't hurt to be defensive, since this bit of
the Makefile will be run for everyone, whether they care about doc-diff
or not.

So that all makes sense. I initially wrote this to suggest that we call
out this subtlety in the commit message. But I see this is based on
existing instances from ee7ec2f9de (documentation: Makefile accounts for
SHELL_PATH setting, 2009-03-22). So maybe I am just showing my
ignorance. ;)

-Peff
