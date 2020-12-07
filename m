Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF764C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 17:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D99A2388C
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 17:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgLGRDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 12:03:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:54972 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgLGRDX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 12:03:23 -0500
Received: (qmail 8475 invoked by uid 109); 7 Dec 2020 17:02:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Dec 2020 17:02:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23715 invoked by uid 111); 7 Dec 2020 17:02:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Dec 2020 12:02:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Dec 2020 12:02:42 -0500
From:   Jeff King <peff@peff.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org
Subject: Re: `git grep` is too picky about option parsing
Message-ID: <X85gMs1gPBNLff7f@coredump.intra.peff.net>
References: <704q5rs6-63q1-sp78-9845-227oq8q42o8q@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <704q5rs6-63q1-sp78-9845-227oq8q42o8q@vanv.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 06, 2020 at 11:12:43PM +0100, Jan Engelhardt wrote:

> -e, -i, -l and -n are all valid options for grep as well as git grep,
> yet git-grep refuses to operate if they appear in a specific order.
> 
> Observed:
> 
> $ git grep -e abc -lin
> error: did you mean `--lin` (with two dashes)?
> 
> Expected:
> 
> $ git grep -e abc -lin
> somefile

Hrm. This is falling afoul of the typo-detection added by 3a9f0f41db
(parse-options: catch likely typo in presense of aggregated options.,
2008-01-26), which wonders if you meant "--line-number" (we allow long
options to be prefixes, so --lin is a synonym; the double irony is that
"-n" is also a synonym here). A few other simplified examples:

  # works; not a prefix of a long option
  git grep -lni foo

  # does not work; prefix of --line-number
  git grep -lin foo

  # works; we require 3 characters before we complain
  git grep -li foo

The problem is that it gives bundled short options a lower precedence
than detecting possible typos against long options. My instinct is to
say that this is wrong. We should allow valid things to work, and only
add error heuristics if the user's request is nonsense (i.e., if one of
the bundled options is not a valid one). But that actually contradicts
the original example given in 3a9f0f41db! There it was trying to make:

  git commit -amend

an error. But that's a set of valid options, the same as:

  git commit -a -m end

So we'd be losing that protection. Another option would be to make the
typo-checker a little more picky:

  - require more than 3 characters; this is just punting off the
    problem, though. Doing "-line foo" is valid. So is "-linefoo", for
    that matter, though that one would do what we want since it stops
    being a prefix.

  - be more aggressive about how much of a long option we match in the
    prefix (at least for the typo checker). "lin" is an awfully small
    part of "line-number". People may plausibly use "--lin" or "--line"
    as a shortcut, but I'm not sure that merits blocking the valid
    "-lin" for the typo-checker.

Either of those would let "-amend" continue to be an error, but fix
"-lin".

-Peff
