Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B52BC2BB1D
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15B8206EB
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCMRr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:47:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:39224 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726480AbgCMRr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 13:47:56 -0400
Received: (qmail 24395 invoked by uid 109); 13 Mar 2020 17:47:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Mar 2020 17:47:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8590 invoked by uid 111); 13 Mar 2020 17:57:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Mar 2020 13:57:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Mar 2020 13:47:55 -0400
From:   Jeff King <peff@peff.net>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     erlend-a@innova.no, git@vger.kernel.org
Subject: Re: [RFC PATCH] Make rev-parse -q and --is-* quiet
Message-ID: <20200313174755.GA549554@coredump.intra.peff.net>
References: <CAHk66ftWBYF3d_L0-__BP5mKNxBioj57y44yhyqGrtK3TZTjSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk66ftWBYF3d_L0-__BP5mKNxBioj57y44yhyqGrtK3TZTjSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 13, 2020 at 11:00:00PM +0530, Abhishek Kumar wrote:

> > @@ -874,24 +874,31 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> >                 continue;
> >             }
> >             if (!strcmp(arg, "--is-inside-git-dir")) {
> > -                printf("%s\n", is_inside_git_dir() ? "true"
> > -                        : "false");
> > +                int is_set = is_inside_git_dir();
> 
> Avoid declaration after statement. Move is_set to the beginning of
> cmd_rev_parse().

This one is OK, because we're starting a new block (and the printf there
is going away).  And it's nicer to keep the variable local to this block
if we can.

> > +                if (quiet)
> > +                    return is_set ? 0 : 1;
> 
> Returning prematurely might be a bad idea. If there are more options after
> "--is-inside-git-dir", they will be not executed. You can maybe rewrite this as:
> 
> ```
>              if (!strcmp(arg, "--is-inside-git-dir")) {
>                 is_set = is_inside_git_dir();
>                 if (!quiet)
>                         printf("%s\n", is_set ? "true"
>                             : "false");
>                  continue;
>              }
> ```
> And then return the value at the end of function, replacing '0' with !is_set.

Yeah, the inability of this new mode to handle multiple options is a
drawback. We could perhaps live with it as a restriction (it is up to
the caller to decide if they want to make multiple calls with --quiet,
or do it all as one and accept the hassle of parsing), but it's rather
unfortunate if:

  git rev-parse --quiet --is-inside-git-dir --is-bare-repository

quietly ignores the third argument. That seems like a recipe for errors.

I'm not sure if returning a single is_set makes sense, though. It
effectively becomes an OR, and you wouldn't know which flag triggered
it. It would make more sense to me for the invocation above to simply be
an error, reminding the caller that they need to handle it more
carefully.

We _could_ encode each value into the exit code (e.g., set bit 1 if the
first condition was true, and so on). But checking that becomes as much
hassle as reading stdout, so there's little value.

-Peff
