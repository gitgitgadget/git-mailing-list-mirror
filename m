Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933221FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 04:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbdDPEuK (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 00:50:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:34229 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbdDPEuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 00:50:09 -0400
Received: (qmail 2698 invoked by uid 109); 16 Apr 2017 04:50:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 04:50:07 +0000
Received: (qmail 13177 invoked by uid 111); 16 Apr 2017 04:50:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 00:50:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Apr 2017 00:50:04 -0400
Date:   Sun, 16 Apr 2017 00:50:04 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: includeIf breaks calling dashed externals
Message-ID: <20170416045004.2ghhiv7jzgroejgw@sigill.intra.peff.net>
References: <CAKPyHN1W175wm1doQHF71vB3PHpU2o=xtEAcZMqZtR=U_Kv0_g@mail.gmail.com>
 <20170414174337.n6qksfvugkrexnsi@sigill.intra.peff.net>
 <20170415114901.GA5727@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170415114901.GA5727@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 06:49:01PM +0700, Duy Nguyen wrote:

> > Probably this fixes it:
> > 
> > diff --git a/config.c b/config.c
> > index b6e4a57b9..8d66bdf56 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -213,6 +213,9 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
> >  	struct strbuf pattern = STRBUF_INIT;
> >  	int ret = 0, prefix;
> >  
> > +	if (!have_git_dir())
> > +		return 0;
> > +
> >  	strbuf_add_absolute_path(&text, get_git_dir());
> >  	strbuf_add(&pattern, cond, cond_len);
> >  	prefix = prepare_include_condition_pattern(&pattern);
> > 
> > But it does raise a question of reading config before/after repository
> > setup, since those will give different answers. I guess they do anyway
> > because of $GIT_DIR/config.
> 
> This happens in execv_dased_external() -> check_pager_config() ->
> read_early_config(). We probably could use the same discover_git_directory
> trick to get .git dir (because we should find it). Maybe something
> like this instead?

I know that we only kick in discover_git_directory() in certain cases
when we're reading config (for the "early config"). Would it makes sense
to respect the same rules here?

I.e., if we have a program that wants to look at config but explicitly
_doesn't_ setup the git repository, is it right to say that we are
inside that repository?

So instead of lazily doing the discovery here:

> diff --git a/config.c b/config.c
> index 1a4d85537b..4f540ae578 100644
> --- a/config.c
> +++ b/config.c
> @@ -212,8 +212,14 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
>  	struct strbuf text = STRBUF_INIT;
>  	struct strbuf pattern = STRBUF_INIT;
>  	int ret = 0, prefix;
> +	struct strbuf gitdir = STRBUF_INIT;
>  
> -	strbuf_add_absolute_path(&text, get_git_dir());
> +	if (have_git_dir())
> +		strbuf_addstr(&gitdir, get_git_dir());
> +	else if (!discover_git_directory(&gitdir))
> +		goto done;

..should we record the discovered git dir in read_early_config(), and
use it only if available? And if not, then we know the program is
explicitly trying not to be in a repo (or we know we tried to discover
one already and it didn't exist).

-Peff
