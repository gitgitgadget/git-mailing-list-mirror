Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36EE11FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbcLHSxf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:53:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:53785 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752999AbcLHSxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:53:34 -0500
Received: (qmail 25888 invoked by uid 109); 8 Dec 2016 18:53:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Dec 2016 18:53:29 +0000
Received: (qmail 12007 invoked by uid 111); 8 Dec 2016 18:54:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Dec 2016 13:54:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2016 13:53:27 -0500
Date:   Thu, 8 Dec 2016 13:53:27 -0500
From:   Jeff King <peff@peff.net>
To:     vi0oss <vi0oss@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned
 submodules
Message-ID: <20161208185326.osknwhc654sqaq3t@sigill.intra.peff.net>
References: <20161208003940.28794-1-vi0oss@gmail.com>
 <CAGZ79kZU401JRp4EtwTGHzk3Zq+snQhX3GArDfF6SpKxsSwtWg@mail.gmail.com>
 <20161208174633.bsktiflql6jpn5t3@sigill.intra.peff.net>
 <d445a6c3-5375-22cf-4f03-1717559f1157@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d445a6c3-5375-22cf-4f03-1717559f1157@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2016 at 09:04:46PM +0300, vi0oss wrote:

> Why Git test use &&-chains instead of proper "set -e"?

Because "set -e" comes with all kinds of confusing corner cases. Using
&& chains is annoying, but rarely surprising.

One of my favorite examples is:

  set -e
  (
    false
    echo 1
  ) || {
    echo outcome=$?
    false
  }
  echo 2

which prints both "1" and "2".

Inside the subshell, "set -e" has no effect, and you cannot re-enable it
by setting "-e" (it's suppressed entirely because we are on the
left-hand side of an || conditional).

So you could write a function like this:

  foo() {
    do_one
    do_two
  }

that relies on catching the failure from do_one. And it works here:

  set -e
  foo

but not here:

  set -e
  if foo then
    do_something
  fi

And there's no way to make it work without adding back in the
&&-chaining.

-Peff
