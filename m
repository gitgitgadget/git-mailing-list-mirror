Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A13C07E9D
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 22:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiIWW5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 18:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiIWW5I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 18:57:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D7A147680
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 15:57:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE5051B9B00;
        Fri, 23 Sep 2022 18:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U+HAVP5un+bZ0ib8Bt+LAYUjTksC8vr5LYy7nx
        tErR0=; b=tjetob7/dHtEadwjjYj3Y+89owcQx1kofQSwDkocGu1b6uCaA6+3HK
        8ii1R7bGqTu5F9n5oTSRyaPB4v4U4ByOG5Mv7fCT03wYFhgBErO47iBCpPSunASk
        H2IRl2jUi1Upo2g7+Y7odvWHtt56yOCYxgjNTZhKFshOQSlTSN1uQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A5ED91B9AFF;
        Fri, 23 Sep 2022 18:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E8EF1B9AFB;
        Fri, 23 Sep 2022 18:57:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH 0/4] submodule: parallelize status
References: <20220922232947.631309-1-calvinwan@google.com>
Date:   Fri, 23 Sep 2022 15:56:59 -0700
In-Reply-To: <20220922232947.631309-1-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 22 Sep 2022 23:29:43 +0000")
Message-ID: <xmqqleq9snr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08598042-3B93-11ED-83A0-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Future work: The reason why status is much slower on a cold cache vs
> warm cache is mainly due to refreshing the index. It is worth
> investigating whether this is entirely necessary.

I suspect that the CI breakage

  https://github.com/git/git/actions/runs/3115673002/jobs/5052804463

is due to this topic.  

In "SANTIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true make test" run
locally, I see t7507 failing quite badly.
