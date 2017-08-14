Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A73C20899
	for <e@80x24.org>; Mon, 14 Aug 2017 16:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbdHNQ4D (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 12:56:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56347 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751592AbdHNQ4C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 12:56:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EE00A6C8B;
        Mon, 14 Aug 2017 12:56:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=fhW36CJF8as0OdY6Fn6RvakR+VI=; b=AFKyJI
        f705R8xjy9onBTOY4wgaIO6cOFET9dwI350rjmggQjd2lB9DX8e2LKtKogcV2UJE
        7pYXEd4wNMhFmHeoimZvubnPZxljGXKTq1sIHjQa0X7IzZWdhfsKM5Hdf5KzN26c
        b3AtI5tWqcsj9XpIpbpvyG+G/WAFKbA61mzgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ih/ctLjjwKpS9CGFJtAfl57Z0W42wIV9
        Ya2cNuJfVmdSmipA/q8vSpCLckeN6OTHzeyWDy25+c5O6pH9KdGIN/4IPySwZ4CM
        ql+AAis0P9UTHTHG005RGK/r+eyBQkQ6eAgN8YeuhwemBhr953M6iyDaY4wq27tN
        6/1l+dpySLA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46A9AA6C8A;
        Mon, 14 Aug 2017 12:56:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96EA7A6C88;
        Mon, 14 Aug 2017 12:56:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] Add overflow check to get_delta_hdr_size
In-Reply-To: <1502522838-12581-1-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Sat, 12 Aug 2017 09:27:18 +0200")
References: <1502522838-12581-1-git-send-email-martin@mail.zuhause>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
Date:   Mon, 14 Aug 2017 09:56:00 -0700
Message-ID: <xmqqk226w0kf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73DC8090-8111-11E7-B767-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> From: Martin Koegler <martin.koegler@chello.at>
>
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---
> Applies on top of my size_t series
>
> I'm not sure, if die or error is better.

As there is no fallback when we hit it, die would be sufficient; the
only thing the callers of this helper, or their callers, could do is
as a reaction to an error return from here would be to die themselves,
I would think.




>  delta.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/delta.h b/delta.h
> index 2df0f55..18a4983 100644
> --- a/delta.h
> +++ b/delta.h
> @@ -96,6 +96,11 @@ static inline size_t get_delta_hdr_size(const unsigned char **datap,
>  		cmd = *data++;
>  		size |= (cmd & 0x7f) << i;
>  		i += 7;
> +		if (bitsizeof(size_t) <= i) {
> +			error("too large object size");
> +			size = 0;
> +			break;
> +		}
>  	} while (cmd & 0x80 && data < top);
>  	*datap = data;
>  	return size;
