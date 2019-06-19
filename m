Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5E71F462
	for <e@80x24.org>; Wed, 19 Jun 2019 03:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfFSD7A (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 23:59:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:59212 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726689AbfFSD7A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 23:59:00 -0400
Received: (qmail 24087 invoked by uid 109); 19 Jun 2019 03:59:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 03:59:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20602 invoked by uid 111); 19 Jun 2019 03:59:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Jun 2019 23:59:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2019 23:58:58 -0400
Date:   Tue, 18 Jun 2019 23:58:58 -0400
From:   Jeff King <peff@peff.net>
To:     Boxuan Li <liboxuan@connect.hku.hk>
Cc:     git@vger.kernel.org, j6t@kdbg.org, gitster@pobox.com
Subject: Re: [RFC PATCH] userdiff: ship built-in driver config file
Message-ID: <20190619035857.GB515@sigill.intra.peff.net>
References: <20190617165450.81916-1-liboxuan@connect.hku.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190617165450.81916-1-liboxuan@connect.hku.hk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 12:54:50AM +0800, Boxuan Li wrote:

> A few notes and questions:
> 1. In [diff "tex"] section, \x80 and \xff cannot be parsed by git config parser.
> I have no idea why this is happening. I changed them to \\x80 and \\xff as a workaround, which
> resulted in t4034 failure (See https://travis-ci.org/li-boxuan/git/jobs/546729906#L4679).
> 2. I am not sure how and where I can free the memory allocated to "builtin_drivers".
> 3. When I run `git format-patch HEAD~1`, core dump happens occasionally. Seems
> no test case caught this problem. Till now, I have no luck finding out the reason.

I couldn't replicate it with a simple test, but perhaps running under
valgrind or "make SANITIZE=address" would help?

> diff --git a/templates/this--userdiff b/templates/this--userdiff
> new file mode 100644
> index 0000000000..85114a7229
> --- /dev/null
> +++ b/templates/this--userdiff
> @@ -0,0 +1,164 @@
> +[diff "ada"]
> +	xfuncname = "!^(.*[ \t])?(is[ \t]+new|renames|is[ \t]+separate)([ \t].*)?$\n"
> +	xfuncname = "!^[ \t]*with[ \t].*$\n"
> +	xfuncname = "^[ \t]*((procedure|function)[ \t]+.*)$\n"
> +	xfuncname = "^[ \t]*((package|protected|task)[ \t]+.*)$"

While having separate lines that get joined here does make the result
easier to read, I think it creates some confusion. diff.*.xfuncname in a
regular config file _doesn't_ behave this way (it's the usual
last-one-wins, so we expect a single string). You've handled this
specially in your code to read this file, but it's confusing because
this test otherwise looks exactly like a config file. And thus somebody
might be tempted to copy it to their config file and modify it, but it
would not do what they expected.

I don't recall how well our config parser copes with embedded newlines
in values.  I.e., if it would be possible to write:

  [diff "foo"]
  xfuncname = "the pattern starts here...
  and continues through newlines!"

I think it doesn't work, but perhaps it would be a nice feature to add
it. It would make the format slightly more complex, though (and make
diagnosing a missing double-quote much harder). I dunno.

-Peff
