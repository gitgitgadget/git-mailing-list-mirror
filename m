Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B50F92095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932754AbdCUSYf (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:24:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:48787 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757759AbdCUSXl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:23:41 -0400
Received: (qmail 11672 invoked by uid 109); 21 Mar 2017 18:23:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 18:23:39 +0000
Received: (qmail 17843 invoked by uid 111); 21 Mar 2017 18:23:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 14:23:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Mar 2017 14:23:35 -0400
Date:   Tue, 21 Mar 2017 14:23:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] prefix_filename: return newly allocated string
Message-ID: <20170321182335.3yrjkhk4mxhso73j@sigill.intra.peff.net>
References: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
 <20170321012847.yebhpdmk5zrizgmj@sigill.intra.peff.net>
 <xmqqinn2qyyo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinn2qyyo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 11:14:23AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/worktree.c b/worktree.c
> > index 42dd3d52b..2520fc65c 100644
> > --- a/worktree.c
> > +++ b/worktree.c
> > @@ -250,16 +250,19 @@ struct worktree *find_worktree(struct worktree **list,
> >  {
> >  	struct worktree *wt;
> >  	char *path;
> > +	char *to_free;
> >  
> >  	if ((wt = find_worktree_by_suffix(list, arg)))
> >  		return wt;
> >  
> > -	arg = prefix_filename(prefix, arg);
> > +	if (prefix)
> > +		arg = to_free = prefix_filename(prefix, arg);
> >  	path = real_pathdup(arg, 1);
> >  	for (; *list; list++)
> >  		if (!fspathcmp(path, real_path((*list)->path)))
> >  			break;
> >  	free(path);
> > +	free(to_free);
> >  	return *list;
> >  }
> 
> worktree.c:265:6: error: to_free may be used uninitialized in this function

Doh. I had originally written it without the "if (prefix)" and added it
as a micro-optimization at the end.

Still, the whole thing compiles fine for me. I find it odd that neither
gcc nor clang notices the problem on my system. It's quite obviously
wrong.

> diff --git a/worktree.c b/worktree.c
> index 2520fc65cc..bae787cf8d 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -250,7 +250,7 @@ struct worktree *find_worktree(struct worktree **list,
>  {
>  	struct worktree *wt;
>  	char *path;
> -	char *to_free;
> +	char *to_free = NULL;

Yep, this is the right fix. Thanks.

-Peff
