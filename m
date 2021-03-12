Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88322C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4843364F25
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhCLUJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:09:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63046 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbhCLUIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 15:08:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70BD4AE402;
        Fri, 12 Mar 2021 15:08:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9LudCzLvCrGW
        dgB+EKB4Xson/wY=; b=nI7wi5v4p91WLFKfiTNvAuBnY32mUikTCgOUophP4PoQ
        WoYNJbdIkwuwzYVffc9JSVTdSemsSMvSOYrtzfUqkKxI6kuCxh7PS+boxNfDHhmB
        mUNfiW7u5qqDn4eBOvxA09yIW08/0tmqDCFXayES6A27j2Bq5se/FBT87x+vdk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h2uyGJ
        Owaj5de2cZwU3bzoXyzichAHY1kfqvZ911+wHCbxfK7cdkKzhBYGl3oy2axvenJT
        CzNapJ5q+v6sWO4DOGN0b2Sdnm2gHexK75hd+PfX4G3pdDzEmMxyFQx0RHMwss91
        1p0shpsYNHHvBP/xmH3+Bm/SZ4L1HfWw04eQ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6616FAE400;
        Fri, 12 Mar 2021 15:08:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3658AE3FE;
        Fri, 12 Mar 2021 15:08:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 05/20] sparse-index: implement ensure_full_index()
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <399ddb0bad56c69ff9d9591f5e8eacf52cf50a15.1615404665.git.gitgitgadget@gmail.com>
        <xmqq1rckc1cb.fsf@gitster.g>
        <c5e42675-5f03-728a-60ec-880da368085b@gmail.com>
Date:   Fri, 12 Mar 2021 12:08:43 -0800
In-Reply-To: <c5e42675-5f03-728a-60ec-880da368085b@gmail.com> (Derrick
        Stolee's message of "Fri, 12 Mar 2021 08:56:28 -0500")
Message-ID: <xmqqft106sok.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BF8C8A54-836E-11EB-B8A9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> =C3=86var, the assumption that led to your e68237bb (tree.h API: remov=
e
>> support for starting at prefix !=3D "", 2021-03-08) closes the door
>> for this code rather badly.  Please work with Derrick to figure out
>> what the best course of action would be.
>
> Thanks for pointing this out, Junio.
>
> My preference would be to drop "tree.h API: remove support for
> starting at prefix !=3D """, but it should be OK to keep "tree.h API:
> remove "stage" parameter from read_tree_recursive()" (currently
> b3a078863f6), even though it introduces a semantic conflict here.
>
> Since I haven't seen my sparse-index topic get picked up by a
> tracking branch, I'd be happy to rebase on top of =C3=86var's topic if
> I can still set a non-root prefix.

I did try to have both in 'seen' (after all, that is the primary way
I find out these conflicts early---no one can keep all the details
of all the topics in flight in one's head), and saw that we now have
a need for non-empty prefix that we thought we no longer have in the
other topic --- I think we should probably keep support of non-empty
prefix (as the primary reason why that patch exists is because we
saw no in-tree users---now if your 05/20 proves to be a good use of
the feature, there is one fewer reasons to remove the support) in
some form, so discarding e68237bb certainly is an option.


If we were to base the sparse-index topic on top of ab/read-tree, we
may be able to gain further simplification and clean-up of the API.

I think all the clean-up value e68237bb has are on the calling side
(they no longer have to pass constant ("", 0) to the function), and
we could rewrite e68237bb by

 - renaming "read_tree_recursive()" to "read_tree_at()", with the
   non-empty prefix support.

 - creating a new function "read_tree()", which lacks the support
   for prefix, as a thin-wrapper around "read_tree_at()".

 - modifying the callers of "read_tree_recursive()" changed by
   e68237bb to instead call "read_tree()" (without prefix).

to simplify majority of calling sites without losing functionality.

Then your [05/20] can use the read_tree_at() to read with a prefix.


But that kind of details, I'd want to see you two figure out
yourselves.

Thanks.

