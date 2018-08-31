Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADC501F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeIAAKj (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:10:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:35666 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727203AbeIAAKj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:10:39 -0400
Received: (qmail 30478 invoked by uid 109); 31 Aug 2018 20:01:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Aug 2018 20:01:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8298 invoked by uid 111); 31 Aug 2018 20:01:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 31 Aug 2018 16:01:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Aug 2018 16:01:35 -0400
Date:   Fri, 31 Aug 2018 16:01:35 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] doc-diff: add --clean mode to remove temporary
 working gunk
Message-ID: <20180831200135.GC5120@sigill.intra.peff.net>
References: <20180830195546.GA22407@sigill.intra.peff.net>
 <20180831063318.33373-1-sunshine@sunshineco.com>
 <20180831063318.33373-3-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180831063318.33373-3-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 02:33:17AM -0400, Eric Sunshine wrote:

> As part of its operation, doc-diff creates a bunch of temporary
> working files and holds onto them in order to speed up subsequent
> invocations. These files are never deleted. Moreover, it creates a
> temporary working tree (via git-wortkree) which likewise never gets
> removed.
> 
> Without knowing the implementation details of the tool, a user may not
> know how to clean up manually afterward. Worse, the user may find it
> surprising and alarming to discover a working tree which s/he did not
> create explicitly.
> 
> To address these issues, add a --clean mode which removes the
> temporary working tree and deletes all generated files.

That sounds like a good plan. I like keeping the complexity here in the
script.

> diff --git a/Documentation/doc-diff b/Documentation/doc-diff
> index c2906eac5e..f397fd229b 100755
> --- a/Documentation/doc-diff
> +++ b/Documentation/doc-diff
> @@ -2,20 +2,25 @@
>  
>  OPTIONS_SPEC="\
>  doc-diff [options] <from> <to> [-- <diff-options>]
> +doc-diff (-c|--clean)
>  --
>  j=n	parallel argument to pass to make
>  f	force rebuild; do not rely on cached results
> +c,clean	cleanup temporary working files
>  "

This will cause parseopt to normalize "--clean" to "-c" (along with
"--cle", etc).

>  parallel=
>  force=
> +clean=
>  while test $# -gt 0
>  do
>  	case "$1" in
>  	-j)
>  		parallel=$2; shift ;;
> +	-c|--clean)
> +		clean=t ;;

So this part can just test for "-c". AFAICT this is how "rev-parse
--parseopt" has always worked, though the documentation is quite
unclear. Other scripts seem to also use these redundant long options.
I'm not opposed to including it as a defensive measure (or simply an
annotation for the reader).

> +cd_to_toplevel
> +tmp=Documentation/tmp-doc-diff
> +
> +if test -n "$clean"
> +then
> +	test $# -eq 0 || usage
> +	git worktree remove --force "$tmp/worktree" 2>/dev/null
> +	rm -rf "$tmp"
> +	exit 0
> +fi

And this matches what I'd expect "--clean" to do. Makes sense.

-Peff
