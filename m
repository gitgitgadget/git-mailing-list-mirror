Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911D02023D
	for <e@80x24.org>; Fri,  3 Mar 2017 09:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbdCCJNX (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 04:13:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:37811 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751369AbdCCJCY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 04:02:24 -0500
Received: (qmail 1051 invoked by uid 109); 3 Mar 2017 04:45:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 04:45:21 +0000
Received: (qmail 24676 invoked by uid 111); 3 Mar 2017 04:45:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 23:45:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 23:45:19 -0500
Date:   Thu, 2 Mar 2017 23:45:19 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/9] Export the discover_git_directory() function
Message-ID: <20170303044518.rdtyvgs7kqe7fkpf@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
 <cover.1488506615.git.johannes.schindelin@gmx.de>
 <0ca4cce042cc0b0f13f87363b70a3689057ae9b0.1488506615.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ca4cce042cc0b0f13f87363b70a3689057ae9b0.1488506615.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 03:04:15AM +0100, Johannes Schindelin wrote:

> The function we introduced earlier needs to return both the path to the
> .git/ directory as well as the "cd-up" path to allow
> setup_git_directory() to retain its previous behavior as if it changed
> the current working directory on its quest for the .git/ directory.
> 
> Let's rename it and export a function with an easier signature that
> *just* discovers the .git/ directory.
> 
> We will use it in a subsequent patch to support early config reading
> better.
> 

Seems like an obviously good next step.

> diff --git a/cache.h b/cache.h
> index 80b6372cf76..a104b76c02e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -518,6 +518,7 @@ extern void set_git_work_tree(const char *tree);
>  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
>  
>  extern void setup_work_tree(void);
> +extern const char *discover_git_directory(struct strbuf *gitdir);

Perhaps it's worth adding a short docstring describing the function. I
know that would make it unlike all of its neighbors, but it is not
immediately obvious to me what the return value is (or whether gitdir is
an input or output parameter).

> +const char *discover_git_directory(struct strbuf *gitdir)
> +{
> +	struct strbuf dir = STRBUF_INIT;
> +	int len;

Nit: please use size_t for storing strbuf lengths.

> +	if (strbuf_getcwd(&dir))
> +		return NULL;
> +
> +	len = dir.len;
> +	if (discover_git_directory_1(&dir, gitdir) < 0) {
> +		strbuf_release(&dir);
> +		return NULL;
> +	}
> +
> +	if (dir.len < len && !is_absolute_path(gitdir->buf)) {
> +		strbuf_addch(&dir, '/');
> +		strbuf_insert(gitdir, 0, dir.buf, dir.len);
> +	}
> +	strbuf_release(&dir);

I was confused by two things here.

One is that because I was wondering whether "gitdir" was supposed to be
passed empty or not, it wasn't clear that this insert is doing the right
thing.  If there _is_ something in it, then discover_git_directory_1()
would just append to it, which makes sense. But then this insert blindly
sticks the absolute-path bit at the front of the string, leaving
whatever was originally there spliced into the middle of the path.
Doing:

  size_t base = gitdir->len;
  ...
  strbuf_insert(gitdir, base, dir.buf, dir.len);

would solve that. It's probably not that likely for somebody to do:

  strbuf_addstr(&buf, "my git dir is ");
  discover_git_directory(&buf);

but since it's not much effort, it might be worth making it work.

The second is that I don't quite understand why we only make the result
absolute when we walked upwards. In git.git, the result of the function
in various directories is:

  - ".git", when we're at the root of the worktree
  - "/home/peff/git/.git, when we're in "t/"
  - "." when we're already in ".git"
  - "/home/peff/git/.git/." when we're in ".git/objects"

I'm not sure if some of those cases are not behaving as intended, or
there's some reason for the differences that I don't quite understand.

-Peff
