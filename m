Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34DBC20966
	for <e@80x24.org>; Thu, 30 Mar 2017 17:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933721AbdC3RdU (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 13:33:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54549 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933259AbdC3RdU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 13:33:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C0096C998;
        Thu, 30 Mar 2017 13:33:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nwOxi76VPLZFlypRm498e7x1EAM=; b=gOWexo
        Ae/dXlvdB8sh7oo4gbb4a7Dyi1BjfisAXAq/bljR6VWznK5uwaNf+Z+ceBH9HreD
        qREPh08qDZfjFC3HbkDoNN8wdsne1SrIvFWBLaJHgK0kigjGkwEvnrDU24Go28X+
        h+8QueJT76Cx8M8+L9n7Ix8dw1VQudbd0Ytm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=feLInx0bd708BLJpbirpFj9LU5A9s1LS
        FPeq1O49G81w/cWwdzlcwC9XpSyKc6Tp6Asf6dW0QHeVTqMpSb3S6zoq4ERypRnj
        q7qFXRnOJeGQ5rvrKoAycjDtlCwS4G12kf2G8PRCXQJqm2CGFKbxvagnYd/8iisQ
        Ru5F5pCcZhA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63D586C997;
        Thu, 30 Mar 2017 13:33:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA2B96C995;
        Thu, 30 Mar 2017 13:33:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        David Turner <dturner@twopensource.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 04/11] update-index: add untracked cache notifications
References: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
        <1453877887-11586-5-git-send-email-chriscool@tuxfamily.org>
        <20170330032858.rdklpoipmvwjov4d@sigill.intra.peff.net>
Date:   Thu, 30 Mar 2017 10:33:16 -0700
In-Reply-To: <20170330032858.rdklpoipmvwjov4d@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 29 Mar 2017 23:28:58 -0400")
Message-ID: <xmqqefxe655v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F61C82BC-156E-11E7-BDAD-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 27, 2016 at 07:58:00AM +0100, Christian Couder wrote:
>
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index 62222dd..369c207 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -130,7 +130,7 @@ static int test_if_untracked_cache_is_supported(void)
>>  	if (!mkdtemp(mtime_dir.buf))
>>  		die_errno("Could not make temporary directory");
>>  
>> -	fprintf(stderr, _("Testing "));
>> +	fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());
>
> Coverity points out that this is a leak (xgetcwd returns an allocated
> buffer).

I saw that quite recently and was wondering why it reported it this
late.  It has been in 'master' for more than a month.

In any case, thanks for noticing and I agree the fix in the other
message is obviously correct.

