Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77162C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3B764EB6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhCQRLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:11:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56934 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhCQRKs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:10:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75D6BA30B9;
        Wed, 17 Mar 2021 13:10:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s582xE/KUy5t1DejaYWw0YOPnH0=; b=nwDADg
        a+glP8ZiXsnJPBcquE5Cepj6doCYaZRITMcS5azBV+rwYf0NMGvu0gSKmBAKumNd
        jqbhhclOfsmIKfnnOpBPNKkRpHcfn68gJpJRBVbR1vcqxWxECZTEri5ReKzdS2eA
        As7JAXemPEAODOAMXL+/fkr35RbUmTJsd4wGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EJiazVAdhyAFy8Kq3Axe3MuhDdRWChiU
        08Gx/BU+V37tWE5EuEejh88BBm6Odu1VIyVIR2RIm7WtiZm5MpkDhTHms5hmfLIS
        IEaOycimVxQsuRwgqhp/ZldHDzTcm084TsTGGv/M+FNc2gZCCq3sARm8YV1K5/bV
        pzMOEGh8EYI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CD1AA30B7;
        Wed, 17 Mar 2021 13:10:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5F5CA30B6;
        Wed, 17 Mar 2021 13:10:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH] fsmonitor: avoid global-buffer-overflow READ when
 checking trivial response
References: <pull.904.git.1615826363431.gitgitgadget@gmail.com>
        <c34badb9-a3bc-a5fe-c6fc-c1bdce867e0d@jeffhostetler.com>
Date:   Wed, 17 Mar 2021 10:10:44 -0700
In-Reply-To: <c34badb9-a3bc-a5fe-c6fc-c1bdce867e0d@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 16 Mar 2021 10:20:29 -0400")
Message-ID: <xmqq7dm5zox7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B679BA12-8743-11EB-8688-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 3/15/21 12:39 PM, Andrzej Hunt via GitGitGadget wrote:
>> From: Andrzej Hunt <ajrhunt@google.com>
>> query_result can be be an empty strbuf (STRBUF_INIT) - in that case
>> trying to read 3 bytes triggers a buffer overflow read (as
>> query_result.buf = '\0').
>> Therefore we need to check query_result's length before trying to
>> read 3
>> bytes.
>> This overflow was introduced in:
>>    940b94f35c (fsmonitor: log invocation of FSMonitor hook to trace2, 2021-02-03)
>> It was found when running the test-suite against ASAN, and can be most
>> easily reproduced with the following command:
> ...
> Looks good to me.  And thanks for catching this.

Thanks, will queue on jh/fsmonitor-prework as a maint-2.31 candidate.
