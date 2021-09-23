Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3E4C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 18:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1C360F43
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 18:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhIWSZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:25:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60209 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbhIWSZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 14:25:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 252F7D7150;
        Thu, 23 Sep 2021 14:23:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XhDpo3M02aOhcGtdft7t207uu0QWIzcbxfPF4c
        mUvY0=; b=wiGM75f5x4pAlRnl2ANCbXwYRhRO45JZ1XFYTs/HFErcWzhvBiOw6t
        Vtr0wWrbATS6qeqSCXFxmVKoxwPmLW81QsnK58DkQRBXsnGLkh8zsH4dtWiY9OcY
        rMcvadkq1jDLHosmUTh2sOYVdaS64u6E5gfRaBlDQu2EgU4w74rdM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 176B6D714F;
        Thu, 23 Sep 2021 14:23:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72C95D714E;
        Thu, 23 Sep 2021 14:23:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        vdye@github.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 03/14] dir: extract directory-matching logic
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <b1f6468f9cdb7d16f6317c71b21f4459af158e87.1632159937.git.gitgitgadget@gmail.com>
        <xmqqwnn8430s.fsf@gitster.g>
        <36475af0-1021-f59d-cb33-b3b402c13767@gmail.com>
        <a99a58ee-c3fe-501b-3116-8b54eaed0e53@gmail.com>
Date:   Thu, 23 Sep 2021 11:23:35 -0700
In-Reply-To: <a99a58ee-c3fe-501b-3116-8b54eaed0e53@gmail.com> (Derrick
        Stolee's message of "Thu, 23 Sep 2021 09:42:56 -0400")
Message-ID: <xmqqlf3nywuw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E0AB726-1C9B-11EC-9B83-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/23/2021 9:39 AM, Derrick Stolee wrote:
>> On 9/22/2021 7:13 PM, Junio C Hamano wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> +static int path_matches_dir_pattern(const char *pathname,
>>>> +				    int pathlen,
>>>> +				    int *dtype,
>>>> +				    struct path_pattern *pattern,
>>>> +				    struct index_state *istate)
>>>> +{
>>>> +	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
>>>> +	if (*dtype != DT_DIR)
>>>> +		return 0;
>>>> +
>>>> +	return 1;
>>>> +}
>>>
>>> The function name and parameter list have "pattern" but as far as I
>>> can see any "matches" or "pattern" comes into the picture.  The code
>>> in the caller after calling this function may be doing pattern
>>> matching, but not this one.
>>>
>>> What this helper is doing is "signal if the pathname in the working
>>> tree is supposed to be a directory with the return value, while
>>> filling *dtype with what kind of thing it is."
>>>
>>> path_must_be_dir_in_working_tree() or something, perhaps?
>> 
>> Yes, a rename would be prudent here. Thanks.
>
> Of course, when I go to amend the commit, the commit message says
>
> 	We will expand the path_matches_dir_pattern() method in a following
> 	change.
>
> which means that more will follow that will actually care about the
> pattern and matching as a directory.
>
> After looking at the extension in the next patch, do you still think a
> rename is necessary?

When the focus and purpose of the function changes, it may warrant a
rename to include "matching" or "pattern", but not before.

Or we might be seeing a premature refactoring with these two steps.
Are we gaining multiple callers of this function before it gets
extended to care about pattern and matching?  If not, perhaps
teaching the inlined codepath about the pattern and matching in
place first before extracting the code to a helper function for
readability and reusability may help make the resulting series
easier to follow, and we do not have to see a function with a
misleading name.

