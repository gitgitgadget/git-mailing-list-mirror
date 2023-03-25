Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C045C6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 08:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCYIlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 04:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCYIlK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 04:41:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF47136C8
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 01:41:09 -0700 (PDT)
Received: (qmail 12785 invoked by uid 109); 25 Mar 2023 08:41:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Mar 2023 08:41:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12015 invoked by uid 111); 25 Mar 2023 08:41:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Mar 2023 04:41:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Mar 2023 04:41:07 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] t3070: make chain lint tester happy
Message-ID: <20230325084107.GB3738217@coredump.intra.peff.net>
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
 <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
 <20230325063731.GB562387@coredump.intra.peff.net>
 <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com>
 <20230325075832.GA579632@coredump.intra.peff.net>
 <20230325080453.GA852237@coredump.intra.peff.net>
 <CAPig+cTBwAugUL_u_SPebFRj4j1Gv6FMuH8vn+uUy=6_+GXy3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTBwAugUL_u_SPebFRj4j1Gv6FMuH8vn+uUy=6_+GXy3A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2023 at 04:18:54AM -0400, Eric Sunshine wrote:

> >   1. Say that the internal linter still has value, and tweak the
> >      suppression so it only turns off the extra per-script run of
> >      chainlint.pl, and not the internal one (which is cheap-ish to run).
> 
> This is appealing since the internal linter is nearly zero-cost,
> though doing this would not fully address the "recipe for confusion"
> since the two linters would still not be in agreement. This approach
> does have the benefit that it gives at least _some_ protection (minus
> caveats mentioned below) on platforms where it may be common to
> disable chainlint.pl due to slowness, such as Windows.

I think it's OK if they're not in agreement, as long as both are run.
Then the set of problems you need to fix is the union of their outputs.
That's conservative, but everybody gets the same answer.

The bigger confusion to me is when "make test" and "./t1234-foo.sh" do
not agree in their output, which is what happened here. Some people say
"everything is good" and some say "no, it is broken", depending on how
they ran it.

> >   2. Say that the internal linter does not have value, and we should
> >      rely on chainlint.pl. In which case we might as well ditch the
> >      internal one completely.
> 
> The value of the internal linter is fairly limited in that it only
> checks top-level &&-chain; it doesn't check inside subprocesses,
> blocks, or any compound statement (case/esac, if/fi, while/done,
> etc.).

Right, the chainlint.pl one is much more thorough. I just wondered if
there were any cases we were worried about it missing, that the internal
one catches. We found one in this thread, but as discussed, it is not a
problem (presumably chainlint.pl catches a "real" case where an
earlier line is hidden by the "&", but I wouldn't mind seeing it
complain here as a matter of style/future-proofing).

> I retained the internal linter in place "just in case" (i.e. in the
> event the script missed something legitimate), but I don't feel
> strongly about it.

Certainly the output from chainlint.pl is much nicer, too. :) I think
I'd be comfortable dropping the internal one at this point in terms of
quality. The bigger question to me is whether there are setups where it
isn't run (you mentioned Windows, but I'd have thought the
single-process invocation made things nice and fast there).

-Peff
