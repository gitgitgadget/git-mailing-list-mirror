Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D72D1FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 02:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754703AbcKVClF (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 21:41:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:45858 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754404AbcKVClE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 21:41:04 -0500
Received: (qmail 20100 invoked by uid 109); 22 Nov 2016 02:41:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 02:41:04 +0000
Received: (qmail 25032 invoked by uid 111); 22 Nov 2016 02:41:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Nov 2016 21:41:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Nov 2016 21:41:02 -0500
Date:   Mon, 21 Nov 2016 21:41:02 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/7] setup_git_env: avoid blind fall-back to ".git"
Message-ID: <20161122024102.otlnl6jcrb3pejux@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
 <20161122004421.GA12263@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161122004421.GA12263@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 04:44:21PM -0800, Jonathan Nieder wrote:

> >  	git_dir = getenv(GIT_DIR_ENVIRONMENT);
> > -	if (!git_dir)
> > +	if (!git_dir) {
> > +		if (!startup_info->have_repository)
> > +			die("BUG: setup_git_env called without repository");
> >  		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
> > +	}
> 
> This trips reproducibly for
> 
>   git ls-remote https://kernel.googlesource.com/pub/scm/git/git
> 
> when run outside of a git repository.
> 
> Backtrace:
> 
>   #0  setup_git_env () at environment.c:172
>   #1  get_git_dir () at environment.c:214
>   #2  get_helper at transport-helper.c:127
>   #3  get_refs_list (for_push=0) at transport-helper.c:1038
>   #4  transport_get_remote_refs at transport.c:1076
>   #5  cmd_ls_remote at builtin/ls-remote.c:97
> 
> transport-helper.c:127 is
> 
> 	argv_array_pushf(&helper->env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
> 			 get_git_dir());
> 
> That code is pretty clearly wrong.  Should it be made conditional
> on have_git_dir(), like this?

Yeah, I think making it conditional makes the most sense. Just trying to
think of cases that might not be covered by your patch:

  - if we are not in a repository, we shouldn't ever need to override an
    existing $GIT_DIR from the environment. Because if $GIT_DIR is
    present, then we _would_ be in a repo if it's valid, and die if it
    isn't.

  - not setting $GIT_DIR may cause a helper to do the usual discovery
    walk to find the repository. But we know we're not in one, or we
    would have found it ourselves. So worst case it may expend a little
    effort to try to find a repository and fail (I think remote-curl
    would do this to try to find repo-level config).

Both of those points assume that we've already called
setup_git_directory_gently(), but I think that's a reasonable
assumption. And certainly is true for ls-remote, and should be for any
git command that invokes the transport code.

> diff --git a/transport-helper.c b/transport-helper.c
> index 91aed35..e4fd982 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -124,8 +124,9 @@ static struct child_process *get_helper(struct transport *transport)
>  	helper->git_cmd = 0;
>  	helper->silent_exec_failure = 1;
>  
> -	argv_array_pushf(&helper->env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
> -			 get_git_dir());
> +	if (have_git_dir())
> +		argv_array_pushf(&helper->env_array, "%s=%s",
> +				 GIT_DIR_ENVIRONMENT, get_git_dir());

So yeah, I think this is the extent of the change needed.

Thanks.

-Peff
