Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DD9C636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 17:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjBGR4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 12:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjBGR4J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 12:56:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39B376BC
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 09:56:07 -0800 (PST)
Received: (qmail 10962 invoked by uid 109); 7 Feb 2023 17:56:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Feb 2023 17:56:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22994 invoked by uid 111); 7 Feb 2023 17:56:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Feb 2023 12:56:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Feb 2023 12:56:06 -0500
From:   Jeff King <peff@peff.net>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Message-ID: <Y+KQtqNPews3vBS8@coredump.intra.peff.net>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 05, 2023 at 03:46:21AM +0000, John Cai via GitGitGadget wrote:

> +`diff-algorithm`
> +^^^^^^^^^^^^^^^^
> +
> +The attribute `diff-algorithm` affects which algorithm Git uses to generate
> +diffs. This allows defining diff algorithms per file extension. Precedence rules
> +are as follows, in order from highest to lowest:
> +
> +*Command line option*
> +
> +Pass in the `--diff-algorithm` command line option int git-diff(1)
> +
> +*Git attributes*
> +
> +------------------------
> +*.json	diff-algorithm=histogram
> +------------------------
> +
> +*Git config*
> +
> +----------------------------------------------------------------
> +[diff]
> +	algorithm = histogram
> +----------------------------------------------------------------

From the user's perspective, this is weirdly inconsistent with the
existing diff attributes, which would be more like:

  # in .gitattributes
  *.json diff=json 

  # in config
  [diff "json"]
  algorithm = histogram

I know why one might choose the scheme you did; it kicks in if the repo
sets the algorithm, without users having to set up any extra config.
Which is sort of nice, if we assume that malicious actors don't have any
incentive to pick the algorithm. In theory they don't, though I saw Ævar
mention possible DoS elsewhere in the thread.

  Side note: It's also possible that algorithm selection could be
  required to trigger a separate security bug (say, a buffer overflow in
  the patience code or something), so restricting that works in a
  belt-and-suspenders way. But that somehow feels like like the wrong
  side of the paranoia-vs-feature line.

So I dunno. I recognize that this scheme fulfills your immediate needs
better, but I fear that we'll be stuck with a weird split between "diff"
and "diff-*" attributes forever. In the long run, having a way for the
repo to say "and here is some config I recommend to you" would give you
the best of both, but that is a challenging topic that has been
discussed and punted on for many years.

-Peff
