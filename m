Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72F8C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12B860F21
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhJLRRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:17:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52981 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLRRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 13:17:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14BD3163ED7;
        Tue, 12 Oct 2021 13:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KztniTeyppTEa2/Qqrl5ddD2KCwWy0+nrLHv4J
        nC7b4=; b=KMzVAheIPUArn4s79GAqYCD1Da/TxYFir1gMmdrKsBs4J3cna8bpkA
        2ICGo9mJuY5PP5ePQbmyiDs6t9duDoCSNtOplTrMLOy1gBA2dxIATPwHeS5P5YE3
        xcbbHuhEZmNKM1IfN2jXUukbxuq611/SaiEB7NhZ3YOBcx7qxogvY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F2879163ED6;
        Tue, 12 Oct 2021 13:15:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 78D54163ECF;
        Tue, 12 Oct 2021 13:15:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Robin Dupret <robin.dupret@gmail.com>, git@vger.kernel.org,
        Robin Dupret <robin.dupret@hey.com>
Subject: Re: [PATCH] http-backend: remove a duplicated code branch
References: <20211011192546.1571-1-robin.dupret@hey.com>
        <20211011192546.1571-2-robin.dupret@hey.com>
        <YWTyr6joJlyi1TPe@coredump.intra.peff.net>
Date:   Tue, 12 Oct 2021 10:15:12 -0700
In-Reply-To: <YWTyr6joJlyi1TPe@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 11 Oct 2021 22:27:59 -0400")
Message-ID: <xmqqfst65fmn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F652B20C-2B7F-11EC-BE87-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/http-backend.c b/http-backend.c
>> index e7c0eeab23..3d6e2ff17f 100644
>> --- a/http-backend.c
>> +++ b/http-backend.c
>> @@ -466,9 +466,7 @@ static void run_service(const char **argv, int buffer_input)
>>  	struct child_process cld = CHILD_PROCESS_INIT;
>>  	ssize_t req_len = get_content_length();
>>  
>> -	if (encoding && !strcmp(encoding, "gzip"))
>> -		gzipped_request = 1;
>> -	else if (encoding && !strcmp(encoding, "x-gzip"))
>> +	if (encoding && (!strcmp(encoding, "gzip") || !strcmp(encoding, "x-gzip")))
>>  		gzipped_request = 1;
>
> I think this conversion is correct, and I do find the resulting slightly
> easier to read. I wondered if the two conditions might have come
> separately, but no, they were both there in the initial 556cfa3b6d
> (Smart fetch and push over HTTP: server side, 2009-10-30).
>
> We do frown a bit on making small style changes like this. This kind of
> churn isn't dramatically improving the quality of the code, and it
> carries the risk of regression (if there is something subtle that you or
> the reviewers missed) and creates a maintenance burden (it may conflict
> with other patches, though I doubt it in this case, and it creates work
> for reviewers and the maintainer to apply).
>
> So...I dunno. I don't mind it, but it is not a pattern we like to
> encourage in general. Let's see what Junio thinks.

This particular conversion is mostly "Meh", although if it were done
in this way:

	if (encoding) {
		if (!strcmp(encoding, "gzip") || !strcmp(encoding, "x-gzip"))
			gzipped_request = 1;
	}

the result may be a bit less "meh" by making it easier to adjust the
code for other kinds of encoding in the future.

My usual rule of thumb for such a single-hunk clean-up patch that is
"obviously not incorrect" is to take it only once or twice per new
contributor.  At some point, new contributors gain enough experience
to know better, at which point I'd start frowning at them.

Thanks.
