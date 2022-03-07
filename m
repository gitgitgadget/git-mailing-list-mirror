Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DEBC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 06:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiCGGMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 01:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiCGGMC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 01:12:02 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5440E1CFD7
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 22:11:08 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7282127B07;
        Mon,  7 Mar 2022 01:11:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+5bibCtDWeTxlEljspxM9lHqr1quHXM6WlL+x4
        OsJgQ=; b=Pr91lJ8aBUfwyH6avKW9e4p6qDOh6XUkn4QQft4siOlnAvo+11MLYk
        5pqNuUmxEjDs7w4LmZlZ1HGvsll0bZcS6GZYtQH6y/ip7W57S808GONR8nmC6X9Y
        O8YPSgmCvL0lCmR9M2Y2ailkvA26CvnpDhRoTALenjhOQAQEao8Fc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2763127B05;
        Mon,  7 Mar 2022 01:11:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7A57127B04;
        Mon,  7 Mar 2022 01:11:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] cat-file: skip expanding default format
References: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
        <xmqqmti2uwzr.fsf@gitster.g>
Date:   Sun, 06 Mar 2022 22:11:03 -0800
In-Reply-To: <xmqqmti2uwzr.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        06 Mar 2022 21:56:08 -0800")
Message-ID: <xmqqilsquwaw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F03E5B2-9DDD-11EC-B74C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> When format is passed into --batch, --batch-check, --batch-command,
>> the format gets expanded. When nothing is passed in, the default format
>> is set and the expand_format() gets called.
>>
>> We can save on these cycles by hardcoding how to print the
>> information when nothing is passed as the format, or when the default
>> format is passed. There is no need for the fully expanded format with
>> the default. Since batch_object_write() happens on every object provided
>> in batch mode, we get a nice performance improvement.
>
> That is OK in principle, but ...
>
>> +	if (!opt->format && !opt->print_contents) {
>> +		char buf[1024];
>> +
>> +		print_default_format(buf, 1024, data);
>> +		batch_write(opt, buf, strlen(buf));
>> +		goto cleanup;
>> +	}
>> +
>> +	fmt = opt->format ? opt->format : default_format;
>
> ... instead of doing this, wouldn't it be nicer to base the decision
> to call print_default_format() on purely the contents of the format,
> i.e.
>
> 	fmt = opt->format ? opt->format : default_format;
> 	if (!strcmp(fmt, DEFAULT_FORMAT) && !opt->print_contents) {
> 		... the above print_default_format() call block here ...
> 		goto cleanup;
> 	}
>
> where DEFAULT_FORMAT is 
>
> #define DEFAULT_FORMAT = "%(objectname) %(objecttype) %(objectsize)"
>
> and
>
>> @@ -515,9 +543,7 @@ static int batch_objects(struct batch_options *opt)
>>  	struct expand_data data;
>>  	int save_warning;
>>  	int retval = 0;
>> -
>> -	if (!opt->format)
>> -		opt->format = "%(objectname) %(objecttype) %(objectsize)";
>
> retain the defaulting with
>
> 	if (!opt->format)
> 		opt->format = DEFAULT_FORMAT;
>
> instead of making opt->format == NULL to mean something special?
>
> That way, even if the user-input happens to name the format that is
> identical to DEFAULT_FORMAT, because we only care what the format
> is, and not where the format comes from, we will get the same
> optimization.  Wouldn't it make more sense?

Actually, doing that literally and naively would not be a good idea,
as the special case code is inside batch_object_write() that is
called once per each object, and because the format used will not
change for each call, doing strcmp() every time is wasteful.  The
same is true for

	fmt = opt->format ? opt->format : default_format;

as opt->format will not change across calls to this function.

So, if we were to do this optimization:

 * we key on the fact that opt->format is NULL to trigger the
   optimization inside batch_object_write(), so that we do not have
   to strcmp(DEFAULT_FORMAT, fmt) for each and every object.

 * a while loop in batch_objects() or for_each_*_object() calls is
   what calls batch_object_write() for each object.  So somewhere
   early in that function (or before we enter the function), we can
   check opt->format and

    - if it is NULL, we can leave it NULL.
    - if it is the same as DEFAULT_FORMAT, clear it to NULL.

   so that the optimization in batch_object_write() can cheaply kick
   in.

would be a good way to go, perhaps?
