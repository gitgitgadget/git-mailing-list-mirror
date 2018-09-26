Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236F31F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeI0Bfh (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 21:35:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:60558 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726304AbeI0Bfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 21:35:37 -0400
Received: (qmail 19941 invoked by uid 109); 26 Sep 2018 19:21:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Sep 2018 19:21:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21413 invoked by uid 111); 26 Sep 2018 19:20:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 26 Sep 2018 15:20:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2018 15:21:09 -0400
Date:   Wed, 26 Sep 2018 15:21:09 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Alexander Pyhalov <apyhalov@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t7005-editor: quote filename to fix whitespace-issue
Message-ID: <20180926192109.GE30680@sigill.intra.peff.net>
References: <20180926121107.GH27036@localhost>
 <20180926161411.10697-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180926161411.10697-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 06:14:11PM +0200, Martin Ågren wrote:

> diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
> index b2ca77b338..5fcf281dfb 100755
> --- a/t/t7005-editor.sh
> +++ b/t/t7005-editor.sh
> @@ -112,7 +112,7 @@ do
>  done
>  
>  test_expect_success 'editor with a space' '
> -	echo "echo space >\$1" >"e space.sh" &&
> +	echo "echo space >\"\$1\"" >"e space.sh" &&
>  	chmod a+x "e space.sh" &&
>  	GIT_EDITOR="./e\ space.sh" git commit --amend &&

I was actually puzzled how SHELL_PATH matters here at all, since the
resulting script does not mention it.

What happens is that we first try to execve("./e space.sh"), can get
ENOEXEC. And then we resort to passing it to the shell, which then uses
historical shell magic (which apparently predates the invention of #!
entirely!) to decide to run it as a script using the current shell. And
that shell is selected via the SHELL_PATH at build time (and not the
$SHELL_PATH we have in our environment here).

So I think this fix and the explanation are correct. I do think it would
be a lot less subtle (and a lot more readable) as:

  write_script "e space.sh" <<-\EOF &&
  echo space >"$1"
  EOF

but that is orthogonal to what you're fixing.

-Peff
