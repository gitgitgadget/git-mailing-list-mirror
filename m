Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF77C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D72C223B16
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbhAVWLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:11:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50667 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730939AbhAVWLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 17:11:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C12E7A8AD6;
        Fri, 22 Jan 2021 17:10:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vftZrvcCl8Fwl+Ps1BhSaJrKxWs=; b=kcCjlU
        d9ogwEsFzcwArXnfHNOCWZ3dbK11twiZKKeiAeLU7wYwEkqAQa9y8dFIvv/Q8jn5
        nYzwNV6X35pfWtQab0OjwM3q5V+l9M1BZR3Fh1dYBG2NfINGGnbrDajKx22a10Ov
        vljeW5N6autjrjv9poUaVQlbjJqOheNJL0OO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZHgfkwYGykMzxxPoZTqIvdiMgQ9NC+f8
        hJcvDSaASgoH1tOv4xEJ+//RDRlLBpK8g5z1bYXTYGfOalIDm/XPkWxk0pBrrtyC
        26SUIaKfYzfHdXhPPvqAmYc4kG070Ih2dK+i9NonqIVgo5TCVUKFxlwzCyFAxDO6
        1Mm4KfB/JNQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8A42A8AD4;
        Fri, 22 Jan 2021 17:10:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FCF3A8AD3;
        Fri, 22 Jan 2021 17:10:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Vosmaer <jacob@gitlab.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] upload-pack.c: fix filter spec quoting bug
References: <20210122142137.21161-1-jacob@gitlab.com>
        <20210122142137.21161-2-jacob@gitlab.com>
        <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
Date:   Fri, 22 Jan 2021 14:10:25 -0800
In-Reply-To: <YAs2RMT1rEH/2LSp@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 22 Jan 2021 15:32:04 -0500")
Message-ID: <xmqq4kj87hda.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1464BDE-5CFE-11EB-9261-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jan 22, 2021 at 03:21:37PM +0100, Jacob Vosmaer wrote:
>
>> This fixes a bug that occurs when you combine partial clone and
>> uploadpack.packobjectshook. You can reproduce it as follows:
> ...
> I'm somewhat embarrassed to say that despite being the one who added the
> pack-objects hook 4 years ago, we still have not switched over to it at
> GitHub from our custom patch (the reason is just mundane; there's some
> other adjustments that would have to happen and nobody has ever quite
> gotten around to it). Presumably you are looking to use it at GitLab.
> Just beware that you are probably treading new-ish ground, so there may
> be other bugs like this lurking.
>
>> diff --git a/upload-pack.c b/upload-pack.c
>> index 3b66bf92ba..eae1fdbc55 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -305,14 +305,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>>  	if (pack_data->filter_options.choice) {
>>  		const char *spec =
>>  			expand_list_objects_filter_spec(&pack_data->filter_options);
>> -		if (pack_objects.use_shell) {
>> -			struct strbuf buf = STRBUF_INIT;
>> -			sq_quote_buf(&buf, spec);
>> -			strvec_pushf(&pack_objects.args, "--filter=%s", buf.buf);
>> -			strbuf_release(&buf);
>> -		} else {
>> -			strvec_pushf(&pack_objects.args, "--filter=%s", spec);
>> -		}
>> +		strvec_pushf(&pack_objects.args, "--filter=%s", spec);
>
> Yep, this looks like the right fix. I think with an addition to the test
> suite, this will be good to go.

Yeah, that looks simpler and better.  It does deserve new tests.

Thanks, both.
