Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E881F406
	for <e@80x24.org>; Wed, 17 Jan 2018 20:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754978AbeAQUyj (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 15:54:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62968 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754973AbeAQUyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 15:54:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C85DBC9318;
        Wed, 17 Jan 2018 15:54:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UM/ekAHb5ApVwG63bxmCqx1oU+E=; b=mtEv4n
        EWxsoQ9QtzzQI5Pc7eHoHhPjR3M9ujefvr0GPIwTmIFWJ0OTAp3NEV2TA860vci0
        Li/VL9iPShDUDwUi3UjOHy9rufdQlV/C8WZYwAKN3vqsLt8ZZFCAKPIXr2g7NQja
        wTNHV10K/lZHWNKVcZYOXkunnXf/wRqpVU9kE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qpg/sig+O4bKYAB/UYd5pfmNZ73HWVQj
        gmWl5qCp6igV1mAVaCT2RyaO7EwnGmi4mFk97CH2JpZ9RQdbHiK23JbMNIXsFBy8
        jcxs/oCF26QJtZxXE0f7jBsl700OaDTH4U5THZbMW8lT7qzwoyYEwGxAUeENCj8S
        fKMJY4AzOE8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE487C9317;
        Wed, 17 Jan 2018 15:54:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DED9C9316;
        Wed, 17 Jan 2018 15:54:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, Kevin Daudt <me@ikke.info>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/2] sha1_file: improve sha1_file_name() perfs
References: <20180117175455.9316-1-chriscool@tuxfamily.org>
        <20180117175455.9316-2-chriscool@tuxfamily.org>
        <3cbace45-61df-3074-a48c-66c68c96d542@jeffhostetler.com>
Date:   Wed, 17 Jan 2018 12:54:33 -0800
In-Reply-To: <3cbace45-61df-3074-a48c-66c68c96d542@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 17 Jan 2018 15:37:55 -0500")
Message-ID: <xmqq4lnkryt2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F428C66-FBC8-11E7-8B6B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>>     void sha1_file_name(struct strbuf *buf, const unsigned char
>> *sha1)
>>   {
>> -	strbuf_addf(buf, "%s/", get_object_directory());
>> +	const char *obj_dir = get_object_directory();
>> +	size_t extra = strlen(obj_dir) + 1 + GIT_MAX_HEXSZ;
>
> Very minor nit.  Should this be "+3" rather than "+1"?
> One for the slash after obj_dir, one for the slash between
> "xx/y[38]", and one for the trailing NUL.
>
>>   +	if (extra > strbuf_avail(buf))
>> +		strbuf_grow(buf, extra);

The callers who care use static strbuf with 1/2, which lets them
grow it to an appropriate size after they make their first call.

On the other hand, the ones to which performance does not matter by
definition do not care.

I actually think this whole "extra -> grow" business should be
discarded.  With a miscomputed "extra" like this, it does not help
anybody---everybody may pay cost for one extra realloc due to the
miscalculation, and the ones that do care also do during their first
call.


