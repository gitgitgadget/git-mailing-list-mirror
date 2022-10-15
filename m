Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E256C4332F
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 18:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJOSNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 14:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJOSNk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 14:13:40 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924DE402E5
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 11:13:38 -0700 (PDT)
Received: (qmail 19387 invoked by uid 109); 15 Oct 2022 18:13:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 Oct 2022 18:13:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11985 invoked by uid 111); 15 Oct 2022 18:13:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Oct 2022 14:13:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 Oct 2022 14:13:37 -0400
From:   Jeff King <peff@peff.net>
To:     Jonas Bernoulli <jonas@bernoul.li>
Cc:     git@vger.kernel.org
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
Message-ID: <Y0r4US7AKxT/BLiY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a65xrnwz.fsf@bernoul.li>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 15, 2022 at 06:50:36PM +0200, Jonas Bernoulli wrote:

> > We're not getting anything useful from the "list | cut -f2"
> > invocation that we couldn't get from "foreach 'echo $sm_path'".
> 
> But we get speed (this is with about one hundred modules):
> 
> $ time git submodule foreach -q 'echo $sm_path' > /dev/null
> 
> real    0m0.585s
> user    0m0.413s
> sys     0m0.182s
> 
> $ time git submodule--helper list > /dev/null
> 
> real    0m0.008s
> user    0m0.004s
> sys     0m0.004s

Yeah, that's not too surprising that it's slower. It's exec-ing a bunch
of shells to do that.

I don't really use submodules and haven't worked much on them either,
but maybe one of these works:

  - the output of the old "submodule--helper list" looks a lot like
    "ls-files" dumping the index and filtering on submodule entries.
    Running:

       git ls-files -s | grep ^160000

    produces the same output.

  - If you just want the oid/path of each, then "git submodule status"
    prints those. You might want "--cached" to avoid spending extra time
    checking the status (though it kind of looks like we may run "git
    describe" in each anyway; yikes!)

I'm not sure if those are exactly equivalent, either. It looks like the
old code was probably respecting submodule active markers (though in my
test repo without the submodule actually checked out, it's still
reported). There is probably room for a user-facing "git submodule list"
command, but again, I don't really know enough about the space to say
what it should report.

-Peff
