Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7BC1F424
	for <e@80x24.org>; Wed,  9 May 2018 14:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934895AbeEIOmZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 10:42:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:33420 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751000AbeEIOmY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 10:42:24 -0400
Received: (qmail 1249 invoked by uid 109); 9 May 2018 14:42:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 May 2018 14:42:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15265 invoked by uid 111); 9 May 2018 14:42:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 09 May 2018 10:42:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 May 2018 10:42:22 -0400
Date:   Wed, 9 May 2018 10:42:22 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>
Subject: Re: [PATCH 1/1] commit-graph: fix UX issue when .lock file exists
Message-ID: <20180509144221.GA14714@sigill.intra.peff.net>
References: <20180509141523.89896-1-dstolee@microsoft.com>
 <20180509141523.89896-2-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180509141523.89896-2-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 09, 2018 at 02:15:38PM +0000, Derrick Stolee wrote:

> The commit-graph file lives in the .git/objects/info directory.
> Previously, a failure to acquire the commit-graph.lock file was
> assumed to be due to the lack of the info directory, so a mkdir()
> was called. This gave incorrect messaging if instead the lockfile
> was open by another process:
> 
>   "fatal: cannot mkdir .git/objects/info: File exists"
> 
> Rearrange the expectations of this directory existing to avoid
> this error, and instead show the typical message when a lockfile
> already exists.

Sounds like a reasonable bug fix.

Your cover letter is way longer than this description. Should some of
that background perhaps go in the commit message?

(I would go so far as to say that sending a cover letter for a single
patch is an anti-pattern, because the commit message should be able to
stand on its own).

> @@ -754,23 +755,14 @@ void write_commit_graph(const char *obj_dir,
>  	compute_generation_numbers(&commits);
>  
>  	graph_name = get_commit_graph_filename(obj_dir);
> -	fd = hold_lock_file_for_update(&lk, graph_name, 0);
>  
> -	if (fd < 0) {
> -		struct strbuf folder = STRBUF_INIT;
> -		strbuf_addstr(&folder, graph_name);
> -		strbuf_setlen(&folder, strrchr(folder.buf, '/') - folder.buf);
> -
> -		if (mkdir(folder.buf, 0777) < 0)
> -			die_errno(_("cannot mkdir %s"), folder.buf);
> -		strbuf_release(&folder);
> -
> -		fd = hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
> -
> -		if (fd < 0)
> -			die_errno("unable to create '%s'", graph_name);
> -	}
> +	strbuf_addstr(&folder, graph_name);
> +	strbuf_setlen(&folder, strrchr(folder.buf, '/') - folder.buf);
> +	if (!file_exists(folder.buf) && mkdir(folder.buf, 0777) < 0)
> +		die_errno(_("cannot mkdir %s"), folder.buf);
> +	strbuf_release(&folder);

The result is racy if somebody else is trying to create the directory at
the same time. For that you'd want to notice EEXIST coming from mkdir
and consider that a success.

I think you probably ought to be calling adjust_shared_perm() on the
result, too, in case core.sharedrepository is configured.

If you use safe_create_leading_directories(), it should handle both.
Something like:

  if (safe_create_leading_directories(graph_name))
	die_errno(_("unable to create leading directories of %s"),
		  graph_name));

I think I'm holding it right; that function is a little short on
documentation, but it's the standard way to do this in Git's codebase,
and you can find lots of example callers.

-Peff
