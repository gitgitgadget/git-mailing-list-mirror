Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7CAC77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 21:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDNVfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDNVfj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 17:35:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E91465B3
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 14:35:38 -0700 (PDT)
Received: (qmail 23409 invoked by uid 109); 14 Apr 2023 21:35:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Apr 2023 21:35:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31810 invoked by uid 111); 14 Apr 2023 21:35:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Apr 2023 17:35:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Apr 2023 17:35:37 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: set actual revdate for manpages
Message-ID: <20230414213537.GA640081@coredump.intra.peff.net>
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
 <20230414070449.GA540206@coredump.intra.peff.net>
 <643949a57396c_5b7e62948d@chronos.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <643949a57396c_5b7e62948d@chronos.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 06:40:05AM -0600, Felipe Contreras wrote:

> > It would be nicer to populate the date variable in that case, like we do
> > for GIT_VERSION. I think that could look something like this:
> 
> Indeed, that would be better, but that totally can be done in a separate patch,
> or a separate series even.
> 
> The perfect doesn't have to be the enemy of the good, and that can be done
> later.
> 
> In the meantime something is better than nothing.

Sometimes, as long as it is not making the status quo worse in the
meantime. In this case, if the tarball build continues to use the
current date (which it appears to), then it's not changing. It does
become inconsistent with the output you get from building in-repo, which
is unfortunate. But that might be acceptable.

If so, it would make sense to document that decision in the commit
message.  We'd also want to suppress stderr from the Git invocation so
that tarball builders don't see a confusing error message. And probably
we should avoid using the "git show" porcelain in a script. I think:

  git rev-list -1 --no-commit-header --format=%as HEAD

would do what you want (or %cs; I don't have a strong opinion there).

> > --- a/GIT-VERSION-GEN
> > +++ b/GIT-VERSION-GEN
> > @@ -10,7 +10,8 @@ LF='
> >  # then try git-describe, then default.
> >  if test -f version
> >  then
> > -	VN=$(cat version) || VN="$DEF_VER"
> > +	VN=$(cut -d" " -f1 version) || VN="$DEF_VER"
> > +	DN=$(cut -d" " -f2 version) || DN=""
> 
> Although this works, I have an issue with doing multiple unnecessary forks.
> 
> This does the same, no?
> 
>   read VN DN <version

Yeah, that should be fine. The original could probably be using "read"
in the first place. In general it's worth micro-optimizing this script
because it runs on every single "make" invocation, though this code path
in particular is only run for tarball builders (who presumably build a
lot less than developers).

It might also be worth just putting the two fields in two separate
files, if there's any question of spaces in the version field.

-Peff
