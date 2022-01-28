Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEF6C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 23:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351866AbiA1X6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 18:58:31 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60077 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351872AbiA1X62 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 18:58:28 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A733180A6F;
        Fri, 28 Jan 2022 18:58:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QPw2N1INzx+YVXoP+bRzfgY896vY4C3MVTtESy
        6kOfY=; b=l1NB/Evcun8LPgcvZt/aNNPK4ZZ/77jed5f6qpYSHVePYAgyuotGdu
        7x40TTuJ/YmjWpfpcIEz87A9iorw1WmcWi+1aHi3gv/lbKasmoRrp2w1OqRzHFPW
        B/JlEPYmvNh0xw0atX3iD4O+BG/FX/+DHBmGTG/kE4uT4717+802w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42757180A6E;
        Fri, 28 Jan 2022 18:58:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A144C180A6D;
        Fri, 28 Jan 2022 18:58:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        =?utf-8?Q?Jean-No?= =?utf-8?Q?=C3=ABl?= Avila via
         GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 1/4] i18n: factorize more 'incompatible options'
 messages
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
        <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
        <844e01391e1198960072844536d736f51573cac6.1643408644.git.gitgitgadget@gmail.com>
        <7f46e276-b669-e8fe-21fd-6b43f5bfb33b@kdbg.org>
Date:   Fri, 28 Jan 2022 15:58:23 -0800
In-Reply-To: <7f46e276-b669-e8fe-21fd-6b43f5bfb33b@kdbg.org> (Johannes Sixt's
        message of "Sat, 29 Jan 2022 00:21:51 +0100")
Message-ID: <xmqqee4rtnts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DFECF22-8096-11EC-B447-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> +void die_if_incompatible_opt4(int opt1, const char *opt1_name,
>> +							  int opt2, const char *opt2_name,
>> +							  int opt3, const char *opt3_name,
>> +							  int opt4, const char *opt4_name)
>> +{
>> +	int count = 0;
>> +	const char *options[4];
>> +
>> +	if (opt1)
>> +		options[count++] = opt1_name;
>> +	if (opt2)
>> +		options[count++] = opt2_name;
>> +	if (opt3)
>> +		options[count++] = opt3_name;
>> +	if (opt4)
>> +		options[count++] = opt4_name;
>> +	switch (count) {
>> +	case 4:
>> +		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"), opt1_name, opt2_name, opt3_name, opt4_name);
>> +		break;
>> +	case 3:
>> +		die(_("options '%s', '%s', and '%s' cannot be used together"), options[0], options[1], options[2]);
>> +		break;
>> +	case 2:
>> +		die(_("options '%s' and '%s' cannot be used together"), options[0], options[1]);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +}
>
> Generally, this is good. I wonder whether we have to expect compiler
> warnings about unreachable break statements after the die() calls.
>
> A bit of code duplication could be avoided if die_if_incompatible_opt3()
> forwarded with an additional pair 0, "" to die_if_incompatible_opt4().

I wondered if a single varargs function

    void die_if_incompatible_optN(const char *name1, int opt1, ...);

that takes a name=NULL terminated sequence of <name, opt> would
work, but

 (1) it would require the caller to always spell out the terminating
     NULL, which may be ugly.

 (2) it would tempt people to programatically generate message for N
     options, which leads to sentence lego, which is the exact
     opposite of what this series wants to achieve.

In any case, I do agree with you that the callers of _opt3()
variants can just pass (0, "unused") in the 4-th slot.  If this were
made varargs, then it only needs to pass NULL at the end, so that
might be an improvement, though.

Also, isn't "if" in the name of the function misleading?  as far as
I can tell, this function is not "check if these options are
compatible and die if some are incompatible with each other", but
the caller is convinced that these options are incompatible before
it decides to call this function and there is no "if" in what this
function can do.

void die_for_incompatible_opts(const char *name1, int opt1, ...)
{
	const char *name[4];
	int count = 0;
        va_list params;

        va_start(params, name1);

        if (opt1)
	        name[count++] = name1;
        while (count < ARRAY_SIZE(name)) {
                const char *n = va_arg(params, const char *);

                if (!n)
			break;
                if (va_arg(params, int))
	                name[count++] = n;
        }
        va_end(params);

        switch (count) {
	default:
		BUG("die-for-incompatible-opts can only take up to %d args",
		    ARRAY_SIZE(name));
	case 4:
		die(_("options '%s', '%s', '%s', and '%s'"
		      " cannot be used together"),
		    name[0], name[1], name[2], name[3]);
		break;
	case 3:
		die(_("options '%s', '%s', and '%s'"
		      " cannot be used together"),
		    name[0], name[1], name[2]);
		break;
	...
	}
}

might be easier to extend when somebody discovers there needs the
"opt5" variant. 
