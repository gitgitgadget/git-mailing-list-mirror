Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91361C2FC15
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 05:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347883AbjHQFMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 01:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348074AbjHQFMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 01:12:24 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC202698
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 22:12:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C25E81B2393;
        Thu, 17 Aug 2023 01:12:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PxjtoxBr+CPIreBHNKtxtEdaSfXgvO/68CwFni
        N2M5s=; b=MoD4W4lXYAhsLKL9dqddC4VE5d0pM7MzDXoZFHq/3q/09aiy8JI3Q5
        mlvxeXi64114NovNwlLzzWyxzX0NJJFhbMDszoZ4IVc51P8OKYsi0b63hTX24ywD
        8fQstC7wK2Pp78sXRxv6R+ujHLFjMxb3ib652oxlFvX8YYwtdd1SM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA64E1B2392;
        Thu, 17 Aug 2023 01:12:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D1ED1B2391;
        Thu, 17 Aug 2023 01:12:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] upload-pack: fix exit code when denying fetch of
 unreachable object ID
References: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
        <fe028981d353158e9840eb035194ca15e6a2c15e.1692165840.git.ps@pks.im>
        <xmqqjztvezen.fsf@gitster.g> <xmqq8rabey3v.fsf@gitster.g>
        <CABQH79pick0c1UVc+W8n2QtVmSJAjqXcJGtYSm0aahAFDNvE1g@mail.gmail.com>
Date:   Wed, 16 Aug 2023 22:12:18 -0700
In-Reply-To: <CABQH79pick0c1UVc+W8n2QtVmSJAjqXcJGtYSm0aahAFDNvE1g@mail.gmail.com>
        (Derrick Stolee's message of "Wed, 16 Aug 2023 13:16:29 -0400")
Message-ID: <xmqqa5uqckwd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3A3384C-3CBC-11EE-966A-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

[jc: the message I am responding to may not be on the list archive,
 as it was multipart/alternative with text/html in it, but I think
 the main point from you can be seen by others only from the parts
 I quoted here].

> While I don't think we should document that the exit code has
> a special meaning for the builtin, adding the test will help
> prevent another accidental change in the future. If the patch is
> worth taking (to fix the accidental change) then I think the test
> should stay, so we don't make this change accidentally again.

I think my stance is a bit more nuanced, in that the first half of
the patch to make us exit with 128 is worth taking, simply because
we did not have to and did not intend to change the exit status, but
the other half of the patch, using test_expect_code in the test
suite, sends a wrong message that somehow exact value of non-zero
exit status in this particular case matters.

To put it another way, if your patch to shuffle the calls for two
error messages, concluded with a call to exit(), were written in the
ideal world, you would have passed 128 to exit(), *and* you wouldn't
have added any test that says "fetch should exit with 128 and not 1
when it fails".  I aimed to massage Patrick's patch so that the
original patch from you will become that patch in the ideal world
when it is squashed in.

> To my view, test cases can change in the future as long as
> there is good justification in doing so. Having existing tests
> helps to demonstrate a change in behavior.

I agree with that 100%, but the thing is that the error shuffling
patch will not escape 'next' until the upcoming release, at which
time we can rewind and redo 'next'.  I think the first half of
Patrick's fix would be a good material to squash into that patch,
which would make the result identical to the one that would have
been written in the ideal world I described above.

And the other half would not have a place to be in that patch in the
ideal world.  IOW, there is no "change in behaviour" we want to
demonstrate here, as we will pretend nothing bad happened after the
upcoming release ;-)

Thanks.
