Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79C361F404
	for <e@80x24.org>; Thu,  5 Apr 2018 19:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeDETEv (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 15:04:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:54926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751913AbeDETEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 15:04:49 -0400
Received: (qmail 2563 invoked by uid 109); 5 Apr 2018 19:04:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 19:04:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18491 invoked by uid 111); 5 Apr 2018 19:05:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 15:05:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 15:04:47 -0400
Date:   Thu, 5 Apr 2018 15:04:47 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, sxlijin@gmail.com
Subject: Re: [RFC PATCH 2/7] dir.c: fix off-by-one error in
 match_pathspec_item
Message-ID: <20180405190446.GB21164@sigill.intra.peff.net>
References: <20180405173446.32372-1-newren@gmail.com>
 <20180405173446.32372-3-newren@gmail.com>
 <20180405174925.GA19974@sigill.intra.peff.net>
 <CABPp-BERWUPCPq-9fVW1LNocqkrfsoF4BPj3gJd9+En43vEkTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BERWUPCPq-9fVW1LNocqkrfsoF4BPj3gJd9+En43vEkTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 11:36:45AM -0700, Elijah Newren wrote:

> > Do we care about matching the name "foo" against the patchspec_item "foo/"?
> >
> > That matches now, but wouldn't after your patch.
> 
> Technically, the tests pass anyway due to the fallback behavior
> mentioned in the commit message, but this is a really good point.  It
> looks like the call to submodule_path_match() from builtin/grep.c is
> going to be passing name without the trailing '/', which is contrary
> to how read_directory_recursive() in dir.c builds up paths (namely
> with the trailing '/'). If we tried to force consistency (either
> always omit the trailing slash or always include it), then we'd
> probably want to do so for match_pathspec() calls as well, and there
> are lots of those throughout the code and auditing it all looks
> painful.
> 
> So I should probably make the check handle both cases:
> 
> @@ -383,8 +383,9 @@ static int match_pathspec_item(const struct
> pathspec_item *item, int prefix,
>         /* Perform checks to see if "name" is a super set of the pathspec */
>         if (flags & DO_MATCH_LEADING_PATHSPEC) {
>                 /* name is a literal prefix of the pathspec */
> +               int offset = name[namelen-1] == '/' ? 1 : 0;
>                 if ((namelen < matchlen) &&
> -                   (match[namelen] == '/') &&
> +                   (match[namelen-offset] == '/') &&
>                     !ps_strncmp(item, match, name, namelen))
>                         return MATCHED_RECURSIVELY_LEADING_PATHSPEC;

That seems reasonable to me, and your "offset" trick here should prevent
us from getting confused. Can namelen ever be zero here? I guess
probably not (I could see an empty pathspec, but an empty path does not
make sense).

There are other similar trailing-slash matches in that function, but I'm
not sure of all the cases in which they're used. I don't know if any of
those would need similar treatment (sorry for being vague; I expect I'd
need a few hours to dig into how the pathspec code actually works, and I
don't have that today).

-Peff
