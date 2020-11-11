Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74202C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165412072C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKKRhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:37:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:54754 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgKKRhm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 12:37:42 -0500
Received: (qmail 13484 invoked by uid 109); 11 Nov 2020 17:37:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Nov 2020 17:37:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17537 invoked by uid 111); 11 Nov 2020 17:37:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Nov 2020 12:37:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Nov 2020 12:37:38 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 0/5] Remove now-unused git-parse-remote
Message-ID: <20201111173738.GB9902@coredump.intra.peff.net>
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
 <20201111151754.31527-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111151754.31527-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 04:17:49PM +0100, Ævar Arnfjörð Bjarmason wrote:

> I started poking at removing .git/branches from the default template,
> which I had a patch for until I noticed Johannes's old[1] series.
> 
> In any case, this is one thing that came out of that
> investigation. The code we're keeping by moving it to git-submodule.sh
> can also be replaced by some C code we have, but I wanted to leave
> that to another submission (if I'll get to it), and make this simply a
> code removal.

I'm happy to see unused code go away in general, but this raises a
question: what promises have we made to end-user scripts about this
library being available?

We do install it, including a manpage which claims you can do:

  . "$(git --exec-path)/git-parse-remote"

though it does not actually document any particular functions being
available. It looks like we've removed functions before without warning
(e.g., 1a92777504 (git-request-pull: open-code the only invocation of
get_remote_url, 2011-03-01)).

I'm just wondering if we need to have any kind of warning or deprecation
period.

To be clear, I find it pretty unlikely that anybody is using the rather
esoteric functions in this file, but that's usually when I get most
surprised. :)

>  .gitignore                         |  1 -
>  Documentation/git-parse-remote.txt | 23 -------
>  Makefile                           |  2 -
>  command-list.txt                   |  1 -
>  git-parse-remote.sh                | 98 ------------------------------
>  git-submodule.sh                   |  8 ++-
>  6 files changed, 7 insertions(+), 126 deletions(-)
>  delete mode 100644 Documentation/git-parse-remote.txt

I expected to see a "delete" line for git-parse-remote.sh here. I
thought at first maybe you were leaving the empty shell so that people
could continue to source it (keeping the promise in the manpage, but not
providing any actual functions). But it looks like the final patch stops
building it at all, leaving the now-useless source file.

-Peff
