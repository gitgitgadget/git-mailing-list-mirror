Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F67CE79A4
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 21:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjIYVvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 17:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIYVvN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 17:51:13 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA31AF
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 14:51:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 231311CBB12;
        Mon, 25 Sep 2023 17:51:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Xc9+56e2GNzrQ/frP914XHEaKdhgjPGK8Zgr7R
        Wrx7s=; b=Ax0/P4j9Rmpn2Yfg1+8fRqwA6RGpNvFi15M7S8ygtJVhuUvJTbAYym
        1ALgzJbi1tbZH6n1mXunE/yc6tco9pz8V9vx41WaTdeGIBU51CSpxy25Ale22Xuq
        AO3qidFxHArlasqyxeEYO5CH/hiGRBz8wdBZER3Ho8FKDg3hwtmMk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEE811CBB11;
        Mon, 25 Sep 2023 17:51:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCA271CBB10;
        Mon, 25 Sep 2023 17:51:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 3/3] pkt-line: do not chomp newlines for sideband
 messages
In-Reply-To: <20230925154144.15213-3-worldhello.net@gmail.com> (Jiang Xin's
        message of "Mon, 25 Sep 2023 23:41:44 +0800")
References: <CANYiYbF+Xmk4rCNLMJe+i_CFafg8=QU5vbXWNUZbOVsDLTe5QQ@mail.gmail.com>
        <20230925154144.15213-3-worldhello.net@gmail.com>
Date:   Mon, 25 Sep 2023 14:51:02 -0700
Message-ID: <xmqqa5t9rkft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0305398-5BED-11EE-9070-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Add new flag "PACKET_READ_USE_SIDEBAND" for "packet_read_with_status()"
> to prevent mangling newline characters in sideband messages.
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  pkt-line.c             | 32 ++++++++++++++++++++++++++++++--
>  pkt-line.h             |  1 +
>  t/t0070-fundamental.sh |  2 +-
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index 5943777a17..865ad19484 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -462,8 +462,33 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
>  	}
>  
>  	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
> -	    len && buffer[len-1] == '\n')
> -		len--;
> +	    len && buffer[len-1] == '\n') {
> +		if (options & PACKET_READ_USE_SIDEBAND) {
> +			int band = *buffer & 0xff;
> +			switch (band) {
> +			case 1:
> +				/* Chomp newline for payload */
> +				len--;
> +				break;
> +			case 2:
> +				/* fallthrough */
> +			case 3:
> +				/*
> +				 * Do not chomp newline for progress and error
> +				 * message.
> +				 */
> +				break;
> +			default:
> +				/*
> +				 * Bad sideband, let's leave it to
> +				 * demultiplex_sideband() to catch this error.
> +				 */
> +				break;
> +			}
> +		} else {
> +			len--;
> +		}
> +	}

That's a mouthful and we could shorten it a lot, but is very easy to
follow the logic ;-)

> diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
> index a927c665d6..138c2becc1 100755
> --- a/t/t0070-fundamental.sh
> +++ b/t/t0070-fundamental.sh
> @@ -97,7 +97,7 @@ test_expect_success 'unpack-sideband with demultiplex_sideband(), no chomp newli
>  	test_cmp expect-err err
>  '
>  
> -test_expect_failure 'unpack-sideband with demultiplex_sideband(), chomp newline' '
> +test_expect_success 'unpack-sideband with demultiplex_sideband(), chomp newline' '
>  	test_when_finished "rm -f expect-out expect-err" &&
>  	test-tool pkt-line send-split-sideband >split-sideband &&
>  	test-tool pkt-line unpack-sideband \

We cannot quite see what got fixed that is outside the postimage,
but it is nice that we have one fewer test_expect_failure in the
end.

Will queue.  Thanks.
