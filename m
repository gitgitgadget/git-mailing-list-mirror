Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D46FC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 19:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbiCGTlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 14:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiCGTlY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 14:41:24 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF392AC67
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 11:40:29 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6726012D31B;
        Mon,  7 Mar 2022 14:40:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mPmPnLNZGafgx5JHdiHfxIKz35OgheIQjqeyzV
        Bnqdw=; b=O7tJXfR/HoJ9jOrBisQ3HCOk86+dPUAddH7JWXKAahD4v7eT0/x3nx
        UEQo8EyfW6E2l/FUsbXzEIaOrO9ZX8W0BeR8pW6vBmBMKHZySEBLb0nd3zHXbFWf
        iHozcDRr8KDzwVbE6Le/XwlRogS0gkVvYGEy0/NJ/7iPq5fISOqdc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E5FE12D31A;
        Mon,  7 Mar 2022 14:40:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9A5512D318;
        Mon,  7 Mar 2022 14:40:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
Subject: Re: [PATCH 11/11] bundle: unbundle promisor packs
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
        <xmqqzgm5wafu.fsf@gitster.g>
        <ee6c7a5b-63e8-af1c-fdb7-75dca9cd798d@github.com>
        <xmqqv8wpu2fq.fsf@gitster.g>
        <85d434f8-0eb1-c6f7-dfd4-99bffbfbba57@github.com>
Date:   Mon, 07 Mar 2022 11:40:26 -0800
In-Reply-To: <85d434f8-0eb1-c6f7-dfd4-99bffbfbba57@github.com> (Derrick
        Stolee's message of "Mon, 7 Mar 2022 13:57:57 -0500")
Message-ID: <xmqq8rtlsg9h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70B58786-9E4E-11EC-BA37-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I also had some struggles getting this to work since local clones
> were actually ignoring the filter. I didn't think it was worth
> setting up an HTTP or SSH server just for this test.

Does "clone --no-local $path" work as a workaround?  It should do
the same thing as "ssh" codepath except that it uses "sh" instead as
the process on the other side is running locally.

>>> I also attempted doing a "git clone --bare partial.bdl unbundled.git" to
>>> get the 'git clone' command to actually place the refs. However, 'git clone'
>>> does not set up the repository filter based on the bundle, so it reports
>>> missing blobs (even though there is no checkout).
>> 
>> Understandable, as cloning from a bundle, if I recall correctly, was
>> done as yet another special case in "git clone", differently from
>> the main "over the network" code path.  And from end-user's point of
>> view, I think updating it is part of introducing the filtered
>> bundle.
>
> The reason I did not include that here is because of the lack of
> repository-global promisor/filter config. I do want to loop back
> and make those updates, but perhaps for this series we should add
> an error condition into 'git clone' to say "Cannot currently clone
> from a filtered bundle" to help users understand the issue?

It would be a workable stepwise solution, I would think.  It is not
like we are robbing an existing feature from users---it merely is
that the support of partial cloning over different "transport" is
uneven, which is to be expected, especially in earlier phase of
introducing a new feature.

Thanks.

