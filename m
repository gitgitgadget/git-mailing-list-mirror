Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42C620986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbcJDRef (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:34:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:52174 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751872AbcJDRed (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:34:33 -0400
Received: (qmail 5123 invoked by uid 109); 4 Oct 2016 17:34:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 17:34:33 +0000
Received: (qmail 7519 invoked by uid 111); 4 Oct 2016 17:34:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 13:34:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 13:34:30 -0400
Date:   Tue, 4 Oct 2016 13:34:30 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] push: change submodule default to check
Message-ID: <20161004173430.eax4ptohyonc5bw2@sigill.intra.peff.net>
References: <20161004162102.rwofudnx3g3fsyul@sigill.intra.peff.net>
 <20161004164036.6584-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161004164036.6584-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 09:40:36AM -0700, Stefan Beller wrote:

> >> Why should we even have a default different from today's?  If most
> >> repositories don't have submodules enabled at all, we can just let
> >> those working with submodules enabled to toggle their configuration
> >> and that is an very easy to understand solution, no?
> >
> > You will not see any complaint from me on that. I was taking for granted
> > that the current default is inconvenient to submodule users, but I don't
> > have any experience myself.
> >
> 
> And there I was trying to help submodule users not shoot in their foot.

Sorry if my reply came off as snarky. I really did mean it literally. I
do not know if the end goal is good or not, so all of my discussion was
just assuming it was.

So in that vein...

> diff --git a/builtin/push.c b/builtin/push.c
> index 3bb9d6b..d7d664a 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -22,7 +22,7 @@ static int deleterefs;
>  static const char *receivepack;
>  static int verbosity;
>  static int progress = -1;
> -static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> +static int recurse_submodules;
>  static enum transport_family family;
>  
>  static struct push_cas_option cas;
> @@ -31,6 +31,14 @@ static const char **refspec;
>  static int refspec_nr;
>  static int refspec_alloc;
>  
> +static void preset_submodule_default(void)
> +{
> +	if (file_exists(".gitmodules"))
> +		recurse_submodules = RECURSE_SUBMODULES_CHECK;
> +	else
> +		recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> +}

This does seem like a reasonable heuristic. I wonder if you want to
confirm that we actually have a worktree (and are in it) before looking
at file_exists(). It's unlikely that looking at ".gitmodules" in a bare
repo would trigger in practice, but it does not hurt to be careful.

-Peff
