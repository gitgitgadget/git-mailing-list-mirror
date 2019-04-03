Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA7720248
	for <e@80x24.org>; Wed,  3 Apr 2019 22:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfDCWVP (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 18:21:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56506 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDCWVO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 18:21:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67E9314B67C;
        Wed,  3 Apr 2019 18:21:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:date:message-id:mime-version:content-type;
         s=sasl; bh=OOP2A4Ov/BJhF7XliLBpCIr7Eqc=; b=SY4egRGEza169axfTX9v
        JVAgyNuaGCLhUBg7fmwcdmZ+4DGR2ruEVl1sIJ01I25AIiFjOSLqQJadsGJYumAw
        3nkbI+XJjfWUFiarkFd3fdK04bQcHTOm0Nc6jlumYhQOlLeG0Cq+sPP/wFXVRSlo
        o0phbjmDQno/bLIaEzZlVEw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6098314B67B;
        Wed,  3 Apr 2019 18:21:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:date:message-id:mime-version:content-type;
 s=mesmtp; bh=arqYtAFf5GjkV4uRLGMlun4L0BvkyGQkt6mRHJ0nAzM=;
 b=JAGD59dhcoAAI6Xd8PdhPt1MWyJQ+cx2O+JJXLQsPFRD4aXXXZhmSzVzK8x+k84R/nPhPTAl/2JAtyDKFRetgNjtUMu1DdEpqsLVH1nrrxetTH+kBBhv6y3A+jgHHVH5RQ/fF8NOZupcvUEd1MZTNPE5Mrztn8bZl5kH2l5vCAM=
Received: from localhost (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E31BC14B67A;
        Wed,  3 Apr 2019 18:21:11 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, debian@onerussian.com
Subject: Re: [PATCH v2 2/4] t3000: move non-submodule repo test to separate file
In-Reply-To: <xmqqlg0rsent.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 03 Apr 2019 18:21:11 -0400
Message-ID: <87d0m2bui0.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9863B16-565E-11E9-81B4-DF19F34BB12D-24757444!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Kyle Meyer <kyle@kyleam.com> writes:
>
>> a2d5156c2b (resolve_gitlink_ref: ignore non-repository paths,
>> 2016-01-22) added a test to t3000-ls-files-others.sh to check that
>> 'ls-files -o' does not die() when given a subdirectory that looks like
>> a repository but is actually a subdirectory containing a bogus .git
>> file.
>>
>> Move this test to a separate file in preparation for testing scenarios
>> with non-submodule repositories that are not bogus.
>
> It is unclear to me why this is needed.

It's not needed.  My thinking, which I didn't do a good job of spelling
out above, is

    We're going to be adding a test that checks how 'ls-files -o'
    handles a few different scenarios involving untracked repositories.
    This new test should go into a separate file rather than
    t3000-ls-files-others.sh because it substantially changes the shared
    directory layout that the t3000 tests work on.  Like the upcoming
    test, the "non-submodule .git" test from t3000 deals with a (bogus)
    untracked repository, so let's split it off into a separate test
    file that will be extended with the other scenarios.

Perhaps that's not a good reason to touch t3000, though.  I could drop
this patch, as well as the next one, and just add the new test file in
the final patch.

>> +++ b/t/t3009-ls-files-others-nonsubmodule.sh
>> @@ -0,0 +1,21 @@
>> +#!/bin/sh
>> +
>> +test_description='test git ls-files --others with non-submodule repositories'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup: expected output' '
>> +	cat >expected <<-EOF
>> +	expected
>> +	output
>> +	EOF
>> +'
>
> I think this is overkill.  Usually we have one expectation for a
> single test, so having the above inside the actual test below makes
> more sense.

OK, I'll move this into the test.
