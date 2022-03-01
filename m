Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DD6C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbiCAUOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiCAUOI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:14:08 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8FD2A706
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:13:25 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6575718DC44;
        Tue,  1 Mar 2022 15:13:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fOneSzORSZ+q
        R58X47TN9WoIQmcUp7IR854kAlyht2I=; b=XfWKsi3siRKIAyv69Ue1JtLPVSaE
        dxAEDgrSDtnHm05z4RzayPXJC/W335EKEMqBm7CvhlnBpE5u+/xyBnye4DzlxCOn
        4vyo55oiI2c9UDBYK3MFFxe/gq3gKh9yYdD8Efs3/rtUy62V+kXg6ytN+mGLVrrL
        8/GXLjQABGa9P6M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D2DE18DC43;
        Tue,  1 Mar 2022 15:13:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CF9B518DC42;
        Tue,  1 Mar 2022 15:13:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com,
        avarab@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 3/5] commit-graph: fix ordering bug in generation
 numbers
References: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
        <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
        <562341b76b30ff3cdc01cea4cda550a7b8165bdd.1646164112.git.gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 12:13:21 -0800
In-Reply-To: <562341b76b30ff3cdc01cea4cda550a7b8165bdd.1646164112.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 01 Mar 2022
        19:48:30 +0000")
Message-ID: <xmqqmti9ph26.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0B827998-999C-11EC-8FDE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When computing the generation numbers for a commit-graph, we compute
> the corrected commit dates and then check if their offsets from the
> actual dates is too large to fit in the 32-bit Generation Data chunk.
> However, there is a problem with this approach: if we have parsed the
> generation data from the previous commit-graph, then we continue the
> loop because the corrected commit date is already computed. This causes
> an under-count in the number of overflow values.
>
> It is incorrect to add an increment to num_generation_data_overflows
> next to this 'continue' statement, because we might start
> double-counting commits that are computed because of the depth-first
> search walk from a commit with an earlier OID.
>
> Instead, iterate over the full commit list at the end, checking the
> offsets to see how many grow beyond the maximum value.

OK.

> Create a new t5328-commit-graph-64-bit-time.sh test script to handle
> special cases of testing 64-bit timestampes. This helps demonstrate thi=
s
> bug in more cases. It still won't hit all potential cases until the nex=
t
> change, which reenables reading generation numbers. Use the skip_all
> trick from 0a2bfccb9c8 (t0051: use "skip_all" under !MINGW in
> single-test file, 2022-02-04) to make the output clean when run on a
> 32-bit system.
>
> Hepled-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

I can typofix this one locally if needed.
