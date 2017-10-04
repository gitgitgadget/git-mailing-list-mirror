Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6312B2036B
	for <e@80x24.org>; Wed,  4 Oct 2017 06:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbdJDGK1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 02:10:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61596 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750797AbdJDGK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 02:10:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC7AD96929;
        Wed,  4 Oct 2017 02:10:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pp+0oxrepA5CCDFE+HQIiJMpZpk=; b=XTYAan
        U8NXmBCMHKqUVywzt0hEaCOWSO02VRlw3k2rNEwlSI8lDtKnFbjznImjn2epyFPF
        8+hL4A5I9SuLwJZ+xRa0O/znbcWikVvtUKJFggIZDdqh9cbBiMicq8WYoHSg71rj
        qh4YUa2awCITOIo18bBzH3eWeM2vV4O5vpHOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RBoyu6nuw/SkqI7o/eDARoBGuBZKsVa7
        Py27ig3k3u6KTxB/hPqbLj2+E2CkZKz/09z+j/2gtsywPDDezxCsyUx8Sf8RnIMG
        8jp4vD3wl6089Lkp2l3CyqKnv1G4cZ6KDlfJfuG5hk2pM3oSjQpRNuXmdt6oH9xW
        Frlmf3N7xjc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2DBC96927;
        Wed,  4 Oct 2017 02:10:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32AD596926;
        Wed,  4 Oct 2017 02:10:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com, sbeller@google.com
Subject: Re: [PATCH v3 3/5] sha1_name: Unroll len loop in find_unique_abbrev_r
References: <20170925095452.66833-1-dstolee@microsoft.com>
        <20171002145651.204984-4-dstolee@microsoft.com>
        <xmqqinfwh5g0.fsf@gitster.mtv.corp.google.com>
        <6a3804a4-9728-d122-7fac-f297fc7977d1@gmail.com>
Date:   Wed, 04 Oct 2017 15:10:24 +0900
In-Reply-To: <6a3804a4-9728-d122-7fac-f297fc7977d1@gmail.com> (Derrick
        Stolee's message of "Tue, 3 Oct 2017 07:26:02 -0400")
Message-ID: <xmqqpoa3cujz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B63A4BC6-A8CA-11E7-B60F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 10/3/2017 6:49 AM, Junio C Hamano wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
>>
>>> p0008.1: find_unique_abbrev() for existing objects
>>> --------------------------------------------------
>>>
>>> For 10 repeated tests, each checking 100,000 known objects, we find the
>>> following results when running in a Linux VM:
>>>
>>> |       | Pack  | Packed  | Loose  | Base   | New    |         |
>>> | Repo  | Files | Objects | Objects| Time   | Time   | Rel%    |
>>> |-------|-------|---------|--------|--------|--------|---------|
>>> | Git   |     1 |  230078 |      0 | 0.09 s | 0.06 s | - 33.3% |
>>> | Git   |     5 |  230162 |      0 | 0.11 s | 0.08 s | - 27.3% |
>>> | Git   |     4 |  154310 |  75852 | 0.09 s | 0.07 s | - 22.2% |
>>> | Linux |     1 | 5606645 |      0 | 0.12 s | 0.32 s | +146.2% |
>>> | Linux |    24 | 5606645 |      0 | 1.12 s | 1.12 s | -  0.9% |
>>> | Linux |    23 | 5283204 | 323441 | 1.08 s | 1.05 s | -  2.8% |
>>> | VSTS  |     1 | 4355923 |      0 | 0.12 s | 0.23 s | + 91.7% |
>>> | VSTS  |    32 | 4355923 |      0 | 1.02 s | 1.08 s | +  5.9% |
>>> | VSTS  |    31 | 4276829 |  79094 | 2.25 s | 2.08 s | -  7.6% |
>>
>> The above does not look so good, especially in cases where a
>> repository is well maintained by packing into smaller number of
>> packs, we get much worse result?
>
> I understand that this patch on its own does not have good numbers. I
> split the
> patches 3 and 4 specifically to highlight two distinct changes:
>
> Patch 3: Unroll the len loop that may inspect all files multiple times.
> Patch 4: Parse less while disambiguating.
>
> Patch 4 more than makes up for the performance hits in this patch.

Now you confused me even more.  When we read the similar table that
appears in [Patch 4/5], what does the "Base Time" column mean?
Vanilla Git with [Patch 3/5] applied?  Vanillay Git with [Patch 4/5]
alone applied?  Something else?
