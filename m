Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E37E7C4CE
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 15:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242928AbjJDPjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 11:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjJDPjB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 11:39:01 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6B2C6
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 08:38:57 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:56148)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qo3xf-00HKh4-Ph; Wed, 04 Oct 2023 09:38:55 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:56586 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qo3xe-009r35-NI; Wed, 04 Oct 2023 09:38:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20231003202504.GA7697@coredump.intra.peff.net>
        <878r8j2mu1.fsf@email.froward.int.ebiederm.org>
        <20231004132132.GC607079@coredump.intra.peff.net>
        <871qea31xf.fsf@email.froward.int.ebiederm.org>
        <20231004144734.GA1143669@coredump.intra.peff.net>
Date:   Wed, 04 Oct 2023 10:38:47 -0500
In-Reply-To: <20231004144734.GA1143669@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 4 Oct 2023 10:47:34 -0400")
Message-ID: <87o7he1jp4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qo3xe-009r35-NI;;;mid=<87o7he1jp4.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX185DV/dOpW2vD0koV1MDph7tEOyRzJ+xOs=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Is SANITIZE=leak make test unreliable for anyone else?
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 04, 2023 at 09:19:40AM -0500, Eric W. Biederman wrote:
>
>> What I see on a random failure looks like:
>> 
>> > make -C t/ all
>> > make[1]: Entering directory '/home/user/projects/git/git/t'
>> > rm -f -r 'test-results'
>> > GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT && make aggregate-results-and-cleanup
>> > make[2]: Entering directory '/home/user/projects/git/git/t'
>> > *** t0000-basic.sh ***
>> > Segmentation fault
>> > error: test_bool_env requires bool values both for $GIT_TEST_PASSING_SANITIZE_LEAK and for the default fallback
>> 
>> Which doesn't sound like anything you have described so I am guessing it
>> is something with my environment I need to track down.
>
> No, that seems different entirely. You'll have to figure out which
> program is segfaulting and why (if you can see it in a script besides
> t0000 you're probably better off, as that one is a maze of
> tests-within-tests, since it is testing the test-harness itself).
>
> Although the "error" you see maybe implies that it is failing early on
> in test-lib.sh, when we are calling "test-tool env-helper". If that is
> segfaulting there is probably something very wrong with your build.

Just to document what I am seeing it appears to be some odd interaction
with address space randomization.

If I run my make as: "setarch --addr-no-randomize make test"

I don't see coredumps any more.

Now to dig a deeper and see if I can figure out what about address space
randomization is making things break.


Eric
