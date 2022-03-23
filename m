Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B763C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 22:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345107AbiCWWOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiCWWOn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 18:14:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB8EDF32
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 15:13:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17160188A39;
        Wed, 23 Mar 2022 18:13:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ftKnSm/qQs1wM2waymktzXToRZaWR/ReUxztsm
        TjvNA=; b=bhs6xSEhsU/C4kUuJ+sPHwnL9C2GyYMDY8kk3kTH6IsdZVWv+lf9cp
        4CmaKoWg5X259+9lqcspkXfpPPy/8A1/UCLz4gVUzOIVqw5FKIykGuH6l84LZmBN
        UTZsPrP0CB4RdOHfJ/hIDW6uTqJUUUBZQPS98qKI3IEKsDeLBtf4Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0EF8B188A38;
        Wed, 23 Mar 2022 18:13:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7406A188A37;
        Wed, 23 Mar 2022 18:13:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/7] test-lib: add a "test_expect_todo", similar to
 "test_expect_failure"
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
        <patch-1.7-4624abc2591-20220318T002951Z-avarab@gmail.com>
        <xmqqczij9jeg.fsf@gitster.g> <xmqq8rt77zp7.fsf@gitster.g>
        <220319.86v8waetae.gmgdl@evledraar.gmail.com>
        <xmqqilsa76ve.fsf@gitster.g>
        <220319.86ilsadw69.gmgdl@evledraar.gmail.com>
        <db558292-2783-3270-4824-43757822a389@gmail.com>
        <xmqqy2144hwa.fsf@gitster.g>
        <a9478c1b-4441-0c79-332d-a7c5592dbc70@github.com>
Date:   Wed, 23 Mar 2022 15:13:06 -0700
In-Reply-To: <a9478c1b-4441-0c79-332d-a7c5592dbc70@github.com> (Derrick
        Stolee's message of "Tue, 22 Mar 2022 10:43:23 -0400")
Message-ID: <xmqqy210pbbh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AF77F5C-AAF6-11EC-BA03-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> The thing I'm hoping to see from a final version is that a top-level
> helper like test_expect_todo will expect at least one test_todo
> helper to be executed inside of the test (perhaps communicated by
> setting a special GIT_TEST_* environment variable?) and if any of

I was hoping that we can do without test_expect_todo.
test_expect_success can turn itself into test_expect_todo when it
sees test_todo is invoked even once in it.  And Phillip's outline
actually implements the idea, if I am not mistaken.

> the test_todo lines change from fail to pass, then that is
> communicated as a _failure_ from CI's perspective. Let us discover
> if we have accidentally "fixed" any of these test cases and update
> the tests accordingly.

In other words, we do not want to lose the "TODO fixed" we have been
getting out of test_expect_failure, which I agree with.  I am not
sure if Phillip's outline had that feature.

> I can predict writing a test case with multiple test_todo lines
> that need to be updated to drop the test_todo helpers one-by-one
> as a change is being introduced.

Yes.
