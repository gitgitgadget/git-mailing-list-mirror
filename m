Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDD5F1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 20:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbdARUEr (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 15:04:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58152 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751756AbdARUEq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 15:04:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FBFA62032;
        Wed, 18 Jan 2017 15:04:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wYKI0rHu8gFY2HSBF7ih+BZfE20=; b=oDHx5c
        Ca9WLN4gEY5XWIIkPUXUPqeZk9QyWPMjGY67UafjV5+UB0m5rFNYSBiryVmJ2Ah0
        6uZ/HUmIDV1u8JdQaKKH/bicNHVfRpiLbQG+JyRUpA/+q9nfZaY7XQroI2zyKHPR
        J8nEOjP6E1OkIxrNVRmz/6qoONpRMxcKc+3+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vCxiB+WtHm1wNvs2Avyp8y7j/0fExL9X
        Eh8jsdoXnyrHrEDg7dmMvWC8DeXKWhmqZLnCgIdzZSaOfJwVoddyFKV5d8tq8pMQ
        PdUuUglhfEYRsauE3MAjfMkKhZc9NsKzDdAUF2aswCRTVTo95ta08SH7uhu/aU8n
        UMppbXTLrsw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 861FE62031;
        Wed, 18 Jan 2017 15:04:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B561462030;
        Wed, 18 Jan 2017 15:04:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 2/5] name-rev: extend --refs to accept multiple patterns
References: <20170118000930.5431-1-jacob.e.keller@intel.com>
        <20170118000930.5431-3-jacob.e.keller@intel.com>
Date:   Wed, 18 Jan 2017 12:04:43 -0800
In-Reply-To: <20170118000930.5431-3-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Tue, 17 Jan 2017 16:09:27 -0800")
Message-ID: <xmqqy3y8878k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B162558-DDB9-11E6-BE3D-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Teach git name-rev to take a string list of patterns from --refs instead
> of only a single pattern. The list of patterns will be matched
> inclusively, such that a ref only needs to match one pattern to be
> included. If a ref will only be excluded if it does not match any of the
> patterns.

I think "If a" in the last sentence should be "A".

>  --refs=<pattern>::
>  	Only use refs whose names match a given shell pattern.  The pattern
> -	can be one of branch name, tag name or fully qualified ref name.
> +	can be one of branch name, tag name or fully qualified ref name. If
> +	given multiple times, use refs whose names match any of the given shell
> +	patterns. Use `--no-refs` to clear any previous ref patterns given.

Unlike 1/5, this is facing the end-users, and the last sentence is
very appropriate.

> +	if (data->ref_filters.nr) {
> +		struct string_list_item *item;
> +		int matched = 0;
> +
> +		/* See if any of the patterns match. */
> +		for_each_string_list_item(item, &data->ref_filters) {
> +			/*
> +			 * We want to check every pattern even if we already
> +			 * found a match, just in case one of the later
> +			 * patterns could abbreviate the output.
> +			 */
> +			switch (subpath_matches(path, item->string)) {
> +			case -1: /* did not match */
> +				break;
> +			case 0: /* matched fully */
> +				matched = 1;
> +				break;
> +			default: /* matched subpath */
> +				matched = 1;
> +				can_abbreviate_output = 1;
> +				break;
> +			}
>  		}

I agree that we cannot short-cut on the first match to make sure
that the outcome is stable, but I wondered what should be shown when
we do have multiple matches.  Say I gave

    --refs="v*" --refs="refs/tags/v1.*"

and refs/tags/v1.0 matched.  The above code would say we can
abbreviate.

What is the reason behind this design decision?  Is it because it is
clear that the user shows her willingness to accept more compact
form by having --refs="v*" that would allow shortening?  If that is
the case, I think I agree with the reasoning.  But we probably want
to write it down somewhere, because another reasoning, which may
also be valid, would call for an opposite behaviour (i.e. the more
specific --refs="refs/tags/v1.*" also matched, so let's show that
fact by not shortening).

