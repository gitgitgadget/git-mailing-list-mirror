Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 094B42036B
	for <e@80x24.org>; Tue,  3 Oct 2017 10:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbdJCKtW (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 06:49:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59115 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751484AbdJCKtV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 06:49:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A1259030A;
        Tue,  3 Oct 2017 06:49:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0F512gnhRKCOkt3q/nyugUqIPKc=; b=slquQE
        7fHtqRwVnYk8dPeYwWxJ6nqBbjarbDuGn4/wfB0AQb/iYTDGegBCoFlnyiX9Iu2V
        p6RmpZMENXJnas5UFlEcwX6VSgi78K7gMRA+LQkDUWEM9GN8mCwfTRFizZTZh22Z
        pcISqNrTfKvenrwBDVMuaq0/+nbCvgSmh80/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g/4k5WDsOkw2X8XuuSfjC8PFpTDl/nmZ
        CUfVuGx9iD2518zY/tgcA+ubT5k4a9qui2ld9WXLNRePJuFhNaZH9pSI05QAsbIe
        Ihkf/0Q8kYDfMmLczmhNqYQP3aja+dpLn5vRSP/U/5qW4Y02HjkkDmqaweQDuzdl
        /WrW16iy8aM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20F4390308;
        Tue,  3 Oct 2017 06:49:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E44D90307;
        Tue,  3 Oct 2017 06:49:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com,
        sbeller@google.com
Subject: Re: [PATCH v3 3/5] sha1_name: Unroll len loop in find_unique_abbrev_r
References: <20170925095452.66833-1-dstolee@microsoft.com>
        <20171002145651.204984-4-dstolee@microsoft.com>
Date:   Tue, 03 Oct 2017 19:49:19 +0900
In-Reply-To: <20171002145651.204984-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 2 Oct 2017 10:56:49 -0400")
Message-ID: <xmqqinfwh5g0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82E0D62A-A828-11E7-9C7E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> p0008.1: find_unique_abbrev() for existing objects
> --------------------------------------------------
>
> For 10 repeated tests, each checking 100,000 known objects, we find the
> following results when running in a Linux VM:
>
> |       | Pack  | Packed  | Loose  | Base   | New    |         |
> | Repo  | Files | Objects | Objects| Time   | Time   | Rel%    |
> |-------|-------|---------|--------|--------|--------|---------|
> | Git   |     1 |  230078 |      0 | 0.09 s | 0.06 s | - 33.3% |
> | Git   |     5 |  230162 |      0 | 0.11 s | 0.08 s | - 27.3% |
> | Git   |     4 |  154310 |  75852 | 0.09 s | 0.07 s | - 22.2% |
> | Linux |     1 | 5606645 |      0 | 0.12 s | 0.32 s | +146.2% |
> | Linux |    24 | 5606645 |      0 | 1.12 s | 1.12 s | -  0.9% |
> | Linux |    23 | 5283204 | 323441 | 1.08 s | 1.05 s | -  2.8% |
> | VSTS  |     1 | 4355923 |      0 | 0.12 s | 0.23 s | + 91.7% |
> | VSTS  |    32 | 4355923 |      0 | 1.02 s | 1.08 s | +  5.9% |
> | VSTS  |    31 | 4276829 |  79094 | 2.25 s | 2.08 s | -  7.6% |

The above does not look so good, especially in cases where a
repository is well maintained by packing into smaller number of
packs, we get much worse result?

> p0008.2: find_unique_abbrev() for missing objects
> -------------------------------------------------
>
> For 10 repeated tests, each checking 100,000 missing objects, we find
> the following results when running in a Linux VM:
>
> |       | Pack  | Packed  | Loose  | Base   | New    |        |
> | Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
> |-------|-------|---------|--------|--------|--------|--------|
> | Git   |     1 |  230078 |      0 | 0.66 s | 0.08 s | -87.9% |
> | Git   |     5 |  230162 |      0 | 0.90 s | 0.13 s | -85.6% |
> | Git   |     4 |  154310 |  75852 | 0.79 s | 0.10 s | -87.3% |
> | Linux |     1 | 5606645 |      0 | 0.48 s | 0.32 s | -33.3% |
> | Linux |    24 | 5606645 |      0 | 4.41 s | 1.09 s | -75.3% |
> | Linux |    23 | 5283204 | 323441 | 4.11 s | 0.99 s | -75.9% |
> | VSTS  |     1 | 4355923 |      0 | 0.46 s | 0.25 s | -45.7% |
> | VSTS  |    32 | 4355923 |      0 | 5.40 s | 1.15 s | -78.7% |
> | VSTS  |    31 | 4276829 |  79094 | 5.88 s | 1.18 s | -79.9% |

The question is if this is even measuring a relevant workload.  How
often would we have a full 40-hex object name for which we actually
do not have the object, and ask its name to be abbreviated?

Compared to it, the result from p0008.1 feels a lot more important.
We know we make tons of "abbreviate the object name for this object
we have" and we see them every day in our "git log -p" output.

Seeing a lot more impressive result from p0008.2 than p0008.1 makes
me unsure if this patch is optimizing for the right case.

I'll have to see the code a bit deeper before I can comment on it.

Thanks.
