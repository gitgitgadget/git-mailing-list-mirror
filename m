Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B8BC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 03:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13817611AD
	for <git@archiver.kernel.org>; Thu,  6 May 2021 03:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhEFD41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 23:56:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60571 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhEFD40 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 23:56:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E26B81207D3;
        Wed,  5 May 2021 23:55:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=plWOUi956uGn
        IegaKn6AHtnpTUmtpJVfcb/LAe/VITY=; b=VYSorN5Qo2VSwEKnnFiDLATIhdyI
        A4fg4D5BL9EteWFMFSmfvQvtHYNE9cRnDPUY6DpOQy9vBV9WO5jIiMgboQEuMRMl
        hH2mupF3GGvBuzlMV2ZsYn+nw30tdoE87daeItuhdoq0VBluTQkBS0sC9TG7d5e/
        xgIWLPNoeUTOPxI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C88B91207D2;
        Wed,  5 May 2021 23:55:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 00B8E1207D1;
        Wed,  5 May 2021 23:55:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] sparse-index.c: don't call prepare_repo_settings()
 twice in a row
References: <cover-0.2-00000000000-20210505T121028Z-avarab@gmail.com>
        <patch-2.2-8bca02efcee-20210505T121028Z-avarab@gmail.com>
        <7954338a-bb44-1345-61b6-787782063c3c@gmail.com>
Date:   Thu, 06 May 2021 12:55:24 +0900
In-Reply-To: <7954338a-bb44-1345-61b6-787782063c3c@gmail.com> (Derrick
        Stolee's message of "Wed, 5 May 2021 10:00:55 -0400")
Message-ID: <xmqqwnsczfbn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3DDE206-AE1E-11EB-9769-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 5/5/2021 8:11 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change code added in 58300f47432 (sparse-index: add index.sparse
>> config option, 2021-03-30) to only call prepare_repo_settings()
>> once. We know that our own set_sparse_index_config() has just finished
>> calling it, so we don't need to call it if we're acting on "test_env".
>
> I'm not sure about the value here. prepare_repo_settings() returns
> quickly if the settings have already been prepared, so a second call
> is negligible in cost.
>
>> @@ -133,11 +133,12 @@ int convert_to_sparse(struct index_state *istate=
)
>>  	test_env =3D git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
>>  	if (test_env >=3D 0)
>>  		set_sparse_index_config(istate->repo, test_env);
>> +	else
>> +		prepare_repo_settings(istate->repo);
>
> The change presented here to either call set_sparse_index_config()
> _or_ prepare_repo_settings() seems like it knows too much about
> how set_sparse_index_config() works.

I tend to agree on both counts.

Thanks.
