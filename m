Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D05B211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 19:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725734AbeLBGvi (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 01:51:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:56212 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725728AbeLBGvi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 01:51:38 -0500
Received: (qmail 20740 invoked by uid 109); 1 Dec 2018 19:38:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Dec 2018 19:38:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1490 invoked by uid 111); 1 Dec 2018 19:37:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Dec 2018 14:37:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Dec 2018 14:38:22 -0500
Date:   Sat, 1 Dec 2018 14:38:22 -0500
From:   Jeff King <peff@peff.net>
To:     "H.Merijn Brand" <h.m.brand@xs4all.nl>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Do not fail test if '.' is part of $PATH
Message-ID: <20181201193822.GA28918@sigill.intra.peff.net>
References: <20181201180757.0b2d3c89@pc09.procura.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181201180757.0b2d3c89@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 01, 2018 at 06:07:57PM +0100, H.Merijn Brand wrote:

> When $PATH contains the current directory as .:PATH, PATH:., PATH:.:PATH,
> or (maybe worse) as :PATH, PATH:, or PATH::PATH - as an empty entry is
> identical to having dot in $PATH - this test used to fail

Good catch. The test cares about Git not accidentally adding "." to the
PATH, but we can't check that if it is already there.

> This patch was tested with PATH=$PATH, PATH=.:$PATH, PATH=$PATH:.,
> PATH=$PATH:.:/bin, PATH=:$PATH, PATH=$PATH:, and PATH=$PATH::/bin
> [...]
> +test_lazy_prereq DOT_IN_PATH '
> +       case ":$PATH:" in
> +       *:.:*|*::*) true  ;;
> +       *)          false ;;
> +       esac
> +'

Since the test is ultimately checking "can we run should-not-run from
the current directory", might it be simpler to actually try that as the
precondition? I.e., something like:

  test_expect_success 'create program in current directory' '
	write_script should-not-run <<-\EOF &&
	echo yikes
	EOF
  '

  test_lazy_prereq DOT_IN_PATH '
	should-not-run
  '

  test_expect_success !DOT_IN_PATH 'run_command is restricted to PATH' '
	test_must_fail test-tool run-command run-command should-not-run
  '

?

That's more lines, but we don't have to peek into the details of how
$PATH works.

-Peff
