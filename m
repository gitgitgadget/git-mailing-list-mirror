Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA2C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 07:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD22320659
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 07:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfKVHPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 02:15:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:57758 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726018AbfKVHPh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 02:15:37 -0500
Received: (qmail 18675 invoked by uid 109); 22 Nov 2019 07:15:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Nov 2019 07:15:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20268 invoked by uid 111); 22 Nov 2019 07:19:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Nov 2019 02:19:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Nov 2019 02:15:36 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ryenus@gmail.com, stolee@gmail.com,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] progress: create GIT_PROGRESS_DELAY
Message-ID: <20191122071536.GC23225@sigill.intra.peff.net>
References: <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
 <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
 <a7acdf9c8f8c85f9f39750315716f21e83ce67c6.1574351516.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7acdf9c8f8c85f9f39750315716f21e83ce67c6.1574351516.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 21, 2019 at 03:51:55PM +0000, Derrick Stolee via GitGitGadget wrote:

> @@ -267,9 +268,19 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
>  	return progress;
>  }
>  
> +static int get_default_delay(void)
> +{
> +	static int delay_in_secs = -1;
> +
> +	if (delay_in_secs < 0)
> +		delay_in_secs = git_env_ulong("GIT_PROGRESS_DELAY", 2);
> +
> +	return delay_in_secs;
> +}

Thanks, this factoring out looks good.

Since the only callers of start_progress_delay() pass in either the
result of this function or "0", it _could_ become a bool flag and we
could just resolve it inside that function. But I don't think there's a
big advantage to doing so.

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index d42b3efe39..0824857e1f 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -132,7 +132,7 @@ test_expect_success 'commit-graph write progress off for redirected stderr' '
>  
>  test_expect_success 'commit-graph write force progress on for stderr' '
>  	cd "$TRASH_DIRECTORY/full" &&
> -	git commit-graph write --progress 2>err &&
> +	GIT_PROGRESS_DELAY=0 git commit-graph write --progress 2>err &&
>  	test_file_not_empty err
>  '

I'm tempted to suggest that we should just set GIT_PROGRESS_DELAY=0 for
the whole test suite. That would root out any potentially racy tests,
though given that the default is 2 seconds, it would probably take a
pretty horribly loaded system to trigger such a race.

Curiously, doing this:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 46c4440843..63357ed6c4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -423,6 +423,9 @@ export EDITOR
 GIT_TRACE_BARE=1
 export GIT_TRACE_BARE
 
+GIT_PROGRESS_DELAY=0
+export GIT_PROGRESS_DELAY
+
 check_var_migration () {
 	# the warnings and hints given from this helper depends
 	# on end-user settings, which will disrupt the self-test

results in a few test failures. It looks like unpack-trees is eager to
print the "Updating files" progress meter even when stderr is redirected
to a file. Which seems like a bug. I don't mind if we put that off for
now, though, in order to get your fix here merged more quickly.

-Peff
