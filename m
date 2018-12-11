Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7732520A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 10:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeLKKXe (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:23:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:37906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726176AbeLKKXe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:23:34 -0500
Received: (qmail 13709 invoked by uid 109); 11 Dec 2018 10:23:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 10:23:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3824 invoked by uid 111); 11 Dec 2018 10:22:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 05:22:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 05:23:09 -0500
Date:   Tue, 11 Dec 2018 05:23:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH] run-command: report exec failure
Message-ID: <20181211102309.GF31588@sigill.intra.peff.net>
References: <xmqqd0q8liow.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0q8liow.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 02:46:07PM +0900, Junio C Hamano wrote:

> In 321fd823 ("run-command: mark path lookup errors with ENOENT",
> 2018-10-24), we rewrote the logic to execute a command by looking
> in the directories on $PATH; as a side effect, a request to run a
> command that is not found on $PATH is noticed even before a child
> process is forked to execute it.
> 
> We however stopped to report an exec failure in such a case by
> mistake.  Add a logic to report the error unless silent-exec-failure
> is requested, to match the original code.
> 
> Reported-by: John Passaro <john.a.passaro@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Ah, thanks, I didn't see this before writing my other message. The
commit message and fix look good to me.

>  * Strictly speaking, the failure that is diagnosed by the spawned
>    child is reported with die() and prefixed with "failure:"; I am
>    adding error_errno(), so this will be reported with "error:"
>    prefix, which is a slight change in behaviour, but I am guessing
>    that this should be OK.

Yes, IMHO that's fine. Arguably the in-child version should say
"error:", too, as the fact that there is a second process is purely an
implementation detail (and not even true on Windows, or if we were to
start using posix_spawn).

> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index cf932c8514..9c83d44d9c 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -13,11 +13,13 @@ cat >hello-script <<-EOF
>  EOF
>  
>  test_expect_success 'start_command reports ENOENT (slash)' '
> -	test-tool run-command start-command-ENOENT ./does-not-exist
> +	test-tool run-command start-command-ENOENT ./does-not-exist 2>err &&
> +	test_i18ngrep "cannot run" err
>  '

This one is already correct before the patch, but I agree it's a good
idea to test it. Here (and in the others), grepping for "does-not-exist"
would be slightly more robust against us later changing the error
message, but it's probably not a big deal in practice.

Thanks again for a quick fix for my bug.

-Peff
