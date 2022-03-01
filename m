Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE0C4321E
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbiCAUZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbiCAUYh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:24:37 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7226F3980B
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:22:34 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26EEF1109C8;
        Tue,  1 Mar 2022 15:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AU5243C55p7wUHvY1D+fmsxjyd0R+YiuCQsc4X
        kQxk8=; b=s/2t2dagZoTNxz6TDpi2wxQoyVnr/+4W4abSCkSvgTA94HKKtGpqHw
        XGBD0QXfviFt5jEvenv8x94eLsa4JoKdUUg26MBTHnvCKWrIQTa45jgc3UMj86vN
        QcVEs2w7I3whEvxBY4BoQf1qGVw4I99WW5dNRIcRqFrhTY//Chp+I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D0571109C7;
        Tue,  1 Mar 2022 15:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 798FE1109C6;
        Tue,  1 Mar 2022 15:22:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] name-rev: use generation numbers if available
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
        <20220228215025.325904-3-jacob.e.keller@intel.com>
        <xmqqpmn6wg98.fsf@gitster.g>
        <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
        <xmqqfso2t9cu.fsf@gitster.g>
        <6b00c67b-01c9-bf22-a8e6-904f47fa7acf@github.com>
        <f5ca62f4-eb3d-eeb7-e7c8-7fb800f3d6cd@intel.com>
        <3c3e6063-7eb4-7ff4-3a1b-a07db1fe969f@github.com>
Date:   Tue, 01 Mar 2022 12:22:32 -0800
In-Reply-To: <3c3e6063-7eb4-7ff4-3a1b-a07db1fe969f@github.com> (Derrick
        Stolee's message of "Tue, 1 Mar 2022 14:56:28 -0500")
Message-ID: <xmqqfso1pgmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53B857EA-999D-11EC-9798-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> I think the "tests should document current behavior" is handled by the
>> fact that this specific test fails if you revert the name-rev changes
>> but keep the test.
>
> Ah, so this _is_ documenting a new behavior that didn't exist
> before the series. That is good to include, then. If it was
> "just" testing the behavior before this series, then it would
> have less reason to exist.

With of without the additional codepath to handle the case where
commit graph is available, the original heuristics that is based on
commit timestamps are fooled by a history with skewed timestamps.

So I thought this "without commit graph, the algorithm must fail
this way" test would be testing the current behaviour *and* the
behaviour of the new code, no?
