Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5DAC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C306135F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhHXVnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:43:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57568 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbhHXVnG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:43:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93BF8D3824;
        Tue, 24 Aug 2021 17:42:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8MK2Xot5HyFPa7qtu8UMjGCCVl3hI3eiMx6whV
        uaH1Q=; b=ZVqWVKuwpMouOhSu03Ark2IndGAwm3xPun4mmqLaK1asYU7ylz0rH1
        fQC2ncDlMY2LffZdqefGvIJ6WyJy8oujT1Jc8zB6uM7u01QYJo/frJ9aMJzW9wtJ
        qbMNid0xVj8ElaEtPfc4tNzkZ+R7bekkMAWseIiTS5OwEeQpSgCGs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C455D3823;
        Tue, 24 Aug 2021 17:42:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A2EFD3822;
        Tue, 24 Aug 2021 17:42:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] upload-pack: buffer ref advertisement writes
References: <20210824140259.89332-1-jacob@gitlab.com>
        <YSVfq9lZGdSRCcP9@nand.local>
Date:   Tue, 24 Aug 2021 14:42:20 -0700
In-Reply-To: <YSVfq9lZGdSRCcP9@nand.local> (Taylor Blau's message of "Tue, 24
        Aug 2021 17:07:55 -0400")
Message-ID: <xmqqczq2mseb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29491138-0524-11EC-A244-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> @@ -105,7 +108,12 @@ static int send_ref(const char *refname, const struct object_id *oid,
>>  	}
>>
>>  	strbuf_addch(&refline, '\n');
>> -	packet_write(1, refline.buf, refline.len);
>> +
>> +	packet_buf_write_len(&data->out, refline.buf, refline.len);
>> +	if (data->out.len >= OUT_WRITE_SIZE) {
>> +		write_or_die(1, data->out.buf, data->out.len);
>> +		strbuf_reset(&data->out);

This is somewhat unexpected.  When one introduces size limit, it is
more natural to make it upper bound and arrange the code more like

	if (currently buffered plus new data exceeds size limit) {
		flush the currently buffered data;
		if (new data alone exceeds size limit)
			flush the new data;
		else
			buffer the new data;
	} else {
		buffer the new data;
	}

When a single packet exceeds the size limit, you'd end up making an
oversize write() call anyway, but otherwise it would keep the write
below the limit, not slightly above the limit, which makes it much
easier to justify why the limit exists at the level it is set.

Also, why is it 32k?  Our jumbo packet limit is 65k, I think, and it
may probably be easier to explain if we matched it.

>> +	}
>
> None of this looks wrong to me, but it might be nice to teach the
> packet writer a buffered mode that would handle this for us. It would be
> especially nice to bolt the final flush onto packet_flush(), since it is
> otherwise easy to forget to do.

FWIW, the packet-line part of the system was from the beginning
written with an eye to allow buffering until _flush() comes; we may
have added some buggy conversation path that deadlocks if we make
the non-flush packets fully buffered, so there may need some fixes,
but I do not expect the fallout would be too hard to diagnose.

It may be worth trying that avenue first before piling on the user
level buffering like this patch does.

Thanks.
