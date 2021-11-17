Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8216CC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF8561502
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhKQIWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:22:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61008 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhKQIWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 03:22:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00938F4475;
        Wed, 17 Nov 2021 03:19:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=z6x9aQNwE8wr6i6RPuGHlZdII
        LN8bhCm99UlFo3y8Fg=; b=WTHko5uUsuNYB97q7rUWGjraQx2iILGgQGGTc0mwY
        a8FUf/wR5aOzSkS5+GTJM37qkxOfIa3tX/IrSHhRK6PTyIHslOCFQF5ThXCYLmdD
        dv5USVv9vRADlRTh3hm5NF+Gi7NKpi++Wn0goqdpDDT7XzJ12cjCEffjPxfr2KlZ
        1Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4BABF4474;
        Wed, 17 Nov 2021 03:19:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07C82F4472;
        Wed, 17 Nov 2021 03:19:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] test-lib: show missing prereq summary
References: <20211115160750.1208940-1-fs@gigacodes.de>
        <20211115160750.1208940-2-fs@gigacodes.de>
        <211115.865ysts45o.gmgdl@evledraar.gmail.com>
        <20211116141938.gbaufny5o2boptvh@fs>
Date:   Wed, 17 Nov 2021 00:19:08 -0800
Message-ID: <xmqqpmqz42kj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0A486FDE-477F-11EC-B60D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> On 15.11.2021 18:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>On Mon, Nov 15 2021, Fabian Stelzer wrote:
>>
>>> +if test -n "$missing_prereq"
>>> +then
>>> +	unique_missing_prereq=3D$(
>>> +		echo $missing_prereq |
>>> +		tr -s "," "\n" |
>>> +		grep -v '^$' |
>>> +		sort -u |
>>> +		paste -s -d ',')
>>
>>What is paste? Some out-of-tree debugging utility?
>>
>>I think you might find a better way to do this shown in my
>>"ab/generate-command-list" topic, currently in seen. It removed most of
>>the same sort of tr|grep|sort etc. chain in generate-cmdlist.sh.
>
> I've looked at the generate-command-list code and TBH i still think thi=
s
> is a better solution. If I read your change correctly you've removed th=
e
> sort and unique completely since it was not necessary for the use-case.
> In this case i think it is. Since we call tr with `-s` the grep -v migh=
t
> not be strictly necessary though. Also in this case these commands are
> only called once at the end of the test run and not in any kind of loop
> like in the cmdlist code so i think this variant is much easier to read
> and debug with a negligible performance impact.

I tend to agree with you.  The snippet we see above is quite
straight-forward not over-engineered.

> I tried writing a sh only variant and this is what i came up with. Not
> sure if this could be much more simplified. It looses the sort though.

Fun, but I'd rather not go there, unless this is a performance
critical bit, which it is not.

Thanks.


>
> input=3D"PCRE,JGIT2,JGIT2,,PCRE,JGIT2,PCRE,PCRE2,!PCRE,!WINDOWS,GPG,GPG=
SSH,PCRE,!GPG,GPG,JGIT2"
>
> unique=3D
> save_IFS=3D$IFS
> IFS=3D,
> for prereq in $input
> do
> 	case "$prereq" in
> 	'')
> 		# Skip empty entries
> 		;;
> 	*)
> 		case ",$unique," in
> 		*,$prereq,*)
> 			# Skip over duplicates
> 			;;
> 		*)
> 			if test -z "$unique"
> 			then
> 				unique=3D"$prereq"
> 			else
> 				unique=3D"$unique,$prereq"
> 			fi
> 			;;
> 		esac
> 	esac
> done
> IFS=3D$save_IFS
> echo $unique
