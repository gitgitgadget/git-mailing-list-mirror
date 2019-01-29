Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CDF81F453
	for <e@80x24.org>; Tue, 29 Jan 2019 13:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfA2NLy (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 08:11:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:52974 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725355AbfA2NLx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 08:11:53 -0500
Received: (qmail 26500 invoked by uid 109); 29 Jan 2019 13:11:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 13:11:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6259 invoked by uid 111); 29 Jan 2019 13:11:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 08:11:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 08:11:51 -0500
Date:   Tue, 29 Jan 2019 08:11:51 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/3] Setup working tree in describe
Message-ID: <20190129131151.GB22211@sigill.intra.peff.net>
References: <20190129051859.12830-1-koraktor@gmail.com>
 <20190129051859.12830-2-koraktor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129051859.12830-2-koraktor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 06:18:58AM +0100, Sebastian Staudt wrote:

> Subject: Re: [PATCH v3 2/3] Setup working tree in describe

We usually write subjects as "area: do some thing" which is a little
easier when scanning big lists of "git log --oneline".

I think it's key, too, that we only do this for the --dirty case, not
always. So maybe:

  describe: setup working tree for --dirty

or something?

> This ensures the given working tree is used for --dirty.

There's been a lot of digging and discussion on the list about what
happens if we don't do this. Could we summarize it here?

Perhaps:

  We don't use NEED_WORK_TREE when running the git-describe builtin,
  since you should be able to describe a commit even in a bare
  repository. However, the --dirty flag does need a working tree. Since
  we don't call setup_work_tree(), it uses whatever directory we happen
  to be in. That's unlikely to match our index, meaning we'd say "dirty"
  even when the real working tree is clean.

  We can fix that by calling setup_work_tree() once we know that the
  user has asked for --dirty.

> The implementation of --broken uses diff-index which calls
> setup_work_tree() itself.

If I hadn't just read the rest of the thread, I'd probably wonder why we
are talking about --broken at all. Maybe:

  The --broken option similarly needs a working tree. But because the
  current implementation calls an external diff-index to do the work,
  we don't have to bother setting up the working tree in the
  git-describe process.

> diff --git a/builtin/describe.c b/builtin/describe.c
> index cc118448ee..b5b7abdc8f 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -629,6 +629,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  			struct argv_array args = ARGV_ARRAY_INIT;
>  			int fd, result;
>  
> +			setup_work_tree();
>  			read_cache();
>  			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
>  				      NULL, NULL, NULL);

The patch itself looks good. :)

-Peff
