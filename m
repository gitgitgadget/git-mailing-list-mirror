Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D65CDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjJKWTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJKWTf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:19:35 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C522491
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:19:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C6091CF5C;
        Wed, 11 Oct 2023 18:19:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=BSWSzxmDzaTIyQuznbSpQbmaRSAfSAmvsUu4q9
        d01x4=; b=TUV/ysuhdrFQNqr6F9A3vziesWAlw7MZ+yOcDffVzjboqZ/b5zAvJg
        5wlzVNpTOYaKPZjFedWGE8tgPKhZyoCDmysfRCoBuyKH1eA9X5bwycNgMH9VX1od
        SEn1Dvt5UoWnGHnRWfk+sg56ze5Yp8Nge53pabVAyy/340kajNWwg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54DF41CF5B;
        Wed, 11 Oct 2023 18:19:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F3F51CF5A;
        Wed, 11 Oct 2023 18:19:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk,
        Izzy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Izzy <winglovet@gmail.com>
Subject: Re: [PATCH v6] merge-tree: add -X strategy option
In-Reply-To: <20231011214340.GA518221@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 11 Oct 2023 17:43:40 -0400")
References: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
        <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>
        <a482d047-dd40-436d-8daa-0c74780af11f@gmail.com>
        <20231009155315.GA3252778@coredump.intra.peff.net>
        <xmqq4jiz3env.fsf@gitster.g>
        <20231009185234.GB3270793@coredump.intra.peff.net>
        <xmqqlec9kl0k.fsf@gitster.g>
        <20231011214340.GA518221@coredump.intra.peff.net>
Date:   Wed, 11 Oct 2023 15:19:28 -0700
Message-ID: <xmqqedi0kdjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EF13B08-6884-11EE-8492-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I am happy with either, as they both resolve the "merge-tree knows
> intimate details about merge_options" issue. The patch I showed would
> require manually passing more details down to real_merge(), which is I
> guess what you are getting at with the "more work may want to go into
> it".

I was alluding more about teaching "merge-tree" various optional
behaviour merge_options represents.  In today's patch it may be
-X<options>, who knows what tomorrow's patch wants to bring
"merge-tree" to feature-parity with "merge".  And the first approach
would mean we would add xopts today to the struct, but we will be
required passing more details as we add other things.

>> It is not that much code on top of the commit that is already queued
>> in 'next', I suspect.  Perhaps something like this?
>
> This looks OK, though...
>
>> +void clear_merge_options(struct merge_options *opt UNUSED)
>> +{
>> +	; /* no-op as our copy is shallow right now */
>> +}
>
> Clearing is generally not just about copies, but any use of the struct.
> so this invites the question of whether the original non-copy struct
> should have a call to clear_merge_options() in cmd_merge_tree(). And
> ditto for every other user.

Yes, once we start leaking, somebody hopefully notice the lack of a
call to this on the original/template copy and add one.  Until then...
