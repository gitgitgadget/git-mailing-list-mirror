Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD1D1F424
	for <e@80x24.org>; Thu, 29 Mar 2018 11:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeC2LTS (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 07:19:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:47138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752489AbeC2LTR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 07:19:17 -0400
Received: (qmail 985 invoked by uid 109); 29 Mar 2018 11:19:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 11:19:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17208 invoked by uid 111); 29 Mar 2018 11:20:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 07:20:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 07:19:15 -0400
Date:   Thu, 29 Mar 2018 07:19:15 -0400
From:   Jeff King <peff@peff.net>
To:     Erik E Brady <brady@cisco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] credential: cred helper fast exit can cause SIGPIPE,
 crash
Message-ID: <20180329111915.GA30797@sigill.intra.peff.net>
References: <20180328222051.23684-1-brady@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180328222051.23684-1-brady@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 03:20:51PM -0700, Erik E Brady wrote:

> Subject: Re: [PATCH] credential: cred helper fast exit can cause SIGPIPE, crash

Thanks for sending this. The patch itself looks good to me, but I have a
few nits with your commit message.

We usually write commit messages in the imperative, with the subject
summarizing the change. So:

  Subject: credential: ignore SIGPIPE when writing to credential helpers

or similar.

> credential.c, run_credential_helper(): now ignores SIGPIPE
> when writing to credential helper.  Avoids problem with race
> where cred helper exits very quickly and, after, git tries
> to write to it, generating SIGPIPE and crashing git.  To
> reproduce this the cred helper must not read from STDIN.

We can stop being terse outside of the subject line. :) I'd probably
write something like:

  The credential subsystem can trigger SIGPIPE when writing to an
  external helper if that helper closes its stdin before reading the
  whole input. Normally this is rare, since helpers would need to read
  that input to make a decision about how to respond, but:

    1. It's reasonable to configure a helper which blindly a "get"
       answer, and trigger it only for certain hosts via config like:

         [credential "https://example.com"]
	 helper = "!get-example-password"

    2. A broken or misbehaving helper might exit immediately. That's an
       error, but it's not reasonable for it to take down the parent Git
       process with SIGPIPE.

  Even with such a helper, seeing this problem should be rare. Getting
  SIGPIPE requires the helper racily exiting before we've written the
  fairly small credential output.

Feel free to steal or adapt any of that as you see fit.

> This was seen with a custom credential helper, written in
> Go, which ignored the store command (STDIN not read) and
> then did a quick exit.  Even with this fast helper the race
> was pretty rare, ie: was only seen on some of our older VM's
> running 2.6.18-416.el5 #1 SMP linux for whatever reason.  On
> these VM's it occurred only once every few hundred git cmds.
> ---

Missing signoff. See Documentation/SubmittingPatches, especially the
'sign-off' and 'dco' sections.

>  credential.c | 3 +++
>  1 file changed, 3 insertions(+)

No test, but I think that's fine here. Any such test would be inherently
racy.

> @@ -227,8 +228,10 @@ static int run_credential_helper(struct credential *c,
>  		return -1;
>  
>  	fp = xfdopen(helper.in, "w");
> +	sigchain_push(SIGPIPE, SIG_IGN);
>  	credential_write(c, fp);
>  	fclose(fp);
> +	sigchain_pop(SIGPIPE);

This looks like the right place to put the push/pop (as you noted
before, we may not write until fclose flushes, so it definitely has to
go after that).

Thanks again for digging this up. It's pretty subtle. :)

-Peff
