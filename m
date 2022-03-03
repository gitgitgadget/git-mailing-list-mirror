Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8531C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiCCAdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiCCAdg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:33:36 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789F5BF972
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:32:52 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CECB182CCA;
        Wed,  2 Mar 2022 19:32:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pjfu9Zq94/VVAFsRJ35VKNwxnfuEHup/nvwqdP
        OzCwQ=; b=PrZ7LBF8bOWeamTz5RN+mkkk/E2Q9V/FlZBwTu3HjnTC+JedRXl5Rr
        h4qgJCwrvCsu0m8VdL0jjUMXo8SSwpAVL7ZM9T9bJ4A/a9t0B+9Y3+T+05u9Zz72
        /08kC0d80lQTSuxZx7GBSZkZ1BwKTTsvFGCrpyiBQSXjStnb4gRDM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0622C182CC9;
        Wed,  2 Mar 2022 19:32:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 800EC182CC6;
        Wed,  2 Mar 2022 19:32:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/7] fetch: increase test coverage of fetches
References: <cover.1645102965.git.ps@pks.im> <cover.1645430423.git.ps@pks.im>
        <081174b7a00cf094a7dacd8aba89fb137ea40f66.1645430423.git.ps@pks.im>
        <xmqqsfrzev2d.fsf@gitster.g>
Date:   Wed, 02 Mar 2022 16:32:48 -0800
In-Reply-To: <xmqqsfrzev2d.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        02 Mar 2022 16:30:50 -0800")
Message-ID: <xmqqo82neuz3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7461C6E2-9A89-11EC-8251-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> +test_expect_success 'backfill failure causes command to fail' '
>> +	git init clone5 &&
>> +
>> +	write_script clone5/.git/hooks/reference-transaction <<-EOF &&
>> +		while read oldrev newrev reference
>> +		do
>> +			if test "\$reference" = refs/tags/tag1
>> +			then
>> +				# Create a nested tag below the actual tag we
>> +				# wanted to write, which causes a D/F conflict
>> +				# later when we want to commit refs/tags/tag1.
>> +				# We cannot just `exit 1` here given that this
>> +				# would cause us to die immediately.
>> +				git update-ref refs/tags/tag1/nested $B
>> +				exit \$!
>> +			fi
>> +		done
>> +	EOF
>
> I think I've reviewed the previous round of these patches in
> detail.  I by mistake sent a comment for this step in v2, but I
> think the same puzzlement exists in this round, too.

Namely:

I have been wondering if we need to do this from the hook?  If we
have this ref before we start "fetch", would it have the same
effect, or "fetch" notices that this interfering ref exists and
removes it to make room for storing refs/tags/tag1, making the whole
thing fail to fail?

> +				exit \$!

In any case, "exit 0" or "exit \$?" would be understandable, but
exit with "$!", which is ...?  The process ID of the most recent
background command?  Puzzled.
