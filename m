Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4E4C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 17:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbiBYRHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbiBYRHU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 12:07:20 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10281AA4B8
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:06:47 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AEA0118B2DD;
        Fri, 25 Feb 2022 12:06:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=q572bg4HV0is
        1cUnwlV05PAx8/dMXKEkZHBEzu9q6iI=; b=Ba8XisHrLdRofFCYSyD9AY3yjws6
        //pJE3k6NDOb3++f+mXpqruTZA1QRcaCEhrBJQ+1rNambyTcscD6zF2l2AZpaQtI
        3rLJ/SQRVY2g1zQeQB3yueTHvp9DKTMKP8dXjI8yrPmitk/RDNvzf7va2DuMpS0u
        ViBWu+wi5gyEAvQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A753D18B2DC;
        Fri, 25 Feb 2022 12:06:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B20A18B2DB;
        Fri, 25 Feb 2022 12:06:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
References: <xmqqh78nh3sf.fsf@gitster.g>
        <20220225080811.8097-1-chakrabortyabhradeep79@gmail.com>
Date:   Fri, 25 Feb 2022 09:06:42 -0800
In-Reply-To: <20220225080811.8097-1-chakrabortyabhradeep79@gmail.com>
        (Abhradeep Chakraborty's message of "Fri, 25 Feb 2022 13:38:11 +0530")
Message-ID: <xmqqo82ug9jx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4E4A4E0A-965D-11EC-B8B4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

>> These two calls to optbug() use xstrfmt() to grab allocated pieces
>> of memory and pass it as a parameter to the function, which means
>> the string is leaked without any chance to be freed.
>>
>> Do we care?
>>
>> >  		if (opts->argh &&
>> >  		    strcspn(opts->argh, " _") !=3D strlen(opts->argh))
>> >  			err |=3D optbug(opts, "multi-word argh should use dash to separa=
te words");
>>
>> The existing use of optbug() we see here does not share such a
>> problem.
>
> hmm, I wanted a formatting function to format (i.e. pass the
> `opt->help` dynamically) the output string. The existing use of
> `optbug()` that you specified has no `%s` formatter; it is a plain
> string. That's why I used `xstrfmt()`. Moreover, it was in =C3=86var's
> suggestion[1] -
>
>> +		if (opts->help && ends_with(opts->help, "."))
>> +			err |=3D optbug(opts, xstrfmt("argh should not end with a dot: %s"=
, opts->help));
>
> But I think, you're right. There is some memory leakage here.
> Should I go with plain strings then? (i.e. "help should not end
> with a dot" instead of `xstrfmt("help should not end with a dot:
> %s", opts->help)`)

Sorry that I've given you a trick question, when I know you are
quite new to the community.

I think the right answer to "Do we care?" is "In this case, because
we are about to call exit(), we don't care.  The extra complexity
and code necessary to retain the memory we get from xstrfmt and free
it is not worth it."  It's not like we do this in a loop that iterates
unbounded number of times before the exit() happens (in which case
we should care).

Thanks.




