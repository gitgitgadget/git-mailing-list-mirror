Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C1AC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87BA721D79
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKT4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:56:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:55040 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgIKT4X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 15:56:23 -0400
Received: (qmail 3585 invoked by uid 109); 11 Sep 2020 19:56:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2020 19:56:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7268 invoked by uid 111); 11 Sep 2020 19:56:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2020 15:56:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Sep 2020 15:56:22 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
Subject: Re: [PATCH 1/4] clone: add tests for --template and some disallowed
 option pairs
Message-ID: <20200911195622.GB2697399@coredump.intra.peff.net>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
 <4cdcedff313751da8c91d701c095f1051e759ce2.1599848727.git.gitgitgadget@gmail.com>
 <8f864b6c-4b05-a9d6-b649-5f7c50697730@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f864b6c-4b05-a9d6-b649-5f7c50697730@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 02:57:11PM -0400, Derrick Stolee wrote:

> > diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> > index e69427f881..d20a78f84b 100755
> > --- a/t/t5606-clone-options.sh
> > +++ b/t/t5606-clone-options.sh
> > @@ -19,6 +19,50 @@ test_expect_success 'clone -o' '
> >  
> >  '
> >  
> > +test_expect_success 'disallows --bare with --origin' '
> > +
> > +	test_expect_code 128 git clone -o foo --bare parent clone-bare-o 2>err &&
> > +	test_debug "cat err" &&
> > +	test_i18ngrep "\-\-bare and --origin foo options are incompatible" err
> > +
> > +'
> 
> It seems that all of your tests have an extraneous newline
> at the end.

And the beginning. :)

It's matching the surrounding test, which are written in an older
inconsistent style. I think it's OK to match them, but cleaning them
would be welcome, too.

While I'm looking at this hunk, two other things:

 - do we really care about code 128, or just failure? test_must_fail
   might be a better choice

 - I didn't even know we had test_debug. ;) The last time somebody added
   a call to it was in 2012. I think it's being used as intended here,
   but I'm not sure that the clutter to the test is worth it (we have
   other tools like "-i" to stop at the right spot and let you inspect
   the broken state).

 - the backslash escapes confused me for a moment. I guess they are
   trying to hide the dashes from grep's option parser. That's OK,
   though I'd have probably just started with "bare" since we're
   matching a substring anyway. I think you could also use "-e" with
   test_i18ngrep.

-Peff
