Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CB1E7C4C1
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 14:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjJDOUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjJDOUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 10:20:09 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C59AB
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 07:20:05 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:54960)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qo2jM-00H4de-BV; Wed, 04 Oct 2023 08:20:04 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:59696 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qo2jL-002g9l-8z; Wed, 04 Oct 2023 08:20:03 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20231003202504.GA7697@coredump.intra.peff.net>
        <878r8j2mu1.fsf@email.froward.int.ebiederm.org>
        <20231004132132.GC607079@coredump.intra.peff.net>
Date:   Wed, 04 Oct 2023 09:19:40 -0500
In-Reply-To: <20231004132132.GC607079@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 4 Oct 2023 09:21:32 -0400")
Message-ID: <871qea31xf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qo2jL-002g9l-8z;;;mid=<871qea31xf.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+MULtwW57Bz1UdAArVrB4gfiiOqlilyeI=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Is SANITIZE=leak make test unreliable for anyone else?
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 03, 2023 at 08:33:26PM -0500, Eric W. Biederman wrote:
>
>> My big question is:
>> 
>>     Do other people see random test failures when SANITIZE=leak is enabled?
>> 
>> Is it just me?
>
> Yes, I've seen this. You mentioned that you were testing with v2.42,
> which lacks 370ef7e40d (test-lib: ignore uninteresting LSan output,
> 2023-08-28). Try using the current version of 'master', or just
> cherry-picking that commit onto v2.42.
>
> A few other tips to avoid confusing results (though they at least do not
> vary from run to run):
>
>   - use the LEAK_LOG option, since you otherwise miss some cases (it
>     looks like you already are from what you posted above)
>
>   - gcc and clang sometimes produce different results. Right now I get
>     no leak from gcc on t9004, but clang reports one (I think clang is
>     right here)
>
>   - turn off compiler optimizations; we've had cases where code
>     reordering/removal creates false positives. Oh, hmm, I forgot we do
>     this by default since d3775de074 (Makefile: force -O0 when compiling
>     with SANITIZE=leak, 2022-10-18), so your v2.42 should be covered.

I just tried master, aka commit d0e8084c65cb ("The fourteenth batch").

What I see on a random failure looks like:

> make -C t/ all
> make[1]: Entering directory '/home/user/projects/git/git/t'
> rm -f -r 'test-results'
> GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT && make aggregate-results-and-cleanup
> make[2]: Entering directory '/home/user/projects/git/git/t'
> *** t0000-basic.sh ***
> Segmentation fault
> error: test_bool_env requires bool values both for $GIT_TEST_PASSING_SANITIZE_LEAK and for the default fallback

Which doesn't sound like anything you have described so I am guessing it
is something with my environment I need to track down.

Eric
