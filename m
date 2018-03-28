Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 695E51F404
	for <e@80x24.org>; Wed, 28 Mar 2018 18:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeC1SaO (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 14:30:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:46466 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752642AbeC1SaN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 14:30:13 -0400
Received: (qmail 16049 invoked by uid 109); 28 Mar 2018 18:30:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Mar 2018 18:30:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11902 invoked by uid 111); 28 Mar 2018 18:31:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Mar 2018 14:31:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2018 14:30:11 -0400
Date:   Wed, 28 Mar 2018 14:30:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Rafael Ascensao <rafa.almas@gmail.com>
Subject: Re: [PATCH 6/8] environment.c: adjust env containing relpath when
 $CWD is moved
Message-ID: <20180328183011.GA16931@sigill.intra.peff.net>
References: <20180328094733.GA1523@sigill.intra.peff.net>
 <20180328175537.17450-1-pclouds@gmail.com>
 <20180328175537.17450-7-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180328175537.17450-7-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 07:55:35PM +0200, Nguyễn Thái Ngọc Duy wrote:

> From: Duy Nguyen <pclouds@gmail.com>
> 
> As noted in the previous patch, when $CWD is moved, we recognize the
> problem with relative paths and update $GIT_WORK_TREE and $GIT_DIR
> with new ones.
> 
> We have plenty more environment variables that can contain paths
> though. If they are read and cached before setup_work_tree() is
> called, nobody will update them and they become bad paths.

Hmm, yeah, I missed these. It would be interesting to know if there are
easy-to-run test cases that show off these bugs, or if they're
hypothetical. (Even if they are hypothetical, I'm not opposed to fixing
them in the name of maintainability).

> Hook into setup_work_tree() and update all those env variables. The
> code to update $GIT_WORK_TREE is no longer needed and removed.

That's a nice cleanup.

> Technically we should remove the setenv() in set_git_dir() as well,
> but that is also called _not_ by setup_work_tree() and we should keep
> the behavior the same in that case for safety. set_git_dir() will be
> removed from setup_work_tree() soon, which achieves the same goal.

Makes sense.

> diff --git a/environment.c b/environment.c
> index 39b3d906c8..f9dcc1b99e 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -128,6 +128,20 @@ const char * const local_repo_env[] = {
>  	NULL
>  };
>  
> +/* A subset of local_repo_env[] that contains path */
> +const char * const local_repo_path_env[] = {
> +	ALTERNATE_DB_ENVIRONMENT,
> +	CONFIG_ENVIRONMENT,
> +	DB_ENVIRONMENT,
> +	GIT_COMMON_DIR_ENVIRONMENT,
> +	GIT_DIR_ENVIRONMENT,
> +	GIT_SHALLOW_FILE_ENVIRONMENT,
> +	GIT_WORK_TREE_ENVIRONMENT,
> +	GRAFT_ENVIRONMENT,
> +	INDEX_ENVIRONMENT,
> +	NULL
> +};

It might be nice to fold this list into local_repo_env automatically. I
think you'd have to do it with a macro.

OTOH, it's possible that there could be a path-related environment
variable that _isn't_ actually part of local_repo_env. E.g., I think
GIT_CONFIG might classify there (though I don't know if it's worth
worrying about).

> +static void update_path_envs(const char *old_cwd, const char *new_cwd,
> +			     void *cb)
> +{
> +	int i;
> +
> +	/*
> +	 * FIXME: special treatment needed for
> +	 * GIT_ALTERNATE_OBJECT_DIRECTORIES because it can contain
> +	 * multiple paths.
> +	 */

Yuck. It just keeps getting more complicated. :(

I do wonder if relative paths in variables like this are worth worrying
about. AFAIK, it's always been a "well, it kind of works" situation, but
not something we've tried to actively support. I think with the current
code you'd potentially get inconsistent results between a command which
sets up the work tree and one which doesn't. So this would be fixing
that, but at the same time, I'm not sure how much we want to promise
here.

-Peff
