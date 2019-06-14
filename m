Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04FB71F462
	for <e@80x24.org>; Fri, 14 Jun 2019 20:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfFNU0E (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 16:26:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52437 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFNU0E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 16:26:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34425161FA4;
        Fri, 14 Jun 2019 16:26:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DcjG3UAxbDSKvf0HiDt9oQuN36s=; b=EgAJkh
        WQDD7hAyyYcN6ikMuvLQQjRsgj8ZS1xbao2DRUfs6lgzs23TE2FHWfeOwNfl5tGw
        mSCRPEoUuWaBHxSf1BYRVfI/BwsziTQNpJa+iXnS0HixL7TYYcJtvfF+o0j2WRg2
        ySV5kyesA0WAnnJ4bh8wExhXHiFLNg3i8wNA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eIa6VN7E3zsWh7xr7R+FsB5n1ggLsyrP
        xkLXipXaWJ7riltKizrrAFHHABCC5H9e3dEPNQmtys1oKx7Hhf/eGDJdNzgNefVo
        +o7QjQt5xAqOUb3gzoI3tE5FiIjdMkvxE1eWfsnvnwGLOoLYbreguoBgZJmJwKOp
        yK/MQhlazs4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22AAB161FA3;
        Fri, 14 Jun 2019 16:26:02 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E56A0161FA2;
        Fri, 14 Jun 2019 16:26:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] rev-list: teach --oid-only to enable piping
References: <20190607225900.89299-1-emilyshaffer@google.com>
        <20190613215102.44627-1-emilyshaffer@google.com>
        <20190614160728.GA30083@sigill.intra.peff.net>
Date:   Fri, 14 Jun 2019 13:25:59 -0700
In-Reply-To: <20190614160728.GA30083@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 14 Jun 2019 12:07:28 -0400")
Message-ID: <xmqqlfy3ud60.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FFF85EC-8EE2-11E9-AE8D-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But I wonder if things would be simpler if we did not touch the commit
> code path at all. I.e., if this were simply "--no-object-names", and it
> touched only show_object().

Yeah, that sounds more tempting.  And the refined code structure you
suggested ...

>> @@ -255,6 +262,10 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
>>  	display_progress(progress, ++progress_counter);
>>  	if (info->flags & REV_LIST_QUIET)
>>  		return;
>> +	if (arg_oid_only) {
>> +		printf("%s\n", oid_to_hex(&obj->oid));
>> +		return;
>> +	}
>>  	show_object_with_name(stdout, obj, name);
>>  }
>>  
>
> A minor style point, but I think this might be easier to follow without
> the early return, since we are really choosing to do A or B. Writing:
>
>   if (arg_oid_only)
> 	printf(...);
>   else
> 	show_object_with_name(...);
>
> shows that more clearly, I think.

... is a good way to clearly show that intention, I would think.

