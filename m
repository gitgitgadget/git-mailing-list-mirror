Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62352C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 17:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjHJRkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 13:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjHJRkL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 13:40:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0852726AA
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 10:40:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 99CEC1D17D;
        Thu, 10 Aug 2023 13:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9tUdzys9ajEgst4JSDF+D7mYpjaEbOfvx0FqGn
        I1aaA=; b=nmXFqbdnMCmNqUpxRRMoy2UrDibQjqYL0TES+4DyrIgNcsD9r+AnY1
        CYcT+qsinATc5neieFjpK9JYKrytxvS/NEtSgTvZdWs3jUT+qfPR4Cw5TnxKOVlH
        I/Dk++DHnv0WJ4VIYAaiamP4LZ3OBH+pZ4ZU9hlftKy0xS2qZwjl8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91ECF1D17C;
        Thu, 10 Aug 2023 13:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 65E721D17B;
        Thu, 10 Aug 2023 13:40:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] t4053: avoid race when killing background processes
References: <pull.1571.git.1691677993195.gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 10:40:03 -0700
In-Reply-To: <pull.1571.git.1691677993195.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Thu, 10 Aug 2023 14:33:13 +0000")
Message-ID: <xmqqedkassng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F082FDAE-37A4-11EE-AD28-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The test 'diff --no-index reads from pipes' starts a couple of
> background processes that write to the pipes that are passed to "diff
> --no-index". If the test passes then we expect these processes to exit
> as all their output will have been read. However if the test fails
> then we want to make sure they do not hang about on the users machine
> and the test remembers they should be killed by calling
>
>       test_when_finished  "! kill $!"
>
> after each background process is created. Unfortunately there is a
> race where test_when_finished may run before the background process
> exits even when all its output has been read resulting in the kill
> command succeeding which causes the test to fail. Fix this by ignoring
> the exit status of the kill command. If the diff is successful we
> could instead wait for the background process to exit and check their
> status but that feels like it is testing the platform's printf
> implementation rather than git's code.
>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     t4053: avoid race when killing background processes
>     
>     Thanks to Peff for reporting this. Junio - this fixes a regression
>     introduced in the current cycle. It is fairly minor though so I'm not
>     sure if you want to pick it up now or wait until 2.42.0 is out.

This did not cut -rc1 that was scheduled for yesterday, but a fix
for a new test added during the cycle is a very welcome addition.

While I can see that "kill" in the when-finished handler may or may
not find the backgrounded process by the time it is run, and
ignoring its exit status (hence keeping test_when_finished happy)
would be a reasonable thing to do.  I can understand if this patch
is to fix a different symptom, namely, when-finished handler
sometimes fails and makes the test fail.

But I am not sure how this causes the test to "hang", which
presumably is a symptom that somebody is trying to read from
a pipe that nobody is making progress to write into?  We will
send a signal either way to the writers, and the only difference is
that we ignore the exit code.

Granted, when-finished handlers are concatenated with "&&-", and one
"kill"s failure will cause the other "kill" not to run, so we may
send a signal to only one but not to the other, but that should all
happen after "diff --no-index" returns, so it still does not explain
the "hang".

Puzzled...

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1571%2Fphillipwood%2Fdiff-no-index-pipes-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1571/phillipwood/diff-no-index-pipes-fixes-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1571
>
>  t/t4053-diff-no-index.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index a28b9ff2434..1fb7d334620 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -248,11 +248,11 @@ test_expect_success PIPE,SYMLINKS 'diff --no-index reads from pipes' '
>  	{
>  		(test_write_lines a b c >old) &
>  	} &&
> -	test_when_finished "! kill $!" &&
> +	test_when_finished "kill $! || :" &&
>  	{
>  		(test_write_lines a x c >new) &
>  	} &&
> -	test_when_finished "! kill $!" &&
> +	test_when_finished "kill $! || :" &&
>  
>  	cat >expect <<-EOF &&
>  	diff --git a/old b/new-link
>
> base-commit: a82fb66fed250e16d3010c75404503bea3f0ab61
