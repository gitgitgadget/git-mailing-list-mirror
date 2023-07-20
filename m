Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3426CEB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 05:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGTFVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 01:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjGTFVm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 01:21:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263832681
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 22:21:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 561BF35117;
        Thu, 20 Jul 2023 01:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DavUkiwt3TY3tqt6ThA1VqRC8h8HPoz6g6YyMg
        Xm7N4=; b=TIxI4X/4bs8nc6BZ0PEgped5bnNxnivUdZBDDDQIe/hXYepM4Tbeeb
        Wh07/d9EPS+BtI/Jo2l3tZZcZ27S/Lll50iUYXVc0TbDgP6z0/Eu2dA1ocEHQQN5
        khrMq+lTBefIhMQPf76j9k5gedkzjcNsPNhNepUJHCz8TUma6r4eo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E04E35116;
        Thu, 20 Jul 2023 01:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CC67F35115;
        Thu, 20 Jul 2023 01:21:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 1/2] ref-filter: add multiple-option parsing functions
References: <20230714194249.66862-1-five231003@gmail.com>
        <20230719162424.70781-1-five231003@gmail.com>
        <20230719162424.70781-2-five231003@gmail.com>
        <xmqqjzuv5vvg.fsf@gitster.g>
Date:   Wed, 19 Jul 2023 22:21:33 -0700
In-Reply-To: <xmqqjzuv5vvg.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        19 Jul 2023 16:23:15 -0700")
Message-ID: <xmqqcz0n40pu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B4475E0-26BD-11EE-98A3-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +static int match_atom_arg_value(const char *to_parse, const char *candidate,
>> +				const char **end, const char **valuestart,
>> +				size_t *valuelen)
>> +{
>> +	const char *atom;
>> +
>> +	if (!(skip_prefix(to_parse, candidate, &atom)))
>> +		return 0;
>> +	if (valuestart) {
>
> As far as I saw, no callers pass NULL to valuestart.  Getting rid of
> this if() statement and always entering its body would clarify what
> is going on, I think.

Specifically, ...

>> +		if (*atom == '=') {
>> +			*valuestart = atom + 1;
>> +			*valuelen = strcspn(*valuestart, ",\0");
>> +			atom = *valuestart + *valuelen;
>> +		} else {
>> +			if (*atom != ',' && *atom != '\0')
>> +				return 0;
>> +			*valuestart = NULL;
>> +			*valuelen = 0;
>> +		}
>> +	}
>> +	if (*atom == ',') {
>> +		*end = atom + 1;
>> +		return 1;
>> +	}
>> +	if (*atom == '\0') {
>> +		*end = atom;
>> +		return 1;
>> +	}
>> +	return 0;
>> +}

... I think the body of the function would become easier to read if
written like so:

	if (!skip_prefix(to_parse, candidate, &atom))
		return 0; /* definitely not "candidate" */

	if (*atom == '=') {
		/* we just saw "candidate=" */
		*valuestart = atom + 1;
                atom = strchrnul(*valuestart, ',');
		*valuelen = atom - *valuestart;
	} else if (*atom != ',' && *atom != '\0') {
        	 /* key begins with "candidate" but has more chars */
		return 0;
	} else {
        	/* just "candidate" without "=val" */
		*valuestart = NULL;
		*valuelen = 0;
	}

        /* atom points at either the ',' or NUL after this key[=val] */
	if (*atom == ',')
		atom++;
	else if (*atom)
		BUG("should not happen");

	*end = atom;
	return 1;

as it is clear that *valuestart, *valuelen, and *end are not touched
when the function returns 0 and they are all filled when the function
returns 1.

Also, avoid passing ",\0" to strcspn(); its effect is exactly the
same as passing ",", and at that point you are better off using
strchnul().

Thanks.

