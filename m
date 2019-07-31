Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900B01F731
	for <e@80x24.org>; Wed, 31 Jul 2019 22:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfGaWCG (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 18:02:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:57642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730814AbfGaWCG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 18:02:06 -0400
Received: (qmail 21117 invoked by uid 109); 31 Jul 2019 22:02:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 22:02:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22417 invoked by uid 111); 31 Jul 2019 22:03:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 18:03:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 18:02:05 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] config: work around bug with includeif:onbranch
 and early config
Message-ID: <20190731220204.GA1933@sigill.intra.peff.net>
References: <pull.300.git.gitgitgadget@gmail.com>
 <pull.300.v2.git.gitgitgadget@gmail.com>
 <ea1a746113b85bde5319c410f68fe3dc75f8a328.1564603600.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea1a746113b85bde5319c410f68fe3dc75f8a328.1564603600.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 31, 2019 at 01:06:42PM -0700, Johannes Schindelin via GitGitGadget wrote:

> Since 07b2c0eacac (config: learn the "onbranch:" includeIf condition,
> 2019-06-05), there is a potential catch-22 in the early config path: if
> the `include.onbranch:` feature is used, Git assumes that the Git
> directory has been initialized already. However, in the early config
> code path that is not true.
> 
> One way to trigger this is to call the following commands in any
> repository:
> 
> 	git config includeif.onbranch:refs/heads/master.path broken
> 	git help -a
> 
> The symptom triggered by the `git help -a` invocation reads like this:
> 
> BUG: refs.c:1851: attempting to get main_ref_store outside of repository
> 
> Let's work around this, simply by ignoring the `includeif.onbranch:`
> setting when parsing the config when the ref store has not been
> initialized (yet).

I think this "fix the BUG() now, consider making more uses cases work
later" is the right thing to do, and it matches many of the other
"oops, we are looking at repository bits while not in a repo" fixes
we've done over the past few years.

> Technically, there is a way to solve this properly: teach the refs
> machinery to initialize the ref_store from a given gitdir/commondir pair
> (which we _do_ have in the early config code path), and then use that in
> `include_by_branch()`. This, however, is a pretty involved project, and
> we're already in the feature freeze for Git v2.23.0.

This gets tricky, because some commands are intentionally avoiding the
normal lookup procedure (e.g., clone or init, and probably things like
upload-pack that want to enter another repo). So I think it is OK as
long as the early-config code is explicitly saying "and please look at
the refs in this specific direectory now", and it doesn't affect other
possible code paths that might look at refs. I _think_ that's what
you're suggesting above, but I just want to make sure (not that it
matters either way for this patch).

As a workaround, I suspect in many cases it might work to simply do a
gentle setup (e.g., in "help"), but we simply weren't doing it before
because there was no use case. That obviously wouldn't work for
something like clone, though.

> diff --git a/config.c b/config.c
> index ed7f58e0fc..3900e4947b 100644
> --- a/config.c
> +++ b/config.c
> @@ -275,7 +275,8 @@ static int include_by_branch(const char *cond, size_t cond_len)
>  	int flags;
>  	int ret;
>  	struct strbuf pattern = STRBUF_INIT;
> -	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
> +	const char *refname = !the_repository || !the_repository->gitdir ?
> +		NULL : resolve_ref_unsafe("HEAD", 0, NULL, &flags);

I think the_repository is always non-NULL. The way similar sites check
this is with "!startup_info->have_repository" or have_git_dir(). The
early-config code uses the latter, so we should probably match it here.

  Side note: I suspect there are some cleanup opportunities. IIRC, I had
  to add have_git_dir() to cover some cases where $GIT_DIR was set but
  we hadn't explicitly done a setup step, but there's been a lot of
  refactoring and cleanup in the initialization code since then. I'm not
  sure if it's still necessary.

> diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
> index 413642aa56..0c37e7180d 100755
> --- a/t/t1309-early-config.sh
> +++ b/t/t1309-early-config.sh
> @@ -89,4 +89,9 @@ test_expect_failure 'ignore .git/ with invalid config' '
>  	test_with_config "["
>  '
>  
> +test_expect_success 'early config and onbranch' '
> +	echo "[broken" >broken &&
> +	test_with_config "[includeif \"onbranch:refs/heads/master\"]path=../broken"
> +'

OK, so we know we didn't see the broken config because we'd have barfed
if we actually included it. Makes sense.

-Peff
