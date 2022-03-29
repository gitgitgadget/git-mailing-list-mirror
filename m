Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78576C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 16:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiC2QqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiC2QqU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 12:46:20 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D14AC6A
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 09:44:37 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD013118D25;
        Tue, 29 Mar 2022 12:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SEsqgNhEnBTfJw7B3q1w5aTSu0Ih+LvQlNeatu
        UxXQ0=; b=foOKXiN+e4K7wQKIbVCINwLgJ+bYUALPz8j8Vxe/I3gyXlPDbvYjEd
        W36Wsf9+LY/TPym5c93za1CckKr5QvgGblQVqe70xxIbzm+/ksti8cvS2gm73+/3
        58yV1phJwriTnnVuSbuWaMlZfAQ9+J+ZSm234LRBLhcswKzCqlpbI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A473E118D24;
        Tue, 29 Mar 2022 12:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F13F118D1B;
        Tue, 29 Mar 2022 12:44:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, reichemn@icloud.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] mv: refresh stat info for moved entry
References: <pull.1187.git.1648173419533.gitgitgadget@gmail.com>
        <pull.1187.v2.git.1648516027925.gitgitgadget@gmail.com>
        <5ca04e86-6c61-3d4e-88a0-a3c827e19e13@github.com>
Date:   Tue, 29 Mar 2022 09:44:34 -0700
In-Reply-To: <5ca04e86-6c61-3d4e-88a0-a3c827e19e13@github.com> (Derrick
        Stolee's message of "Tue, 29 Mar 2022 09:19:29 -0400")
Message-ID: <xmqqa6d8wvwt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84874D3E-AF7F-11EC-907B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> Note that the test added in 't7001-mv.sh' requires a "sleep 1" to ensure the
>> 'ctime' of the file creation will be definitively older than the 'ctime' of
>> the renamed file in 'git mv'.
>
> Unfortunate that this is necessary, but it seems to be the only way
> to handle this because of the interaction with the system clock and
> the filesystem. There are several sleeps like this in
> t1701-racy-split-index.sh, for example.

Does "test-tool chmtime" to tweak the filesystem timestamp help?  I
didn't look at the specific step that uses sleep to work around.

>> +
>> +	/*
>> +	 * Refresh the new index entry. Using 'refresh_cache_entry' ensures
>> +	 * we only update stat info if the entry is otherwise up-to-date (i.e.,
>> +	 * the contents/mode haven't changed). This ensures that we reflect the
>> +	 * 'ctime' of the rename in the index without (incorrectly) updating
>> +	 * the cached stat info to reflect unstaged changes on disk.
>> +	 */
>> +	refreshed = refresh_cache_entry(istate, new_entry, CE_MATCH_REFRESH);
>> +	if (refreshed && refreshed != new_entry) {
>> +		add_index_entry(istate, refreshed, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
>> +		discard_cache_entry(new_entry);
>
> I'm glad you're checking that both refreshed is non-NULL and not equal
> to new_entry. Both are possible results from refresh_cache_entry().

;-)
