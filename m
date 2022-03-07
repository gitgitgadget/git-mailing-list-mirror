Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE33DC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 20:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiCGUol (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiCGUok (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 15:44:40 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27797DE39
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 12:43:45 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C50DA12DA81;
        Mon,  7 Mar 2022 15:43:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UCCwOyFPaBReWmiJcRNJ2r0p6y4CIZ9qp+83mo
        h6IAo=; b=dGlEAp1GOrS3k7a5TPCb2sm3z9miG6RwkQFe1OdzptYN+Ax7dHk8YO
        JjamFRUnIeu4KyohxB5wVhYUP4UqTjqoI3MFfuH37gvmlEj90BPPqKkJiLDx6LPk
        BAtlx4TZ1w+rq5QqACyQpOL4deAuZPBttPVh2riiI5KYMYDgoSZ9A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA97A12DA80;
        Mon,  7 Mar 2022 15:43:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30DBB12DA7E;
        Mon,  7 Mar 2022 15:43:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/2] string-list API: change "nr" and "alloc" to
 "size_t"
References: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
        <cover-v2-0.2-00000000000-20220307T152316Z-avarab@gmail.com>
        <patch-v2-2.2-6db8ab7a121-20220307T152316Z-avarab@gmail.com>
        <9c9ca557-122e-3bcb-db4b-3b5ba7bf9369@iee.email>
Date:   Mon, 07 Mar 2022 12:43:43 -0800
In-Reply-To: <9c9ca557-122e-3bcb-db4b-3b5ba7bf9369@iee.email> (Philip Oakley's
        message of "Mon, 7 Mar 2022 16:23:07 +0000")
Message-ID: <xmqqy21lqyrk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4798ED6C-9E57-11EC-87C6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>> @@ -448,10 +448,10 @@ void shortlog_output(struct shortlog *log)
>>  				(int)UTIL_TO_INT(item), item->string);
>>  		} else {
>>  			struct string_list *onelines = item->util;
>> -			fprintf(log->file, "%s (%d):\n",
>> -				item->string, onelines->nr);
>> -			for (j = onelines->nr - 1; j >= 0; j--) {
>> -				const char *msg = onelines->items[j].string;
>> +			fprintf(log->file, "%s (%"PRIuMAX"):\n",
>> +				item->string, (uintmax_t)onelines->nr);
>> +			for (j = onelines->nr; j >= 1; j--) {
>> +				const char *msg = onelines->items[j - 1].string;
> Does this change of iteration limits and j's offset need a commit
> message comment?

Good eyes.  I also tried to made sure this is the only loop that
counts toward zero that use a variable whose type has become size_t
with this patch, which is unsigned and cannot use "var >= 0" as the
loop termination condition, but what is not in the patch is hard to
know.  If there were loops that used to count down with the .nr or
the .alloc members of string_list structure, they would need to be
updated, but if such a code exists, it is likely a bug already.

I think many internal index string-list.c uses are still "int"
(cf. get_entry_index() and functions on the call graph that leads to
it, like add_entry() and string_list_remove()) that wants to be
updated to "ssize_t"; if the string_list has very many elements,
add_entry() may not find an existing string and add a duplicate at
the end, because the bisection search get_entry_index() uses cannot
move the upper-bound pointer beyond "int".

It would have been better if you culled the parts of the patch you
are not referring to, by the way.

Thanks.

