Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE8531F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfHFRtf (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:49:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53468 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfHFRtf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:49:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBDBC1672D0;
        Tue,  6 Aug 2019 13:49:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ddskg9dk2cilFMAPGnd9vLbuMO0=; b=m+DT4q
        I0CBcCXBTTwYPs1mKs7RGJvv4vnmeYYqhczT69bzmmzOMMQBorYbq8gQrRgQXc8O
        9ED8za/JK4ZRfg4b6Zx6jUcGyyGdkr6SGGbolSi9lCxaMjKaR/w92L9YASBQ+3Jo
        J+sluHUfuqRcNOd3dh6EfWtaYV4UHGxJYMG24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yTOaCyjTNPKJ45ZOOtoBnsoCWvtrlZLU
        OIEkMrNmWrVHYyfmI1NH+qQ5jXhClglQ+R4exbjh4GJUG3O7L/YcX6nSHfGqlWPC
        XzkaHwsI9p7/vHN5ND6GaWhVVv08fEvPYTwhGUMOGm0hbMmrTcx0AMOv9VCRxrRp
        LO3gxc8ByyQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0BEF1672CF;
        Tue,  6 Aug 2019 13:49:32 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10D941672CE;
        Tue,  6 Aug 2019 13:49:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/1] merge-recursive: avoid directory rename detection in recursive case
References: <20190726220928.GG113966@google.com>
        <20190805223350.27504-1-newren@gmail.com>
        <xmqq1rxykz91.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 06 Aug 2019 10:49:30 -0700
In-Reply-To: <xmqq1rxykz91.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 06 Aug 2019 09:57:46 -0700")
Message-ID: <xmqqsgqejiad.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BB15AFC-B872-11E9-A24F-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do agree that it is sensible to avoid doing any funky thing during
> the virtual base merges, whose result is much less observable (hence
> harder to form the right mental model in end user's head) than the
> outermost merge.  Do we want to allow this for inner merges when the
> setting is 2?  Wouldn't that hit the same BUG()?

Ah, actually no.  2 would make a choice of committing to one
possible merge result and does not leave options to be resolved as
conflicted, so we should be able to write out its decision as a
tree.  If we cannot form a tree object when operating with 2, we do
have a bug and we do want to know about it.

