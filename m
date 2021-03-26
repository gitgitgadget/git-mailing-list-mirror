Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AB4C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 21:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C70161A28
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 21:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCZVin (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 17:38:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52589 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZViL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 17:38:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 271BBAEFEF;
        Fri, 26 Mar 2021 17:38:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YORw4qLCfFLTp2SxDkYkEEcVFQs=; b=NWB6Rk
        FWF6AzWbpFIlh8Iyf7HtVuSCT6wSiwNKYcfr6CdvooVu5luNE8SmZd5yi3wMnAHD
        yD3K8DNy+blDkO9VJjGmsJNOZm9Y6UOsZifGsXyIp6K/830IhD08MltH0MKVD2wu
        jWrinR7XCIwoqn+KG+oPq5B+DsCbCPspfRS1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HFNMbinQ9iGM2C/Ze7x2psb5E93EKo7y
        jO81ZVVs3ihyruNxBbf3yt7Mxje06Xx2tCjC3DW9T/vMbWsDWwpYvqYLVeCp+X49
        z533wlw3qwfSvbhr9lUCrh1szrJyfe2pWZA5jerosVPamPhin/qU+EGninC+1TsH
        vzUnZfqxpzE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC879AEFEE;
        Fri, 26 Mar 2021 17:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C306AAEFED;
        Fri, 26 Mar 2021 17:38:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] csum-file: make hashwrite() more readable
References: <pull.914.git.1616608219602.gitgitgadget@gmail.com>
        <pull.914.v2.git.1616762291574.gitgitgadget@gmail.com>
Date:   Fri, 26 Mar 2021 14:38:03 -0700
In-Reply-To: <pull.914.v2.git.1616762291574.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 26 Mar 2021 12:38:11
        +0000")
Message-ID: <xmqqlfa9siis.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C432C08-8E7B-11EB-B41C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  		if (nr == sizeof(f->buffer)) {
> -			/* process full buffer directly without copy */
> -			data = buf;
> +			/*
> +			 * Flush a full batch worth of data directly
> +			 * from the input, skipping the memcpy() to
> +			 * the hashfile's buffer. In this block,
> +			 * f->offset is necessarily zero.
> +			 */

What made me a bit confused was the fact that, in order to exercise
the "bypass memcpy and take a full bufferful from the incoming data
directly" optimization, there are two preconditions.  The incoming
data must be large enough, and we do not have anything kept in the
buffer that needs to be emitted before the incoming data.  And the
cleverness of the original code was that both are checked by this
single "nr == sizeof(f->buffer)" condition.

So I do appreciate this extra comment, and I think future readers of
the code will, too.

> +			the_hash_algo->update_fn(&f->ctx, buf, nr);
> +			flush(f, buf, nr);
>  		} else {
> -			memcpy(f->buffer + offset, buf, nr);
> -			data = f->buffer;
> +			/*
> +			 * Copy to the hashfile's buffer, flushing only
> +			 * if it became full.
> +			 */
> +			memcpy(f->buffer + f->offset, buf, nr);
> +			f->offset += nr;
> +			left -= nr;
> +			if (!left)
> +				hashflush(f);
>  		}
>  
>  		count -= nr;
> -		offset += nr;
>  		buf = (char *) buf + nr;
> -		left -= nr;
> -		if (!left) {
> -			the_hash_algo->update_fn(&f->ctx, data, offset);
> -			flush(f, data, offset);
> -			offset = 0;
> -		}
> -		f->offset = offset;
>  	}
>  }
>  
>
> base-commit: 142430338477d9d1bb25be66267225fb58498d92
