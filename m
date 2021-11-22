Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D8CC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbhKVRaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:30:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64053 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbhKVRae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:30:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B29AAF3934;
        Mon, 22 Nov 2021 12:27:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iXN/e+tZLP5x89S8LJ4EIiVRmAprTqyJuLa3yr
        iogc0=; b=bu8INbU/j9HRBAQE20bSw6HPtFtkiWh85ZjyH03opidM6qz5k2/aHy
        aPosFeEHCap8BOj9M7c/0XaB+9HTGhmFrOOr0SuF4RlR1PpvTW2A2FcZhsMOL8Ur
        Nk7xp7/EZyzfjhIWIM0EJSbarDN+hUUrSbqViGR89ERi1AnkGCgsI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAEACF3933;
        Mon, 22 Nov 2021 12:27:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 202F7F3932;
        Mon, 22 Nov 2021 12:27:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 support
References: <20211114211622.1465981-1-sandals@crustytoothpaste.net>
        <20211114211622.1465981-2-sandals@crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2111161129120.21127@tvgsbejvaqbjf.bet>
        <xmqqk0h7423v.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet>
Date:   Mon, 22 Nov 2021 09:27:26 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 22 Nov 2021 12:44:37 +0100 (CET)")
Message-ID: <xmqq1r38hzi9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 768AB646-4BB9-11EC-BF08-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I like the direction, but ...
>>
>> >> diff --git a/Makefile b/Makefile
>> >> index 12be39ac49..22d9e67542 100644
>> >> --- a/Makefile
>> >> +++ b/Makefile
>> >> @@ -1204,7 +1204,7 @@ endif
>> >>  # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
>> >>  # tweaked by config.* below as well as the command-line, both of
>> >>  # which'll override these defaults.
>> >> -CFLAGS = -g -O2 -Wall
>> >> +CFLAGS = -g -O2 -Wall -std=gnu99
>>
>> ... as has been already pointed out, this part probably should not
>> be there.  It is not our intention to require gcc/clang, or to
>> constrain newer systems to gnu99.
>
> Another data point in favor of dropping this: our FreeBSD CI build reports
> a compile error with this:
>
> 	[...]
> 	archive.c:337:35: error: '_Generic' is a C11 extension
> 	[-Werror,-Wc11-extensions]
> 			strbuf_addstr(&path_in_archive, basename(path));
> 							^
> 	/usr/include/libgen.h:61:21: note: expanded from macro 'basename'
> 	#define basename(x)     __generic(x, const char *, __old_basename, basename)(x)
> 				^
> 	/usr/include/sys/cdefs.h:329:2: note: expanded from macro '__generic'
> 		_Generic(expr, t: yes, default: no)
> 		^
> 	1 error generated.
>
> I verified in https://github.com/gitgitgadget/git/pull/1082 that this
> patch is indeed the cause of this compile error.

Thanks.

I took a look at #1082, which reverted this one (and nothing else)
to see a test succeds, and then re-reverted it to see it fail (but
apparently only on FreeBSD/Cirrus).  

I had an impression that it was claimed that without this, the other
weatherbaloon for "for (type var=..." would not fly in some of the
jobs we have at CI?


