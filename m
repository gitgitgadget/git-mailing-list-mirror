Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A170EC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 22:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8431E61058
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 22:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhKBWer (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 18:34:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:51892 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhKBWeq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 18:34:46 -0400
Received: (qmail 3756 invoked by uid 109); 2 Nov 2021 22:32:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Nov 2021 22:32:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12018 invoked by uid 111); 2 Nov 2021 22:32:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Nov 2021 18:32:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Nov 2021 18:32:10 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: fix rewording with
 --committer-date-is-author-date
Message-ID: <YYG8aq85UmMMVW4l@coredump.intra.peff.net>
References: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 02, 2021 at 08:10:44PM +0000, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when
> fast-forwarding, 2021-08-20) stopped reading the author script in
> run_git_commit() when rewording a commit. This is normally safe
> because "git commit --amend" preserves the authorship. However if the
> user passes "--committer-date-is-author-date" then we need to read the
> author date from the author script when rewording. Fix this regression
> by tightening the check for when it is safe to skip reading the author
> script.

That description makes sense, and the patch matches. Not being that
familiar with this area, my biggest question would be: are there are
other cases that would need the same treatment? And is there a way we
can make it easier to avoid forgetting such a case in the future?

> diff --git a/sequencer.c b/sequencer.c
> index cd2aabf1f76..ea96837cde3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -997,7 +997,9 @@ static int run_git_commit(const char *defmsg,
>  
>  	cmd.git_cmd = 1;
>  
> -	if (is_rebase_i(opts) && !(!defmsg && (flags & AMEND_MSG)) &&
> +	if (is_rebase_i(opts) &&
> +	    ((opts->committer_date_is_author_date && !opts->ignore_date) ||
> +	     !(!defmsg && (flags & AMEND_MSG))) &&
>  	    read_env_script(&cmd.env_array)) {
>  		const char *gpg_opt = gpg_sign_opt_quoted(opts);

This conditional is getting pretty complicated. I wonder if a helper
like:

  if (is_rebase_i(opts) && !needs_env_script(...))

might help, but I guess it needs a funky array of inputs (defmsg, flags,
and opts). So maybe it is just making things worse.

> +test_expect_success '--committer-date-is-author-date works when rewording' '
> +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
> +	(
> +		set_fake_editor &&
> +		FAKE_COMMIT_MESSAGE=edited \
> +			FAKE_LINES="reword 1" \
> +			git rebase -i --committer-date-is-author-date HEAD^
> +	) &&
> +	test_write_lines edited "" >expect &&
> +	git log --format="%B" -1 >actual &&
> +	test_cmp expect actual &&
> +	test_ctime_is_atime -1
> +'

This test make sense (I had to look up what "-1" means for
test_ctime_is_atime; it's passed to git-log to decide which commits to
look at).

> +test_expect_success 'reset-author-date with --committer-date-is-author-date works when rewording' '
> +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
> +	(
> +		set_fake_editor &&
> +		FAKE_COMMIT_MESSAGE=edited \
> +			FAKE_LINES="reword 1" \
> +			git rebase -i --committer-date-is-author-date \
> +				--reset-author-date HEAD^
> +	) &&
> +	test_write_lines edited "" >expect &&
> +	git log --format="%B" -1 >actual &&
> +	test_cmp expect actual &&
> +	test_atime_is_ignored -1
> +'

And this one I guess is covering the --ignore-date cut-out in the code?
I think it would pass even without it, as that is just noting a case
where we _don't_ need to call read_env_script(). But I don't know if
there is any user-visible effect of accidentally calling it when we
don't need to (my impression is that it's just a performance thing).

-Peff
