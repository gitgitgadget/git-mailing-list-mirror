Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A7C1FCA5
	for <e@80x24.org>; Fri, 30 Dec 2016 00:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbcL3Asu (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 19:48:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:33164 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753019AbcL3Ast (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 19:48:49 -0500
Received: (qmail 32633 invoked by uid 109); 30 Dec 2016 00:48:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Dec 2016 00:48:49 +0000
Received: (qmail 26964 invoked by uid 111); 30 Dec 2016 00:49:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Dec 2016 19:49:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Dec 2016 19:48:45 -0500
Date:   Thu, 29 Dec 2016 19:48:45 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] remote helpers: avoid blind fall-back to ".git" when
 setting GIT_DIR
Message-ID: <20161230004845.rknafqsyosmyr6z2@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
 <20161122004421.GA12263@google.com>
 <20161122024102.otlnl6jcrb3pejux@sigill.intra.peff.net>
 <20161230001114.GB7883@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161230001114.GB7883@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2016 at 04:11:14PM -0800, Jonathan Nieder wrote:

> Thanks.  Here's the patch again, now with commit messages and a test.
> Thanks for the analysis and sorry for the slow turnaround.

Thanks for following up. While working on a similar one recently, I had
the nagging feeling that there was a case we had found that was still to
be dealt with, and I think this was it. :)

The patch to the C code looks good. I have a few comments on the tests:

> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index aeb3a63f7c..a86fca3e6c 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -34,6 +34,21 @@ test_expect_success 'clone http repository' '
>  	test_cmp file clone/file
>  '
>  
> +test_expect_success 'list refs from outside any repository' '
> +	cat >expect <<-EOF &&
> +	$(git rev-parse master)	HEAD
> +	$(git rev-parse master)	refs/heads/master
> +	EOF
> +	mkdir lsremote-root &&
> +	(
> +		GIT_CEILING_DIRECTORIES=$(pwd) &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd lsremote-root &&
> +		git ls-remote "$HTTPD_URL/dumb/repo.git" >../actual
> +	) &&
> +	test_cmp expect actual
> +'

Since my recent de95302a4c (t5000: extract nongit function to
test-lib-functions.sh, 2016-12-15), this can be shortened to:

  cat >expect <<-EOF &&
  ...
  EOF
  nongit git ls-remote "$HTTPD_URL/dumb/repo.git" >actual &&
  test_cmp expect actual

I think that commit is in 'master' now.

Without my patch to die() in setup_git_env(), I think this would pass
with or without your patch, right?  I think the current behavior _is_
buggy, but a setup to show off the improvement would be so arcane that I
don't think it is worth it. E.g., something like:

  echo '[http]extraHeader = "Foo: Bar" >nongit/.git/config

would probably trigger the use of that config when it shouldn't. But
that's really stretching.

> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 6e5b9e42fb..7ba894f0f4 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -163,6 +163,21 @@ test_expect_success 'redirects send auth to new location' '
>  	expect_askpass both user@host auth/smart/repo.git
>  '
>  
> +test_expect_success 'list refs from outside any repository' '
> +	cat >expect <<-EOF &&
> +	$(git rev-parse master)	HEAD
> +	$(git rev-parse master)	refs/heads/master
> +	EOF
> +	mkdir lsremote-root &&
> +	(
> +		GIT_CEILING_DIRECTORIES=$(pwd) &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd lsremote-root &&
> +		git ls-remote "$HTTPD_URL/smart/repo.git" >../actual
> +	) &&
> +	test_cmp expect actual
> +'

Is this really testing anything that the dumb one isn't? The interesting
bit is in invoking git-remote-http, not what it does under the hood. I
don't mind too much being thorough, but if we are going to go that route
we should probably come up with a standard battery of tests for dumb
and smart HTTP, and then invoke them for each case without having to
write each one twice.

> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> index 225a022e8a..4573d98e6c 100755
> --- a/t/t5570-git-daemon.sh
> +++ b/t/t5570-git-daemon.sh
> @@ -35,6 +35,21 @@ test_expect_success 'clone git repository' '
>  	test_cmp file clone/file
>  '
>  
> +test_expect_success 'list refs from outside any repository' '
> +	cat >expect <<-EOF &&
> +	$(git rev-parse master)	HEAD
> +	$(git rev-parse master)	refs/heads/master
> +	EOF
> +	mkdir lsremote-root &&
> +	(
> +		GIT_CEILING_DIRECTORIES=$(pwd) &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd lsremote-root &&
> +		git ls-remote "$GIT_DAEMON_URL/repo.git" >../actual
> +	) &&
> +	test_cmp expect actual
> +'

This one isn't actually broken now, right? The test is just there to
catch future regressions?

If we are being thorough, then would we also care about file-local
repos, git-over-ssh, etc?

> diff --git a/t/t5802-connect-helper.sh b/t/t5802-connect-helper.sh
> index c6c2661878..7232032cd2 100755
> --- a/t/t5802-connect-helper.sh
> +++ b/t/t5802-connect-helper.sh

This one is quite a big addition. I know this falls under the "while
we're at it" line at the end of your commit message, but maybe it's
worth pulling the GIT_EXT_SERVICE bits out into their own patch (and
explaining briefly what's going on; I had to go look up what
GIT_EXT_SERVICE_NOPREFIX even was).

-Peff
