Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E96211B3
	for <e@80x24.org>; Fri,  7 Dec 2018 00:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeLGAWO (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 19:22:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61408 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGAWO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 19:22:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4B9D36527;
        Thu,  6 Dec 2018 19:22:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gABEtxiHf0wbPLrDAViITzL4bOQ=; b=Qr1nCv
        g830Zww84SQCmy2s8Hpi3GkrrICzeb54n0TNmPjWlplhDWR3KOOE89N5LfAJ/uJD
        0UAsOmvRssfB/v+S3p8fzGUdV6JErMqmzzTFil53Rp7Zs29esDsmdyV/6ngGjpo3
        XibIT7ipdY1Ze2DZh2dWp6P8aJ3bGcxBFlZE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jBPs+ZLJgM7Oev45Ai4j9lXK8/IopOmZ
        j9IK4DMB1bN3ZpyBZ0cbpGsGtifBsVo0CRTuIo6igPGlGwlXHYHBLmCHxWIzcPW8
        r/hixG3OwU9Banlh6owOxXoKyhmaAHpY4ZlcKboEuEUTiFIfxjnBOk99X0PuTA0I
        ZHHcv26k4Po=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9DA6A36526;
        Thu,  6 Dec 2018 19:22:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AEFD136525;
        Thu,  6 Dec 2018 19:22:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP RFC 4/5] upload-pack: refactor writing of "packfile" line
References: <xmqqzhtj88nw.fsf@gitster-ct.c.googlers.com>
        <20181206232538.141378-1-jonathantanmy@google.com>
Date:   Fri, 07 Dec 2018 09:22:04 +0900
In-Reply-To: <20181206232538.141378-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 6 Dec 2018 15:25:38 -0800")
Message-ID: <xmqqmupi89ub.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20F86E2E-F9B6-11E8-8166-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>> > @@ -126,6 +129,12 @@ static int read_pack_objects_stdout(int outfd, struct output_state *os)
>> >  	}
>> >  	os->used += readsz;
>> >  
>> > +	if (!os->packfile_started) {
>> > +		os->packfile_started = 1;
>> > +		if (use_protocol_v2)
>> > +			packet_write_fmt(1, "packfile\n");
>> 
>> If we fix this function so that the only byte in the buffer is held
>> back without emitted when os->used == 1 as I alluded to, this may
>> have to be done a bit later, as with such a change, it is no longer
>> guaranteed that send_client_data() will be called after this point.
>
> I'm not sure what you mean about there being no guarantee that
> send_client_data() is not called - in create_pack_file(), there is an
> "if (output_state.used > 0)" line (previously "if (0 <= buffered)") that
> outputs anything remaining.

I was referring to this part of the review on the previous step,
which you may not yet have read.

    OK, this corresponds to the "*cp++ = buffered"  in the original just
    before xread().

    > +		os->used = 1;
    > +	} else {
    > +		send_client_data(1, os->buffer, os->used);
    > +		os->used = 0;

    I am not sure if the code is correct when os->used happens to be 1
    (shouldn't we hold the byte, skip the call to send_client_data(),
    and go back to poll() to expect more data?), but this is a faithful
    code movement and rewrite of the original.

The point of this logic is to make sure we always hold back some
bytes and do not feed *all* the bytes to the other side by calling
"send-client-data" until we made sure the upstream of what we are
relaying (pack-objects?) successfully exited, but it looks to me
that the "else" clause above ends up flushing everything when
os->used is 1, which goes against the whole purpose of the code.

And the "fix" I was alluding to was to update that "else" clause to
make it a no-op that keeps os->used non-zero, which would not call
send-client-data.

When that fix happens, the part that early in the function this
patch added "now we know we will call send-client-data, so let's say
'here comes packdata' unless we have already said that" is making
the decision too early.  Depending on the value of os->used when we
enter the code and the number of bytes xread() reads from the
upstream, we might not call send-client-data yet (namely, when we
have no buffered data and we happened to get only one byte).

> ... it might be
> better if the server can send sideband throughout the whole response -
> perhaps that should be investigated first.

Yup.  It just looked quite crazy, and it is even more crazy to
buffer keepalives ;-)
