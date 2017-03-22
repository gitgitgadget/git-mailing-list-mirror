Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D75E2095D
	for <e@80x24.org>; Wed, 22 Mar 2017 22:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbdCVWAG (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:00:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:49739 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbdCVWAE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:00:04 -0400
Received: (qmail 29192 invoked by uid 109); 22 Mar 2017 21:59:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 21:59:56 +0000
Received: (qmail 32377 invoked by uid 111); 22 Mar 2017 22:00:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 18:00:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 17:59:51 -0400
Date:   Wed, 22 Mar 2017 17:59:51 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jan.palus@gmail.com
Subject: Re: [PATCH] t7406: correct test case for submodule-update initial
 population
Message-ID: <20170322215951.f4xbxehzvsd64c4y@sigill.intra.peff.net>
References: <20170322213953.oddbgw5nfrvmzjgm@sigill.intra.peff.net>
 <20170322214948.12015-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170322214948.12015-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 02:49:48PM -0700, Stefan Beller wrote:

> * The syntax of the here-doc was wrong, such that the entire test was
>   sucked into the here-doc, which is why the test succeeded successfully.

As opposed to succeeding unsuccessfully? :)

> * The variable $submodulesha1 was not expanded as it was inside a single
>   quoted string. Use double quote to expand the variable.

Hmm. Sort of. It was inside a non-interpolating here-doc inside a
single-quoted string which was being eval'd. The second half is fine
(the eval adds an extra layer of evaluation).

Your fix:

> +	cat >expect <<-\EOF &&
> +	Execution of '\'"false $submodulesha1"\'' failed in submodule path '\''submodule'\''
> +	EOF

_does_ work, but it does so because it's evaluating $submodulesha1 in
the shell snippet and handing the result off to test_expect_success to
eval. So it would have problems if:

  - that variable contained "\nEOF\n" itself ;)

  - the variable was modified inside the shell snippet.

Neither of those is true, but I think:

  cat >expect <<-EOF &&
  Execution of '\''false $submodulesha1'\'' failed in ...
  EOF

is safer and less surprising. The single-quote handling is unfortunate and
ugly, but necessary to get them into the shell snippet in the first
place. I notice the others tests in this script set up the expect file
outside of a block. You could also do something like:

  sq=\'
  test_expect_success '...' '
	cat >expect <<-EOF
	Execution of ${sq}false $submodulesha1${sq} ...
  '

but I'm not sure if that is any more readable.

-Peff
