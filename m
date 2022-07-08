Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B9BC43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 15:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbiGHPFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 11:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiGHPFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 11:05:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6CA2CE37
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 08:05:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BDB351B519E;
        Fri,  8 Jul 2022 11:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lepn9YURT/XV7KUp9MszF55TOgTh3dE7hZU8QO
        1jZUQ=; b=GyRXAcDdk6QbwU6V6nN9iW5AWrZYbQJXwW7s4WAC3DJQTypUyq6vrl
        ZMbQdTqCEHnmSmBGrfQ0vrR3k5EtwCpeVdl6NeVGDSzeamhdFDYC1UELJI7BoOAA
        iJJYiduG0FeTUSJSEIEcmxdvZliPv6cHAONGxJLyzO8VCaHRWO3Gw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B75811B519D;
        Fri,  8 Jul 2022 11:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5517B1B519C;
        Fri,  8 Jul 2022 11:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Kilian Kilger via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kilian Kilger <kkilger@gmail.com>,
        Kilian Kilger <kilian.kilger@sap.com>
Subject: Re: [PATCH] git-p4: fix bug with encoding of p4 client name
References: <pull.1285.git.git.1657267260405.gitgitgadget@gmail.com>
        <CAPMMpohwP1U4pr-G=fDDu_AHTY-2mn8hn8zBf-pAsmm=w0mSzw@mail.gmail.com>
Date:   Fri, 08 Jul 2022 08:05:09 -0700
In-Reply-To: <CAPMMpohwP1U4pr-G=fDDu_AHTY-2mn8hn8zBf-pAsmm=w0mSzw@mail.gmail.com>
        (Tao Klerks's message of "Fri, 8 Jul 2022 13:28:51 +0200")
Message-ID: <xmqqmtdjwspm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C680BC8-FECF-11EC-A2BC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

>
>
> On Fri, Jul 8, 2022 at 10:01 AM Kilian Kilger via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Kilian Kilger <kilian.kilger@sap.com>
>>
>> The Perforce client name can contain arbitrary characters
>> which do not decode to UTF-8. Use the fallback strategy
>> implemented in metadata_stream_to_writable_bytes() also
>> for the client name.
>>
>> Signed-off-by: Kilian Kilger <kkilger@gmail.com>
>> ---
>> ...
>>
>> @@ -871,6 +871,8 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
>>                      continue
>>              if 'desc' in entry:
>>                  entry['desc'] = metadata_stream_to_writable_bytes(entry['desc'])
>> +            if 'client' in entry:
>> +                entry['client'] = metadata_stream_to_writable_bytes(entry['client'])
>>              if 'FullName' in entry:
>>                  entry['FullName'] = metadata_stream_to_writable_bytes(entry['FullName']

We had two repetitions and now we have three, which is a good time
to see if it makes sense to reduce the temptation for future
developers to add the fourth repetition in the next round, e.g.

	for e in ["client", "desc", "FullName"]:
		if e in entry:
			entry[e] = metadata_stream_to_writable_bytes(entry[e])

or something like that?

> This makes sense to me, and I don't see anything wrong with the "form"
> (and nor does GitGitGadget).

One thing that is a bit problematic is that in-body From does not
match the sign-off.  Kilian, which identity do you want to use in
your contribution to this project? 

> Not sure whether formal review sign-off is used on this list, I don't
> tend to see it, but do I see "Reviewed-by" on patches, so FWIW:
>
> Reviewed-by: Tao Klerks <tao@klerks.biz>

Thanks.

