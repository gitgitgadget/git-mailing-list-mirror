Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0713CC433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 22:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbiARWFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 17:05:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53704 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiARWFg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 17:05:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C485217E7D0;
        Tue, 18 Jan 2022 17:05:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4z0aTBmVUu3gKfruxU84ULx9kS0AOKJS20/Sf8
        TWxoc=; b=WydJvb/+GXkrSrZtTERlBXqiN3iTwODbD9IZ1YUaE9U7Y++UffhAIU
        TB6X/CPuACpjcdUkC9bZA2cD8F1Jvw5FAY6gGgVQJp8uKBuQqfegB2x7GEOkFwum
        yV2cqYMDJuGsJOYMGuVgp9fRexCXtYYkxzL2jad/LqBushhZStLtY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BD6AC17E7CF;
        Tue, 18 Jan 2022 17:05:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 31A1517E7CE;
        Tue, 18 Jan 2022 17:05:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v5 3/3] fetch --negotiate-only: do not update submodules
References: <20220113004501.78822-1-chooglen@google.com>
        <20220118185453.33710-1-chooglen@google.com>
        <20220118185453.33710-4-chooglen@google.com>
Date:   Tue, 18 Jan 2022 14:05:31 -0800
In-Reply-To: <20220118185453.33710-4-chooglen@google.com> (Glen Choo's message
        of "Tue, 18 Jan 2022 10:54:53 -0800")
Message-ID: <xmqqtue0r978.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1C30794-78AA-11EC-9E0D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> +	if (negotiate_only)
> +		switch (recurse_submodules_cli) {
> +		case RECURSE_SUBMODULES_OFF:
> +		case RECURSE_SUBMODULES_DEFAULT: {
> +			/*
> +			 * --negotiate-only should never recurse into
> +			 * submodules. Skip it by setting recurse_submodules to
> +			 * RECURSE_SUBMODULES_OFF.
> +			 */
> +			recurse_submodules = RECURSE_SUBMODULES_OFF;
> +			break;
> +		}
> +		default:
> +			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
> +		}

I think that this part has the only difference since the previous
round, but I am puzzled about it.  Everything else looks as good as
the previous round was.

I did not (and I do not) mind the block for the body of this if
statement.  Even though technically a single switch() statement
makes a single statement block that does not need {} around, it is
large enough that extra {} around (which you had in the previous
round) may make it clear where the body begins and ends.

But do we really need the extra block _inside_ the switch statement?
IOW I would have expected to see this instead:

		switch (recurse_submodules_cli) {
		case RECURSE_SUBMODULES_OFF:
		case RECURSE_SUBMODULES_DEFAULT:
			/*
			 * --negotiate-only should never recurse into
			 * submodules. Skip it by setting recurse_submodules to
			 * RECURSE_SUBMODULES_OFF.
			 */
			recurse_submodules = RECURSE_SUBMODULES_OFF;
			break;
		default:
			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
		}

Thanks.
