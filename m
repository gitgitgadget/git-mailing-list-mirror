Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB6DC47247
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5E32173E
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iX58+raQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgEHPrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 11:47:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53465 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgEHPrD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 11:47:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CD805B127;
        Fri,  8 May 2020 11:46:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8w+qX2fmGZHU1GjOiw0cQ7RT0To=; b=iX58+r
        aQrnxpfoDu+3446RsvhnIpIzU9t/Y5TTcFZKusE0jdpotFB1ESYrtx7qNRba5IeO
        BqrGvoV4YDEWlAtY/htg9E7cz+UIdehadm+FduJJ5cWahau3lF8TLeIgjibPEt79
        t+lLdFXfSSCVXwF+nTaI/JjdBasWIVqYaVSNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aWjLQLnDJVEzp5Uk0W5QgwCb7N/hfWcL
        8kF/elQcYqXkyqrOn8q8PM8mlruUEL/ZM1ZIJqwvdOOiLUoDfu2howfUGiFvrQqC
        e1f70UbyYWAdPTjui7jIsvESGPt3V3aeB1rtpUq326y6yLxR0Mrvc1AqIU7bTzHa
        nvsn4OHSMjc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6144F5B126;
        Fri,  8 May 2020 11:46:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C54EB5B125;
        Fri,  8 May 2020 11:46:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] upload-pack: fix filter options scope
References: <20200507095829.16894-1-chriscool@tuxfamily.org>
        <20200508080115.15616-1-chriscool@tuxfamily.org>
        <20200508130616.GA631018@coredump.intra.peff.net>
Date:   Fri, 08 May 2020 08:46:58 -0700
In-Reply-To: <20200508130616.GA631018@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 8 May 2020 09:06:16 -0400")
Message-ID: <xmqqtv0qzax9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26D148F4-9143-11EA-AB40-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, May 08, 2020 at 10:01:15AM +0200, Christian Couder wrote:
>
>> The changes since the previous RFC version are the following:
>> 
>>   - now filter_options is part of struct upload_pack_data as
>>     suggested by Peff and Taylor
>>   - improved commit message
>>   - updated comment before the test that used to fail
>
> Thanks, this version looks good to me.
>
>>  static void create_pack_file(const struct object_array *have_obj,
>> -			     const struct object_array *want_obj)
>> +			     const struct object_array *want_obj,
>> +			     struct list_objects_filter_options *filter_options)
>
> I had hoped that stuffing it into upload_pack_data would require fewer
> changes passing it around, but I guess many of these functions don't
> know about upload_pack_data in the first place. Oh well. I think this is
> the best we can do for now. In the long run we'd perhaps want to take
> upload_pack_data there, but it wouldn't help until the v0 path also uses
> that struct.

Yup, I agree that this v2-only fix is a good first step.

Even though the log message itself got a lot better explaining the
nature of the issue, I do not think the title of the patch does a
good job explaining what it is about to the readers of shortlog.

"fix" is a meaningless word in a bugfix patch, and it does not make
it clear what bad effect of the original code had by not giving a
clean-slate "options" variable to the second invocation of the
callchain.

Is it that the server side was incapable of serving a follow-up
fetch request in the same process when protocol v2 was in use?
Perhaps

    upload-pack: allow follow-up fetch in protocol v2

or something?

I care about singling out protocol v2 because then we would
immediately know that backporting this to older maintenance track is
of lower priority as the plan is to flip the default back to v0.

Thanks.
