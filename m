Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B70EE6457
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 11:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjIOL3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 07:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjIOL3P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 07:29:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543E189
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 04:29:09 -0700 (PDT)
Received: (qmail 10715 invoked by uid 109); 15 Sep 2023 11:29:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Sep 2023 11:29:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1425 invoked by uid 111); 15 Sep 2023 11:29:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Sep 2023 07:29:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Sep 2023 07:29:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/2] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
Message-ID: <20230915112906.GA3125427@coredump.intra.peff.net>
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
 <64825651-00d2-d2c5-2da2-91a9917bef21@gmail.com>
 <20230912082742.GB1630538@coredump.intra.peff.net>
 <2890b210-c42f-41cf-e676-0b1c56310f73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2890b210-c42f-41cf-e676-0b1c56310f73@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 02:28:15AM +0200, Rubén Justo wrote:

> > And the problem is in (3). You switch it to trigger only if we have no
> > failures (fixing the inversion). But should we have the same a/b split
> > for this case? I.e.:
> > 
> >   3a. if we saw no test failures, invert to cause a failure
> >   3b. we saw other failures; do not invert, but _do_ mention that the
> >       log found extra leaks
> > 
> > In 3b we are explaining to the user what happened. Though maybe it is
> > not super important, because I think we'd have dumped the log contents
> > anyway?
> 
> I think so too.  At that point we've already dumped the contents of the
> $TEST_RESULTS_SAN_FILE file.
> 
> IMO, when $test_failure is zero (the "if" I'm touching), the message
> makes sense not so much to say that a leak has been found, but rather
> because we're forcing the non-zero exit.
> 
> But when $test_failure is not zero, after we've already dumped the
> log, maybe this is somewhat redundant:
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 87cfea9e9a..b160ae3f7a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1267,6 +1267,8 @@ check_test_results_san_file_ () {
>         then
>                 say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!" &&
>                 invert_exit_code=t
> +       else
> +               say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak"
>         fi
>  }
> 
> However, if you or anyone else thinks it adds value, I have no objection
> to re-roll with it.

I'm on the fence. It is probably not a big deal, and my biggest issue is
just that I had to walk through the explanation in my previous mail to
convince myself the change was not missing an important case.

But having done so, the main value in re-rolling would be preventing
somebody else from reading the code and having the same question. But
this discussion in the archive is probably sufficient.

-Peff
