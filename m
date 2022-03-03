Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CD4C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 06:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiCCGtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 01:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCGty (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 01:49:54 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C60447AFE
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 22:49:10 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D51381855CC;
        Thu,  3 Mar 2022 01:49:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S+C3NrGjlpNkjlY+l9qjCDMzjfmzEK84BjckHW
        qd8VU=; b=HB/Gg+B5G2VDZaxprjgzN51b+UNNKuKZ1cn8WstlGAw1CR6moUs6Td
        09D8a4eBDnrqYEXK47vQglhdbijPr8jVr1smoSyg7btkS5LGLJcNz/bhDNRx2zgj
        tdFjtJ5DEggBpLtyFVC+h+C9s9QRUtLLh3LsoL+JxMe5+qLAXwUow=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD6FA1855CB;
        Thu,  3 Mar 2022 01:49:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 572A01855CA;
        Thu,  3 Mar 2022 01:49:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/7] fetch: increase test coverage of fetches
References: <cover.1645102965.git.ps@pks.im> <cover.1645430423.git.ps@pks.im>
        <081174b7a00cf094a7dacd8aba89fb137ea40f66.1645430423.git.ps@pks.im>
        <xmqqsfrzev2d.fsf@gitster.g> <xmqqo82neuz3.fsf@gitster.g>
        <YiBjjV6Kw2KHsMxq@ncase>
Date:   Wed, 02 Mar 2022 22:49:05 -0800
In-Reply-To: <YiBjjV6Kw2KHsMxq@ncase> (Patrick Steinhardt's message of "Thu, 3
        Mar 2022 07:43:25 +0100")
Message-ID: <xmqqmti7bkf2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05386A20-9ABE-11EC-80A4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> >> +				# would cause us to die immediately.
>> >> +				git update-ref refs/tags/tag1/nested $B
>> >> +				exit \$!
>> >> +			fi
>> >> +		done
>> >> +	EOF
>> >
>> > I think I've reviewed the previous round of these patches in
>> > detail.  I by mistake sent a comment for this step in v2, but I
>> > think the same puzzlement exists in this round, too.
>> 
>> Namely:
>> 
>> I have been wondering if we need to do this from the hook?  If we
>> have this ref before we start "fetch", would it have the same
>> effect, or "fetch" notices that this interfering ref exists and
>> removes it to make room for storing refs/tags/tag1, making the whole
>> thing fail to fail?
>> 
>> > +				exit \$!
>> 
>> In any case, "exit 0" or "exit \$?" would be understandable, but
>> exit with "$!", which is ...?  The process ID of the most recent
>> background command?  Puzzled.
>
> Oof, this was supposed to be `exit \$?`, thanks for catching this. But
> your above comment is right: we can indeed just create the D/F conflict
> outside of the hook and thus avoid the hook script altogether. Thanks!

I see.

As that shell does not send anything to background, at the point of
the reference $! would yield an empty string, and "exit" is
equivalent to "exit $?", it is doing the right thing, I presume.

The topic has been in 'next' for a while, so if you are inclined to
fix it up, please send an incremental patch.  If you do "exit" it
would be a one-liner change, or if you use a different "cause D/F
conflict outside the hook" approach, the change may become a bit
more involved.

Thanks.
