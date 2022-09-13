Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D418EECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 18:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiIMSPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiIMSOn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 14:14:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A96D4E85C
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 10:23:52 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 991911C04A8;
        Tue, 13 Sep 2022 13:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F78zSwo4SS5YaEfcnstqTalYIK9zNGQnt3fetS
        BLeT4=; b=MdUQJkTl2qJLNcmJ8cvatxr4hhyr9J/XaAyyQ9nznELVKN0GaehGHY
        MLvYe2udpJ642Yg+v9qHBIA3AEttdCgXs6/i7822jPnzRmL22FD22Jh1J0Q3sUKT
        yD71sCoG69TqLrEKUFyxMgFuk4EyGZWP912fejGXYuO3QCyPg5D98=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 916481C04A7;
        Tue, 13 Sep 2022 13:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 425DE1C04A6;
        Tue, 13 Sep 2022 13:23:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, vdye@github.com,
        git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] builtin/grep.c: walking tree instead of
 expanding index with --sparse
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
        <20220908001854.206789-4-shaoxuan.yuan02@gmail.com>
        <xmqqczc5rblr.fsf@gitster.g>
        <093827ae-41ef-5f7c-7829-647536ce1305@github.com>
Date:   Tue, 13 Sep 2022 10:23:46 -0700
In-Reply-To: <093827ae-41ef-5f7c-7829-647536ce1305@github.com> (Derrick
        Stolee's message of "Thu, 8 Sep 2022 16:46:54 -0400")
Message-ID: <xmqq7d279oil.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D35A97C6-3388-11ED-8A67-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 9/8/2022 1:59 PM, Junio C Hamano wrote:
>> Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
>> 
>>> +
>>> +	/*
>>> +	 * NEEDSWORK: when reading a submodule, the sparsity settings in the
>>> +	 * superproject are incorrectly forgotten or misused. For example:
>>> +	 *
>>> +	 * 1. "command_requires_full_index"
>>> +	 * 	When this setting is turned on for `grep`, only the superproject
>>> +	 *	knows it. All the submodules are read with their own configs
>>> +	 *	and get prepare_repo_settings()'d. Therefore, these submodules
>>> +	 *	"forget" the sparse-index feature switch. As a result, the index
>>> +	 *	of these submodules are expanded unexpectedly.
>>  ...
> I think this comment is misplaced. It should either be contained in
> the commit message or placed closer to this diff hunk:

OK, so given what you wrote below, except for such a minor
shuffling, the current series is ready to go?

Thanks.

> ...
> Shaoxuan's comment is attempting to list the reasons why submodules
> do not currently work with sparse-index, and specifically that we
> can add tests that _should_ exercise this code in a meaningful way,
> but because of the current limitations of the codebase, the code
> isn't actually exercised in that scenario.
>
> In order to actually create a test that demonstrates how submodules
> and sparse-checkout work with this logic, we need to do some serious
> refactoring of the sparse-checkout logic to care about the repository
> struct, along with some other concerns specifically around the sparse
> index. This doesn't seem appropriate for the GSoC timeline or even for
> just this topic.

