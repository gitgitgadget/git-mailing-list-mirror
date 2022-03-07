Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2BBC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244310AbiCGQsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244335AbiCGQrv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:47:51 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E470939DC
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:46:55 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4F76190575;
        Mon,  7 Mar 2022 11:46:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3KCwopEreCMc8RXwQWibi2WW+b3UnG6HtFT3wx
        WW58I=; b=cAdjzZG8aEHwLJjHcB9U87pM0LK4XXNridp104XrXeVriJ0+ErRMe0
        bO1uKCHQ+ZJMO3rm73eAY0f7pvppD6zMs4u5ylWEMnV2icM3Zh6dcuJi0YBZXvsE
        BcmEWnqalpW9oEZpUs/kd9BSeRdsBEC48g6oSJjuSlarE7rytiYEY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBD03190574;
        Mon,  7 Mar 2022 11:46:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3D133190573;
        Mon,  7 Mar 2022 11:46:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
Subject: Re: [PATCH 02/11] revision: put object filter into struct rev_info
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <3a88c99d9bc765bf4728fe0f0df1eed86adace0e.1645638911.git.gitgitgadget@gmail.com>
        <xmqqk0d9z7nc.fsf@gitster.g>
        <d00617ba-01e8-1a3a-3cf1-49324e604f01@github.com>
Date:   Mon, 07 Mar 2022 08:46:51 -0800
In-Reply-To: <d00617ba-01e8-1a3a-3cf1-49324e604f01@github.com> (Derrick
        Stolee's message of "Mon, 7 Mar 2022 08:59:03 -0500")
Message-ID: <xmqqbkyhvhfo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 309CE116-9E36-11EC-A7CE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> member so we need an on-demand allocation.  CALLOC_ARRAY() instead
>> of xcalloc(), when we know we are creating one element and not an
>> array of elements whose size happens to be one, is not wrong but it
>> does look strange.  Was there a reason why we avoid xcalloc()?
>
> I think I've been using CALLOC_ARRAY(..., 1) over "... = xcalloc()"
> for simplicity's sake for a while. I see quite a few across the
> codebase, too, but I can swap the usage here if you feel that is
> important.

Not at all.  I think it was just me who was confused; CALLOC_ARRAY()
vs xcalloc() is not confusing.  Both are capable of and meant for
allocating an array of these elements, and use of it for a single
element non-array is the same either way.  Nothing to complain about.

>> they may or may not be prepared to take.  This "we get rid of a
>> global struct and replace it with an on-demand allocated structure,
>> pointer to which is stored in the revs structure" rewrite somehow
>> makes me nervous.
>
> I think the main idea is that the filter being NULL indicates "no
> filter is used. Do a full object walk." If we use a static struct,
> then we need to instead use revs->filter.filter_spec.nr, but that
> is already being used as a BUG() statement:

Thanks.  My observation was primarily that it looked deviating from
the original code but that is not an objection unless the original
was without room for improvement.  And in fact in this case, I think
the global variable that was a static struct should have been a
global variable that is a pointer to a struct which is NULL unless
the filtering capability is being used.  So in that sense, the
conversion done in this series is an improvement and going in the
right direction.

> While we _could_ make that switch to using a static struct and
> change our checks to allow empty specs, that would be a more
> involved change. Maybe we can leave it for a follow up?

No, there is no need to.  A pointer that is NULL when unused is the
right thing to do.

Thanks.
