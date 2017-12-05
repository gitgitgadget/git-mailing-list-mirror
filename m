Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AABC620A40
	for <e@80x24.org>; Tue,  5 Dec 2017 21:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbdLEVDh (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 16:03:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63182 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751177AbdLEVDg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 16:03:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52194B7ABD;
        Tue,  5 Dec 2017 16:03:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ovJvFPRmMQcC7tFOgITF1pU4UQM=; b=lp3pf5
        epVyaXJCPpFBElg4HyXjKlvi0yAMxcEZSY58HXMLzb1Nl8pLByZyR9bQbI2k4PxC
        az76lCuhI7ElYkrN2TAuDCo7uwVMPuAj6YA21uW9yoqmXn9n0mLyp18OX9qQvGu3
        mB1y93U8PSvd4rGI3mkkyZ0zdOt2aJGKpbz+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C7i4YUHSoDtnlQ2JQI5UFZjIo31j24Mu
        jmg282b8fUgzhpJY1jnvlrGugHLVBuf8WapRaf5FL5osDRy3D2/ReEPz77M2ZfBj
        NOQnBBOR7OsWPhnMo3Zn3WbuBnMQdnlYuWGFHkflQw3WHm6TucJAxncL+vfAtWGc
        nHUSoYFRVqA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 479AEB7ABC;
        Tue,  5 Dec 2017 16:03:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3F89B7ABA;
        Tue,  5 Dec 2017 16:03:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 09/12] fixup: sha1_file: convert gotos to break/continue
References: <20171205165854.64979-1-git@jeffhostetler.com>
        <20171205165854.64979-10-git@jeffhostetler.com>
Date:   Tue, 05 Dec 2017 13:03:34 -0800
In-Reply-To: <20171205165854.64979-10-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Tue, 5 Dec 2017 16:58:51 +0000")
Message-ID: <xmqqfu8oj3a1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C248EF38-D9FF-11E7-8EFB-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> +	while (1) {
> +		if (find_pack_entry(real, &e))
> +			break;
>  
> +		/* Most likely it's a loose object. */
> +		if (!sha1_loose_object_info(real, oi, flags))
> +			return 0;
>  
> +		/* Not a loose object; someone else may have just packed it. */
> +		reprepare_packed_git();
> +		if (find_pack_entry(real, &e))
> +			break;
>  
> +		/* Check if it is a missing object */
> +		if (fetch_if_missing && repository_format_partial_clone &&
> +		    !already_retried) {
> +			fetch_object(repository_format_partial_clone, real);
> +			already_retried = 1;
> +			continue;
> +		}
> +
> +		return -1;
> +	}

OK.  This "infinite" loop actually never runs more than twice,
thanks to "already-retried" thing.  It probably makes sense to
structure the code this way.

I suspect that this would also have worked better with the older
incarnation of the jk/fewer-pack-rescan topic where an optimization
used to be after that the initial queries to packs fail to find the
object, but the topic has since been updated to do its optimization
check much earlier in the function, so its interaction with this
topic would not be much of an issue anymore with or without this
rewrite.

In any case, I think this is a good change.

