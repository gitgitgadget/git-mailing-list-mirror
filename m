Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BD4C433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 15:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbiERPx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 11:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbiERPxY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 11:53:24 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCCB1C9654
        for <git@vger.kernel.org>; Wed, 18 May 2022 08:53:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DEBC13DBB7;
        Wed, 18 May 2022 11:53:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=76ROPWK0I5USWOFTLu3J5s+7y2BMHc06UaqpHd
        xUrfA=; b=HidAEdOB7rbIAwysgTtSrnrsybmX8kW4+1JlrEcagh3pMhvAdqHxRf
        mNXDouuDUfdopcbVt/48kUA5molMdkiN7Ec2XDZEkTZFDHo8Ndmzryl5zN9wZ6Ym
        Q5l7GwwuBYCTF7jvj3K1gNX/fiJFWTJlyNRv+GESTEiTHJUp7msN8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7445B13DBB6;
        Wed, 18 May 2022 11:53:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D11C713DBB3;
        Wed, 18 May 2022 11:53:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Benedek Kozma <cyberbeni@gmail.com>
Subject: Re: [PATCH v2] fetch: do not run a redundant fetch from submodule
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
        <xmqqczgzdc1r.fsf@gitster.g>
        <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq1qxfbqtq.fsf@gitster.g>
        <kl6lczghj7tn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqpmkg8z58.fsf@gitster.g>
        <kl6l7d6ljrrg.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq4k1p2v40.fsf@gitster.g> <xmqqwnel1eqb.fsf@gitster.g>
        <xmqqczgd16wx.fsf_-_@gitster.g> <xmqqk0alyqyj.fsf_-_@gitster.g>
        <kl6lo7zwhzsl.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 18 May 2022 08:53:18 -0700
In-Reply-To: <kl6lo7zwhzsl.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 17 May 2022 09:47:06 -0700")
Message-ID: <xmqqczgayh01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A39F1C1E-D6C2-11EC-ACC8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> +
>> +	/*
>> +	 * This is only needed after fetch_one(), which does not fetch
>> +	 * submodules by itself.
>> +	 *
>> +	 * When we fetch from multiple remotes, fetch_multiple() has
>> +	 * already updated submodules to grab commits necessary for
>> +	 * the fetched history from each remote, so there is no need
>> +	 * to fetch submodules from here.
>> +	 */
>> +	if (!result && remote && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
>>  		struct strvec options = STRVEC_INIT;
>>  		int max_children = max_jobs;
>
> Looks good; the comment is easier to understand than my suggestion for
> sure.

Thanks.  Today's code has diverged too much from the original code I
wrote long time ago (before submodules), and I needed an extra set
of eyeballs to double check and tell me that what I (wishfully)
wrote how the code works with submodules is in line with today's
code ;-)

