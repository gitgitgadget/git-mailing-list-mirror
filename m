Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D316207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161316AbcIZRkC (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:40:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55291 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935875AbcIZRkB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:40:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10233410B6;
        Mon, 26 Sep 2016 13:40:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t/yBPXbzikRRwIY/O2xvSY44esM=; b=Jh+iSX
        pmoNCJ74gtNu6Rq8i9HrMQBC4FeOWxF1+B1hOJesiMBroHqo574LbaEAkCn6NTFx
        Mjm2d5xoYcPLHTHmacNOEaDMZKlS+l0Z+syfV4isi6j3XfS6tlI5tkJsbjSg1Tr0
        TgyEkpLWqaEyUA3EkDjFnLyR3fe3qsLN8P43o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uNtcM2Q2b4+4nPAbNALFwQXlTYT64PnJ
        9/QNxm9D2F6gDH0/Ttep+xk8sfUuXrZsmGzC3xZgt4W3yZ+GYiVCxW/2HmWf2m75
        tEeOpAM8RF1zJtbCAtjhjVkGLHaVKqBzbylBULNgFCr/EphYCCtR+1pwU70OwOrM
        kkA9WkzMBuw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06A0A410B5;
        Mon, 26 Sep 2016 13:40:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F129410B4;
        Mon, 26 Sep 2016 13:39:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
        Gustavo Grieco <gustavo.grieco@imag.fr>
Subject: Re: [PATCH] unpack_sha1_header(): detect malformed object header
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
        <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
        <xmqqshsnuvvz.fsf_-_@gitster.mtv.corp.google.com>
        <20160926140309.l2h4b65gpqyutepn@sigill.intra.peff.net>
        <xmqqfuomvdqe.fsf@gitster.mtv.corp.google.com>
        <xmqqshsmtvju.fsf@gitster.mtv.corp.google.com>
        <20160926173540.j4rxcks3pmdcyvtd@sigill.intra.peff.net>
Date:   Mon, 26 Sep 2016 10:39:57 -0700
In-Reply-To: <20160926173540.j4rxcks3pmdcyvtd@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 26 Sep 2016 13:35:41 -0400")
Message-ID: <xmqqbmzatv9u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F2889EC-8410-11E6-9DB3-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/streaming.c b/streaming.c
>> index 811fcc2..884a8f1 100644
>> --- a/streaming.c
>> +++ b/streaming.c
>> @@ -347,7 +347,8 @@ static open_method_decl(loose)
>>  		return -1;
>>  	}
>>  
>> -	parse_sha1_header(st->u.loose.hdr, &st->size);
>> +	if (parse_sha1_header(st->u.loose.hdr, &st->size) < 0)
>> +		return -1;
>
> Do you have to git_inflate_end() and munmap() here, as the error path
> above does (this was missing from my patch, too)?

Ah, definitely.  We'd need to be consistent; otherwise we'd be
either leaking resources (or existing one double-freeing).
